#!/usr/bin/env python3
"""Finite-horizon extension signatures for unresolved Route-B cylinders.

For a residue R unresolved at depth K under the fixed bounded coalescence
certificate search, record which of its 2^h binary extensions remain unresolved
at depth K+h. Two parents with the same bitmask have the same *observed*
finite-horizon unresolved extension pattern.

This is only a state-compression diagnostic. The signatures depend on the
bounded certificate search and therefore are not mathematical invariants of
Collatz trajectories.
"""

from __future__ import annotations

from collections import Counter

from verification.round7_affine_coalescence_search import search_residue


def survivors(K: int, reverse_depth: int = 16) -> list[int]:
    return [
        R
        for R in range(1, 1 << K, 2)
        if search_residue(K, R, max_back_depth=reverse_depth) is None
    ]


def extension_mask(K: int, R: int, h: int, target: set[int]) -> int:
    mask = 0
    for e in range(1 << h):
        child = R + (e << K)
        if child in target:
            mask |= 1 << e
    return mask


def run(min_K: int = 5, max_K: int = 15, max_h: int = 4, reverse_depth: int = 16) -> None:
    saved = {K: survivors(K, reverse_depth) for K in range(min_K, max_K + 1)}

    print("Round 7 finite-horizon unresolved-language signatures")
    print("IMPORTANT: diagnostic of one bounded certificate search, not a Collatz invariant")

    for h in range(1, max_h + 1):
        print()
        print(f"h={h}")
        print("K,parent_survivors,distinct_extension_signatures,largest_signature_multiplicity")
        for K in range(min_K, max_K - h + 1):
            target = set(saved[K + h])
            counts = Counter(extension_mask(K, R, h, target) for R in saved[K])
            largest = max(counts.values(), default=0)
            print(f"{K},{len(saved[K])},{len(counts)},{largest}")

    print()
    print("Interpretation:")
    print("- h=1 can have at most 3 nonempty patterns because a currently unresolved parent has")
    print("  low-only, high-only, or both unresolved children in the observed search.")
    print("- A small/stable number of signatures at larger h would motivate a finite-state quotient.")
    print("- Growth in the number of signatures is a warning that the current observable is too coarse;")
    print("  it does not prove that no other finite/regular mixed-radix quotient exists.")


if __name__ == "__main__":
    run()
