#!/usr/bin/env python3
"""Exact regression replay of the guarded q=10 recharge counterfamily.

This checks the implementation independently; the parameterized theorem is
proved in AC_shadow_debt_recharge.md. Deliberately uses explicit exceptions
so python -O cannot erase the checks.
"""

from __future__ import annotations


def require(ok: bool, message: str) -> None:
    if not ok:
        raise RuntimeError(message)


def v2(n: int) -> int:
    require(n > 0, "v2 argument must be positive")
    return (n & -n).bit_length() - 1


def v3(n: int) -> int:
    require(n > 0, "v3 argument must be positive")
    k = 0
    while n % 3 == 0:
        n //= 3
        k += 1
    return k


def step(n: int) -> int:
    return (3 * n + 1) // 2 if n % 2 else n // 2


def iterate(n: int, count: int) -> int:
    for _ in range(count):
        n = step(n)
    return n


def canonical(n: int) -> tuple[int, int, int]:
    length = v2(n + 1)
    cofactor = (n + 1) // (1 << length)
    epsilon = (cofactor // 2) % 2
    z = (cofactor - 2 * epsilon - 1) // 4
    require(n == (1 << length) * (4 * z + 2 * epsilon + 1) - 1,
            "canonical identity failed")
    return length, epsilon, z


def in_hard(n: int) -> bool:
    length, epsilon, _ = canonical(n)
    return length >= 2 and epsilon != length % 2


def in_core(n: int) -> bool:
    return in_hard(n) and n % 3 != 2


def eta(n: int) -> int:
    while n != 1 and not in_core(n):
        old = n
        if n % 3 == 2:
            n = (2 * n - 1) // 3
            require(step(n) == old, "gamma coalescence identity failed")
        else:
            length, _, _ = canonical(n)
            if length == 0:
                n //= 2
            elif length == 1:
                require((3 * n + 1) % 4 == 0, "beta L=1 guard failed")
                n = (3 * n + 1) // 4
            else:
                require((3 * n - 1) % 4 == 0, "beta compatible guard failed")
                n = (3 * n - 1) // 4
        require(0 < n < old, "eta did not strictly decrease")
    return n


def core_step(n: int) -> int:
    require(in_core(n), "S input is outside C")
    length, _, _ = canonical(n)
    return eta(iterate(n, length + 2))


def labels(n: int) -> tuple[int, ...]:
    length, epsilon, z = canonical(n)
    debt = v2(11 * z + 9)
    return length, epsilon, v3(n + 1), debt, debt // 4, n % 3, v2(n + 5)


def check(t: int) -> None:
    require(t >= 0, "t must be nonnegative")
    u = 6807 + 12288 * t
    n = 1024 * u - 5
    m = (2187 * u - 7) // 2
    require(u % 2 == 1 and u % 3 == 0, "parameter guards failed")
    require(729 * u + 1 == 2048 * (2423 + 4374 * t),
            "recharge factorization failed")
    require(m - n == (139 * u + 3) // 2 and m > n,
            "root-relative growth failed")
    states = [n, 1152 * u - 5, 1296 * u - 5, m]
    require([v2(x + 5) for x in states] == [10, 7, 4, 10],
            "shadow depths differ")
    for a, b in zip(states, states[1:]):
        require(core_step(a) == b, "guarded S edge failed")
    for x in states:
        length, epsilon, _ = canonical(x)
        require((length, epsilon, v3(x + 1), x % 3) == (2, 1, 0, 1),
                "common core labels differ")
    require(labels(n) == labels(m) == (2, 1, 0, 1, 0, 1, 10),
            "endpoint labels differ")
    value = n
    for expected in "OOEOOEOOEOE":
        require(("O" if value % 2 else "E") == expected,
                "shortcut word guard failed")
        value = step(value)
    require(value == m and iterate(n, 11) == m,
            "complete shortcut path failed")


def main() -> None:
    parameters = list(range(1000)) + [10**6, 10**30, 2**1024, 2**4096 + 139]
    for t in parameters:
        check(t)
    print(f"PASS: {len(parameters)} parameter replays; exact q labels "
          "10->7->4->10; S^3(n)=T^11(n)=m>n.")


if __name__ == "__main__":
    main()
