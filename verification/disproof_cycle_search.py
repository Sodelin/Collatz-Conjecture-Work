from __future__ import annotations

import argparse
from dataclasses import dataclass


def shortcut(n: int) -> int:
    if n <= 0:
        raise ValueError("positive integers only")
    return n // 2 if n % 2 == 0 else (3 * n + 1) // 2


def compose_word(word: int, k: int) -> tuple[int, int, int]:
    c = 0
    q = 0
    for j in range(k):
        if (word >> j) & 1:
            c = 3 * c + (1 << j)
            q += 1
    return pow(3, q), c, 1 << k


def word_string(word: int, k: int) -> str:
    return "".join("O" if (word >> j) & 1 else "E" for j in range(k))


@dataclass(frozen=True)
class Candidate:
    k: int
    q: int
    denominator: int
    word: int
    start: int
    orbit: tuple[int, ...]


def replay_candidate(word: int, k: int) -> Candidate | None:
    a, c, two_k = compose_word(word, k)
    d = two_k - a
    if d <= 0 or c == 0 or c % d:
        return None
    n = c // d
    if n <= 0:
        return None
    start = n
    orbit = [n]
    for j in range(k):
        expected_odd = bool((word >> j) & 1)
        if (n % 2 == 1) != expected_odd:
            return None
        n = shortcut(n)
        orbit.append(n)
    if n != start:
        return None
    return Candidate(k, word.bit_count(), d, word, start, tuple(orbit))


def residue_dp(k: int, q_target: int, d: int) -> tuple[int | None, int | None, int]:
    """Return the maximum exact C at residue zero, its word, and peak states.

    The DP is exhaustive over all length-k parity words with q_target odd bits.
    Each (odd count, residue) stores the maximum exact C and a reconstructing
    word. Merging is complete for detecting a nontrivial fixed point because
    both transitions, C -> C and C -> 3C+2^j, are strictly monotone in C.
    Thus the stored value remains the true maximum over all merged prefixes.
    At final residue zero, max_C/d <= 2 proves every integral candidate for
    that (k,q) is trivial; max_C/d > 2 supplies a nontrivial candidate to replay.
    """
    states: list[dict[int, tuple[int, int]]] = [dict() for _ in range(q_target + 1)]
    states[0][0] = (0, 0)
    peak = 1
    for j in range(k):
        nxt: list[dict[int, tuple[int, int]]] = [dict() for _ in range(q_target + 1)]
        steps_left_after = k - j - 1
        for q_used, residues in enumerate(states):
            for residue, (exact_c, word) in residues.items():
                if q_used + steps_left_after >= q_target:
                    prior = nxt[q_used].get(residue)
                    if prior is None or exact_c > prior[0]:
                        nxt[q_used][residue] = (exact_c, word)
                if q_used < q_target:
                    q2 = q_used + 1
                    if q2 + steps_left_after >= q_target:
                        exact_c2 = 3 * exact_c + (1 << j)
                        residue2 = exact_c2 % d
                        prior = nxt[q2].get(residue2)
                        if prior is None or exact_c2 > prior[0]:
                            nxt[q2][residue2] = (exact_c2, word | (1 << j))
        states = nxt
        peak = max(peak, sum(len(x) for x in states))
    result = states[q_target].get(0)
    if result is None:
        return None, None, peak
    exact_c, word = result
    return word, exact_c, peak


def all_dp_residues(k: int, q_target: int, d: int) -> set[int]:
    states: list[set[int]] = [set() for _ in range(q_target + 1)]
    states[0].add(0)
    two_j_mod_d = 1 % d
    for _j in range(k):
        nxt: list[set[int]] = [set(x) for x in states]
        for q_used in range(q_target):
            for residue in states[q_used]:
                nxt[q_used + 1].add((3 * residue + two_j_mod_d) % d)
        states = nxt
        two_j_mod_d = (2 * two_j_mod_d) % d
    return states[q_target]


def self_test() -> None:
    for k in range(1, 11):
        for q in range(1, k + 1):
            signed_d = (1 << k) - pow(3, q)
            d = abs(signed_d) or 1
            dp = all_dp_residues(k, q, d)
            exact_cs = [
                compose_word(word, k)[1]
                for word in range(1 << k)
                if word.bit_count() == q
            ]
            brute = {exact_c % d for exact_c in exact_cs}
            if dp != brute:
                raise AssertionError((k, q, d, dp ^ brute))
            if signed_d > 0:
                word, max_c, _ = residue_dp(k, q, signed_d)
                zero_cs_for_pair = [
                    exact_c for exact_c in exact_cs if exact_c % signed_d == 0
                ]
                expected_max = max(zero_cs_for_pair, default=None)
                if max_c != expected_max:
                    raise AssertionError(
                        ("wrong maximum", k, q, signed_d, expected_max, max_c)
                    )
                if word is not None and compose_word(word, k)[1] != max_c:
                    raise AssertionError(
                        ("bad maximum witness", k, q, signed_d, word, max_c)
                    )
            found_word, found_c, _ = residue_dp(k, q, d)
            zero_values = [
                compose_word(word, k)[1]
                for word in range(1 << k)
                if word.bit_count() == q and compose_word(word, k)[1] % d == 0
            ]
            expected_c = max(zero_values) if zero_values else None
            if found_c != expected_c:
                raise AssertionError((k, q, d, found_c, expected_c, found_word))
    word, exact_c, _ = residue_dp(4, 2, 7)
    if exact_c != 14 or word is None or compose_word(word, 4)[1] != 14:
        raise AssertionError((word, exact_c))
    zero_cs = sorted(
        compose_word(word0, 4)[1]
        for word0 in range(1 << 4)
        if word0.bit_count() == 2 and compose_word(word0, 4)[1] % 7 == 0
    )
    if zero_cs != [7, 14]:
        raise AssertionError(zero_cs)
    print("self-test: DP residue sets and residue-zero maxima match brute force for k<=10")
    print("regression: (k,q,D)=(4,2,7) retains max C=14 over merged [7,14]")


def search(k_max: int, d_max: int) -> None:
    tested_pairs = 0
    max_peak = 0
    nontrivial: list[Candidate] = []
    trivial: list[Candidate] = []
    for k in range(1, k_max + 1):
        three_q = 1
        for q in range(1, k + 1):
            three_q *= 3
            d = (1 << k) - three_q
            if d <= 0 or d > d_max:
                continue
            tested_pairs += 1
            word, max_c, peak = residue_dp(k, q, d)
            max_peak = max(max_peak, peak)
            if word is None:
                continue
            if max_c is None or max_c % d:
                raise AssertionError((k, q, d, word, max_c))
            candidate = replay_candidate(word, k)
            if candidate is None:
                raise AssertionError((k, q, d, word_string(word, k)))
            if candidate.start != max_c // d:
                raise AssertionError((candidate.start, max_c, d))
            core = set(candidate.orbit[:-1])
            if core.issubset({1, 2}):
                trivial.append(candidate)
            else:
                nontrivial.append(candidate)
                print("NONTRIVIAL POSITIVE CYCLE CANDIDATE")
                print(candidate)
                print(word_string(word, k))
                print(candidate.orbit)
                return
    print(f"exhausted {tested_pairs} pairs with k<= {k_max} and 0<D<= {d_max}")
    print(f"maximum merged DP states: {max_peak}")
    print(f"trivial 1-2-cycle encodings found: {len(trivial)}")
    print("nontrivial positive cycle candidates found: 0")
    print("This is a bounded exact negative result, not a Collatz proof or disproof.")


def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--k-max", type=int, default=40)
    parser.add_argument("--d-max", type=int, default=250_000)
    args = parser.parse_args()
    self_test()
    search(args.k_max, args.d_max)


if __name__ == "__main__":
    main()
