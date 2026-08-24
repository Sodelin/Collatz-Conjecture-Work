#!/usr/bin/env python3
"""Round 7 diagnostic search for affine strong-induction Collatz shortcuts.

This program is NOT a proof of the Collatz conjecture. It searches a bounded
certificate class. A hit is useful because it can be rechecked symbolically;
a miss says only that this bounded class did not find a certificate.

For a fixed odd residue R modulo 2^K, write N(x)=2^K*x+R. The first K parity
decisions of the ordinary Collatz map are fixed, so U^t(N(x)) is affine in x
for t<=K.

The program searches for a smaller affine m(x)=A*x+B and a fixed parity word
of length j such that U^t(N(x)) = U^j(m(x)) identically. Then strong induction
can reduce convergence of N(x) to convergence of m(x), even if the common
orbit value is larger than N(x).
"""

from __future__ import annotations

from dataclasses import dataclass
from itertools import product
from typing import Iterable


def U(n: int) -> int:
    """Ordinary Collatz map."""
    return n // 2 if n % 2 == 0 else 3 * n + 1


def iterate(n: int, steps: int) -> int:
    for _ in range(steps):
        n = U(n)
    return n


def parity_word(n: int, steps: int) -> tuple[int, ...]:
    out = []
    for _ in range(steps):
        out.append(n & 1)
        n = U(n)
    return tuple(out)


def word_affine(word: tuple[int, ...]) -> tuple[int, int, int]:
    """Return (a,b,e) with U^j(m)=(a*m+b)/2^e along `word`.

    Here a=3^(number of odd steps). This formula is conditional on the input
    actually following the proposed parity word; every returned search hit is
    checked against that condition.
    """
    a, b, e = 1, 0, 0
    for odd in word:
        if odd:
            b = 3 * b + (1 << e)
            a *= 3
        else:
            e += 1
    return a, b, e


@dataclass(frozen=True)
class Certificate:
    K: int
    R: int
    t: int
    j: int
    A: int
    B: int
    word: tuple[int, ...]

    def N(self, x: int) -> int:
        return (1 << self.K) * x + self.R

    def m(self, x: int) -> int:
        return self.A * x + self.B


def affine_forward(K: int, R: int, t: int) -> tuple[int, int]:
    """Exact affine coefficients of U^t(2^K*x+R) for t<=K.

    Evaluate at x=1,2. Since the low K bits fix the first K parity decisions,
    the expression is affine throughout this cylinder.
    """
    M = 1 << K
    y1 = iterate(M + R, t)
    y2 = iterate(2 * M + R, t)
    A = y2 - y1
    B = y1 - A
    return A, B


def uniformly_smaller(M: int, R: int, A: int, B: int, x0: int = 1) -> bool:
    """Check 0 < A*x+B < M*x+R for all integer x>=x0 using affine slopes."""
    if A < 0:
        return False
    if A * x0 + B <= 0:
        return False
    d_slope = M - A
    d_at_x0 = d_slope * x0 + (R - B)
    if d_slope < 0:
        return False
    return d_at_x0 > 0


def validate(cert: Certificate, samples: Iterable[int] = (1, 2, 3, 4, 7, 11)) -> bool:
    """Diagnostic validation. The certificate semantics still need a proof/Lean checker."""
    for x in samples:
        N = cert.N(x)
        m = cert.m(x)
        if not (0 < m < N):
            return False
        if parity_word(m, cert.j) != cert.word:
            return False
        if iterate(N, cert.t) != iterate(m, cert.j):
            return False
    return True


def search_residue(K: int, R: int, max_back_depth: int = 10) -> Certificate | None:
    assert 0 < R < (1 << K) and R % 2 == 1
    M = 1 << K

    # Direct descent is j=0.
    for t in range(1, K + 1):
        yA, yB = affine_forward(K, R, t)
        if uniformly_smaller(M, R, yA, yB):
            cert = Certificate(K, R, t, 0, yA, yB, ())
            if validate(cert):
                return cert

    # Genuine coalescence: derive the only possible affine m(x) for each
    # proposed backward parity word.
    for t in range(1, K + 1):
        yA, yB = affine_forward(K, R, t)
        for j in range(1, max_back_depth + 1):
            for word in product((0, 1), repeat=j):
                a, b, e = word_affine(word)
                numA = (1 << e) * yA
                numB = (1 << e) * yB - b
                if numA % a or numB % a:
                    continue
                A, B = numA // a, numB // a
                if not uniformly_smaller(M, R, A, B):
                    continue
                cert = Certificate(K, R, t, j, A, B, tuple(word))
                if validate(cert):
                    return cert
    return None


def exact_demo_32x_plus_3() -> None:
    cert = Certificate(K=5, R=3, t=5, j=1, A=12, B=1, word=(1,))
    assert validate(cert)
    print("Exact demo:")
    print("  U^5(32*x+3) = U(12*x+1), with 0 < 12*x+1 < 32*x+3 for x>=1")


def sweep(max_K: int = 9, max_back_depth: int = 10) -> None:
    print("K,total_odd_cylinders,certified,uncertified")
    for K in range(3, max_K + 1):
        total = 1 << (K - 1)
        hits = 0
        survivors = []
        for R in range(1, 1 << K, 2):
            cert = search_residue(K, R, max_back_depth=max_back_depth)
            if cert is None:
                survivors.append(R)
            else:
                hits += 1
        print(f"{K},{total},{hits},{len(survivors)}")
        print("  first uncertified residues:", survivors[:24])


if __name__ == "__main__":
    exact_demo_32x_plus_3()
    sweep()
