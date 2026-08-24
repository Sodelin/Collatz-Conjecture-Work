#!/usr/bin/env python3
"""Exact two-state semantic-label no-go certificates for the YAH system.

This standard-library checker reconstructs every labeled rewrite instance in
two finite cancellation certificates.  It proves only that this particular
two-state labeling cannot support symbol-additive or adjacent-edge-additive
scalar/finite-lex orders.  It is not a Collatz proof or an SRS termination
proof.
"""

from __future__ import annotations

from collections import Counter
from dataclasses import dataclass
from itertools import product


VALUES = (0, 1)
DIGITS = ("f", "t", "0", "1", "2")
LEFT = "^"
RIGHT = "$"
TERMINAL_STATE = 0

# Unary maps are written as (value at 0, value at 1).
ALGEBRA = {
    "f": (0, 0),
    "t": (1, 1),
    "0": (0, 0),
    "1": (0, 1),
    "2": (1, 1),
    LEFT: (0, 0),
    RIGHT: (0, 0),
}


@dataclass(frozen=True)
class Rule:
    name: str
    lhs: tuple[str, ...]
    rhs: tuple[str, ...]
    dynamic: bool


RULES = (
    Rule("D_f", ("f", RIGHT), (RIGHT,), True),
    Rule("D_t", ("t", RIGHT), ("2", RIGHT), True),
    Rule("X_f0", ("f", "0"), ("0", "f"), False),
    Rule("X_f1", ("f", "1"), ("0", "t"), False),
    Rule("X_f2", ("f", "2"), ("1", "f"), False),
    Rule("X_t0", ("t", "0"), ("1", "t"), False),
    Rule("X_t1", ("t", "1"), ("2", "f"), False),
    Rule("X_t2", ("t", "2"), ("2", "t"), False),
    Rule("X_^0", (LEFT, "0"), (LEFT, "t"), False),
    Rule("X_^1", (LEFT, "1"), (LEFT, "f", "f"), False),
    Rule("X_^2", (LEFT, "2"), (LEFT, "f", "t"), False),
)
RULE_BY_NAME = {rule.name: rule for rule in RULES}

Token = tuple[str, int]
Edge = tuple[Token, Token]


def eval_word(word: tuple[str, ...], tail: int) -> int:
    value = tail
    for symbol in reversed(word):
        value = ALGEBRA[symbol][value]
    return value


def label_word(word: tuple[str, ...], tail: int) -> tuple[Token, ...]:
    """Label each symbol by the algebra value of the suffix to its right."""
    value = tail
    result: list[Token] = []
    for symbol in reversed(word):
        result.append((symbol, value))
        value = ALGEBRA[symbol][value]
    result.reverse()
    return tuple(result)


INTERIOR_EDGES = {
    ((left_symbol, ALGEBRA[right_symbol][tail]), (right_symbol, tail))
    for right_symbol, tail in product(DIGITS, VALUES)
    for left_symbol in DIGITS
}
LEFT_EDGES = {
    ((LEFT, ALGEBRA[right_symbol][tail]), (right_symbol, tail))
    for right_symbol, tail in product(DIGITS, VALUES)
}
RIGHT_EDGES = {
    ((left_symbol, ALGEBRA[RIGHT][TERMINAL_STATE]),
     (RIGHT, TERMINAL_STATE))
    for left_symbol in DIGITS
}
EMPTY_EDGE = {
    ((LEFT, ALGEBRA[RIGHT][TERMINAL_STATE]),
     (RIGHT, TERMINAL_STATE))
}
LEGAL_EDGES = INTERIOR_EDGES | LEFT_EDGES | RIGHT_EDGES | EMPTY_EDGE


def possible_left_neighbors(output: int) -> tuple[Token, ...]:
    return ((LEFT, output),) + tuple((symbol, output) for symbol in DIGITS)


def possible_right_neighbors(tail: int) -> tuple[Token, ...]:
    result = [
        (symbol, state)
        for symbol, state in product(DIGITS, VALUES)
        if ALGEBRA[symbol][state] == tail
    ]
    if ALGEBRA[RIGHT][TERMINAL_STATE] == tail:
        result.append((RIGHT, TERMINAL_STATE))
    return tuple(result)


def assert_legal_edges(tokens: tuple[Token, ...]) -> None:
    assert all(edge in LEGAL_EDGES for edge in zip(tokens, tokens[1:])), tokens


def canonical_extension(tokens: tuple[Token, ...]) -> tuple[Token, ...]:
    """Extend any legal local segment to a fixed-terminal `^w$` string."""
    result = list(tokens)
    if result[0][0] != LEFT:
        first_symbol, first_tail = result[0]
        result.insert(0, (LEFT, ALGEBRA[first_symbol][first_tail]))
    if result[-1][0] != RIGHT:
        suffix_value = result[-1][1]
        if suffix_value == 1:
            result.append(("t", TERMINAL_STATE))
        result.append((RIGHT, TERMINAL_STATE))
    extended = tuple(result)
    assert extended[0][0] == LEFT and extended[-1] == (RIGHT, TERMINAL_STATE)
    assert_legal_edges(extended)
    return extended


def legal_contexts(rule: Rule, tail: int):
    """Generate every one-symbol context in a fixed-terminal canonical word."""
    if rule.lhs[-1] == RIGHT and tail != TERMINAL_STATE:
        return

    lhs = label_word(rule.lhs, tail)
    rhs = label_word(rule.rhs, tail)
    output = eval_word(rule.lhs, tail)
    assert output == eval_word(rule.rhs, tail)

    lefts: tuple[Token | None, ...]
    rights: tuple[Token | None, ...]
    lefts = (None,) if rule.lhs[0] == LEFT else possible_left_neighbors(output)
    rights = (None,) if rule.lhs[-1] == RIGHT else possible_right_neighbors(tail)

    for left, right in product(lefts, rights):
        full_lhs = ((left,) if left else ()) + lhs + ((right,) if right else ())
        full_rhs = ((left,) if left else ()) + rhs + ((right,) if right else ())
        assert_legal_edges(full_lhs)
        assert_legal_edges(full_rhs)
        canonical_extension(full_lhs)
        canonical_extension(full_rhs)
        yield left, right, full_lhs, full_rhs


def cleaned(counter: Counter) -> Counter:
    return Counter({key: value for key, value in counter.items() if value})


def symbol_delta(lhs: tuple[Token, ...], rhs: tuple[Token, ...]) -> Counter[Token]:
    result = Counter(lhs)
    result.subtract(Counter(rhs))
    return cleaned(result)


def edge_delta(lhs: tuple[Token, ...], rhs: tuple[Token, ...]) -> Counter[Edge]:
    result = Counter(zip(lhs, lhs[1:]))
    result.subtract(Counter(zip(rhs, rhs[1:])))
    return cleaned(result)


def add_scaled(total: Counter, delta: Counter, multiplier: int) -> None:
    assert multiplier > 0
    for feature, coefficient in delta.items():
        total[feature] += multiplier * coefficient


# Denominator-five Farkas vector, cleared to positive integers.
SYMBOL_CERTIFICATE = (
    (2, "D_f", 0),
    (3, "D_t", 0),
    (1, "X_f0", 1),
    (1, "X_f1", 0),
    (2, "X_f2", 0),
    (1, "X_^0", 0),
    (1, "X_^1", 0),
    (1, "X_^2", 0),
)


# Denominator 144057 Farkas vector, cleared to positive integers.  Each row
# is (multiplier, rule, tail state, immediate left token, immediate right
# token).  None is a boundedness/potential row: all are legal rewrite rows.
EDGE_CERTIFICATE = (
    (57168, "D_f", 0, ("t", 0), None),
    (47250, "D_t", 0, ("0", 1), None),
    (39639, "D_t", 0, ("1", 1), None),
    (26731, "X_f0", 0, ("t", 0), ("0", 1)),
    (19538, "X_f0", 0, ("1", 0), ("f", 1)),
    (17360, "X_f0", 0, ("2", 0), ("f", 1)),
    (11931, "X_f0", 1, ("^", 0), ("t", 1)),
    (7358, "X_f0", 1, ("^", 0), ("1", 1)),
    (47250, "X_f0", 1, ("f", 0), ("2", 0)),
    (10432, "X_f1", 0, ("^", 0), ("0", 1)),
    (39808, "X_f1", 0, ("f", 0), ("f", 0)),
    (19538, "X_f1", 0, ("0", 0), ("0", 0)),
    (10432, "X_f1", 0, ("1", 0), ("1", 0)),
    (3082, "X_f1", 1, ("t", 0), ("t", 0)),
    (13262, "X_f1", 1, ("0", 0), ("t", 1)),
    (13891, "X_f1", 1, ("2", 0), ("2", 0)),
    (15149, "X_f2", 0, ("^", 0), ("f", 0)),
    (25544, "X_f2", 0, ("f", 0), ("1", 0)),
    (16379, "X_f2", 0, ("0", 0), ("0", 0)),
    (25926, "X_f2", 0, ("1", 0), ("$", 0)),
    (31242, "X_f2", 0, ("2", 0), ("$", 0)),
    (12298, "X_f2", 1, ("^", 0), ("1", 1)),
    (13628, "X_f2", 1, ("f", 0), ("t", 1)),
    (2274, "X_t0", 0, ("^", 1), ("f", 0)),
    (6069, "X_t0", 0, ("t", 1), ("0", 1)),
    (22528, "X_t0", 0, ("0", 1), ("f", 0)),
    (16379, "X_t0", 0, ("2", 1), ("1", 0)),
    (10579, "X_t0", 1, ("f", 1), ("t", 1)),
    (15170, "X_t0", 1, ("t", 1), ("1", 1)),
    (7725, "X_t0", 1, ("2", 1), ("2", 1)),
    (17015, "X_t1", 0, ("^", 1), ("f", 0)),
    (15494, "X_t1", 0, ("f", 1), ("1", 0)),
    (4529, "X_t1", 1, ("^", 1), ("t", 0)),
    (25748, "X_t1", 1, ("f", 1), ("2", 0)),
    (8969, "X_t1", 1, ("t", 1), ("2", 1)),
    (8969, "X_t1", 1, ("2", 1), ("t", 1)),
    (3082, "X_t2", 0, ("f", 1), ("f", 1)),
    (13875, "X_t2", 0, ("f", 1), ("$", 0)),
    (981, "X_t2", 0, ("t", 1), ("0", 0)),
    (13891, "X_t2", 0, ("t", 1), ("0", 1)),
    (5903, "X_t2", 1, ("^", 1), ("1", 1)),
    (7725, "X_t2", 1, ("0", 1), ("t", 0)),
    (8969, "X_t2", 1, ("1", 1), ("2", 0)),
    (19289, "X_^0", 0, None, ("f", 0)),
    (10432, "X_^0", 1, None, ("t", 0)),
    (27447, "X_^1", 0, None, ("f", 0)),
    (2274, "X_^1", 1, None, ("t", 1)),
    (5698, "X_^2", 0, None, ("1", 0)),
    (15846, "X_^2", 0, None, ("$", 0)),
    (5903, "X_^2", 1, None, ("1", 1)),
)


def validate_rule_table() -> None:
    assert len(RULES) == 11 and len(RULE_BY_NAME) == 11
    for rule in RULES:
        assert rule.dynamic == rule.name.startswith("D_")
        assert (not rule.dynamic) == rule.name.startswith("X_")
        for tail in VALUES:
            assert eval_word(rule.lhs, tail) == eval_word(rule.rhs, tail)


def validate_symbol_certificate() -> int:
    assert len(SYMBOL_CERTIFICATE) == 8
    assert len({row[1:] for row in SYMBOL_CERTIFICATE}) == 8
    total: Counter[Token] = Counter()
    dynamic_rows = 0
    dynamic_mass = 0

    for multiplier, name, tail in SYMBOL_CERTIFICATE:
        rule = RULE_BY_NAME[name]
        contexts = tuple(legal_contexts(rule, tail))
        assert contexts, (name, tail)
        lhs = label_word(rule.lhs, tail)
        rhs = label_word(rule.rhs, tail)
        add_scaled(total, symbol_delta(lhs, rhs), multiplier)
        if rule.dynamic:
            dynamic_rows += 1
            dynamic_mass += multiplier

    assert dynamic_rows == 2
    assert dynamic_mass == 5
    assert cleaned(total) == Counter(), cleaned(total)
    return dynamic_mass


def validate_edge_certificate() -> int:
    assert len(EDGE_CERTIFICATE) == 50
    assert len({row[1:] for row in EDGE_CERTIFICATE}) == 50
    total: Counter[Edge] = Counter()
    dynamic_rows = 0
    dynamic_mass = 0

    for multiplier, name, tail, left, right in EDGE_CERTIFICATE:
        rule = RULE_BY_NAME[name]
        legal = {
            (context_left, context_right): (lhs, rhs)
            for context_left, context_right, lhs, rhs
            in legal_contexts(rule, tail)
        }
        assert (left, right) in legal, (name, tail, left, right)
        lhs, rhs = legal[(left, right)]
        add_scaled(total, edge_delta(lhs, rhs), multiplier)
        if rule.dynamic:
            dynamic_rows += 1
            dynamic_mass += multiplier

    assert dynamic_rows == 3
    assert dynamic_mass == 144057
    assert cleaned(total) == Counter(), cleaned(total)
    return dynamic_mass


def main() -> None:
    validate_rule_table()
    assert len(INTERIOR_EDGES) == 50
    assert len(LEGAL_EDGES) == 66
    context_count = sum(
        len(tuple(legal_contexts(rule, tail)))
        for rule in RULES
        for tail in VALUES
    )
    assert context_count == 441

    symbol_mass = validate_symbol_certificate()
    edge_mass = validate_edge_certificate()

    print("model equations = 22")
    print("fixed-terminal legal contexts =", context_count)
    print("symbol certificate rows = 8; dynamic mass =", symbol_mass)
    print("symbol weighted delta = {}")
    print("edge certificate rows = 50; dynamic mass =", edge_mass)
    print("edge weighted delta = {}")
    print("PASS")


if __name__ == "__main__":
    main()
