#!/usr/bin/env python3
"""Exact full/extended scalar-arctic no-start certificates for YAH.

The checker reconstructs the 22 rules obtained by labeling the eleven-rule
Yolcu--Aaronson--Heule Collatz system with the fixed two-state suffix algebra.
It then verifies an all-positive word-count cancellation.  In dimension one,
an extended arctic-natural interpretation has one finite natural matrix
coefficient per labeled symbol and constant coefficient -infinity.  Word
coefficients are therefore ordinary sums.  The cancellation forces every weak
rule coefficient delta to be
zero, so no labeled rule can be removed strictly at the first full/relative
rule-removal step.

Collapsing the two tail states gives a second all-positive cancellation on the
original eleven-rule system itself.  The checker verifies both identities.

This is not a top-termination certificate and says nothing about higher
dimensions, other carriers or labelings, local/reachable-only relations, or
the Collatz conjecture.
"""

from __future__ import annotations


if not __debug__:
    raise RuntimeError(
        "Verification requires assertions; rerun without -O, -OO, "
        "or PYTHONOPTIMIZE."
    )

from collections import Counter
from dataclasses import dataclass


STATES = (0, 1)

# Unary maps are represented by (value at 0, value at 1).
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


RULES = (
    Rule("D_f", ("f", "$"), ("$",)),
    Rule("D_t", ("t", "$"), ("2", "$")),
    Rule("X_f0", ("f", "0"), ("0", "f")),
    Rule("X_f1", ("f", "1"), ("0", "t")),
    Rule("X_f2", ("f", "2"), ("1", "f")),
    Rule("X_t0", ("t", "0"), ("1", "t")),
    Rule("X_t1", ("t", "1"), ("2", "f")),
    Rule("X_t2", ("t", "2"), ("2", "t")),
    Rule("X_^0", ("^", "0"), ("^", "t")),
    Rule("X_^1", ("^", "1"), ("^", "f", "f")),
    Rule("X_^2", ("^", "2"), ("^", "f", "t")),
)

Token = tuple[str, int]


def eval_word(word: tuple[str, ...], tail: int) -> int:
    value = tail
    for symbol in reversed(word):
        value = ALGEBRA[symbol][value]
    return value


def label_word(word: tuple[str, ...], tail: int) -> tuple[Token, ...]:
    """Attach to each symbol the algebra value of its suffix."""
    value = tail
    labeled: list[Token] = []
    for symbol in reversed(word):
        labeled.append((symbol, value))
        value = ALGEBRA[symbol][value]
    labeled.reverse()
    return tuple(labeled)


def delta(lhs: tuple[Token, ...], rhs: tuple[Token, ...]) -> Counter[Token]:
    result = Counter(lhs)
    result.subtract(rhs)
    return Counter(
        {token: coefficient for token, coefficient in result.items() if coefficient}
    )


# One strictly positive multiplier for every labeled rule instance.
MULTIPLIER = {
    ("D_f", 0): 3,
    ("D_f", 1): 1,
    ("D_t", 0): 6,
    ("D_t", 1): 1,
    ("X_f0", 0): 1,
    ("X_f0", 1): 4,
    ("X_f1", 0): 5,
    ("X_f1", 1): 1,
    ("X_f2", 0): 7,
    ("X_f2", 1): 2,
    ("X_t0", 0): 2,
    ("X_t0", 1): 1,
    ("X_t1", 0): 3,
    ("X_t1", 1): 1,
    ("X_t2", 0): 3,
    ("X_t2", 1): 1,
    ("X_^0", 0): 2,
    ("X_^0", 1): 1,
    ("X_^1", 0): 1,
    ("X_^1", 1): 1,
    ("X_^2", 0): 1,
    ("X_^2", 1): 1,
}

# The state-collapsed multiplier in the original eleven-rule order.  It is
# derived by summing the two labeled-instance multipliers for each rule.
UNLABELED_MULTIPLIER = {
    "D_f": 4,
    "D_t": 7,
    "X_f0": 5,
    "X_f1": 6,
    "X_f2": 9,
    "X_t0": 3,
    "X_t1": 4,
    "X_t2": 4,
    "X_^0": 3,
    "X_^1": 2,
    "X_^2": 2,
}


def cleaned(counter: Counter[Token]) -> Counter[Token]:
    return Counter(
        {token: coefficient for token, coefficient in counter.items() if coefficient}
    )


def main() -> None:
    assert len(RULES) == 11
    assert len({rule.name for rule in RULES}) == 11
    expected_keys = {(rule.name, tail) for rule in RULES for tail in STATES}
    assert set(MULTIPLIER) == expected_keys
    assert all(weight > 0 for weight in MULTIPLIER.values())
    assert sum(MULTIPLIER.values()) == 49
    assert set(UNLABELED_MULTIPLIER) == {rule.name for rule in RULES}
    assert all(weight > 0 for weight in UNLABELED_MULTIPLIER.values())
    assert sum(UNLABELED_MULTIPLIER.values()) == 49
    assert all(
        UNLABELED_MULTIPLIER[rule.name]
        == sum(MULTIPLIER[(rule.name, tail)] for tail in STATES)
        for rule in RULES
    )

    total: Counter[Token] = Counter()
    unlabeled_total: Counter[str] = Counter()
    all_tokens: set[Token] = set()
    rows = 0

    for rule in RULES:
        symbol_delta = Counter(rule.lhs)
        symbol_delta.subtract(rule.rhs)
        for symbol, coefficient in symbol_delta.items():
            unlabeled_total[symbol] += (
                UNLABELED_MULTIPLIER[rule.name] * coefficient
            )
        for tail in STATES:
            assert eval_word(rule.lhs, tail) == eval_word(rule.rhs, tail)
            lhs = label_word(rule.lhs, tail)
            rhs = label_word(rule.rhs, tail)
            all_tokens.update(lhs)
            all_tokens.update(rhs)
            weight = MULTIPLIER[(rule.name, tail)]
            for token, coefficient in delta(lhs, rhs).items():
                total[token] += weight * coefficient
            rows += 1

    assert rows == 22
    assert all_tokens == {
        (symbol, state) for symbol in ALGEBRA for state in STATES
    }
    assert cleaned(total) == Counter()
    assert Counter(
        {
            symbol: coefficient
            for symbol, coefficient in unlabeled_total.items()
            if coefficient
        }
    ) == Counter()

    print("unlabeled certificate rows =", len(RULES))
    print("unlabeled total multiplier =", sum(UNLABELED_MULTIPLIER.values()))
    print("weighted unlabeled symbol-count delta = {}")
    print("ORIGINAL_FULL_EXTENDED_SCALAR_ARCTIC_NO_START = PASS")
    print("semantic equations = 22")
    print("labeled tokens =", len(all_tokens))
    print("certificate rows =", rows)
    print("all multipliers positive = PASS")
    print("total multiplier =", sum(MULTIPLIER.values()))
    print("weighted token-count delta = {}")
    print("FULL_EXTENDED_SCALAR_ARCTIC_NO_START = PASS")


if __name__ == "__main__":
    main()
