#!/usr/bin/env python3
"""Exact finite arithmetic check used by Round-7 Lemma L7.

External mathematical input (Rozier-Terracol Theorem 2.4): for a length-j
accelerated Collatz prefix with q odd terms,

    T^j(n) = (3^q / 2^j) n + E_j(n)

and

    E_j(n) <= (3^q - 2^q) / 2^q.

If the prefix is coefficient-contracting (3^q < 2^j) but non-descending,
then

    n <= F(j,q)
      = 2^(j-q) (3^q - 2^q) / (2^j - 3^q).

Barina's peer-reviewed verified base range gives convergence through 2^71.
This script checks, using exact integer arithmetic, that F(j,q) < 2^71 for
every coefficient-contracting pair with j <= 183, and locates the first j
for which this extremal bound can reach 2^71.

This script does NOT verify Rozier-Terracol's theorem or Barina's computation.
It checks only the finite arithmetic corollary between those external inputs.
"""

from __future__ import annotations


if not __debug__:
    raise RuntimeError(
        "Verification requires assertions; rerun without -O, -OO, "
        "or PYTHONOPTIMIZE."
    )

from fractions import Fraction

BASE = 1 << 71
SHORT_MAX_J = 183


def bound_F(j: int, q: int) -> Fraction | None:
    den = (1 << j) - 3**q
    if den <= 0:
        return None
    num = (1 << (j - q)) * (3**q - 2**q)
    return Fraction(num, den)


def log2_interval(frac: Fraction, digits: int = 12) -> str:
    """Diagnostic decimal log2; not used in proof assertions."""
    import math

    value = math.log2(frac.numerator) - math.log2(frac.denominator)
    return f"{value:.{digits}f}"


def check_short_range() -> tuple[int, int, Fraction]:
    best_j = -1
    best_q = -1
    best = Fraction(0, 1)

    for j in range(1, SHORT_MAX_J + 1):
        for q in range(0, j + 1):
            F = bound_F(j, q)
            if F is None:
                continue
            assert F < BASE, (j, q, F)
            if F > best:
                best_j, best_q, best = j, q, F

    return best_j, best_q, best


def first_reaching_base(search_to: int = 1000) -> tuple[int, int, Fraction]:
    for j in range(1, search_to + 1):
        for q in range(0, j + 1):
            F = bound_F(j, q)
            if F is not None and F >= BASE:
                return j, q, F
    raise AssertionError(f"no pair found through j={search_to}")


def main() -> None:
    j0, q0, best = check_short_range()
    j1, q1, first = first_reaching_base()

    assert (j0, q0) == (176, 111)
    assert (j1, q1) == (184, 116)

    print("Round 7 paradoxical-prefix finite barrier check")
    print("Exact arithmetic only")
    print(f"Published verification threshold B = 2^71 = {BASE}")
    print()
    print(f"PASS: F(j,q) < 2^71 for every j <= {SHORT_MAX_J} with 3^q < 2^j")
    print(f"Largest F in checked range occurs at (j,q)=({j0},{q0})")
    print(f"  F = {best.numerator}/{best.denominator}")
    print(f"  diagnostic log2(F) = {log2_interval(best)}")
    print()
    print("First j for which this extremal bound can reach 2^71:")
    print(f"  (j,q)=({j1},{q1})")
    print(f"  F = {first.numerator}/{first.denominator}")
    print(f"  diagnostic log2(F) = {log2_interval(first)}")
    print()
    print("This output checks only the finite corollary. It does not itself prove Collatz,")
    print("Rozier-Terracol Theorem 2.4, Theorem 5.3, or Barina's verified base range.")


if __name__ == "__main__":
    main()
