#!/usr/bin/env python3
"""Dependency-free model and checker machinery for scalar-arctic top cases.

This module deliberately reconstructs the YAH rules and the fixed two-state
semantic labeling.  It does not import any P2--P5 scratch solver module.
"""

from __future__ import annotations


if not __debug__:
    raise RuntimeError(
        "Verification requires assertions; rerun without -O, -OO, "
        "or PYTHONOPTIMIZE."
    )

from collections import Counter
from dataclasses import dataclass
from hashlib import sha256
from typing import Iterable


STATES = (0, 1)
SYMBOLS = ("^", "$", "f", "t", "0", "1", "2")
TOKENS = tuple((symbol, state) for symbol in SYMBOLS for state in STATES)
ALGEBRA = {
    "f": (0, 0),
    "t": (1, 1),
    "0": (0, 0),
    "1": (0, 1),
    "2": (1, 1),
    "^": (0, 0),
    "$": (0, 0),
}


@dataclass(frozen=True)
class Rule:
    name: str
    lhs: tuple[str, ...]
    rhs: tuple[str, ...]
    family: str


RULES = (
    Rule("D_f", ("f", "$"), ("$",), "D"),
    Rule("D_t", ("t", "$"), ("2", "$"), "D"),
    Rule("X_f0", ("f", "0"), ("0", "f"), "A"),
    Rule("X_f1", ("f", "1"), ("0", "t"), "A"),
    Rule("X_f2", ("f", "2"), ("1", "f"), "A"),
    Rule("X_t0", ("t", "0"), ("1", "t"), "A"),
    Rule("X_t1", ("t", "1"), ("2", "f"), "A"),
    Rule("X_t2", ("t", "2"), ("2", "t"), "A"),
    Rule("X_^0", ("^", "0"), ("^", "t"), "B"),
    Rule("X_^1", ("^", "1"), ("^", "f", "f"), "B"),
    Rule("X_^2", ("^", "2"), ("^", "f", "t"), "B"),
)


@dataclass(frozen=True)
class Instance:
    key: str
    family: str
    lhs: tuple[tuple[str, int], ...]
    rhs: tuple[tuple[str, int], ...]


def eval_word(word: tuple[str, ...], tail: int) -> int:
    value = tail
    for symbol in reversed(word):
        value = ALGEBRA[symbol][value]
    return value


def label_word(word: tuple[str, ...], tail: int) -> tuple[tuple[str, int], ...]:
    value = tail
    result: list[tuple[str, int]] = []
    for symbol in reversed(word):
        result.append((symbol, value))
        value = ALGEBRA[symbol][value]
    result.reverse()
    return tuple(result)


def instances(original: bool) -> tuple[Instance, ...]:
    result = []
    for rule in RULES:
        for tail in STATES:
            assert eval_word(rule.lhs, tail) == eval_word(rule.rhs, tail)
            lhs = label_word(rule.lhs, tail)
            rhs = label_word(rule.rhs, tail)
            if not original:
                lhs = tuple(reversed(lhs))
                rhs = tuple(reversed(rhs))
            result.append(Instance(f"{rule.name}[{tail}]", rule.family, lhs, rhs))
    assert len(result) == 22
    return tuple(result)


ORIGINAL = instances(True)
REVERSED = instances(False)
TOP_CASES = tuple(
    [("TOP_BOUNDARY_ORIGINAL", row.key, True) for row in ORIGINAL if row.family == "B"]
    + [("TOP_DYNAMIC_REVERSED", row.key, False) for row in REVERSED if row.family == "D"]
)
assert len(TOP_CASES) == 10


def instance_fingerprint() -> str:
    lines = []
    for orientation, rows in (("O", ORIGINAL), ("R", REVERSED)):
        for row in rows:
            def side(tokens):
                return " ".join(f"{symbol}@{state}" for symbol, state in tokens)
            lines.append(f"{orientation}|{row.key}|{row.family}|{side(row.lhs)}|{side(row.rhs)}")
    return sha256(("\n".join(lines) + "\n").encode()).hexdigest()


# The all-positive full/extended certificate published in f8558a5.  Replaying
# it here makes semantic compatibility stronger than a coincidental hash.
FULL_MULTIPLIER = {
    ("D_f", 0): 3, ("D_f", 1): 1, ("D_t", 0): 6, ("D_t", 1): 1,
    ("X_f0", 0): 1, ("X_f0", 1): 4,
    ("X_f1", 0): 5, ("X_f1", 1): 1,
    ("X_f2", 0): 7, ("X_f2", 1): 2,
    ("X_t0", 0): 2, ("X_t0", 1): 1,
    ("X_t1", 0): 3, ("X_t1", 1): 1,
    ("X_t2", 0): 3, ("X_t2", 1): 1,
    ("X_^0", 0): 2, ("X_^0", 1): 1,
    ("X_^1", 0): 1, ("X_^1", 1): 1,
    ("X_^2", 0): 1, ("X_^2", 1): 1,
}


def verify_full_compatibility() -> None:
    total: Counter[tuple[str, int]] = Counter()
    expected = {(rule.name, tail) for rule in RULES for tail in STATES}
    assert set(FULL_MULTIPLIER) == expected
    assert all(weight > 0 for weight in FULL_MULTIPLIER.values())
    assert sum(FULL_MULTIPLIER.values()) == 49
    for rule in RULES:
        for tail in STATES:
            lhs = Counter(label_word(rule.lhs, tail))
            rhs = Counter(label_word(rule.rhs, tail))
            weight = FULL_MULTIPLIER[(rule.name, tail)]
            for token in set(lhs) | set(rhs):
                total[token] += weight * (lhs[token] - rhs[token])
    assert not +total and not -total


Vector = tuple[int, ...]


def add(left: Vector, right: Vector) -> Vector:
    return tuple(a + b for a, b in zip(left, right))


def sub(left: Vector, right: Vector) -> Vector:
    return tuple(a - b for a, b in zip(left, right))


def unit(index: int, size: int) -> Vector:
    return tuple(1 if j == index else 0 for j in range(size))


@dataclass(frozen=True)
class Inequality:
    """The exact rational inequality coefficients dot x >= rhs."""

    coefficients: Vector
    rhs: int
    name: str


class CNFBuilder:
    def __init__(self) -> None:
        self.names = ["<unused>"]
        self.clauses: list[tuple[int, ...]] = []
        self._and_cache: dict[tuple[int, ...], int] = {}
        self._or_cache: dict[tuple[int, ...], int] = {}
        self.true = self.var("TRUE")
        self.clauses.append((self.true,))

    @property
    def false(self) -> int:
        return -self.true

    def var(self, name: str) -> int:
        self.names.append(name)
        return len(self.names) - 1

    def and_(self, literals: Iterable[int]) -> int:
        values = tuple(dict.fromkeys(literals))
        if any(value == self.false for value in values):
            return self.false
        values = tuple(value for value in values if value != self.true)
        if not values:
            return self.true
        if len(values) == 1:
            return values[0]
        if any(-value in values for value in values):
            return self.false
        key = tuple(sorted(values))
        if key in self._and_cache:
            return self._and_cache[key]
        out = self.var("AND(" + ",".join(map(str, key)) + ")")
        for value in key:
            self.clauses.append((-out, value))
        self.clauses.append((out,) + tuple(-value for value in key))
        self._and_cache[key] = out
        return out

    def or_(self, literals: Iterable[int]) -> int:
        values = tuple(dict.fromkeys(literals))
        if any(value == self.true for value in values):
            return self.true
        values = tuple(value for value in values if value != self.false)
        if not values:
            return self.false
        if len(values) == 1:
            return values[0]
        if any(-value in values for value in values):
            return self.true
        key = tuple(sorted(values))
        if key in self._or_cache:
            return self._or_cache[key]
        out = self.var("OR(" + ",".join(map(str, key)) + ")")
        for value in key:
            self.clauses.append((out, -value))
        self.clauses.append((-out,) + key)
        self._or_cache[key] = out
        return out

    def assert_(self, literal: int) -> None:
        self.clauses.append((literal,))


@dataclass
class BuiltCase:
    family: str
    target: str
    original: bool
    cnf: CNFBuilder
    inequalities: list[Inequality]
    atom_variables: list[int]
    value_names: list[str]


def build_case(family: str, target: str, original: bool) -> BuiltCase:
    rows = ORIGINAL if original else REVERSED
    assert (family, target, original) in TOP_CASES
    cnf = CNFBuilder()

    value_names: list[str] = []
    value_index: dict[tuple[str, int, str], int] = {}
    finite: dict[tuple[str, int, str], int] = {}
    for token in TOKENS:
        for component in ("m", "v"):
            key = token + (component,)
            value_index[key] = len(value_names)
            value_names.append(f"{component}_{token[0]}_{token[1]}")
            finite[key] = cnf.var(f"finite_{component}_{token[0]}_{token[1]}")
        cnf.assert_(cnf.or_((finite[token + ("m",)], finite[token + ("v",)])))

    nvalues = len(value_names)
    zero = (0,) * nvalues
    inequalities: list[Inequality] = []
    atom_variables: list[int] = []
    atom_cache: dict[tuple[Vector, int], int] = {}

    def atom(coefficients: Vector, rhs: int, name: str) -> int:
        key = (coefficients, rhs)
        if key in atom_cache:
            return atom_variables[atom_cache[key]]
        index = len(inequalities)
        inequalities.append(Inequality(coefficients, rhs, name))
        variable = cnf.var(f"arith_{index}_{name}")
        atom_variables.append(variable)
        atom_cache[key] = index
        return variable

    def word(tokens):
        prefix_support: list[int] = []
        prefix_value = zero
        terms: list[tuple[int, Vector]] = []
        for token in tokens:
            vkey = token + ("v",)
            terms.append((cnf.and_(prefix_support + [finite[vkey]]), add(prefix_value, unit(value_index[vkey], nvalues))))
            mkey = token + ("m",)
            prefix_support.append(finite[mkey])
            prefix_value = add(prefix_value, unit(value_index[mkey], nvalues))
        return cnf.and_(prefix_support), prefix_value, tuple(terms)

    def weak(lhs, rhs, tag):
        lm, lmexpr, lterms = lhs
        rm, rmexpr, rterms = rhs
        slope_ge = atom(sub(lmexpr, rmexpr), 0, f"{tag}_slope_ge")
        cnf.assert_(cnf.or_((-rm, cnf.and_((lm, slope_ge)))))
        for rindex, (rsupport, rexpr) in enumerate(rterms):
            witnesses = []
            for lindex, (lsupport, lexpr) in enumerate(lterms):
                ge = atom(sub(lexpr, rexpr), 0, f"{tag}_vge_{lindex}_{rindex}")
                witnesses.append(cnf.and_((lsupport, ge)))
            cnf.assert_(cnf.or_((-rsupport, cnf.or_(witnesses))))

    def strict(lhs, rhs, tag):
        lm, lmexpr, lterms = lhs
        rm, rmexpr, rterms = rhs
        slope_gt = atom(sub(lmexpr, rmexpr), 1, f"{tag}_slope_gt")
        cnf.assert_(cnf.or_((-lm, -rm, slope_gt)))

        rhs_finite = cnf.or_(support for support, _expr in rterms)
        lhs_witnesses = []
        for lindex, (lsupport, lexpr) in enumerate(lterms):
            beats = []
            for rindex, (rsupport, rexpr) in enumerate(rterms):
                gt = atom(sub(lexpr, rexpr), 1, f"{tag}_vgt_{lindex}_{rindex}")
                beats.append(cnf.or_((-rsupport, gt)))
            lhs_witnesses.append(cnf.and_((lsupport, cnf.and_(beats))))
        cnf.assert_(cnf.or_((-rhs_finite, cnf.or_(lhs_witnesses))))

    for row in rows:
        lhs = word(row.lhs)
        rhs = word(row.rhs)
        weak(lhs, rhs, row.key)
        if row.key == target:
            strict(lhs, rhs, row.key)

    return BuiltCase(family, target, original, cnf, inequalities, atom_variables, value_names)


def farkas_valid(case: BuiltCase, lemma: dict) -> bool:
    total = [0] * len(case.value_names)
    rhs = 0
    seen_atoms = set()
    for index, weight in lemma.get("base", []):
        if not (0 <= index < len(total) and isinstance(weight, int) and weight > 0):
            return False
        total[index] += weight
    for index, weight in lemma.get("atoms", []):
        if not (0 <= index < len(case.inequalities) and isinstance(weight, int) and weight > 0):
            return False
        if index in seen_atoms:
            return False
        seen_atoms.add(index)
        inequality = case.inequalities[index]
        for j, coefficient in enumerate(inequality.coefficients):
            total[j] += weight * coefficient
        rhs += weight * inequality.rhs
    return all(value == 0 for value in total) and rhs > 0 and bool(seen_atoms)


def learned_clause(case: BuiltCase, lemma: dict) -> tuple[int, ...]:
    return tuple(-case.atom_variables[index] for index, _weight in lemma["atoms"])


def rup_valid(clauses: Iterable[tuple[int, ...]], candidate: tuple[int, ...], variable_count: int) -> bool:
    """Verify reverse unit propagation for one candidate clause exactly."""
    if any(literal == 0 or abs(literal) > variable_count for literal in candidate):
        return False
    if len(set(candidate)) != len(candidate) or any(-literal in candidate for literal in candidate):
        return False

    # Negate the candidate as unit assumptions.
    assignment = [0] * (variable_count + 1)
    for literal in candidate:
        variable = abs(literal)
        value = -1 if literal > 0 else 1
        if assignment[variable] == -value:
            return True
        assignment[variable] = value

    clause_list = tuple(clauses)
    while True:
        changed = False
        for clause in clause_list:
            satisfied = False
            unassigned = 0
            unit_literal = 0
            for literal in clause:
                value = assignment[abs(literal)]
                if value == 0:
                    unassigned += 1
                    unit_literal = literal
                elif value == (1 if literal > 0 else -1):
                    satisfied = True
                    break
            if satisfied:
                continue
            if unassigned == 0:
                return True
            if unassigned == 1:
                variable = abs(unit_literal)
                value = 1 if unit_literal > 0 else -1
                if assignment[variable] == -value:
                    return True
                if assignment[variable] == 0:
                    assignment[variable] = value
                    changed = True
        if not changed:
            return False
