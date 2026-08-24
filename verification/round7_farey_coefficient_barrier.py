#!/usr/bin/env python3
"""Exact rational certificate for Round-7 Lemma L8.

Goal: certify the smallest denominator of a rational strictly between

    beta = log(2) / log(3 + 2^-71)
    alpha = log(2) / log(3)

without using floating-point comparisons.

Rozier-Terracol Corollary 4.4 plus a least-counterexample harmonic-mean lower
bound says a coefficient-contracting prefix above Barina's 2^71 verified range
requires floor(alpha*j)/j to lie in (beta, alpha).

We prove exact rational inequalities

    L < beta < M < alpha < R

where L,R are Farey neighbors and M is their mediant. Therefore every rational
in (beta,alpha) has denominator at least denom(M).

Logarithms are bounded using the positive series

    log(x) = 2 * sum_{k>=0} z^(2k+1)/(2k+1),
    z=(x-1)/(x+1),

with a rigorous geometric bound on the positive tail.  All proof comparisons
below are Fraction comparisons.  Decimal output is diagnostic only.
"""

from __future__ import annotations

from fractions import Fraction
from decimal import Decimal, getcontext

B = 1 << 71
N_TERMS = 100

L = Fraction(6_586_818_670, 10_439_860_591)
M = Fraction(72_057_431_991, 114_208_327_604)
R = Fraction(65_470_613_321, 103_768_467_013)


def log_interval(x: Fraction, n_terms: int = N_TERMS) -> tuple[Fraction, Fraction]:
    """Rigorous [lower,upper] interval for log(x), for rational x>1."""
    assert x > 1
    z = (x - 1) / (x + 1)
    assert 0 < z < 1
    z2 = z * z

    term = z
    partial = Fraction(0)
    for k in range(n_terms):
        partial += term / (2 * k + 1)
        term *= z2

    lower = 2 * partial

    # term = z^(2N+1).  Since 1/(2k+1) <= 1/(2N+1) for k>=N,
    # the remaining positive series is bounded by a geometric series.
    tail_upper = 2 * term / (2 * n_terms + 1) / (1 - z2)
    upper = lower + tail_upper
    return lower, upper


def ratio_interval(num: tuple[Fraction, Fraction], den: tuple[Fraction, Fraction]) -> tuple[Fraction, Fraction]:
    """Positive interval division."""
    nlo, nhi = num
    dlo, dhi = den
    assert 0 < nlo <= nhi and 0 < dlo <= dhi
    return nlo / dhi, nhi / dlo


def decimal(frac: Fraction, digits: int = 30) -> str:
    getcontext().prec = digits + 10
    return str(Decimal(frac.numerator) / Decimal(frac.denominator))


def main() -> None:
    ln2 = log_interval(Fraction(2))
    ln3 = log_interval(Fraction(3))
    ln3B = log_interval(Fraction(3 * B + 1, B))

    alpha_lo, alpha_hi = ratio_interval(ln2, ln3)
    beta_lo, beta_hi = ratio_interval(ln2, ln3B)

    # Rigorous placement.  Using interval endpoints in the conservative
    # direction proves the exact real-number inequalities.
    assert L < beta_lo
    assert beta_hi < M
    assert M < alpha_lo
    assert alpha_hi < R

    # Farey adjacency and mediant identity.
    det = R.numerator * L.denominator - L.numerator * R.denominator
    assert det == 1
    assert M.numerator == L.numerator + R.numerator
    assert M.denominator == L.denominator + R.denominator

    # The relevant numerator at denominator J is floor(alpha*J).
    J = M.denominator
    p = M.numerator
    assert M < alpha_lo
    assert alpha_hi < Fraction(p + 1, J)

    print("Round 7 Farey coefficient-barrier certificate")
    print("Exact Fraction arithmetic; decimal displays are diagnostic only")
    print()
    print(f"B = 2^71 = {B}")
    print(f"atanh-series terms per logarithm = {N_TERMS}")
    print()
    print("Certified ordering:")
    print("  L < beta_B < M < alpha < R")
    print(f"  L = {L.numerator}/{L.denominator}")
    print(f"  M = {M.numerator}/{M.denominator}")
    print(f"  R = {R.numerator}/{R.denominator}")
    print()
    print("Exact Farey determinant:")
    print(f"  R_num*L_den - L_num*R_den = {det}")
    print("Exact mediant check: PASS")
    print()
    print("Rigorous interval diagnostics:")
    print(f"  beta lower  ~= {decimal(beta_lo)}")
    print(f"  beta upper  ~= {decimal(beta_hi)}")
    print(f"  alpha lower ~= {decimal(alpha_lo)}")
    print(f"  alpha upper ~= {decimal(alpha_hi)}")
    print()
    print("Consequences:")
    print(f"  smallest possible denominator in (beta_B, alpha) = {J}")
    print(f"  floor(alpha*J) = {p}")
    print(f"  first candidate ratio = {p}/{J}")
    print()
    print("PASS: exact certificate establishes the 114,208,327,604-step barrier")
    print("subject to the external Barina base-range result and Rozier-Terracol Corollary 4.4.")


if __name__ == "__main__":
    main()
