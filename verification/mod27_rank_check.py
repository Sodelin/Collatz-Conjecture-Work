#!/usr/bin/env python3
"""Exact modular rank reconstruction of Monks et al. Theorem 6.4.

The all-input argument is in source_role_audit.md. No third-party dependencies.
All guards are exhaustive residue algebra; the replay is a regression only.
"""
from collections import Counter


def require(value, message):
    if not value:
        raise AssertionError(message)


H = {1: 2, 2: 1, 4: 0, 5: 1, 7: 2, 8: 0, 10: 2, 11: 1,
     14: 1, 16: 2, 17: 0, 19: 2, 22: 0, 23: 1, 25: 2}
WEIGHTS = (16, 28, 49)


def shortcut(n):
    return (3 * n + 1) // 2 if n % 2 else n // 2


def valuation2(n):
    require(n > 0, "valuation requires a positive input")
    return (n & -n).bit_length() - 1


def rank(n):
    require(n > 0, "positive map domain")
    residue = n % 27
    if n <= 2 or residue == 20:
        return (0, 0)
    if n % 3 == 0:
        return (3, n)
    if residue == 26:
        return (1, valuation2(n + 1) + 2)
    if residue == 13:
        return (1, 1)
    return (2, WEIGHTS[H[residue]] * n)


def exact_certificate():
    require(set(H) == {r for r in range(27) if r % 3 and r not in (13, 20, 26)},
            "core residue coverage")
    edges = []
    for a in sorted(H):
        for parity in (0, 1):
            b = (14 * (3 * a + 1) if parity else 14 * a) % 27
            require(b % 3 != 0, "coprimality to 3 preserved")
            if b not in H:
                require(b in (13, 20, 26), "exhaustive core exits")
                continue
            require(2 * parity - 1 <= H[a] - H[b], "edge potential")
            wa, wb = WEIGHTS[H[a]], WEIGHTS[H[b]]
            if parity:
                # 40*wa*n - 21*wb*(3*n+1) >= 0 for n=t+3,t>=0.
                lead = 40 * wa - 63 * wb
                translated = (lead, 3 * lead - 21 * wb)
                require(min(translated) >= 0, "all n>=3 linear coefficient test")
            else:
                require(40 * wa - 21 * wb >= 0, "even linear coefficient test")
            edges.append((a, b, parity))
    require(len(edges) == 25, "expected core edge count")
    require(14 * 26 % 27 == 13, "26 even exit")
    require(14 * (3 * 26 + 1) % 27 == 26, "26 odd self-loop")
    require(14 * 13 % 27 == 20, "13 even exit")
    require(14 * (3 * 13 + 1) % 27 == 20, "13 odd exit")
    # For n=26 mod27 and n odd, T(n)+1=3*(n+1)/2 decreases v2 by one.
    print("PASS: 15 core residues, 25 internal colored edges, all-input contraction <=20/21")
    print("h =", H)
    print("rank phases: 3(divisible by3), 2(core linear), 1(26/13 exit debt), 0(target)")


def regression():
    phase_counts = Counter()
    for n in range(1, 200001):
        before = rank(n)
        phase_counts[before[0]] += 1
        if before[0]:
            require(rank(shortcut(n)) < before, f"rank failed at {n}")
    # Extremely long permissible 26 self-loops are included rather than silently pruned.
    for exponent in (1, 2, 3, 20, 100, 1024):
        n = 27 * (1 << exponent) - 1
        for j in range(exponent):
            require(n % 27 == 26 and n % 2 == 1, "long self-loop guard")
            after = shortcut(n)
            require(rank(after) < rank(n), "long self-loop descent")
            n = after
        require(n % 2 == 0 and n % 27 == 26, "loop exits after exactly exponent steps")
        require(shortcut(n) % 27 == 13 and shortcut(shortcut(n)) % 27 == 20,
                "loop exit reaches target")
    print("PASS: 200000 starting-state rank regressions; phase counts", dict(sorted(phase_counts.items())))
    print("PASS: prescribed 26-loop lengths through 1024 odd steps")


def ansari_counterexamples():
    # At the displayed n=1 induction step, work with k=(m-3)/4 modulo9.
    # F'_1 allows all pairs; A' removes only pair22, i.e. k=8 mod9.
    fp_minus_ap = {4 * k + 3 for k in range(9) if k != 8}
    f2 = {4 * (3 * a1 + a0) + 3 for a0 in (0, 1) for a1 in (0, 1)}
    require(fp_minus_ap != f2, "false identity must be rejected")
    require(11 in fp_minus_ap and 11 not in f2, "smallest displayed set-identity witness")
    print("Ansari n=1 claimed equality fails:", sorted(fp_minus_ap), "!=", sorted(f2))
    print("Witness11 belongs to F'_1\\A' but notF2; this refutes the proof step, not Collatz.")
    print("Ansari Lemma3.2 also omits3: all ternary digits zero put3 in every F_n.")


if __name__ == "__main__":
    exact_certificate()
    regression()
    ansari_counterexamples()
