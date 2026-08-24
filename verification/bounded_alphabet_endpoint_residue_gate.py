#!/usr/bin/env python3
"""Exact regressions for the bounded-alphabet endpoint-residue gate.

The checker uses only integer arithmetic.  It reconstructs finite endpoint
representatives and their carries, verifies all words over {1,2,3} through a
bounded depth, and replays representative positive and non-positive-code
boundary cases.  It does not prove the infinite theorem or Collatz.
"""

from __future__ import annotations

from itertools import product


ALPHABET = (1, 2, 3)
EXHAUSTIVE_DEPTH = 8
ACTUAL_SEEDS = (1, 3, 7, 27, 429_111)
ACTUAL_STEPS = 80


def v2(n: int) -> int:
    """Return the 2-adic valuation of a positive integer."""

    assert n > 0
    return (n & -n).bit_length() - 1


def accelerated_step(n: int) -> tuple[int, int]:
    """Return (exact valuation, next odd state)."""

    assert n > 0 and n % 2 == 1
    value = 3 * n + 1
    exponent = v2(value)
    successor = value >> exponent
    assert successor > 0 and successor % 2 == 1
    return exponent, successor


def orbit_prefix(seed: int, steps: int) -> tuple[list[int], list[int]]:
    """Return states x_0..x_steps and valuations a_0..a_(steps-1)."""

    states = [seed]
    valuations: list[int] = []
    for _ in range(steps):
        exponent, successor = accelerated_step(states[-1])
        valuations.append(exponent)
        states.append(successor)
    return states, valuations


def endpoint_data(word: tuple[int, ...] | list[int]) -> tuple[
    list[int], list[int], list[int], list[int]
]:
    """Return q_k, C_k, M_k, and t_k for a finite valuation word."""

    q_values = [0]
    coefficients = [0]
    endpoints = [0]
    carries: list[int] = []

    q_value = 0
    coefficient = 0
    for k, exponent in enumerate(word):
        assert exponent >= 1
        coefficient = 3 * coefficient + (1 << q_value)
        q_value += exponent
        modulus = 3 ** (k + 1)
        endpoint = (coefficient * pow(1 << q_value, -1, modulus)) % modulus

        assert 1 <= endpoint < modulus
        numerator = (1 << exponent) * endpoint - 3 * endpoints[-1] - 1
        assert numerator % modulus == 0
        carry = numerator // modulus
        assert 0 <= carry < (1 << exponent)

        q_values.append(q_value)
        coefficients.append(coefficient)
        endpoints.append(endpoint)
        carries.append(carry)

    return q_values, coefficients, endpoints, carries


def backward_start(endpoint: int, word: tuple[int, ...] | list[int]) -> int:
    """Reconstruct an integral positive prefix start when the guards permit."""

    value = endpoint
    for exponent in reversed(word):
        numerator = (1 << exponent) * value - 1
        assert numerator % 3 == 0
        value = numerator // 3
        assert value > 0 and value % 2 == 1
    return value


def check_all_finite_words() -> int:
    """Exhaust the transition identity for every word through depth 8."""

    count = 0
    for length in range(1, EXHAUSTIVE_DEPTH + 1):
        for word in product(ALPHABET, repeat=length):
            q_values, coefficients, endpoints, carries = endpoint_data(word)
            assert len(q_values) == length + 1
            assert len(coefficients) == length + 1
            assert len(endpoints) == length + 1
            assert len(carries) == length

            for k in range(1, length + 1):
                modulus = 3**k
                assert (
                    (1 << q_values[k]) * endpoints[k] - coefficients[k]
                ) % modulus == 0
                assert coefficients[k] % 3 != 0

            for k, exponent in enumerate(word):
                assert (
                    (1 << exponent) * endpoints[k + 1]
                    == 3 * endpoints[k] + 1 + carries[k] * 3 ** (k + 1)
                )
            count += 1
    return count


def check_actual_seeds() -> list[tuple[int, int]]:
    """Check eventual endpoint/orbit equality and exact backward recovery."""

    results: list[tuple[int, int]] = []
    for seed in ACTUAL_SEEDS:
        states, word = orbit_prefix(seed, ACTUAL_STEPS)
        q_values, coefficients, endpoints, carries = endpoint_data(word)
        del q_values, coefficients

        threshold = (seed + 1).bit_length()
        assert threshold < ACTUAL_STEPS
        for k in range(ACTUAL_STEPS + 1):
            if k == 0:
                continue
            assert states[k] % (3**k) == endpoints[k]
            assert endpoints[k] <= states[k]
        for k in range(threshold, ACTUAL_STEPS + 1):
            assert endpoints[k] == states[k]
        for k in range(threshold, ACTUAL_STEPS):
            assert carries[k] == 0
        assert backward_start(endpoints[threshold], word[:threshold]) == seed
        results.append((seed, threshold))
    return results


def check_boundary_codes() -> tuple[list[int], list[int], list[int]]:
    """Check the all-1 ghost, all-2 realization, and periodic 1113 code."""

    depth = 24

    _, _, all_one_endpoints, all_one_carries = endpoint_data((1,) * depth)
    assert all_one_endpoints == [0] + [3**k - 1 for k in range(1, depth + 1)]
    assert all(carry == 1 for carry in all_one_carries)

    _, _, all_two_endpoints, all_two_carries = endpoint_data((2,) * depth)
    assert all_two_endpoints == [0] + [1] * depth
    assert all_two_carries[0] == 1
    assert all(carry == 0 for carry in all_two_carries[1:])
    assert backward_start(all_two_endpoints[1], (2,)) == 1

    periodic_word = (1, 1, 1, 3) * (depth // 4)
    _, _, periodic_endpoints, periodic_carries = endpoint_data(periodic_word)
    positive_carry_positions = [
        k for k, carry in enumerate(periodic_carries) if carry > 0
    ]
    assert len(positive_carry_positions) >= depth // 4

    # One block has F(x)=(81x+65)/64 and the rational fixed point -65/17.
    numerator = -65
    denominator = 17
    for exponent, expected_numerator in zip(
        (1, 1, 1, 3), (-89, -125, -179, -65), strict=True
    ):
        raw = 3 * numerator + denominator
        assert raw % (1 << exponent) == 0
        numerator = raw >> exponent
        assert numerator == expected_numerator

    return all_one_carries, all_two_carries, positive_carry_positions


def main() -> None:
    finite_words = check_all_finite_words()
    seed_results = check_actual_seeds()
    all_one, all_two, periodic_positions = check_boundary_codes()

    print("F-BOUNDED-ALPHABET-ENDPOINT-GATE-001")
    print(f"finite words checked: {finite_words} (alphabet={ALPHABET}, depth<={EXHAUSTIVE_DEPTH})")
    print(
        "actual seeds reconstructed: "
        + ", ".join(f"{seed}@k={threshold}" for seed, threshold in seed_results)
    )
    print(f"all-1 code: carries={sorted(set(all_one))}, M_k=3^k-1")
    print(
        "all-2 code: first carry="
        f"{all_two[0]}, later carries={sorted(set(all_two[1:]))}, M_k=1"
    )
    print(
        "periodic 1113 ghost: positive carry positions through k<24 = "
        + ",".join(map(str, periodic_positions))
    )
    print("negative rational replay: -65/17 -> -89/17 -> -125/17 -> -179/17 -> -65/17")
    print("PASS: exact finite identities and boundary regressions")
    print("SCOPE: regression evidence only; the infinite theorem is proved in the linked note")


if __name__ == "__main__":
    main()
