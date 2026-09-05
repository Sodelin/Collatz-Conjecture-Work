"""Exact finite regression for L14's odd trajectory normal form.

This checker validates local integer identities over a reported finite range.
It does not prove Collatz and does not replace the universal prose proof.
"""

from __future__ import annotations


if not __debug__:
    raise RuntimeError(
        "Verification requires assertions; rerun without -O, -OO, "
        "or PYTHONOPTIMIZE."
    )

import argparse
from collections import Counter
from dataclasses import dataclass


def v2(n: int) -> int:
    if n <= 0:
        raise ValueError("v2 expects a positive integer")
    return (n & -n).bit_length() - 1


def oddpart(n: int) -> int:
    return n >> v2(n)


def U(n: int) -> int:
    if n <= 0 or n % 2 == 0:
        raise ValueError("U expects a positive odd integer")
    return oddpart(3 * n + 1)


def shortcut_T(n: int) -> int:
    if n <= 0:
        raise ValueError("T expects a positive integer")
    return n // 2 if n % 2 == 0 else (3 * n + 1) // 2


def iterate(function, value: int, steps: int) -> int:
    for _ in range(steps):
        value = function(value)
    return value


def in_terminal_set(n: int) -> bool:
    return n == 1 or n % 8 == 7 or n % 32 == 27


@dataclass(frozen=True)
class Reduction:
    kind: str
    target: int


def reduction_step(x: int) -> Reduction | None:
    if x <= 0 or x % 2 == 0:
        raise ValueError("reduction expects a positive odd integer")
    if x == 1:
        return None

    a = v2(3 * x + 1)
    if a >= 2:
        target = U(x)
        assert target < x
        return Reduction("a>=2", target)

    c = v2(3 * x - 1)
    p = (3 * x - 1) >> c
    assert c >= 2 and p > 0 and p % 2 == 1

    if c % 2 == 1:
        j = (c - 3) // 2
        target = 3**j * p

        current = x
        for r in range(j + 1):
            current = U(current)
            expected = 3**r * 2 ** (2 * j + 2 - 2 * r) * p + 1
            assert current == expected
        assert U(current) == U(target)

        numerator = (2 ** (2 * j + 3) - 3 ** (j + 1)) * p + 1
        assert 3 * (x - target) == numerator
        assert target < x
        return Reduction("c odd", target)

    if c >= 6:
        j = (c - 2) // 2
        assert j >= 2
        target = 2 * 3**j * p + 1

        current = x
        for r in range(j + 1):
            current = U(current)
            expected = 3**r * 2 ** (2 * j + 1 - 2 * r) * p + 1
            assert current == expected
        assert current == target

        numerator = (4 ** (j + 1) - 2 * 3 ** (j + 1)) * p - 2
        assert 3 * (x - target) == numerator
        assert target < x
        return Reduction("c even >= 6", target)

    assert c in (2, 4)
    assert in_terminal_set(x)
    return None


def normal_form(n: int, counts: Counter[str]) -> tuple[int, int]:
    steps = 0
    current = n
    while True:
        reduction = reduction_step(current)
        if reduction is None:
            assert in_terminal_set(current)
            return current, steps
        counts[reduction.kind] += 1
        assert 0 < reduction.target < current
        current = reduction.target
        steps += 1


def check_range(limit: int) -> tuple[Counter[str], int, Counter[str]]:
    counts: Counter[str] = Counter()
    terminals: Counter[str] = Counter()
    max_steps = 0

    for n in range(1, limit + 1, 2):
        expected_terminal = n == 1 or n % 8 == 7 or n % 32 == 27
        assert (reduction_step(n) is None) == expected_terminal

        terminal, steps = normal_form(n, counts)
        assert terminal <= n
        max_steps = max(max_steps, steps)
        if terminal == 1:
            terminals["1"] += 1
        elif terminal % 8 == 7:
            terminals["7 mod 8"] += 1
        else:
            assert terminal % 32 == 27
            terminals["27 mod 32"] += 1

    return counts, max_steps, terminals


def check_scope_regressions(counterfamily_limit: int) -> None:
    # These fail if U is silently replaced by the one-division shortcut map.
    assert U(5) == 1
    assert shortcut_T(5) == 8 > 5
    assert iterate(shortcut_T, 3, 2) == 8
    assert shortcut_T(1) == 2

    # The submitted exhaustion sentence is false on an infinite affine family.
    for s in range(counterfamily_limit + 1):
        x0 = 64 * s + 55
        x1 = 96 * s + 83
        x2 = 144 * s + 125
        x3 = 54 * s + 47
        assert x0 % 8 == 7
        assert U(x0) == x1
        assert U(x1) == x2
        assert U(x2) == x3
        assert x3 < x0

    # Existing L13 coalescence also reduces an L14 terminal state.
    assert 23 % 8 == 7
    assert (3 * 23 - 1) // 4 == 17 < 23
    assert iterate(shortcut_T, 23, 5) == 20
    assert iterate(shortcut_T, 17, 3) == 20

    # The auxiliary minus-map cycle must not be mistaken for U or T.
    V = lambda x: oddpart(3 * x - 1)
    assert V(5) == 7
    assert V(7) == 5


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--limit", type=int, default=1_000_000)
    parser.add_argument("--counterfamily-limit", type=int, default=10_000)
    args = parser.parse_args()
    if args.limit < 1:
        raise SystemExit("--limit must be positive")
    if args.counterfamily_limit < 0:
        raise SystemExit("--counterfamily-limit must be nonnegative")

    counts, max_steps, terminals = check_range(args.limit)
    check_scope_regressions(args.counterfamily_limit)

    checked = (args.limit + 1) // 2
    print(f"odd starts checked = {checked} (1 <= n <= {args.limit})")
    print(f"macro-edge counts = {dict(sorted(counts.items()))}")
    print(f"maximum normalizer edges = {max_steps}")
    print(f"terminal counts = {dict(sorted(terminals.items()))}")
    print(
        "exhaustion counterfamily checked = "
        f"0 <= s <= {args.counterfamily_limit}"
    )
    print("PASS")


if __name__ == "__main__":
    main()
