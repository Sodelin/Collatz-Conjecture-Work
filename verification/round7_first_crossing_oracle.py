#!/usr/bin/env python3
"""Independent exact oracle for the fragile L9/L10/L12 arithmetic.

This is a bounded theorem-regression program, not evidence that a finite
horizon proves Collatz.  For every possible first coefficient-contraction word
with positive odd count and tau<=MAX_TAU, it independently checks:

* the L9 first-crossing time and odd-step deadline inequalities;
* uniqueness of the mechanical word as the additive-remainder maximizer;
* realization by the canonical start residue modulo 2^tau;
* every L10 near-return identity and residue congruence whenever the canonical
  realization is non-descending.

It also exhausts pairs of small hard-exit states and checks all three L12
gap-valuation transitions.  L11 itself is a least-counterexample conditional
and cannot have a genuine finite test witness unless a counterexample exists.
"""

from __future__ import annotations

from collections import Counter
from itertools import combinations


MAX_TAU = 27
HARD_PAIR_LIMIT = 4096


def T(n: int) -> int:
    return n // 2 if n % 2 == 0 else (3 * n + 1) // 2


def v2(n: int) -> int:
    assert n > 0
    return (n & -n).bit_length() - 1


def h(q: int) -> int:
    return 3 if q % 2 == 0 else 1


def hard_exit(n: int) -> bool:
    if n <= 0 or n % 2 == 0:
        return False
    q = v2(n + 1)
    if q < 2:
        return False
    return ((n + 1) >> q) % 4 == h(q)


def first_crossing_s(tau: int) -> int | None:
    """The unique positive s with 2^(tau-1)<=3^s<2^tau, if it exists."""
    for s in range(1, tau):
        p3 = 3**s
        if (1 << (tau - 1)) <= p3 < (1 << tau):
            return s
    return None


def is_first_crossing(tau: int, positions: tuple[int, ...]) -> bool:
    """Check the definition directly, with the final tau-th branch even."""
    s = len(positions)
    p3 = [3**q for q in range(s + 1)]
    q = 0
    i = 0
    for j in range(1, tau):
        if i < s and positions[i] == j:
            q += 1
            i += 1
        if p3[q] < (1 << j):
            return False
    return p3[s] < (1 << tau)


def remainder(positions: tuple[int, ...]) -> int:
    s = len(positions)
    return sum((1 << (p - 1)) * 3 ** (s - 1 - i) for i, p in enumerate(positions))


def realize_word(n: int, tau: int, positions: tuple[int, ...]) -> int:
    odd_positions = set(positions)
    x = n
    for j in range(1, tau + 1):
        assert (x % 2 == 1) == (j in odd_positions)
        x = T(x)
    return x


def check_l9_l10(max_tau: int = MAX_TAU) -> list[tuple[int, int, int, int, int]]:
    rows: list[tuple[int, int, int, int, int]] = []

    for tau in range(2, max_tau + 1):
        s = first_crossing_s(tau)
        if s is None:
            continue

        # Exact integer versions of floor((r-1) log_2 3)+1.
        deadlines = tuple((3 ** (r - 1)).bit_length() for r in range(1, s + 1))
        mechanical = deadlines
        assert tau == (3**s).bit_length()

        word_count = 0
        non_descending = 0
        positive_gap = 0
        max_C = -1
        maximizers: list[tuple[int, ...]] = []

        for positions in combinations(range(1, tau), s):
            if not is_first_crossing(tau, positions):
                continue
            word_count += 1

            # L9 deadline theorem.
            assert all(p <= d for p, d in zip(positions, deadlines))

            C = remainder(positions)
            if C > max_C:
                max_C = C
                maximizers = [positions]
            elif C == max_C:
                maximizers.append(positions)

            M = 1 << tau
            p3s = 3**s
            D = M - p3s
            assert D > 0

            residue = (-C * pow(p3s, -1, M)) % M
            n = residue if residue > 0 else M
            y = realize_word(n, tau, positions)

            # Exact affine and start-residue identities.
            assert M * y == p3s * n + C
            assert (p3s * n + C) % M == 0

            if y < n:
                continue

            non_descending += 1
            d = y - n

            # L10 near-return identity and bound.
            assert C == D * n + M * d
            assert 0 <= d and 3 * d < s
            assert D * n <= C

            # Endpoint residue and its exact interval.
            mod3 = p3s
            r3 = (C * pow(M, -1, mod3)) % mod3
            assert y % mod3 == r3
            assert C < M * y
            assert D * y <= C

            # Gap residue.  Modulo one is the trivial congruence and has no
            # nontrivial inverse representative to compute.
            if D > 1:
                rd = (C * pow(M, -1, D)) % D
                assert d % D == rd

            if d > 0:
                positive_gap += 1
        # L9 uniqueness of the mechanical extremizer.
        assert maximizers == [mechanical]
        assert max_C == remainder(mechanical)
        rows.append((tau, s, word_count, non_descending, positive_gap))

    return rows


def check_l12_pairs(limit: int = HARD_PAIR_LIMIT) -> Counter[str]:
    states = [(n, v2(n + 1)) for n in range(1, limit + 1, 2) if hard_exit(n)]
    counts: Counter[str] = Counter()

    for i, (n, q) in enumerate(states):
        for y, qp in states[i + 1 :]:
            d = y - n
            e = v2(d)
            ud = d >> e

            if qp < q:
                counts["q'<q"] += 1
                assert e == qp
                assert ud % 4 == (h(qp) - (1 << (q - qp)) * h(q)) % 4
            elif qp == q:
                counts["q'=q"] += 1
                assert e >= q + 2
            else:
                counts["q'>q"] += 1
                assert e == q
                assert ud % 4 == ((1 << (qp - q)) * h(qp) - h(q)) % 4

    assert all(counts[key] > 0 for key in ("q'<q", "q'=q", "q'>q"))
    return counts


def main() -> None:
    if not __debug__:
        raise RuntimeError(
            "This regression oracle requires assertions; do not run Python with -O."
        )

    rows = check_l9_l10()
    l12_counts = check_l12_pairs()

    print("Round 7 exact first-crossing and hard-gap oracle")
    print("Bounded theorem regression only; not a Collatz proof/disproof")
    print(f"first-crossing horizon: tau <= {MAX_TAU}")
    print()
    print("tau,s,first_crossing_words,non_descending,positive_gap")
    for row in rows:
        print(",".join(map(str, row)))
    print()
    print("L9 mechanical extremizer: PASS (unique at every listed (tau,s))")
    print("L10 identities for encountered non-descending cases: PASS")
    print("coverage caveat: only tau=2,s=1 is non-descending (n=y=1,D=1)")
    print("nontrivial positive-gap cases exercised: 0")
    print()
    print(f"L12 hard-pair range: odd states <= {HARD_PAIR_LIMIT}")
    for key in ("q'<q", "q'=q", "q'>q"):
        print(f"  {key}: {l12_counts[key]} pairs")
    print("L12 valuation and odd-part congruences: PASS")


if __name__ == "__main__":
    main()
