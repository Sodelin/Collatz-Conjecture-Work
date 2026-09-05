#!/usr/bin/env python3
"""Exact independent replay of growing recharge followed by root escape.

Uses explicit exceptions so optimized Python cannot erase verification.
No third-party dependencies or imported modules.
"""


def require(ok: bool, message: str) -> None:
    if not ok:
        raise RuntimeError(message)


def step(n: int) -> int:
    return (3 * n + 1) // 2 if n % 2 else n // 2


def val(n: int, p: int) -> int:
    require(n > 0, "valuation input must be positive")
    count = 0
    while n % p == 0:
        n //= p
        count += 1
    return count


def parameter(k: int, ell: int, t: int, even_steps=None) -> tuple[int, int]:
    require(k >= 1 and ell >= 1 and t >= 0, "invalid CRT parameters")
    total = k + ell
    h = total if even_steps is None else even_steps
    require(h >= total, "even-run padding must be nonnegative")
    modulus = 2**(3 * ell + h + 1)
    a = (5 * pow(3 * 9**ell, -1, 2**h)) % 2**h
    b = ((2**(3 * ell + 1) * a - 1) * pow(9**k, -1, modulus)) % modulus
    c = (25 * pow(2 * 8**k, -1, 243)) % 243
    d = ((c - b) * pow(modulus, -1, 243)) % 243
    u = b + modulus * d + 243 * modulus * t
    require(u > 0 and u % 2 == 1, "source parameter is not positive odd")
    require((9**k * u + 1) % 2**(3 * ell + 1) == 0,
            "CRT recharge integrality failed")
    v = (9**k * u + 1) // 2**(3 * ell + 1)
    require(v % 2**h == a and v % 2 == 1,
            "CRT exact recharge or exit congruence failed")
    require((2 * 8**k * u - 5) % 243 == 20, "CRT source residue failed")
    return u, v


def guarded_path(k: int, ell: int, u: int) -> tuple[int, int, int, int, list[int]]:
    require(k >= 1 and ell >= 1 and u >= 1, "positive parameters required")
    total = k + ell
    numerator = 9**k * u + 1
    require(val(numerator, 2) == 3 * ell + 1, "missing exact RECHARGE guard")
    v = numerator // 2**(3 * ell + 1)
    z = 3 * 9**ell * v - 5
    require(z % 2**total == 0, "missing EXIT guard")
    n = 2 * 8**k * u - 5
    x = 2 * 9**k * u - 5
    y = (3 * 9**k * u - 7) // 2
    m = z // 2**total
    word = "OOE" * k + "OE" + "OOE" * ell + "E" * total
    values = [n]
    for branch in word:
        value = values[-1]
        require(("O" if value % 2 else "E") == branch,
                "actual parity differs from complete certificate")
        values.append(step(value))
    require(values[3 * k] == x, "first burst endpoint failed")
    require(values[3 * k + 2] == y, "recharge connector endpoint failed")
    require(values[3 * total + 2] == z, "second burst endpoint failed")
    require(values[-1] == m and len(values) - 1 == 4 * total + 2,
            "complete orbit identity or step count failed")
    for j in range(k + 1):
        require(values[3 * j] == 2 * 8**(k - j) * 9**j * u - 5,
                "first burst affine identity failed")
    for j in range(ell + 1):
        require(values[3 * k + 2 + 3 * j] == 3 * 8**(ell - j) * 9**j * v - 5,
                "second burst affine identity failed")
    require([val(a + 5, 2) for a in [n, x, y, z]] ==
            [3 * k + 1, 1, 3 * ell, 0], "exact shadow depths failed")
    exact_margin = ((4 * 16**total - 3 * 9**total) * u
                    - 5 * 2**(3 * ell + 1) * (2**total - 1) - 3 * 9**ell)
    require(2**(3 * ell + total + 1) * (n - m) == exact_margin,
            "root-relative margin identity failed")
    require(exact_margin > 9 * 16**(total - 1), "proved margin bound failed")
    require(0 < m < n, "root-relative descent failed")
    if k >= 3:
        require(z > y > n, "growing segment endpoints failed")
        require(all(a > n for a in values[1:3 * total + 3]),
                "claimed growth prefix dipped below the original root")
    return n, y, z, m, values


def family(j: int, t: int) -> tuple[int, int, int, int]:
    require(j >= 0, "j must be nonnegative")
    k, ell = 3 + j, 4 + 17 * j
    u, _ = parameter(k, ell, t)
    n, y, z, m, values = guarded_path(k, ell, u)
    require(n % 243 == 20 and m % 27 == 20, "target residues failed")
    require(val(n + 7, 3) == 3 and val(4 * n + 1, 3) == 4,
            "root normality or low ancestor valuation failed")
    require(val(y + 5, 2) - val(n + 5, 2) == 2 + 48 * j,
            "larger recharge formula failed")
    require([a % 27 for a in values[:5]] == [20, 17, 26, 13, 20],
            "first return guard failed")
    require(values[4] == (27 * n + 23) // 16 and values[4] > n,
            "first return growth failed")
    return n, y, z, m


def expect_rejection(k: int, ell: int, u: int, message: str) -> None:
    try:
        guarded_path(k, ell, u)
    except RuntimeError as error:
        require(str(error) == message, "negative control failed for wrong reason")
    else:
        raise RuntimeError("negative control was silently accepted")


def main() -> None:
    cases = [(j, t) for j in range(8) for t in [0, 1, 2, 1000, 10**30]]
    cases += [(30, 0), (100, 1), (0, 2**4096 + 139)]
    for j, t in cases:
        family(j, t)
    require(family(0, 0) ==
            (218205150203, 233014972411, 373244930176, 2915976017),
            "displayed growing recharge example changed")
    selectors = []
    for t in range(3):
        n, _, _, _ = family(0, t)
        selectors.append(4 * ((4 * n + 1) // 81) % 9)
    require(selectors == [1, 4, 7], "ancestor complementarity cycle failed")

    general_count = 0
    for k in range(1, 6):
        for ell in range(1, 6):
            for t in [0, 1, 101]:
                u, _ = parameter(k, ell, t)
                guarded_path(k, ell, u)
                general_count += 1

    padded_count = 0
    for k in range(1, 9):
        for ell in [1, k + 1, 2 * k + 1]:
            total = k + ell
            h = 7 + 18 * ((total + 10) // 18)
            require(total <= h < total + 18 and h % 18 == 7,
                    "canonical padding length failed")
            u, _ = parameter(k, ell, 0, h)
            n, _, z, m, values = guarded_path(k, ell, u)
            require(z % 2**h == 0, "padded EXIT divisibility failed")
            value = m
            for _ in range(h - total):
                require(value % 2 == 0, "extra even step was not guarded")
                value = step(value)
            require(value == z // 2**h and 0 < value < n,
                    "padded root-relative descent failed")
            require(n % 243 == 20 and value % 27 == 20,
                    "padded target residues failed")
            require(len(values) - 1 + h - total == 3 * total + 2 + h,
                    "padded actual step count failed")
            padded_count += 1

    # The existing growing same-q recharge family remains a valid control.
    for t in [0, 1, 1000, 2**1024]:
        u = 6807 + 12288 * t
        n = 1024 * u - 5
        y = (2187 * u - 7) // 2
        require(y > n and val(n + 5, 2) == val(y + 5, 2) == 10,
                "older q10 obstruction control changed")
        value = n
        for _ in range(11):
            value = step(value)
        require(value == y, "older q10 actual orbit identity changed")
        expect_rejection(3, 4, u, "missing exact RECHARGE guard")

    # Correct recharge and source residue do not imply final EXIT.
    u = 2081431
    v = (9**3 * u + 1) // 2**13
    require(v == 185225 and val(9**3 * u + 1, 2) == 13,
            "missing-exit control recharge is wrong")
    require((1024 * u - 5) % 243 == 20, "missing-exit source residue is wrong")
    require((3 * 9**4 * v - 5) % 128 == 118,
            "missing-exit control unexpectedly gained divisibility")
    expect_rejection(3, 4, u, "missing EXIT guard")
    print(f"PASS: {len(cases)} growing CRT-family replays; "
          f"{general_count} general guarded replays; {padded_count} padded "
          "target-family replays; old q10 and missing-exit "
          "controls preserved/rejected; unbounded larger recharge followed by "
          "actual descent below the immutable root.")


if __name__ == "__main__":
    main()
