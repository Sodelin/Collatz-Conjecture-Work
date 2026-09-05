#!/usr/bin/env python3
"""Exact arithmetic certificate for the ternary-normalized core obstruction.

Standard library only. Universal assertions are coefficient identities and
valuation/divisibility certificates; sampled replay is a secondary software check.
"""
from fractions import Fraction
import json


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def valuation(n, p):
    require(n != 0 and p >= 2, 'valuation domain')
    n, depth = abs(n), 0
    while n % p == 0:
        n //= p
        depth += 1
    return depth


def shortcut(n):
    return (3 * n + 1) // 2 if n % 2 else n // 2


def data(n):
    L = valuation(n + 1, 2)
    odd = (n + 1) // 2**L
    epsilon = (odd % 4 - 1) // 2
    z = (odd - 2 * epsilon - 1) // 4
    hard = L >= 2 and epsilon != L % 2
    result = {'L': L, 'epsilon': epsilon, 'b': valuation(n + 1, 3),
              'n_mod_3': n % 3, 'z': z, 'hard': hard}
    if L == 2 and epsilon == 1:
        D = valuation(11 * z + 9, 2)
        result.update(D=D, R=D // 4)
    return result


def normal(n):
    """Each branch strictly decreases; convergence preservation is proved in note."""
    require(n > 0, 'normalizer positive domain')
    while n > 1:
        old = n
        if n % 3 == 2:
            n = (2 * n - 1) // 3
        else:
            d = data(n)
            if d['L'] == 0:
                n //= 2
            elif d['L'] == 1:
                n = (3 * n + 1) // 4
            elif not d['hard']:
                n = (3 * n - 1) // 4
            else:
                return n
        require(0 < n < old, 'strict positive normalizer decrease')
    return n


def affine_step(pair, branch):
    a, b = pair
    require(a % 2 == 0, 'uniform parity requires even slope')
    if branch == 'O':
        require(b % 2 == 1, 'odd branch guard')
        return 3 * a // 2, (3 * b + 1) // 2
    require(branch == 'E' and b % 2 == 0, 'even branch guard')
    return a // 2, b // 2


def universal_certificates():
    # w is an arbitrary positive integer. Product specialization w=Mv is free.
    start = (1536, -5)
    expected = [(2304, -7), (3456, -10), (1728, -5), (2592, -7)]
    state = start
    for branch, target in zip('OOEO', expected):
        state = affine_step(state, branch)
        require(state == target, 'affine path identity')
    target = expected[2]
    require((2 * state[0] // 3, (2 * state[1] - 1) // 3) == target,
            'gamma target identity')
    require(state[0] % 3 == 0 and state[1] % 3 == 2, 'gamma guard')
    for (a, b), z_slope in ((start, 96), (target, 108)):
        require(a % 16 == 0 and b % 16 == 11, 'hard label (2,1)')
        require(a % 3 == 0 and (b + 1) % 3 != 0 and b % 3 == 1,
                'ternary core label')
        require((a // 16, (b - 11) // 16) == (z_slope, -1), 'z identity')
        require(11 * z_slope % 4 == 0 and 11 * (-1) + 9 == -2,
                'D exactly one, not a lower bound')
        require(a + b > 0, 'positivity for all w>=1')
    require(target[0] - start[0] == 192 and target[1] == start[1],
            'strict growth and equality mod every M after w=Mv')
    require(Fraction(target[0], start[0]) == Fraction(9, 8), 'asymptotic ratio')
    # F026 family is already removable by an elementary smaller predecessor.
    source = (589824, 244379)
    smaller = (393216, 162919)
    require(affine_step(smaller, 'O') == source, 'F026 predecessor identity')
    require(0 < smaller[0] < source[0] and 0 < smaller[1] < source[1],
            'uniformly positive smaller F026 target')
    # Choosing M divisible by27 gives an exact first return to20 modulo27.
    residue_word = [(2304, -7), (3456, -10), (1728, -5), (2592, -7)]
    require([b % 27 for a, b in residue_word] == [20, 17, 22, 20],
            'first return: no interior20 residue')
    current = residue_word[0]
    for branch, target in zip('OEO', residue_word[1:]):
        current = affine_step(current, branch)
        require(current == target, 'residue20 affine return')
    require(residue_word[-1][0] > residue_word[0][0], 'residue20 return grows')
    # Stronger inverse macros and the exact positive normalization self-loop.
    current = (16, 11)
    for branch in 'OOE':
        current = affine_step(current, branch)
    require(current == (18, 13), 'all odd4 mod9 smaller target')
    current = (432, 425)
    for branch in 'OEO':
        current = affine_step(current, branch)
    require(current == (486, 479), 'smaller target within20 mod27')
    current = (2048, -7)
    for branch in 'OEO':
        current = affine_step(current, branch)
    require(current == (2304, -7), 'positive target for residue20 witness')
    x = 425
    orbit = [x]
    for _ in range(3):
        x = shortcut(x)
        orbit.append(x)
    require(orbit == [425, 638, 319, 479], 'self-loop T segment')
    require([x % 27 for x in orbit] == [20, 17, 22, 20], 'first return guard')
    require(valuation(425+7,3) == 3 and valuation(479+7,3) == 5,
            'source normalized and target peelable')
    require((8*479-7)//9 == 425 and (8*479-7) % 9 == 0,
            'positive auxiliary self-loop')
    return {'universal_word': 'OOEO', 'n': '1536*M*v-5',
            'm': '1728*M*v-5', 'domain': 'M>=1, v>=1',
            'same_labels': [2, 1, 0, 1, 0, 1], 'growth_ratio_limit': '9/8',
            'residue20_corollary': 'M divisible by 27: first-return word OEO, growth 9/8',
            'stronger_targets': 'odd 4 mod 9; within 20 mod 27',
            'auxiliary_composition_self_loop': [425, 638, 319, 479, 425]}


def replay():
    count = 0
    for M in [1, 2, 3, 6, 7, 16, 27, 35, 256, 3**12, 2**32 * 3**13 * 5**7]:
        for v in list(range(1, 65)) + [10**30 + 1, 2**1024 + 17]:
            n, m = 1536*M*v-5, 1728*M*v-5
            require(0 < n < m and n % M == m % M, 'positive residue witness')
            states = [n]
            for _ in range(4):
                states.append(shortcut(states[-1]))
            require(states[3] == m and normal(states[4]) == m, 'return replay')
            for x in (n, m):
                d = data(x)
                require([d[k] for k in ['L','epsilon','b','D','R','n_mod_3']]
                        == [2,1,0,1,0,1], 'frozen measurement replay')
                require(normal(x) == x, 'core normal form')
            # Local OOE-cycle debt is a genuine unbounded escape from residue labels.
            require(valuation(m+5,2) == valuation(n+5,2)-3,
                    'local shadow depth decreases by three')
            count += 1
    for t in list(range(100)) + [2**1024 + 19]:
        n, m = 589824*t + 244379, 393216*t + 162919
        require(0 < m < n and shortcut(m) == n, 'F026 smaller target replay')
    return {'core_witness_replays': count, 'F026_replays': 101}


if __name__ == '__main__':
    result = {'status': 'PASS', 'exact_certificate': universal_certificates(),
              'replay': replay(),
              'scope': 'auxiliary finite-residue polynomial-rank obstruction; no Collatz closure'}
    print(json.dumps(result, indent=2))
