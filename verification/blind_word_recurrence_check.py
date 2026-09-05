"""Reproduce finite arithmetic checks; these are not a termination proof."""

from itertools import product
import json


def require(condition, detail):
    if not condition:
        raise ValueError(detail)


def ordinary(n):
    return n // 2 if n % 2 == 0 else 3 * n + 1


def odd_step(n):
    require(type(n) is int and n > 0 and n % 2 == 1, "positive odd input required")
    numerator = 3 * n + 1
    valuation = (numerator & -numerator).bit_length() - 1
    return numerator >> valuation, valuation


def follows(n, word):
    for expected in word:
        n, actual = odd_step(n)
        if expected != actual:
            return False
    return True


def affine(word):
    a, b, c = 1, 1, 0
    for exponent in word:
        a, c, b = 3 * a, 3 * c + b, b * 2**exponent
    return a, b, c


def positive_seed(word):
    a, b, c = affine(word)
    n = ((b - c) * pow(a, -1, 2*b)) % (2*b)
    require(n > 0 and n % 2 == 1, "invalid canonical positive lift")
    return n


def main():
    exact_word_checks = 0
    for length in range(1, 5):
        for word in product(range(1, 5), repeat=length):
            a, b, c = affine(word)
            gap = a - b
            for n in range(1, 200, 2):
                for repetitions in range(1, 5):
                    predicted = (gap * n + c) % (2 * b**repetitions) == 0
                    observed = follows(n, word * repetitions)
                    require(observed == predicted, (n, word, repetitions))
                    exact_word_checks += 1

    family_checks = 0
    for m in range(1, 41):
        for t in (1, 3, 10):
            n = 16 * 8**m * t - 5
            initial = n
            for j in range(m):
                before = n
                middle, a = odd_step(n)
                n, b = odd_step(middle)
                require((a, b) == (1, 2), "wrong exact valuations")
                require(middle > before and n > before, "growth failed")
                require(n == 16 * 8 ** (m - j - 1) * 9 ** (j + 1) * t - 5,
                        "intermediate endpoint failed")
                raw = before
                for _ in range(5):
                    raw = ordinary(raw)
                require(raw == n, "ordinary/odd map mismatch")
            require(n == 16 * 9**m * t - 5 and n > initial, "final endpoint failed")
            family_checks += 1

    # Prefix-return coding is independent of any putative positive seed.
    bits = [0]
    for _ in range(11):
        bits = [symbol for bit in bits for symbol in (bit, 1 - bit)]
    coding_checks = 0
    for p, q in ((0, 0), (3, 3), (3, 4), (4, 7), (12, 3)):
        code = ((1,), (2,)) if (p, q) == (0, 0) else ((1,) * p + (3,), (1,) * q + (3,))
        for level in range(1, 9):
            h = 2**level
            d = h * (len(code[0]) + len(code[1])) // 2
            encode = lambda source: tuple(x for bit in source for x in code[bit])
            prefix = encode(bits[:2*h])
            before = encode(bits[:3*h])
            returned = encode(bits[3*h:5*h])
            require(len(prefix) == 2*d and len(before) == 3*d, "wrong odd time")
            require(prefix == returned, "prefix-return identity failed")
            require(sum(prefix) >= 2*d, "valuation lower bound failed")
            coding_checks += 1

    seeded_checks = 0
    for p, q in ((3, 3), (3, 4), (4, 7), (10, 11), (34, 40), (100, 105)):
        code = ((1,) * p + (3,), (1,) * q + (3,))
        for level in range(1, 5):
            h = 2**level
            d = h * (len(code[0]) + len(code[1])) // 2
            word = tuple(x for bit in bits[:5*h] for x in code[bit])
            initial = positive_seed(word)
            n, index, returned_state = initial, 0, None
            for bit in bits[:5*h]:
                before = n
                for expected in code[bit]:
                    n, actual = odd_step(n)
                    require(actual == expected, "seeded exact valuation failed")
                    index += 1
                    if index == 3*d:
                        returned_state = n
                require(n > before, "complete guarded hard block did not grow")
            require(returned_state is not None and returned_state > initial,
                    "seeded return index failed")
            modulus = 2**(sum(word[:2*d]) + 1)
            require((returned_state - initial) % modulus == 0, "seeded collision failed")
            require(2 * 32**d < 27**d * (initial + 1), "seeded return bound failed")
            seeded_checks += 1

    # Direct actual-orbit tests include the indispensable equal-state control.
    return_checks = 0
    cycle_controls = 0
    for initial in range(1, 512, 2):
        states, vals = [initial], []
        for _ in range(100):
            endpoint, exponent = odd_step(states[-1])
            states.append(endpoint)
            vals.append(exponent)
        for d in range(1, 21):
            if vals[:2*d] != vals[3*d:5*d]:
                continue
            difference = abs(states[3*d] - initial)
            modulus = 2**(sum(vals[:2*d]) + 1)
            require(difference % modulus == 0, "word collision failed")
            if difference == 0:
                cycle_controls += 1
                continue
            require(difference >= modulus, "separation failed")
            require(2 * 32**d < 27**d * (initial + 1), "prefix bound failed")
            require(10*d + 27 < 27*initial, "effective length bound failed")
            return_checks += 1
    require(cycle_controls > 0 and return_checks > 0, "missing test coverage")
    n = 55
    for expected in (1, 1, 3):
        n, actual = odd_step(n)
        require(actual == expected, "hard-block threshold control failed")
    require(n == 47 and n < 55, "p=2 must not be called uniformly expanding")

    # False controls remain executable under python -O.
    rejected = 0
    for condition in (False, 8 == 9, follows(11, (1, 1)), (2*32 < 27*2)):
        try:
            require(condition, "intentional false control")
        except ValueError:
            rejected += 1
    require(rejected == 4, "false control accepted")

    report = {
        "status": "passed",
        "claim": "finite identity checks only; Collatz remains unproved in this work",
        "exact_repetition_comparisons": exact_word_checks,
        "expanding_family_cases": family_checks,
        "thue_morse_coding_checks": coding_checks,
        "seeded_hard_prefix_checks": seeded_checks,
        "noncycle_prefix_return_checks": return_checks,
        "cycle_exception_controls": cycle_controls,
        "false_controls_rejected": rejected,
        "inputs": {
            "word_lengths": [1, 4],
            "word_entries": [1, 4],
            "odd_seeds": [1, 199],
            "repetitions": [1, 4],
            "family_block_counts": [1, 40],
            "family_multipliers": [1, 3, 10],
        },
    }
    print(json.dumps(report, indent=2))


if __name__ == "__main__":
    main()
