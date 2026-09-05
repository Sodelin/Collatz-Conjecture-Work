#!/usr/bin/env python3
"""Independent exact replay of guarded root-relative burst descent.

No third-party dependencies. Integer CRT construction and actual shortcut
steps check the certificate; the universal family statement is proved in
Root_Relative_Burst_Descent.md.
"""


def require(ok: bool, message: str) -> None:
    if not ok:
        raise RuntimeError(message)


def step(n: int) -> int:
    return (3 * n + 1) // 2 if n % 2 else n // 2


def valuation(n: int, prime: int) -> int:
    require(n > 0, "valuation input must be positive")
    count = 0
    while n % prime == 0:
        n //= prime
        count += 1
    return count


def crt_parameter(k: int, t: int) -> int:
    require(k >= 1 and t >= 0, "invalid CRT parameter")
    two = 2**k
    a = (5 * pow(9**k, -1, two)) % two
    b = (25 * pow(8**k, -1, 243)) % 243
    correction = ((b - a) * pow(two, -1, 243)) % 243
    u = a + two * correction + 243 * two * t
    require(u > 0 and u % 2 == 1, "CRT positivity or oddness failed")
    require((9**k * u - 5) % two == 0, "CRT EXIT congruence failed")
    require((8**k * u - 25) % 243 == 0, "CRT root congruence failed")
    return u


def guarded_descent(k: int, u: int) -> tuple[int, int, list[int]]:
    require(k >= 1 and u >= 1, "k and u must be positive")
    require((9**k * u - 5) % 2**k == 0, "missing EXIT divisibility guard")
    n = 8**k * u - 5
    expected_m = (9**k * u - 5) // 2**k
    require(valuation(n + 5, 2) == 3 * k, "initial exact shadow depth failed")
    word = "OOE" * k + "E" * k
    values = [n]
    for branch in word:
        value = values[-1]
        require(("O" if value % 2 else "E") == branch,
                "actual shortcut parity differs from certificate")
        values.append(step(value))
    require(values[3 * k] == 9**k * u - 5, "OOE burst endpoint failed")
    for j in range(k + 1):
        require(values[3 * j] == 8**(k - j) * 9**j * u - 5,
                "OOE intermediate affine identity failed")
    require(values[-1] == expected_m, "actual orbit endpoint failed")
    require(0 < expected_m < n, "root-relative descent failed")
    require(2**k * (n - expected_m) == (16**k - 9**k) * u - 5 * (2**k - 1),
            "exact descent margin identity failed")
    return n, expected_m, values


def check_family(j: int, t: int) -> tuple[int, int, int]:
    require(j >= 0, "j must be nonnegative")
    k = 7 + 18 * j
    u = crt_parameter(k, t)
    n, m, values = guarded_descent(k, u)
    require(n % 243 == 20 and valuation(n + 7, 3) == 3,
            "root c-normality failed")
    require(valuation(4 * n + 1, 3) == 4,
            "exact low ancestor valuation failed")
    require(m % 27 == 20, "target escaped residue20")
    require([x % 27 for x in values[:5]] == [20, 17, 26, 13, 20],
            "first-return residue guards failed")
    require(values[4] == (27 * n + 23) // 16 and values[4] > n,
            "first-return growth failed")
    require(valuation(values[4] + 7, 3) == 3,
            "first-return c-normality failed")
    return k, n, m


def main() -> None:
    count = 0
    for j in range(12):
        for t in [0, 1, 2, 10, 1000, 10**30]:
            check_family(j, t)
            count += 1
    for j, t in [(30, 0), (100, 1), (0, 2**4096 + 139)]:
        check_family(j, t)
        count += 1
    require(crt_parameter(7, 0) == 749, "displayed CRT example changed")
    require(check_family(0, 0) == (7, 1570766843, 27987842),
            "displayed descent example changed")
    selectors = []
    for t in range(3):
        _, n, _ = check_family(0, t)
        v = valuation(4 * n + 1, 3)
        w = (4 * n + 1) // 3**v
        selectors.append((2**(v - 2) * w) % 9)
    require(selectors == [4, 7, 1],
            "ancestor overlap/nonoverlap examples changed")

    # Independent general-theorem examples include the small k boundary.
    for k in range(1, 25):
        u0 = (5 * pow(9**k, -1, 2**k)) % 2**k
        for t in [0, 1, 101]:
            guarded_descent(k, u0 + 2**k * t)

    # With the guard absent, the burst still exists but k further E steps
    # are not licensed. The checker must reject this input.
    require((9**7 - 5) % 2**7 != 0, "negative control unexpectedly admissible")
    try:
        guarded_descent(7, 1)
    except RuntimeError as error:
        require(str(error) == "missing EXIT divisibility guard",
                "negative control failed for an unrelated reason")
    else:
        raise RuntimeError("missing EXIT guard was silently accepted")

    print(f"PASS: {count} CRT-family replays; 72 general guarded replays; "
          "first return grows, later return descends; absent guard rejected.")


if __name__ == "__main__":
    main()
