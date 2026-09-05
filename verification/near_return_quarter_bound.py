#!/usr/bin/env python3
"""Exact finite certificate for the universal first-contraction quarter bound.

No sampled Collatz trajectories and no floating-point acceptance tests.
The analytic reduction to these finite certificates is in
../proof-search/lemmas/L15_Quarter_Gap_and_Rotation_Block_Certificate.md. Python assertions are regression checks,
not Lean formalization.
"""
from fractions import Fraction

if not __debug__:
    raise SystemExit("Run without -O: this certificate requires assertions.")


def weight(k: int) -> Fraction:
    """2**(-frac(k*log2(3))), evaluated exactly for integral k."""
    if k == 0:
        return Fraction(1)
    power = 3 ** abs(k)
    floor_log = power.bit_length() - 1
    assert (1 << floor_log) <= power < (1 << (floor_log + 1))
    if k > 0:
        return Fraction(1 << floor_log, power)
    return Fraction(power, 1 << (floor_log + 1))


def phase_sums(block: int) -> list[Fraction]:
    """All possible maxima of a block sum over its starting phase.

    Its only upward discontinuities occur at theta=frac(-i*log2(3)).
    At such a phase the sum is sum(weight(k-i), k=0..block-1).
    It strictly decreases between successive discontinuities.
    """
    if block == 0:
        return [Fraction(0)]
    current = sum((weight(k) for k in range(block)), Fraction(0))
    sums = [current]
    for i in range(1, block):
        current += weight(-i) - weight(block - i)
        sums.append(current)
    return sums


def block_max(block: int) -> Fraction:
    return max(phase_sums(block))


def exact_remainder(s: int) -> tuple[int, int]:
    """L9 mechanical maximum C_s and first contraction length tau_s.

    At odd number s, its deadline exponent is floor((s-1)*log2(3)).
    Every acceptance comparison remains integral.
    """
    c, power = 0, 1
    for _ in range(s):
        c = 3 * c + (1 << (power.bit_length() - 1))
        power *= 3
    return c, power.bit_length()


def strict_integer_upper(value: Fraction) -> int:
    """Largest integer strictly below a rational bound."""
    return (value.numerator - 1) // value.denominator


def main() -> None:
    expected = [
        Fraction(0), Fraction(1), Fraction(7, 4), Fraction(23, 9),
        Fraction(119, 36), Fraction(319, 81), Fraction(1213, 256),
        Fraction(5581, 1024), Fraction(14501, 2304),
        Fraction(64565, 9216), Fraction(159181, 20736),
        Fraction(695773, 82944), Fraction(2349463, 262144),
    ]
    maxima = [block_max(b) for b in range(13)]
    assert maxima == expected
    for b, result in enumerate(maxima):
        # Independent direct summation checks the sliding-window evaluation.
        if b:
            direct = [sum((weight(k-i) for k in range(b)), Fraction(0))
                      for i in range(b)]
            assert direct == phase_sums(b)
        print(f"M_{b}={result}")
    slack = 9 - maxima[12]
    excess = max(maxima[r] - Fraction(3*r, 4) for r in range(12))
    assert slack == Fraction(9833, 262144)
    assert excess == Fraction(11, 36)
    assert 9 * slack > excess
    print(f"12-block slack={slack}; remainder excess={excess}")
    print("PASS: S_s < 3*s/4 for every s >= 108, by the block theorem")

    equality = []
    for s in range(1, 108):
        c, tau = exact_remainder(s)
        margin = s * (1 << tau) - 4 * c
        assert margin >= 0, (s, c, tau, margin)
        if margin == 0:
            equality.append(s)
        # Independent reconstruction of the mechanical remainder sum.
        direct = sum((1 << ((3**r).bit_length()-1)) * 3**(s-r-1)
                     for r in range(s))
        assert c == direct
    assert equality == [1]
    print("PASS: 4*C_s <= s*2^tau_s for 1 <= s <= 107; equality only s=1")
    print("THEOREM CERTIFICATE: every first-contraction gap d>=0 obeys 4*d<s")

    frontier_s = 72_057_431_991
    coarse = (frontier_s - 1) // 4
    hard_gap = 4 * (coarse // 4)
    assert coarse == 18_014_357_997
    assert hard_gap == 18_014_357_996
    print(f"L8 frontier quarter bound: d <= {coarse:,}")
    print(f"L8 frontier quarter bound with L11: d <= {hard_gap:,}")

    # Optional stronger bound from the same universally valid finite theorem.
    # This constructs only 1024 exact phase candidates, not an orbit search.
    block = 1024
    q, r = divmod(frontier_s, block)
    refined = (q * block_max(block) + block_max(r)) / 3
    refined_integer = strict_integer_upper(refined)
    refined_hard = 4 * (refined_integer // 4)
    assert refined_integer < coarse
    print(f"L8 frontier exact 1024-block bound: d <= {refined_integer:,}")
    print(f"L8 frontier exact 1024-block bound with L11: d <= {refined_hard:,}")
    print("PASS: exact arithmetic certificate; no Collatz closure asserted")


if __name__ == "__main__":
    main()
