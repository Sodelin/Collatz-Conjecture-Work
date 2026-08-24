#!/usr/bin/env python3
"""Exact finite classifier for the Round-7 whole-family inverse-word class.

This implements the corrected completeness bound proved in
`proof-search/lemmas/L5_Inverse_Word_Search_Completeness_Bound.md`, including
its equal-slope/lower-intercept boundary case.

For a fixed odd cylinder N(x)=2^K*x+R and each uniform accelerated forward
state at time t, a successful strict-slope inverse word can use at most t-s-1
even inverse steps and at most s odd inverse steps, hence has length at most
t-1.  There is one additional count boundary: an equal-slope reduction must
have exactly r=s odd inverses and e=t-s even inverses, hence length t, and its
intercept must be strictly smaller than R.

Therefore this script has NO arbitrary reverse-depth parameter.  At fixed K,R
it exhausts the corrected whole-family affine-smaller certificate class.

A miss is still only a miss for this certificate class.  It is not evidence of
a divergent Collatz orbit.
"""

from __future__ import annotations

from collections import deque
from dataclasses import dataclass


@dataclass(frozen=True)
class Certificate:
    K: int
    R: int
    forward_steps: int
    forward_odd_steps: int
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


def uniform_T_states(K: int, R: int) -> list[tuple[int, int, int, int]]:
    """Return (t,A,B,s) with T^t(2^K*x+R)=A*x+B uniformly."""
    A, B = 1 << K, R
    s = 0
    out: list[tuple[int, int, int, int]] = []

    for t in range(1, K + 1):
        assert A % 2 == 0
        if B % 2 == 0:
            A //= 2
            B //= 2
        else:
            A = 3 * A // 2
            B = (3 * B + 1) // 2
            s += 1
        out.append((t, A, B, s))

    return out


def minimum_x_for_smaller(M: int, R: int, A: int, B: int) -> int | None:
    """Least x0>=0 such that 0 < A*x+B < M*x+R for every x>=x0."""
    if A < 0 or A > M:
        return None

    x0 = 0
    if A == 0:
        if B <= 0:
            return None
    elif B <= 0:
        x0 = max(x0, (-B) // A + 1)

    if A == M:
        # Equal slopes reduce exactly when the inverse-family intercept is
        # strictly smaller.  Positivity is still enforced by x0 above.
        if B >= R:
            return None
    else:
        D = M - A
        E = R - B
        if E <= 0:
            x0 = max(x0, (-E) // D + 1)

    return x0


def validate(cert: Certificate) -> bool:
    """Exact whole-family affine validation plus redundant sample replay."""
    M = 1 << cert.K
    if not (0 < cert.R < M and cert.R % 2 == 1):
        return False
    states = {
        t: (A, B, s) for t, A, B, s in uniform_T_states(cert.K, cert.R)
    }
    state = states.get(cert.forward_steps)
    if state is None:
        return False
    yA, yB, s = state
    if s != cert.forward_odd_steps:
        return False

    A, B = yA, yB
    for symbol in cert.inverse_word:
        if symbol == "E":
            A, B = 2 * A, 2 * B
        elif symbol == "O":
            if A % 3 != 0 or B % 3 != 2:
                return False
            A, B = 2 * A // 3, (2 * B - 1) // 3
        else:
            return False
    if (A, B) != (cert.A, cert.B):
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


def search_forward_state(
    K: int,
    R: int,
    t: int,
    yA: int,
    yB: int,
    s: int,
) -> Certificate | None:
    """Exhaust the corrected affine-smaller class from one forward state."""
    M = 1 << K

    x0 = minimum_x_for_smaller(M, R, yA, yB)
    if x0 is not None:
        cert = Certificate(K, R, t, s, "", yA, yB, x0)
        assert validate(cert)
        return cert

    # Queue entries: (A,B,e,r,word).
    queue = deque([(yA, yB, 0, 0, "")])
    seen: set[tuple[int, int, int, int]] = set()

    while queue:
        A, B, e, r, word = queue.popleft()
        key = (A, B, e, r)
        if key in seen:
            continue
        seen.add(key)

        if word:
            x0 = minimum_x_for_smaller(M, R, A, B)
            if x0 is not None:
                cert = Certificate(K, R, t, s, word, A, B, x0)
                assert validate(cert)
                return cert

        # A strict-slope winner requires e+s<t.  The boundary e+s=t can
        # still win, but only after r=s makes the slope exactly 2^K and the
        # intercept test above proves B<R.  No winner is possible past it.
        if e + s > t:
            continue

        # Odd inverse O(y)=(2y-1)/3, exact for the whole family only when the
        # leading coefficient is divisible by 3 and intercept == 2 mod 3.
        if r < s and A % 3 == 0 and B % 3 == 2:
            OA = 2 * A // 3
            OB = (2 * B - 1) // 3
            queue.append((OA, OB, e, r + 1, word + "O"))

        # Even inverse E(y)=2y.  Include the single equal-slope count layer.
        if e + 1 + s <= t:
            queue.append((2 * A, 2 * B, e + 1, r, word + "E"))

    return None


def classify_residue(K: int, R: int) -> Certificate | None:
    for t, A, B, s in uniform_T_states(K, R):
        cert = search_forward_state(K, R, t, A, B, s)
        if cert is not None:
            return cert
    return None


def exact_regression() -> None:
    # Equal-slope boundary case omitted by the original strict-slope search:
    #
    #   T^3(8*x+5) = 3*x+2 = T^3(8*x+4).
    #
    # Starting from the common target 3*x+2, the exact inverse word OEE gives
    # 2*x+1, then 4*x+2, then 8*x+4.  Its leading coefficient equals 2^3,
    # but its intercept 4 is strictly smaller than R=5.
    assert uniform_T_states(3, 5)[2] == (3, 3, 2, 1)
    A, B = 3, 2
    assert A % 3 == 0 and B % 3 == 2
    A, B = 2 * A // 3, (2 * B - 1) // 3
    A, B = 2 * A, 2 * B
    A, B = 2 * A, 2 * B
    assert (A, B) == (8, 4)
    assert minimum_x_for_smaller(8, 5, A, B) == 0
    equal_slope = Certificate(3, 5, 3, 1, "OEE", A, B, 0)
    assert validate(equal_slope)

    cert = classify_residue(12, 1023)
    assert cert is not None
    # A valid exact certificate must exist; the search may return the first
    # shorter one rather than the maximally peeled representation.
    assert validate(cert)

    cert2 = classify_residue(13, 6143)
    assert cert2 is not None
    assert validate(cert2)

    print("Exact equal-slope boundary regression:")
    print("  T^3(8*x+5) = T^3(8*x+4) = 3*x+2")
    print("  inverse word from the common target: OEE")
    print("  and 0 < 8*x+4 < 8*x+5 for every x>=0")
    print()


def sweep(max_K: int = 15) -> None:
    print("Round 7 exhaustive whole-family inverse-word classifier")
    print("No arbitrary inverse-depth parameter: corrected L5 completeness bound")
    print("Strict-slope depth <=t-1; equal-slope boundary depth =t with B<R")
    print("IMPORTANT: certificate-class exhaustion at fixed K is not a Collatz proof/disproof")
    print()
    print("K,total_odd,certified,class_miss")

    for K in range(3, max_K + 1):
        misses: list[int] = []
        for R in range(1, 1 << K, 2):
            if classify_residue(K, R) is None:
                misses.append(R)
        total = 1 << (K - 1)
        print(f"{K},{total},{total-len(misses)},{len(misses)}")
        print("  first class misses:", misses[:24])


if __name__ == "__main__":
    exact_regression()
    sweep()
