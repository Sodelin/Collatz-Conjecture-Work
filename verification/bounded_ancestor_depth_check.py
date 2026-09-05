#!/usr/bin/env python3
"""Actual inverse-tree/forward replay for a uniform algebraic obstruction.

Bounded checks are regression evidence, not a substitute for the proof.
Uses explicit exceptions, so checks remain active under python -O.
"""
import json


def require(value, message):
    if not value:
        raise ValueError(message)


def T(n):
    return n // 2 if n % 2 == 0 else (3 * n + 1) // 2


def valuation(n, p):
    require(n > 0, "positive valuation input required")
    k = 0
    while n % p == 0:
        n //= p
        k += 1
    return k


def bounded_ancestors(root, depth):
    layer = {root}
    seen = {root}
    for _ in range(depth):
        nxt = set()
        for n in layer:
            nxt.add(2 * n)
            if n % 3 == 2:
                nxt.add((2 * n - 1) // 3)
        seen.update(nxt)
        layer = nxt
    return seen


def check_root(root, depth, anchor=47):
    require(root % 27 == 20, "root outside S")
    ancestors = bounded_ancestors(root, depth)
    require(not any(0 < m < root and m % 27 == 20 for m in ancestors),
            f"unexpected bounded ancestor at root {root}, depth {depth}")
    if depth >= 1 and anchor == 47:
        require([valuation(root + 7, 3), valuation(4 * root + 1, 3),
                 valuation(128 * root - 157, 3)] == [3, 3, 3],
                "ternary coordinates changed")
    return len(ancestors)


def main():
    anchor = 20
    orbit = []
    for _ in range(40):
        orbit.append(anchor)
        anchor = T(anchor)
    require(47 not in orbit, "anchor control failed")
    require(orbit[:7] == [20, 10, 5, 8, 4, 2, 1], "anchor replay changed")
    roots = nodes = 0
    for depth in range(0, 25):
        period = 3 ** (depth + 3)
        for t in [0, 1, 2, 3, 5, 11, 47, 1024, 65537]:
            nodes += check_root(47 + period * t, depth)
            roots += 1
    q_cases = 0
    for depth in [1, 2, 5, 9, 15, 22]:
        period = 3 ** (depth + 3)
        for q in range(0, 16):
            modulus = 2 ** (q + 1)
            t0 = ((2 ** q - 52) * pow(period, -1, modulus)) % modulus
            root = 47 + period * (t0 + modulus)
            require(valuation(root + 5, 2) == q, "q prescription failed")
            nodes += check_root(root, depth)
            q_cases += 1
    mixed_cases = 0
    for depth in [1, 2, 5, 9, 15, 22]:
        period = 3 ** (depth + 3)
        for horizon in [1, 2, 5, 10, 32, 64, 128]:
            modulus = 2 ** (horizon + 1)
            t0 = (-48 * pow(period, -1, modulus)) % modulus
            root = 47 + period * (t0 + modulus)
            nodes += check_root(root, depth)
            n = root
            for j in range(1, horizon + 1):
                require(n % 2 == 1, "odd prefix failed")
                n = T(n)
                require(n == 3 ** j * (root + 1) // 2 ** j - 1,
                        "independent forward formula mismatch")
                require(n > root, "unexpected early descent")
            mixed_cases += 1
    target_cases = 0
    for depth in [3, 4, 5, 8, 12, 16, 20, 24]:
        modulus = 3 ** (depth - 3)
        s0 = (-31 * pow(256, -1, modulus)) % modulus
        for shift in [0, 1, 5]:
            s = s0 + modulus * shift
            root = 22619 + 186624 * s
            require((root - 20) % 3 ** (depth + 3) == 0, "target lift failed")
            require(valuation(root + 5, 2) == 5, "target q changed")
            require([valuation(root + 7, 3), valuation(4 * root + 1, 3),
                     valuation(128 * root - 157, 3)] == [3, 4, 3],
                    "target ternary coordinates changed")
            nodes += check_root(root, depth, anchor=20)
            target_cases += 1
    simultaneous_cases = 0
    for depth in [3, 7, 12, 20]:
        ternary_modulus = 3 ** (depth - 3)
        s3 = (-31 * pow(256, -1, ternary_modulus)) % ternary_modulus
        for spell_length in [2, 3, 7, 32, 128]:
            for terminal in range(4):
                d = 4 * (spell_length - 2) + terminal
                binary_modulus = 2 ** (d + 1)
                s2 = ((2 ** d - 972) * pow(8019, -1, binary_modulus)) % binary_modulus
                s0 = s3 + ternary_modulus * (((s2-s3) * pow(ternary_modulus, -1, binary_modulus)) % binary_modulus)
                for shift in [0, 2]:
                    s = s0 + ternary_modulus * binary_modulus * shift
                    root = 22619 + 186624 * s
                    require((root-20) % 3 ** (depth+3) == 0, "joint ternary CRT failed")
                    require(valuation(972 + 8019*s, 2) == d, "joint binary CRT failed")
                    nodes += check_root(root, depth, anchor=20)
                    n = root
                    for step_index in range(1, 4 * spell_length + 1):
                        require(n % 2 == (1, 1, 0, 1)[(step_index-1) % 4], "joint spell parity failed")
                        n = T(n)
                        require(n > root, "joint early forward descent")
                    require(valuation(n+5, 2) == terminal, "joint exit depth mismatch")
                    require(16 ** spell_length * (11*n+23) == 27 ** spell_length * (11*root+23), "joint independent orbit mismatch")
                    simultaneous_cases += 1
    # A nearby covered root shows the test is not excluding all S ancestors.
    root = 479
    require(425 in bounded_ancestors(root, 3), "positive inverse control failed")
    print(json.dumps({"status": "PASS", "plain_roots": roots,
                      "prescribed_q_roots": q_cases, "mixed_roots": mixed_cases,
                      "q5_target_roots": target_cases,
                      "simultaneous_target_roots": simultaneous_cases,
                      "maximum_joint_spell_length": 128,
                      "maximum_actual_forward_steps": 512,
                      "inverse_tree_nodes_examined": nodes,
                      "maximum_inverse_depth": 24, "maximum_forward_horizon": 128},
                     sort_keys=True))


if __name__ == '__main__':
    main()
