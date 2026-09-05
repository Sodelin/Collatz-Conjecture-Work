"""Exact finite diagnostics for the finite-palette bounded-progress obstruction.

The universal theorem is proved in the accompanying note and Lean module.
These tests audit its witness construction and scope, not Collatz termination.
All checks remain active under python -O; no third-party dependencies are used.
"""

from __future__ import annotations

from itertools import product
from typing import Sequence


def require(condition: bool, message: str) -> None:
    if not condition:
        raise ValueError(message)


def shortcut(n: int) -> int:
    require(type(n) is int and n > 0, "expected a positive integer")
    return n // 2 if n % 2 == 0 else (3 * n + 1) // 2


def forced_growth(length: int, parameter: int) -> list[int]:
    require(type(length) is int and length >= 0, "invalid length")
    require(type(parameter) is int and parameter > 0, "invalid parameter")
    start = (1 << length) * parameter - 1
    require(start > 0, "start must be positive")
    states = [start]
    for j in range(length):
        require(states[-1] % 2 == 1, "forced step must be odd")
        states.append(shortcut(states[-1]))
        expected = 3 ** (j + 1) * 2 ** (length - j - 1) * parameter - 1
        require(states[-1] == expected, "closed form disagrees with direct iteration")
        require(states[-1] > states[-2], "forced orbit failed to increase")
    return states


def find_blocker(
    labels: Sequence[int], values: Sequence[int], palette_size: int, horizon: int
) -> tuple[int, tuple[int, ...]]:
    """Find a full H-window with no strict drop on a certified finite trace.

    Equal labels must have nondecreasing values in trace order. This is the
    finite consequence of an increasing orbit and monotone palette functions.
    The trace has r*H+1 entries, so all inspected windows are fully present.
    """
    require(type(palette_size) is int and palette_size > 0, "empty palette")
    require(type(horizon) is int and horizon > 0, "invalid horizon")
    require(len(labels) == len(values) == palette_size * horizon + 1,
            "wrong trace length")
    previous: dict[int, int] = {}
    for label, value in zip(labels, values):
        require(type(label) is int and 0 <= label < palette_size, "invalid label")
        require(type(value) is int, "rank values must be integers")
        if label in previous:
            require(previous[label] <= value, "same-label monotonicity violated")
        previous[label] = value

    index = 0
    selected = [index]
    for _ in range(palette_size):
        next_index = next(
            (j for j in range(index + 1, index + horizon + 1)
             if values[j] < values[index]), None
        )
        if next_index is None:
            return index, tuple(selected)
        selected.append(next_index)
        index = next_index
    # Reaching this line would give r+1 strictly decreasing selected values,
    # but two have the same label, contradicting the validated precondition.
    raise ArithmeticError("finite-palette contradiction in validated trace")


def audit_blocker(labels: Sequence[int], values: Sequence[int], r: int, h: int) -> None:
    index, selected = find_blocker(labels, values, r, h)
    require(index + h < len(values), "incomplete witness window")
    require(all(values[index + j] >= values[index] for j in range(1, h + 1)),
            "reported window contains a strict decrease")
    require(selected[0] == 0 and selected[-1] == index, "invalid selected path")
    require(all(1 <= b - a <= h and values[b] < values[a]
                for a, b in zip(selected, selected[1:])), "invalid descent edge")


def run_checks() -> None:
    orbit_count = 0
    for length in range(1, 97):
        for parameter in (1, 2, 7, 131):
            forced_growth(length, parameter)
            orbit_count += 1

    # Exhaust every selector on these small traces. Selection need not be
    # periodic, residue-based, computable, or monotone in the general theorem.
    selector_count = 0
    for r, h in ((1, 1), (1, 7), (2, 1), (2, 2), (2, 3), (3, 1), (3, 2)):
        states = forced_growth(r * h, 5)
        offset = states[-1] + 1
        for labels in product(range(r), repeat=len(states)):
            values = [n + (r - i - 1) * offset for n, i in zip(states, labels)]
            audit_blocker(labels, values, r, h)
            selector_count += 1

    # Delay each successful decrease until the end of its allowed H-window,
    # exhausting r-1 palette switches before the guaranteed obstruction.
    delayed_count = 0
    for r in range(1, 7):
        for h in range(1, 9):
            states = forced_growth(r * h, 131)
            offset = states[-1] + 1
            labels = [min(j // h, r - 1) for j in range(len(states))]
            values = [n + (r - i - 1) * offset for n, i in zip(states, labels)]
            audit_blocker(labels, values, r, h)
            index, _ = find_blocker(labels, values, r, h)
            require(index == (r - 1) * h, "delayed-switch fixture mismatch")
            delayed_count += 1

    # Boundary regression: dropping eventual monotonicity permits finite
    # decreasing traces even with one label. Such input must be rejected.
    rejected = 0
    for args in (([0, 0], [2, 1], 1, 1), ([0, 1], [1, 2], 1, 1),
                 ([0], [1], 1, 1), ([0, 0], [1, 2], 0, 1)):
        try:
            find_blocker(*args)
        except ValueError:
            rejected += 1
        else:
            raise ArithmeticError("invalid certificate was accepted")

    states = forced_growth(12, 1)
    labels = [(n % 7) % 3 for n in states]
    values = [n * (100, 10, 1)[i] for n, i in zip(states, labels)]
    index, selected = find_blocker(labels, values, 3, 4)
    require(selected == (0, 1, 3) and states[index] == 13823,
            "published example path mismatch")
    require(values[index + 1:index + 5] == [207350, 31103, 4665500, 699830],
            "published example lookahead mismatch")

    print(f"forced-growth direct/closed-form traces = {orbit_count}")
    print(f"exhaustive finite selector assignments = {selector_count}")
    print(f"delayed palette-switch fixtures = {delayed_count}")
    print(f"invalid certificates rejected = {rejected}")
    print("published 3-piece / 4-step example = PASS")
    print("FINITE_PALETTE_DIAGNOSTICS = PASS")
    print("Scope: finite regression checks; universal theorem has a separate proof.")


if __name__ == "__main__":
    run_checks()
