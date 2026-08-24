#!/usr/bin/env python3
"""Round 7 diagnostic search for exact affine strong-induction Collatz shortcuts.

This program is NOT a proof of the Collatz conjecture. It searches a bounded
certificate class. A hit is useful because it is an exact symbolic identity; a
miss says only that this bounded certificate class did not find a reduction.

For a fixed odd residue R modulo 2^K, write

    N(x) = 2^K*x + R.

As long as the coefficient of x remains even, the parity of the whole affine
family is fixed by its intercept. Hence the ordinary Collatz map U can be
applied symbolically beyond K *ordinary* steps when odd steps intervene. The
symbolic path ends precisely when the coefficient becomes odd and parity then
depends on x.

We search for either:
  (1) direct descent U^t(N(x)) < N(x) uniformly; or
  (2) coalescence U^t(N(x)) = U^j(m(x)) with a uniformly smaller affine
      m(x)=A*x+B.

Case (2) is enough for strong induction even when the common orbit value is
larger than N(x).
"""

from __future__ import annotations

from collections import deque
from dataclasses import dataclass
from typing import Iterable


def U(n: int) -> int:
    return n // 2 if n % 2 == 0 else 3 * n + 1


def iterate(n: int, steps: int) -> int:
    for _ in range(steps):
        n = U(n)
    return n


def parity_word(n: int, steps: int) -> tuple[int, ...]:
    out: list[int] = []
    for _ in range(steps):
        out.append(n & 1)
        n = U(n)
    return tuple(out)


@dataclass(frozen=True)
class Certificate:
    K: int
    R: int
    t: int
    j: int
    A: int
    B: int
    word: tuple[int, ...]
    x0: int = 0

    def N(self, x: int) -> int:
        return (1 << self.K) * x + self.R

    def m(self, x: int) -> int:
        return self.A * x + self.B


def minimum_x_for_smaller(M: int, R: int, A: int, B: int) -> int | None:
    """Least x0>=0 such that 0 < A*x+B < M*x+R for every x>=x0.

    Since both inequalities are affine and M>A is required asymptotically,
    this is exact integer arithmetic.
    """
    if A < 0 or A >= M:
        return None

    x0 = 0
    if A == 0:
        if B <= 0:
            return None
    elif B <= 0:
        x0 = max(x0, (-B) // A + 1)

    D = M - A  # positive
    E = R - B
    if E <= 0:
        x0 = max(x0, (-E) // D + 1)

    return x0


def uniform_forward_path(K: int, R: int) -> list[tuple[int, int, int]]:
    """All exact affine states before this 2-adic cylinder branches.

    Returns triples (t,A,B) with U^t(2^K*x+R)=A*x+B for every integer x>=0.
    The path stops before the first step at which A is odd, because then parity
    of A*x+B depends on x.
    """
    A, B = 1 << K, R
    out: list[tuple[int, int, int]] = []
    t = 0

    while A % 2 == 0:
        if B % 2 == 0:
            # Uniformly even.
            A //= 2
            B //= 2
        else:
            # Uniformly odd.
            A *= 3
            B = 3 * B + 1
        t += 1
        out.append((t, A, B))

    return out


def validate(cert: Certificate, extra_samples: Iterable[int] = (0, 1, 2, 3, 7, 11, 29)) -> bool:
    """Diagnostic replay of an already-symbolic candidate on concrete values.

    Search correctness does not rely on these samples; they are a guardrail
    against implementation mistakes.
    """
    for x in sorted(set([cert.x0, cert.x0 + 1, cert.x0 + 2, *extra_samples])):
        if x < cert.x0:
            continue
        N = cert.N(x)
        m = cert.m(x)
        if not (0 < m < N):
            return False
        if parity_word(m, cert.j) != cert.word:
            return False
        if iterate(N, cert.t) != iterate(m, cert.j):
            return False
    return True


def reverse_predecessors(A: int, B: int):
    """Yield exact affine one-step predecessors (A',B',parity).

    Even predecessor: m=2y, always uniformly even.

    Odd predecessor: m=(y-1)/3. It is a valid affine family only when both
    coefficients divide exactly by 3 and the resulting family is uniformly
    odd, i.e. coefficient even and intercept odd.
    """
    yield 2 * A, 2 * B, 0

    if A % 3 == 0 and (B - 1) % 3 == 0:
        Ap, Bp = A // 3, (B - 1) // 3
        if Ap % 2 == 0 and Bp % 2 == 1:
            yield Ap, Bp, 1


def search_residue(
    K: int,
    R: int,
    max_back_depth: int = 16,
    max_states_per_target: int = 50_000,
) -> Certificate | None:
    assert 0 < R < (1 << K) and R % 2 == 1
    M = 1 << K

    for t, yA, yB in uniform_forward_path(K, R):
        # Direct descent is the coalescence case j=0.
        x0 = minimum_x_for_smaller(M, R, yA, yB)
        if x0 is not None:
            cert = Certificate(K, R, t, 0, yA, yB, (), x0)
            if validate(cert):
                return cert

        # Search exact affine predecessors of this common target.  This avoids
        # enumerating all 2^j parity words blindly.  A reverse branch is kept
        # only when it is an exact uniform affine predecessor.
        queue = deque([(yA, yB, 0, ())])
        seen = {(yA, yB)}
        visited = 0

        while queue and visited < max_states_per_target:
            A, B, j, word = queue.popleft()
            visited += 1
            if j >= max_back_depth:
                continue

            for Ap, Bp, parity in reverse_predecessors(A, B):
                key = (Ap, Bp)
                if key in seen:
                    continue
                seen.add(key)

                # Reversal prepends the new parity decision to the forward word.
                new_word = (parity,) + word
                new_j = j + 1

                x0 = minimum_x_for_smaller(M, R, Ap, Bp)
                if x0 is not None:
                    cert = Certificate(K, R, t, new_j, Ap, Bp, new_word, x0)
                    if validate(cert):
                        return cert

                queue.append((Ap, Bp, new_j, new_word))

    return None


def exact_demo_64x_plus_15() -> None:
    # The maximal uniform forward path of N=64x+15 does not directly descend:
    # after 9 steps it is 162x+40 and after 10 steps 81x+20, still larger
    # asymptotically than 64x+15.  But it coalesces at step 9 with a uniformly
    # smaller odd family m=54x+13 after one step:
    #
    #   U^9(64x+15) = 162x+40 = U(54x+13).
    cert = Certificate(K=6, R=15, t=9, j=1, A=54, B=13, word=(1,), x0=0)
    assert validate(cert)
    print("Exact coalescence demo:")
    print("  U^9(64*x+15) = U(54*x+13) = 162*x+40")
    print("  and 0 < 54*x+13 < 64*x+15 for every x>=0")


def sweep(max_K: int = 12, max_back_depth: int = 16) -> None:
    print("K,total_odd_cylinders,certified,uncertified")
    for K in range(3, max_K + 1):
        total = 1 << (K - 1)
        hits = 0
        survivors: list[int] = []
        for R in range(1, 1 << K, 2):
            cert = search_residue(K, R, max_back_depth=max_back_depth)
            if cert is None:
                survivors.append(R)
            else:
                hits += 1
        print(f"{K},{total},{hits},{len(survivors)}")
        print("  first uncertified residues:", survivors[:24])


if __name__ == "__main__":
    exact_demo_64x_plus_15()
    sweep()
