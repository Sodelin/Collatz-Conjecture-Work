#!/usr/bin/env python3
"""Exact second-attempt certificate; no Collatz closure assertion."""


def check(value, message):
    if not value:
        raise RuntimeError(message)


def valuation(n, p):
    check(n != 0, "zero valuation argument")
    n, k = abs(n), 0
    while n % p == 0:
        n //= p
        k += 1
    return k


def coordinates(n):
    a = valuation(n + 1, 2)
    b = valuation(n + 1, 3)
    return a, b, (n + 1) // (2**a * 3**b)


def label(n):
    a = valuation(n + 1, 2)
    q = (n + 1) // 2**a
    return a, (q % 4 - 1) // 2, q // 4


def hard(n):
    a, e, _ = label(n)
    return a >= 2 and e != a % 2


def shortcut(n):
    return n // 2 if n % 2 == 0 else (3 * n + 1) // 2


def iterate(n, k):
    for _ in range(k):
        n = shortcut(n)
    return n


def debt(n):
    a, e, z = label(n)
    d = (3 ** (a + 1 + e) + 3) // 4 - 2**a * (2*e+1)
    D = valuation((2 ** (a+2) - 3 ** (a+1)) * z - d, 2)
    return D, D // (a+2)


def affine_macro(pair, word):
    a, b = pair
    for parity in word:
        check(a % 2 == 0, "uniform parameter parity")
        check(b % 2 == int(parity == "O"), "constant parity guard")
        if parity == "O":
            a, b = 3*a//2, (3*b+1)//2
        else:
            a, b = a//2, b//2
    return a, b


def main():
    A, B, C = (589824, 244379), (995328, 412391), (2519424, 1043867)
    lambdas = ((49152, 20365), (41472, 17183), (209952, 86989))
    check(affine_macro(A, "OOEO") == B, "first affine macro")
    check(affine_macro(B, "OOOEO") == C, "second affine macro")
    for pair, lam, a in zip((A, B, C), lambdas, (2, 3, 2)):
        check(pair[0] == 2**a * 3 * lam[0], "factor slope")
        check(pair[1]+1 == 2**a * 3 * lam[1], "factor intercept")
        check(lam[0] % 6 == 0 and lam[1] % 6 in (1, 5), "cofactor coprimality")
    check(lambdas[2][0]-4*lambdas[0][0] == 13344, "growth slope")
    check(lambdas[2][1]-4*lambdas[0][1] == 5529, "growth intercept")

    parameters = list(range(512)) + [2**64, 2**256, 2**1024]
    for t in parameters:
        x, y, z = [a*t+b for a,b in (A,B,C)]
        check(hard(x) and hard(y) and hard(z), "all hard")
        check(iterate(x,4)==y and iterate(y,5)==z, "integer map replay")
        check(debt(x)==(2,0) and debt(z)==(2,0), "frozen debt")
        for n, a, lam in zip((x,y,z), (2,3,2), lambdas):
            check(coordinates(n)==(a,1,lam[0]*t+lam[1]), "exact coordinates")
        check(coordinates(z)[2] > 4*coordinates(x)[2], "cofactor growth")

    # Independent direct-map checks of the raw hard macro and reset identity.
    for n in range(3, 20000, 2):
        if not hard(n):
            continue
        L, b, lam = coordinates(n)
        Y = iterate(n,L+2)
        check(Y == (3**(L+b+1)*lam-1)//4, "raw macro")
        check(valuation(Y+1,3)==1, "universal reset regression")
        r = valuation(3**(L+b)*lam+1,2)-2
        lam2 = (3**(L+b)*lam+1)//2**(r+2)
        check(coordinates(Y)==(r,1,lam2), "raw target coordinates")

    print("PASS: universal affine parity guards and cofactor factorizations")
    print(f"PASS: {len(parameters)} independent witness-family replays")
    print("PASS: raw hard-macro coordinate/reset replay on hard odd n<20000")
    print("Witness t=0: 244379 -> 412391 -> 1043867")
    print("Endpoint coordinates: (a,b,lambda)=(2,1,20365) -> (2,1,86989)")
    print("Scope: coordinate-rank obstruction; Collatz remains unresolved")


if __name__ == "__main__":
    main()
