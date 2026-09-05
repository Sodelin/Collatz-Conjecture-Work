"""Finite regression for L15.

This script checks the displayed local identities and residue families over
the stated finite ranges.  It is not a proof of any universal Collatz claim.
"""

from itertools import product


ODD_LIMIT = 100_000
SOURCE_LIMIT = 25_000
FAMILY_T_LIMIT = 10_000
WORD_LENGTH_LIMIT = 8
PURE_A2_DEPTH_LIMIT = 24


def v2(n: int) -> int:
    assert n > 0
    k = 0
    while n % 2 == 0:
        n //= 2
        k += 1
    return k


def U(n: int) -> int:
    assert n > 0 and n % 2 == 1
    m = 3 * n + 1
    return m >> v2(m)


def iterate(n: int, k: int) -> int:
    for _ in range(k):
        n = U(n)
    return n


def in_h(n: int) -> bool:
    return n % 8 == 7 or n % 32 == 27


def l14_rule_available(n: int) -> bool:
    if n == 1:
        return False
    a = v2(3 * n + 1)
    if a >= 2:
        return True
    c = v2(3 * n - 1)
    return c % 2 == 1 or c >= 6


def added_rule_available(n: int) -> bool:
    return n % 3 == 2 or n % 9 == 4


def check_added_rewrites_and_irreducibles() -> int:
    checked = 0
    for x in range(1, ODD_LIMIT + 1, 2):
        if x % 3 == 2:
            y = (2 * x - 1) // 3
            assert y > 0 and y % 2 == 1 and y < x
            assert U(y) == x
        if x % 9 == 4:
            y = (8 * x - 5) // 9
            z = (4 * x - 1) // 3
            assert y > 0 and y % 2 == 1 and y < x
            assert z > 0 and z % 2 == 1
            assert U(y) == z and U(z) == x

        irreducible = not l14_rule_available(x) and not added_rule_available(x)
        expected = x == 1 or (in_h(x) and x % 9 in {0, 1, 3, 6, 7})
        assert irreducible == expected, (x, irreducible, expected)
        checked += 1

    # Exact nonconfluence witness.
    assert iterate(3, 2) == 1  # The rewrite 3 -> 1 is a coalescence, not one U step.
    assert U(1) == 1
    assert (2 * 11 - 1) // 3 == 7
    assert in_h(7) and 7 % 9 == 7
    assert not l14_rule_available(7) and not added_rule_available(7)
    return checked


def source_predecessor(x: int) -> tuple[int, int]:
    assert x > 0 and x % 2 == 1 and x % 3 != 0
    exponents = [e for e in range(1, 7) if (pow(2, e, 9) * x - 1) % 9 == 0]
    assert len(exponents) == 1
    e = exponents[0]
    return e, (2**e * x - 1) // 3


def check_inverse_fibers_and_sources() -> int:
    checked = 0
    for x in range(1, SOURCE_LIMIT + 1, 2):
        valid = []
        for a in range(1, 13):
            numerator = 2**a * x - 1
            if numerator % 3 == 0:
                y = numerator // 3
                assert y > 0 and y % 2 == 1
                assert v2(3 * y + 1) == a and U(y) == x
                valid.append(a)
        if x % 3 == 0:
            assert not valid
        elif x % 3 == 1:
            assert valid and all(a % 2 == 0 for a in valid)
        else:
            assert valid and all(a % 2 == 1 for a in valid)
        for a, b in zip(valid, valid[1:]):
            assert b == a + 2
            ya = (2**a * x - 1) // 3
            yb = (2**b * x - 1) // 3
            assert yb == 4 * ya + 1

        if x % 3 != 0:
            e, d0 = source_predecessor(x)
            assert 1 <= e <= 6
            assert d0 % 2 == 1 and d0 % 3 == 0 and U(d0) == x
            d1 = (2 ** (e + 6) * x - 1) // 3
            assert d1 == 64 * d0 + 21
        checked += 1
    return checked


def word_data(word: tuple[int, ...]) -> tuple[int, int]:
    A = 0
    B = 0
    for i, a in enumerate(word, start=1):
        A += a
        B = 2**a * B + 3 ** (i - 1)
    return A, B


def inverse_replay(x: int, word: tuple[int, ...]) -> int:
    current = x
    for a in word:
        numerator = 2**a * current - 1
        assert numerator % 3 == 0
        current = numerator // 3
        assert current > 0 and current % 2 == 1
        assert v2(3 * current + 1) == a
    return current


def check_mixed_words() -> int:
    checked = 0
    for k in range(1, WORD_LENGTH_LIMIT + 1):
        modulus = 3**k
        for word in product((1, 2), repeat=k):
            A, B = word_data(word)
            residues = [x for x in range(modulus) if (2**A * x - B) % modulus == 0]
            assert len(residues) == 1
            residue = residues[0]
            odd_residue = residue if residue % 2 == 1 else residue + modulus
            assert 0 <= odd_residue < 2 * modulus and odd_residue % 2 == 1

            # Choose a positive lift large enough that the full inverse chain is positive.
            x = odd_residue
            while x == 0 or (2**A * x - B) <= 0:
                x += 2 * modulus
            endpoint = inverse_replay(x, word)
            assert endpoint == (2**A * x - B) // modulus
            assert iterate(endpoint, k) == x
            if 2**A < modulus:
                assert endpoint < x
            checked += 1
    return checked


def check_2211_family() -> int:
    word = (2, 2, 1, 1)
    assert word_data(word) == (6, 73)
    for t in range(FAMILY_T_LIMIT + 1):
        x = 91 + 162 * t
        y = 71 + 128 * t
        assert inverse_replay(x, word) == y
        assert iterate(y, 4) == x and y < x
    return FAMILY_T_LIMIT + 1


def check_pure_a2_obstruction() -> int:
    for K in range(1, PURE_A2_DEPTH_LIMIT + 1):
        w = next(
            candidate
            for candidate in range(2, 49, 2)
            if candidate % 3 == 2 and (3**K * candidate + 1) % 8 == 7
        )
        hs = [1 + 4**i * 3 ** (K - i) * w for i in range(K + 1)]
        assert hs[0] % 8 == 7 and hs[0] % 9 in {1, 7}
        for i in range(1, K + 1):
            assert hs[i] > hs[0]
            assert U(hs[i]) == hs[i - 1]
        assert hs[-1] % 3 == 0
    return PURE_A2_DEPTH_LIMIT


def main() -> None:
    rewrite_count = check_added_rewrites_and_irreducibles()
    source_count = check_inverse_fibers_and_sources()
    word_count = check_mixed_words()
    family_count = check_2211_family()
    depth_count = check_pure_a2_obstruction()
    print(f"expanded rewrite odd starts checked: {rewrite_count}")
    print(f"inverse-fiber/source endpoints checked: {source_count}")
    print(f"mixed words checked through length {WORD_LENGTH_LIMIT}: {word_count}")
    print(f"(2,2,1,1) family parameters checked: {family_count}")
    print(f"pure-a=2 obstruction depths checked: {depth_count}")
    print("PASS")


if __name__ == "__main__":
    main()
