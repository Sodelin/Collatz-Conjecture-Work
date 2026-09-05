#!/usr/bin/env python3
"""Exact endpoint certificate for the 12-term integer block envelope.

The piecewise function is constant in x/B on each half-open region. Its
linear proposed upper bound has positive slope, so checking the left endpoint
of every region proves the real-ratio inequality (and hence the integer one).
No samples establish that universal step; small integer tests are regressions.
"""
from fractions import Fraction


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def floor_power_of_two(n):
    require(n > 0, "floor-power input must be positive")
    return 1 << (n.bit_length() - 1)


ROWS = tuple((3 ** i, floor_power_of_two(3 ** i), 3 ** (11 - i))
             for i in range(12))
THRESHOLDS = sorted((Fraction(2 * lo, a), i)
                    for i, (a, lo, coefficient) in enumerate(ROWS))
M12 = Fraction(2349463, 262144)
EXACT_COEFFICIENT = 416200322061


def numerator(B, x):
    return sum(coefficient * (lo * B if a * x < 2 * lo * B else 2 * lo * B)
               for a, lo, coefficient in ROWS)


def region_value(ratio):
    return sum(coefficient * (lo if a * ratio < 2 * lo else 2 * lo)
               for a, lo, coefficient in ROWS)


def mechanical_max(s):
    remainder = 0
    for i in range(s):
        remainder = 3 * remainder + floor_power_of_two(3 ** i)
    return remainder


def main():
    require(EXACT_COEFFICIENT == 2349463 * 3 ** 11, "Lean coefficient mismatch")
    require(len(set(t for t, _ in THRESHOLDS)) == 12, "thresholds not distinct")
    require(THRESHOLDS[-1] == (Fraction(2), 0), "wrong final threshold")
    require(all(1 < t <= 2 for t, _ in THRESHOLDS), "threshold outside phase interval")
    lefts = [Fraction(1)] + [t for t, _ in THRESHOLDS[:-1]]
    ratios = []
    print("region | left | right | D/B | 12*3^12*left - 4D/B | exact-M12 slack")
    for i, (left, (right, _)) in enumerate(zip(lefts, THRESHOLDS)):
        D = region_value(left)
        require(region_value((left + right) / 2) == D, "unexpected interior jump")
        raw_slack = 12 * 3 ** 12 * left - 4 * D
        exact_slack = EXACT_COEFFICIENT * left - 262144 * D
        require(raw_slack > 0, f"nonpositive quarter-block slack in region {i}")
        require(exact_slack >= 0, f"negative exact-M12 slack in region {i}")
        ratio = D / (3 ** 11 * left)
        ratios.append(ratio)
        print(f"{i} | {left} | {right} | {D} | {raw_slack} | {exact_slack}")
    require(max(ratios) == M12, "sharp M12 mismatch")
    require(ratios.index(M12) == 7, "wrong maximizing region")
    require(9 - M12 == Fraction(9833, 262144), "block deficit mismatch")
    tests = 0
    for B in range(1, 257):
        for x in range(B, 2 * B):
            D = numerator(B, x)
            require(262144 * D <= EXACT_COEFFICIENT * x, "integer envelope failure")
            require(4 * D < 12 * 3 ** 12 * x, "strict block failure")
            tests += 1
    dyadic_tests = 0
    for exponent in range(11):
        B = 2 ** exponent
        for x in range(B, 2 * B):
            direct = sum(3 ** (11 - i) * floor_power_of_two(3 ** i * x)
                         for i in range(12))
            require(direct == numerator(B, x), "dyadic normalization mismatch")
            dyadic_tests += 1
    print(f"PASS: 12 exhaustive threshold regions; exact M12={M12}")
    print(f"PASS: {tests} integer regressions; {dyadic_tests} dyadic-floor reconstructions")
    for s in range(16, 28):
        require(4 * mechanical_max(s) <= s * 3 ** s,
                f"twelve-step induction base failed at {s}")
    require(4 * mechanical_max(15) - 15 * 3 ** 15 == 2419735,
            "exact preceding-count failure mismatch")
    print("PASS: all 12 normalized-envelope induction bases 16..27")
    print("PASS: s=15 fails by 2,419,735; cutoff 16 is sharp with the proved propagation")


if __name__ == "__main__":
    main()
