#!/usr/bin/env python3
"""Round-7 exact accelerated-map macro coalescence search.

This is an untrusted finite certificate generator, not a proof of Collatz.

It uses the once-accelerated map

    T(n) = n/2            if n even
           (3*n+1)/2      if n odd

which is the convention used by the Yolcu-Aaronson-Heule mixed binary/ternary
rewriting system. For a cylinder N(x)=2^K*x+R, the first K T-steps are uniform.
At every exact forward affine state Y=A*x+B we search finite inverse words over

    E(y)=2y
    O(y)=(2y-1)/3, valid only when A divisible by 3 and B == 2 mod 3.

A hit is an exact identity T^t(N(x)) = T^j(m(x)) with m(x)<N(x) eventually.
Finite small x below the exact threshold are not silently assumed away; the
certificate records that threshold.
"""

from __future__ import annotations

from collections import deque
from dataclasses import dataclass


@dataclass(frozen=True)
class MacroCertificate:
    K: int
    R: int
    forward_steps: int
    inverse_word: str
    A: int
    B: int
    x0: int

    def N(self, x: int) -> int:
        return (1 << self.K) * x + self.R

    def m(self, x: int) -> int:
        return self.A * x + self.B


def T(n: int) -> int:
    return n // 2 if n % 2 == 0 else (3 * n + 1) // 2


def iterate_T(n: int, k: int) -> int:
    for _ in range(k):
        n = T(n)
    return n


def uniform_T_path(K: int, R: int) -> list[tuple[int, int, int]]:
    """Exact affine states for the K binary decisions of a 2^K cylinder."""
    A, B = 1 << K, R
    out: list[tuple[int, int, int]] = []
    for t in range(1, K + 1):
        assert A % 2 == 0
        if B % 2 == 0:
            A //= 2
            B //= 2
        else:
            A = 3 * A // 2
            B = (3 * B + 1) // 2
        out.append((t, A, B))
    assert out[-1][1] % 2 == 1
    return out


def minimum_x_for_smaller(M: int, R: int, A: int, B: int) -> int | None:
    """Exact eventual comparison, including equal-slope smaller translations."""
    if A < 0 or A > M:
        return None
    if A == M and B >= R:
        return None
    x0 = 0
    if A == 0:
        if B <= 0:
            return None
    elif B <= 0:
        x0 = max(x0, (-B) // A + 1)

    if A < M:
        D = M - A
        E = R - B
        if E <= 0:
            x0 = max(x0, (-E) // D + 1)
    return x0


def apply_inverse_word(A: int, B: int, word: str) -> tuple[int, int] | None:
    for symbol in word:
        if symbol == "E":
            A, B = 2 * A, 2 * B
        elif symbol == "O":
            if A % 3 != 0 or B % 3 != 2:
                return None
            A, B = 2 * A // 3, (2 * B - 1) // 3
        else:
            raise ValueError(symbol)
    return A, B


def validate(cert: MacroCertificate) -> bool:
    """Exact whole-family affine validation plus redundant sample replay."""
    M = 1 << cert.K
    if not (0 < cert.R < M and cert.R % 2 == 1):
        return False
    states = {t: (A, B) for t, A, B in uniform_T_path(cert.K, cert.R)}
    target = states.get(cert.forward_steps)
    if target is None:
        return False
    if apply_inverse_word(*target, cert.inverse_word) != (cert.A, cert.B):
        return False
    if minimum_x_for_smaller(M, cert.R, cert.A, cert.B) != cert.x0:
        return False

    samples = sorted(set([cert.x0, cert.x0 + 1, cert.x0 + 2, 0, 1, 2, 3, 7, 29]))
    for x in samples:
        if x < cert.x0:
            continue
        N = cert.N(x)
        m = cert.m(x)
        if not (0 < m < N):
            return False
        if iterate_T(N, cert.forward_steps) != iterate_T(m, len(cert.inverse_word)):
            return False
    return True


def search_residue(K: int, R: int, max_inverse_depth: int = 10) -> MacroCertificate | None:
    M = 1 << K

    for t, yA, yB in uniform_T_path(K, R):
        x0 = minimum_x_for_smaller(M, R, yA, yB)
        if x0 is not None:
            cert = MacroCertificate(K, R, t, "", yA, yB, x0)
            if validate(cert):
                return cert

        queue = deque([(yA, yB, "")])
        seen = {(yA, yB)}

        while queue:
            A, B, word = queue.popleft()
            if len(word) >= max_inverse_depth:
                continue

            # Even inverse: always exact.
            EA, EB = 2 * A, 2 * B
            if (EA, EB) not in seen:
                seen.add((EA, EB))
                ew = word + "E"
                x0 = minimum_x_for_smaller(M, R, EA, EB)
                if x0 is not None:
                    cert = MacroCertificate(K, R, t, ew, EA, EB, x0)
                    if validate(cert):
                        return cert
                queue.append((EA, EB, ew))

            # Odd inverse: exact whole-family condition.
            if A % 3 == 0 and B % 3 == 2:
                OA, OB = 2 * A // 3, (2 * B - 1) // 3
                if (OA, OB) not in seen:
                    seen.add((OA, OB))
                    ow = word + "O"
                    x0 = minimum_x_for_smaller(M, R, OA, OB)
                    if x0 is not None:
                        cert = MacroCertificate(K, R, t, ow, OA, OB, x0)
                        if validate(cert):
                            return cert
                    queue.append((OA, OB, ow))

    return None


def exact_demo() -> None:
    # Equal-slope boundary omitted by the original affine comparison helper.
    assert apply_inverse_word(3, 2, "OEE") == (8, 4)
    assert minimum_x_for_smaller(8, 5, 8, 4) == 0
    equal = MacroCertificate(3, 5, 3, "OEE", 8, 4, 0)
    assert validate(equal)

    cert = search_residue(12, 1023, max_inverse_depth=10)
    assert cert is not None
    assert cert.A == 3072 and cert.B == 767
    print("Equal-slope comparison regression:")
    print("  T^3(8*x+5) = T^3(8*x+4) = 3*x+2")
    print("  inverse word: OEE")
    print("  and 0 < 8*x+4 < 8*x+5 for every x>=0")
    print()
    print("Exact new macro certificate:")
    print("  T^12(4096*x+1023) = T^10(3072*x+767)")
    print("  inverse word:", cert.inverse_word)
    print("  and 0 < 3072*x+767 < 4096*x+1023 for all x>=0")


def sweep(max_K: int = 15, max_inverse_depth: int = 10) -> None:
    print("K,total_odd,certified,unresolved")
    for K in range(3, max_K + 1):
        survivors: list[int] = []
        for R in range(1, 1 << K, 2):
            if search_residue(K, R, max_inverse_depth=max_inverse_depth) is None:
                survivors.append(R)
        total = 1 << (K - 1)
        print(f"{K},{total},{total-len(survivors)},{len(survivors)}")
        print("  first unresolved:", survivors[:24])


if __name__ == "__main__":
    if not __debug__:
        raise RuntimeError(
            "This certificate verifier requires assertions; do not run Python with -O."
        )
    exact_demo()
    sweep()
