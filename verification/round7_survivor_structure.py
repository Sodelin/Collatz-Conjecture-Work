#!/usr/bin/env python3
"""Structural diagnostics for Round-7 affine/coalescence survivors.

This script imports the exact bounded certificate search from
`round7_affine_coalescence_search.py` and asks how much of the residue tree is
already eliminated by the endpoint slope alone versus by additional affine
coalescence certificates.

Nothing printed by this program is a proof or disproof of Collatz. The purpose
is to identify state-compression structure and decide whether Route B merits a
finite recursive graph search.
"""

from __future__ import annotations


if not __debug__:
    raise RuntimeError(
        "Verification requires assertions; rerun without -O, -OO, "
        "or PYTHONOPTIMIZE."
    )

from collections import Counter, defaultdict
from math import comb

from verification.round7_affine_coalescence_search import (
    search_residue,
    uniform_forward_path,
)


def endpoint_exponent(K: int, R: int) -> int:
    """Return s when the maximal uniform endpoint coefficient is 3^s."""
    _, A, _ = uniform_forward_path(K, R)[-1]
    s = 0
    while A > 1 and A % 3 == 0:
        A //= 3
        s += 1
    assert A == 1
    return s


def slope_hard(K: int, s: int) -> bool:
    """True when the maximal uniform endpoint does not contract by slope."""
    return 3**s >= 2**K


def survivors(K: int, reverse_depth: int = 16) -> list[int]:
    out: list[int] = []
    for R in range(1, 1 << K, 2):
        if search_residue(K, R, max_back_depth=reverse_depth) is None:
            out.append(R)
    return out


def verify_binomial_law(K: int) -> Counter[int]:
    counts: Counter[int] = Counter()
    for R in range(1, 1 << K, 2):
        counts[endpoint_exponent(K, R)] += 1
    expected = Counter({s: comb(K - 1, s - 1) for s in range(1, K + 1)})
    assert counts == expected
    return counts


def sweep(min_K: int = 3, max_K: int = 15, reverse_depth: int = 16) -> None:
    print("Round 7 survivor-structure diagnostic")
    print("IMPORTANT: bounded certificate search only; not a Collatz proof/disproof")
    print()
    print("K,total_odd,slope_hard,coalescence_unresolved,unresolved_fraction,unresolved_of_hard")
    saved: dict[int, list[int]] = {}

    for K in range(min_K, max_K + 1):
        counts = verify_binomial_law(K)
        hard = sum(n for s, n in counts.items() if slope_hard(K, s))
        rem = survivors(K, reverse_depth=reverse_depth)
        saved[K] = rem
        total = 1 << (K - 1)
        print(
            f"{K},{total},{hard},{len(rem)},"
            f"{len(rem)/total:.9f},{len(rem)/hard:.9f}"
        )

    print()
    K = max_K - 3 if max_K >= 6 else max_K
    if K in saved and K + 1 in saved:
        parents = saved[K]
        children = set(saved[K + 1])
        patterns: Counter[tuple[bool, bool]] = Counter()
        by_s: dict[int, Counter[tuple[bool, bool]]] = defaultdict(Counter)
        for R in parents:
            pat = (R in children, R + (1 << K) in children)
            patterns[pat] += 1
            by_s[endpoint_exponent(K, R)][pat] += 1

        print(f"Child-survival patterns from K={K} to K={K+1}")
        print("pattern=(low-child-survives, high-child-survives)")
        for pat, n in sorted(patterns.items()):
            print(f"  {pat}: {n}")
        print("By parent endpoint exponent s:")
        for s in sorted(by_s):
            print(f"  s={s}: {dict(by_s[s])}")

    if 12 in saved:
        print()
        print("K=12 survivors by endpoint slope exponent")
        c = Counter(endpoint_exponent(12, R) for R in saved[12])
        for s in sorted(c):
            hard_population = comb(11, s - 1) if slope_hard(12, s) else 0
            print(f"  s={s}: unresolved={c[s]}, slope-hard population={hard_population}")


if __name__ == "__main__":
    sweep()
