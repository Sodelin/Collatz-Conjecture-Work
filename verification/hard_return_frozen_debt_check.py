#!/usr/bin/env python3
"""Exact arithmetic certificate and bounded independent replay for HD-1.

No third-party dependency. This does not prove Collatz or the polynomial
no-go; the latter has a separate mathematical proof in the companion note.
"""

from fractions import Fraction


def require(claim, message):
    if not claim:
        raise RuntimeError(message)


def v2(n):
    require(n != 0, "v2 called at zero")
    n = abs(n)
    return (n & -n).bit_length() - 1


def shortcut(n):
    require(n > 0, "map domain")
    return n // 2 if n % 2 == 0 else (3 * n + 1) // 2


def iterate(n, k):
    for _ in range(k):
        n = shortcut(n)
    return n


def label(n):
    r = v2(n + 1)
    q = (n + 1) >> r
    eta = (q % 4 - 1) // 2
    return r, eta, q // 4


def is_hard(n):
    r, eta, _ = label(n)
    return r >= 2 and eta != r % 2


def debt(n):
    r, eta, z = label(n)
    require(is_hard(n), "debt domain")
    d = (3 ** (r + 1 + eta) + 3) // 4 - 2 ** r * (2 * eta + 1)
    D = v2((2 ** (r + 2) - 3 ** (r + 1)) * z - d)
    return D, D // (r + 2)


def rho(n):
    while n != 1 and not is_hard(n):
        r, _, _ = label(n)
        old = n
        if r == 0:
            n //= 2
        elif r == 1:
            n = (3 * n + 1) // 4
        else:
            n = (3 * n - 1) // 4
        require(0 < n < old, "rho strict decrease")
    return n


def hard_return(n):
    require(is_hard(n), "F domain")
    r, _, _ = label(n)
    return rho(iterate(n, r + 2))


def symbolic_shortcut(affine, word):
    """Exact uniform parity guards on all nonnegative integer parameters."""
    a, b = affine
    for branch in word:
        require(a % 2 == 0, "uniform slope parity")
        if branch == "O":
            require(b % 2 == 1, "odd guard")
            a, b = 3 * a // 2, (3 * b + 1) // 2
        elif branch == "E":
            require(b % 2 == 0, "even guard")
            a, b = a // 2, b // 2
        else:
            raise RuntimeError("branch alphabet")
    return a, b


def main():
    n0, n1, n2 = (65536, 47771), (110592, 80615), (279936, 204059)
    require(symbolic_shortcut(n0, "OOEO") == n1, "first symbolic macro")
    require(symbolic_shortcut(n1, "OOOEO") == n2, "second symbolic macro")
    require(n2[0] > 4 * n0[0] and n2[1] > 4 * n0[1], "size growth")
    require((11 * 4096 // 4, (11 * 2985 + 9) // 4) == (11264, 8211), "source factor")
    require((11 * 17496 // 4, (11 * 12753 + 9) // 4) == (48114, 35073), "target factor")
    require(11264 % 2 == 0 and 8211 % 2 == 1, "source exact valuation")
    require(48114 % 2 == 0 and 35073 % 2 == 1, "target exact valuation")
    parameters = list(range(1000)) + [2**k for k in (64, 256, 1024)]
    for u in parameters:
        a, b, c = (A * u + B for A, B in (n0, n1, n2))
        require(label(a) == (2, 1, 4096 * u + 2985), "source label")
        require(label(b) == (3, 0, 3456 * u + 2519), "middle label")
        require(label(c) == (2, 1, 17496 * u + 12753), "target label")
        require(hard_return(a) == b and hard_return(b) == c, "F replay")
        require(debt(a) == (2, 0) and debt(c) == (2, 0), "frozen debt")
        require(label(c)[2].bit_length() >= label(a)[2].bit_length() + 2, "bitlength growth")
    print("PASS: universal affine branch guards and factor identities")
    print(f"PASS: independent F/debt replay for {len(parameters)} parameters")
    print(f"Smallest displayed family member: {n0[1]} -> {n1[1]} -> {n2[1]}")
    print(f"Parameter growth ratio limit: {Fraction(17496, 4096)}")
    print("Scope: exact family and regression; Collatz remains unresolved.")


if __name__ == "__main__":
    main()
