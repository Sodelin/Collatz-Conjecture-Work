#!/usr/bin/env python3
"""Exact certificates for finite-residue hard-return shadows.

Standard library only. The all-moduli theorem and polynomial consequence
have prose proofs in finite_residue_hard_return_obstruction.md. These tests
also reconstruct uniform affine branch certificates for selected moduli.
No positive cycle or divergent orbit is asserted.
"""

from fractions import Fraction
from math import gcd


def require(claim, message):
    if not claim:
        raise RuntimeError(message)


def valuation(n, p):
    require(n != 0 and p >= 2, "valuation domain")
    n, result = abs(n), 0
    while n % p == 0:
        n //= p
        result += 1
    return result


def label(n):
    r = valuation(n + 1, 2)
    odd = (n + 1) // 2**r
    return r, (odd % 4 - 1) // 2, odd // 4


def hard(n):
    r, e, _ = label(n)
    return r >= 2 and e != r % 2


def debt(n):
    r, e, z = label(n)
    d = (3 ** (r + 1 + e) + 3) // 4 - 2**r * (2 * e + 1)
    D = valuation((2 ** (r + 2) - 3 ** (r + 1)) * z - d, 2)
    return D, D // (r + 2)


def shortcut(n):
    require(n > 0, "positive map domain")
    return n // 2 if n % 2 == 0 else (3 * n + 1) // 2


def hard_return(n):
    require(hard(n), "hard source")
    r, _, _ = label(n)
    for _ in range(r + 2):
        n = shortcut(n)
    while n != 1 and not hard(n):
        r, _, _ = label(n)
        old = n
        n = n // 2 if r == 0 else ((3 * n + 1) // 4 if r == 1 else (3 * n - 1) // 4)
        require(0 < n < old, "boundary reducer decreases")
    return n


def modular_return_period(m):
    require(m >= 1 and gcd(m, 6) == 1, "permutation modulus")
    if m == 1:
        return 1
    inverse = pow(512, -1, m)
    residue = 0
    for j in range(1, m + 1):
        residue = inverse * (2187 * residue + 3031) % m
        if residue == 0:
            return j
    raise RuntimeError("affine permutation did not return within m steps")


def crt_pair(x, q, y, r):
    require(gcd(q, r) == 1, "CRT coprimality")
    if r == 1:
        return x % q, q
    return (x + q * ((y - x) * pow(q, -1, r) % r)) % (q * r), q * r


def certificate(M):
    require(M >= 1, "sensor modulus")
    a, b = valuation(M, 2), valuation(M, 3)
    m = M // (2**a * 3**b)
    j = modular_return_period(m)
    K = 9 * j + max(a, 7)
    q2, q3 = 2**K, 3 ** max(b, 2)
    residue2 = -3031 * pow(1675, -1, q2) % q2
    residue3 = -3031 * pow(1675, -1, q3) % q3
    n0, Q = crt_pair(residue2, q2, residue3, q3)
    n0, Q = crt_pair(n0, Q, 0, m)
    require(n0 > 0 and Q % M == 0, "positive arithmetic progression")
    return j, n0, Q


def symbolic_word(affine, word):
    A, B = affine
    for branch in word:
        require(A % 2 == 0, "uniform slope parity")
        if branch == "O":
            require(B % 2 == 1, "uniform odd guard")
            A, B = 3 * A // 2, (3 * B + 1) // 2
        else:
            require(branch == "E" and B % 2 == 0, "uniform even guard")
            A, B = A // 2, B // 2
    return A, B


def require_a_class(affine):
    A, B = affine
    require(A % 128 == 0 and B % 128 == 27, "uniform A label and exact D=2")
    require(A % 9 == 0 and B % 9 == 2, "uniform A exact b=1")


def require_b_class(affine):
    A, B = affine
    require(A % 32 == 0 and B % 32 == 7, "uniform B hard label")
    require(A % 9 == 0 and B % 9 == 2, "uniform B exact b=1")


def symbolic_certificate(M):
    j, n0, Q = certificate(M)
    source = current = (Q, n0)
    require_a_class(current)
    for _ in range(j):
        middle = symbolic_word(current, "OOEO")
        require_b_class(middle)
        endpoint = symbolic_word(middle, "OOOEO")
        require_a_class(endpoint)
        require(512 * endpoint[0] == 2187 * current[0], "G slope")
        require(512 * endpoint[1] == 2187 * current[1] + 3031, "G constant")
        require(endpoint[0] > 4 * current[0] and endpoint[1] > 4 * current[1], "uniform growth")
        current = endpoint
    require((current[0] - source[0]) % M == 0, "sensor return slope")
    require((current[1] - source[1]) % M == 0, "sensor return constant")
    return j, n0, Q, current


def main():
    fixed = Fraction(-3031, 1675)
    x = fixed
    observed = ""
    for step in range(9):
        require(x.denominator % 2 == 1, "2-adic integral rational")
        odd = x.numerator % 2
        observed += "O" if odd else "E"
        x = (3 * x + 1) / 2 if odd else x / 2
        if step == 3:
            require(x == Fraction(-2707, 1675), "rational middle state")
    require(observed == "OOEOOOOEO" and x == fixed, "exact rational word certificate")
    require(gcd(2187, 512) == 1 and 2187 > 4 * 512, "positive expansion")
    moduli = [1, 2, 3, 4, 5, 7, 9, 16, 25, 27, 32, 67, 125, 335, 512, 729, 1001,
              2**128 * 3**16 * 5]
    replays, total_edges = 0, 0
    for M in moduli:
        j, n0, Q, target = symbolic_certificate(M)
        for t in [0, 1, 2, 17, 2**128 + 1]:
            n = start = n0 + Q * t
            for _ in range(j):
                require(label(n)[:2] == (2, 1) and debt(n) == (2, 0), "A data")
                require(valuation(n + 1, 3) == 1, "A 3-adic depth")
                middle = hard_return(n)
                require(label(middle)[:2] == (3, 0), "B label")
                endpoint = hard_return(middle)
                require(512 * endpoint == 2187 * n + 3031 and endpoint > 4 * n, "exact F edges")
                n = endpoint
            require(n == target[0] * t + target[1], "symbolic versus independent replay")
            require(n % M == start % M and n > 4**j * start, "frozen sensor and growth")
            require(label(n)[:2] == (2, 1) and debt(n) == (2, 0), "final A data")
            require(valuation(n + 1, 3) == 1, "final 3-adic depth")
            replays += 1
            total_edges += 2 * j
        print(f"M={M}: period={j}, positive seed bits={n0.bit_length()}, uniform progression PASS")
    # One word genuinely fails modulo these primes: the longer period is necessary.
    for p in [5, 67]:
        require(1675 % p == 0 and 3031 % p != 0, "one-word fixed-residue impossibility")
        require(modular_return_period(p) == p, "translation return period")
    require(hard_return(91) == 155, "word-specific debt recharge edge")
    require(valuation(1675 * 91 + 3031, 2) == 6, "recharge source valuation")
    require(valuation(1675 * 155 + 3031, 2) == 9, "recharge target valuation")
    print(f"PASS: {len(moduli)} uniform affine certificates; {replays} integer path replays; {total_edges} F edges")
    print("Scope: finite positive shadows with residue return; not a positive cycle or a divergence proof.")


if __name__ == "__main__":
    main()
