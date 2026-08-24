"""Finite regression for the prime-renewal finite-window no-go.

The script checks exact finite identities and constructions only.  It does not
construct one infinite orbit, prove divergence, or prove Collatz.
"""

from math import gcd


ODD_SEED_LIMIT = 20_000
PREFIX_LENGTH = 10
HARD_PARAMETER_LIMIT = 20_000
PRIME_LIMIT = 200


def v2(n: int) -> int:
    assert n > 0
    k = 0
    while n % 2 == 0:
        n //= 2
        k += 1
    return k


def T(n: int) -> int:
    assert n > 0 and n % 2 == 1
    m = 3 * n + 1
    return m >> v2(m)


def primes_through(limit: int) -> list[int]:
    primes = []
    for n in range(2, limit + 1):
        if all(n % p for p in primes if p * p <= n):
            primes.append(n)
    return primes


def correction_prefix(seed: int, length: int) -> tuple[list[int], list[int], list[int]]:
    states = [seed]
    valuations = []
    corrections = [0]
    A = 0
    C = 0
    state = seed
    for t in range(length):
        a = v2(3 * state + 1)
        valuations.append(a)
        C = 3 * C + 2**A
        A += a
        state = T(state)
        states.append(state)
        corrections.append(C)
        assert 2**A * state == 3 ** (t + 1) * seed + C
    return states, valuations, corrections


def check_general_corrections() -> int:
    checked = 0
    for seed in range(1, ODD_SEED_LIMIT + 1, 2):
        states, _valuations, corrections = correction_prefix(seed, PREFIX_LENGTH)
        for p in primes_through(47):
            if p >= 5 and seed % p == 0:
                for state, correction in zip(states, corrections):
                    assert (state % p == 0) == (correction % p == 0)
        checked += 1
    return checked


def check_hard_words() -> int:
    checked = 0
    for u in range(1, HARD_PARAMETER_LIMIT + 1, 2):
        n1 = 4 * u + 3
        states, valuations, corrections = correction_prefix(n1, 2)
        assert valuations == [1, 1]
        assert states[2] == 9 * u + 8
        assert 4 * states[2] - 9 * n1 == 5
        assert gcd(n1, states[2]) in {1, 5}
        assert corrections == [0, 1, 5]

        n2 = 16 * u + 11
        states, valuations, corrections = correction_prefix(n2, 3)
        assert valuations == [1, 2, 1]
        assert states[3] == 27 * u + 20
        assert 16 * states[3] - 27 * n2 == 23
        assert gcd(n2, states[3]) in {1, 23}
        assert corrections == [0, 1, 5, 23]
        checked += 1
    return checked


def multiplicative_order(a: int, p: int) -> int:
    assert gcd(a, p) == 1
    value = 1
    for k in range(1, p):
        value = value * a % p
        if value == 1:
            return k
    raise AssertionError((a, p))


def crt_pair(a: int, m: int, b: int, n: int) -> tuple[int, int]:
    assert gcd(m, n) == 1
    k = ((b - a) * pow(m, -1, n)) % n
    x = a + m * k
    return x % (m * n), m * n


def first_return_seed(p: int) -> tuple[int, int]:
    ratio = 3 * pow(2, -1, p) % p
    length = multiplicative_order(ratio, p)
    dyadic = 2 ** (length + 1)
    seed, _modulus = crt_pair(dyadic - 1, dyadic, 0, p)
    if seed == 0:
        seed += dyadic * p
    return seed, length


def check_delayed_returns() -> tuple[int, int]:
    primes = [p for p in primes_through(PRIME_LIMIT) if p >= 5]
    max_gap = 0
    for p in primes:
        seed, length = first_return_seed(p)
        states, valuations, _corrections = correction_prefix(seed, length)
        assert valuations == [1] * length
        assert states[0] % p == 0 and states[-1] % p == 0
        assert all(state % p != 0 for state in states[1:-1])
        max_gap = max(max_gap, length)
    return len(primes), max_gap


def check_finite_script() -> tuple[int, int]:
    selected = [5, 7, 11, 13, 17]
    lengths = [multiplicative_order(3 * pow(2, -1, p) % p, p) for p in selected]
    starts = []
    total = 0
    for length in lengths:
        starts.append(total)
        total += length

    residue = 2 ** (total + 1) - 1
    modulus = 2 ** (total + 1)
    for p, start in zip(selected, starts):
        C = 3**start - 2**start
        target = (-C * pow(pow(3, start, p), -1, p)) % p
        residue, modulus = crt_pair(residue, modulus, target, p)
    if residue == 0:
        residue += modulus

    states, valuations, _corrections = correction_prefix(residue, total)
    assert valuations == [1] * total
    for p, start, length in zip(selected, starts, lengths):
        block = states[start : start + length + 1]
        assert block[0] % p == 0 and block[-1] % p == 0
        assert all(state % p != 0 for state in block[1:-1])
    return len(selected), total


def check_rough_growth() -> int:
    checked = 0
    for L in range(1, 13):
        for Y in (5, 11, 29, 47):
            odd_primes = [p for p in primes_through(Y) if p % 2 == 1]
            M = 1
            for p in odd_primes:
                M *= p
            states = [3**t * 2 ** (L + 1 - t) * M - 1 for t in range(L + 1)]
            for t in range(L):
                assert v2(3 * states[t] + 1) == 1
                assert T(states[t]) == states[t + 1]
                assert states[t + 1] > states[t]
            for state in states:
                assert state % M == M - 1 if M > 1 else True
                assert all(state % p != 0 for p in odd_primes)
            checked += 1
    return checked


def main() -> None:
    correction_count = check_general_corrections()
    hard_count = check_hard_words()
    prime_count, max_gap = check_delayed_returns()
    script_primes, script_length = check_finite_script()
    rough_count = check_rough_growth()
    print(f"general correction prefixes checked: {correction_count}")
    print(f"hard-word odd parameters checked: {hard_count}")
    print(f"delayed-return primes checked through {PRIME_LIMIT}: {prime_count}")
    print(f"largest checked first-return gap: {max_gap}")
    print(f"finite script: {script_primes} primes across {script_length} valuation-1 steps")
    print(f"rough-growth (L,Y) pairs checked: {rough_count}")
    print("PASS")


if __name__ == "__main__":
    main()
