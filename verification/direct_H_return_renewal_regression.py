"""Finite regression for direct hard-boundary and renewal identities.

The checks are finite algebraic regressions.  They do not prove Collatz or the
existence/nonexistence of an infinite typed return ray.
"""

from math import gcd


PARAMETER_LIMIT = 100_000
ODD_STATE_LIMIT = 100_000
RENEWAL_CHAIN_LENGTH = 20


def require(condition: bool, detail: object) -> None:
    if not condition:
        raise AssertionError(detail)


def v2(n: int) -> int:
    require(n > 0, ("v2-domain", n))
    k = 0
    while n % 2 == 0:
        n //= 2
        k += 1
    return k


def T(n: int) -> int:
    require(n > 0 and n % 2 == 1, ("T-domain", n))
    m = 3 * n + 1
    return m >> v2(m)


def h1(u: int) -> int:
    return 4 * u + 3


def h2(u: int) -> int:
    return 16 * u + 11


def check_typed_edges() -> int:
    checked = 0
    for u in range(1, PARAMETER_LIMIT + 1, 2):
        x1 = h1(u)
        first = T(x1)
        h1_member = first >= 7 and (first - 3) % 4 == 0 and ((first - 3) // 4) % 2 == 1
        h2_member = first >= 27 and (first - 11) % 16 == 0 and ((first - 11) // 16) % 2 == 1
        require(h1_member == (u % 4 == 3), ("AA-domain", u, first))
        require(h2_member == (u % 16 == 9), ("AB-domain", u, first))
        if h1_member:
            v = (first - 3) // 4
            require(v == (3 * u + 1) // 2 and first == h1(v), ("AA-formula", u, v))
        if h2_member:
            v = (first - 11) // 16
            require(v == 3 * (u - 1) // 8 and first == h2(v), ("AB-formula", u, v))

        x2 = h2(u)
        require(v2(3 * x2 + 1) == 1, ("B-first-valuation", u))
        middle = T(x2)
        require(v2(3 * middle + 1) == 2, ("B-second-valuation", u))
        second = T(middle)
        h1_member = second >= 7 and (second - 3) % 4 == 0 and ((second - 3) // 4) % 2 == 1
        h2_member = second >= 27 and (second - 11) % 16 == 0 and ((second - 11) // 16) % 2 == 1
        require(h1_member == (u % 4 == 1), ("BA-domain", u, second))
        require(h2_member == (u % 16 == 15), ("BB-domain", u, second))
        if h1_member:
            v = (second - 3) // 4
            require(v == (9 * u + 5) // 2 and second == h1(v), ("BA-formula", u, v))
        if h2_member:
            v = (second - 11) // 16
            require(v == (9 * u + 1) // 8 and second == h2(v), ("BB-formula", u, v))
        checked += 1
    return checked


def classify_switching_return(u: int) -> int | None:
    """Return k for AB BB^(k-1) BA, or None when the direct path exits."""
    if u % 16 != 9:
        return None
    b_parameter = 3 * (u - 1) // 8
    require(b_parameter > 0 and b_parameter % 2 == 1, ("AB-target", u, b_parameter))
    k = 1
    while True:
        state = h2(b_parameter)
        if b_parameter % 4 == 1:
            target = (9 * b_parameter + 5) // 2
            require(target > 0 and target % 2 == 1, ("BA-target", u, k, target))
            require(T(T(state)) == h1(target), ("BA-step", u, k, b_parameter))
            return k
        if b_parameter % 16 == 15:
            target = (9 * b_parameter + 1) // 8
            require(target > 0 and target % 2 == 1, ("BB-target", u, k, target))
            require(T(T(state)) == h2(target), ("BB-step", u, k, b_parameter))
            b_parameter = target
            k += 1
            continue
        return None


def check_completed_returns() -> int:
    checked = 0
    for u in range(1, PARAMETER_LIMIT + 1, 2):
        t = v2(3 * u + 5)
        predicted = (t - 1) // 3 if t >= 4 and (t - 1) % 3 == 0 else None
        actual = classify_switching_return(u)
        require(actual == predicted, ("switching-iff", u, t, predicted, actual))
        if actual is not None:
            k = actual
            q = (3 * u + 5) // (2 * 8**k)
            require(q > 0 and q % 2 == 1 and q % 3 == (-1) ** k % 3, ("q", u, k, q))
            v = 9**k * q - 2
            require(2 * 8**k * (v + 2) == 9**k * (3 * u + 5), ("return-identity", u, k, v))
            checked += 1
    return checked


def renewal(x: int) -> tuple[int, int, int, int]:
    R = v2(x + 1)
    q = (x + 1) >> R
    b = v2(3**R * q - 1)
    y = (3**R * q - 1) >> b
    return R, q, b, y


def check_renewals() -> tuple[int, int]:
    checked = 0
    nontrivial_divisor_checks = 0
    for x in range(1, ODD_STATE_LIMIT + 1, 2):
        R, q, b, y = renewal(x)
        state = x
        valuations = []
        for _ in range(R):
            valuations.append(v2(3 * state + 1))
            state = T(state)
        require(valuations[:-1] == [1] * (R - 1), ("renewal-prefix", x, valuations))
        require(valuations[-1] == b + 1, ("renewal-last", x, valuations, b))
        require(state == y, ("renewal-target", x, state, y))
        require(2 ** (R + b) * y == 3**R * x + (3**R - 2**R), ("renewal-identity", x))
        checked += 1

    # Finite-chain regressions of the two separately hypothesized gcd filters.
    for seed in range(1, 2_000, 2):
        xs = []
        Rs = []
        bs = []
        x = seed
        for _ in range(RENEWAL_CHAIN_LENGTH):
            xs.append(x)
            R, _q, b, x = renewal(x)
            Rs.append(R)
            bs.append(b)
        xs.append(x)

        d_state = 0
        d_shift = 0
        for value in xs:
            d_state = gcd(d_state, value)
            d_shift = gcd(d_shift, value + 1)
        while d_shift % 2 == 0:
            d_shift //= 2
        g = 0
        h = 0
        for R in Rs:
            g = gcd(g, R)
        for b in bs:
            h = gcd(h, b)
        require((3**g - 2**g) % d_state == 0, ("state-gcd", seed, d_state, g, xs, Rs))
        require((2**h - 1) % d_shift == 0, ("shift-gcd", seed, d_shift, h, xs, bs))
        if d_state > 1 or d_shift > 1:
            nontrivial_divisor_checks += 1

    # Nontrivial, independently readable witnesses for both implications.
    R, _q, _b, y = renewal(15)
    d_state = gcd(15, y)
    require((R, y, d_state) == (4, 5, 5), ("state-witness-data", R, y, d_state))
    require((3**R - 2**R) % d_state == 0, ("state-witness", R, d_state))

    _R, _q, b, y = renewal(23)
    d_shift = gcd(23 + 1, y + 1)
    while d_shift % 2 == 0:
        d_shift //= 2
    require((b, y, d_shift) == (4, 5, 3), ("shift-witness-data", b, y, d_shift))
    require((2**b - 1) % d_shift == 0, ("shift-witness", b, d_shift))
    return checked, nontrivial_divisor_checks


def main() -> None:
    edge_count = check_typed_edges()
    return_count = check_completed_returns()
    renewal_count, divisor_count = check_renewals()
    print(f"typed odd parameters checked: {edge_count}")
    print(f"completed switching returns checked: {return_count}")
    print(f"renewal states checked: {renewal_count}")
    print(f"finite chains with a nontrivial common-divisor check: {divisor_count}")
    print("nontrivial divisor witnesses checked: 2")
    print("PASS")


if __name__ == "__main__":
    main()
