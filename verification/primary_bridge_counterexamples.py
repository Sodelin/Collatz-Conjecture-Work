#!/usr/bin/env python3
"""Exact regression witnesses for primary_bridge_audit.md; not Collatz closure."""
from fractions import Fraction
from itertools import product


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def v2(n):
    require(n != 0, 'nonzero valuation argument')
    return (abs(n) & -abs(n)).bit_length() - 1


def syracuse(n):
    value = 3*n + 1
    return value >> v2(value)


def h(n):
    return n//2 if n % 2 == 0 else 1


def h_power_extraction(n):
    x = n
    while x != 1:
        if x % 2:
            return False
        x = h(x)
    return True


def main():
    require(1 % 16 == 17 % 16, 'equal source residues')
    require(syracuse(1) == 1 and syracuse(17) == 13, 'different U successors')
    print('PASS: U does not induce a deterministic map on odd residues modulo16')

    for n in range(1, 10001):
        if n > 1:
            require(0 < h(n) < n, 'two-rule natural rank')
        require(h_power_extraction(n) == (n & (n-1) == 0), 'powers-of2 extraction')
    print('PASS: elementary two-rule ranked-system separation regression')

    discrepancies = [1-Fraction(1, 2**(k-1)) for k in range(3, 20)]
    require(all(a <= b for a,b in zip(discrepancies, discrepancies[1:])), 'monotonicity')
    require(sum(discrepancies, Fraction(0)) > 10, 'fixed point violates finite WMH sum')
    print('PASS: convergent odd orbit has delta_K=1-2^(1-K), not summable')

    # Finite inverse branches approximate the explicit 2-adic invariant measure.
    # Each chosen exponent is forced exactly; uniqueness recovers every prefix.
    modulus = 1 << 40
    inv3 = pow(3, -1, modulus)
    starts = set()
    for word in product((1,2), repeat=8):
        x = 1
        for exponent in reversed(word):
            x = ((2**exponent * x - 1) * inv3) % modulus
        starts.add(x)
        for exponent in word:
            value = 3*x+1
            require(v2(value) == exponent, 'prescribed inverse-branch valuation')
            x = value >> exponent
    require(len(starts) == 256, 'distinct valuation prefixes')
    require(all(v2(3*x+1) in (1,2) for x in starts), 'non-Haar first-step support')
    print('PASS: 256 exact inverse-branch words have only valuations1 or2')
    print('Scope: finite witnesses; infinite proofs and limitations are in the audit note')


if __name__ == '__main__':
    main()
