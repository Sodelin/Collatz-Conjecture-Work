#!/usr/bin/env python3
"""Exact replay for a guarded residue-20 inverse family; no closure claim.

The universal argument is algebraic and is written in the companion note.
Replay is deliberately independent: it runs forward shortcut Collatz steps.
"""
import json
from fractions import Fraction

TABLE = {1: (1, 6, 13), 2: (1, 2, 7), 4: (2, 10, 21),
         5: (2, 4, 11), 7: (1, 0, 4), 8: (2, 4, 11)}

def require(condition, message):
    if not condition:
        raise RuntimeError(message)

def valuation(n, p):
    require(n > 0, 'valuation requires positive input')
    v = 0
    while n % p == 0:
        n //= p
        v += 1
    return v

def step(n):
    return (3*n+1)//2 if n % 2 else n//2

def iterate(n, count):
    for _ in range(count):
        n = step(n)
    return n

def make_certificate(r):
    require(r > 0 and r % 27 == 20, 'root must lie in S')
    v = valuation(4*r+1, 3)
    if v < 4:
        return None
    u = (4*r+1)//3**v
    t = (pow(2, v-2, 9)*u) % 9
    h, e, threshold = TABLE[t]
    if v < threshold:
        return None
    z = 2**(v-h-1)*3**h*u-1
    m = 2**e*z
    return {'root': r, 'target': m, 'steps': v-h+1+e,
            'valuation': v, 'unit_class': t, 'h': h, 'e': e}

def check_certificate(c):
    r, m = c['root'], c['target']
    require(0 < m < r, 'strict comparison with immutable root')
    require(m % 27 == 20, 'target must remain in S')
    require(valuation(r+7, 3) == 3, 'new roots are old-c-normal')
    require(iterate(m, c['steps']) == r, 'actual forward orbit identity')

def main():
    # Exhaust the six unit classes directly in modular arithmetic.
    for t, (h, e, threshold) in TABLE.items():
        if h == 1:
            z_mod27 = (3*t-1) % 27
        else:
            z_mod27 = (9*(2*t % 3)-1) % 27
        require((2**e*z_mod27)%27 == 20, 'modular target table')
        require(Fraction(2**(threshold-h+1+e), 3**(threshold-h)) < 1,
                'coefficient threshold')
        if threshold > 4:
            require(Fraction(2**(threshold-1-h+1+e), 3**(threshold-1-h)) >= 1,
                    'chosen macro threshold is sharp for arbitrary units')
    require(Fraction(4608*2**21, 3**21) < 1, 'uniform threshold 21')
    require(Fraction(4608*2**20, 3**20) > 1, 'uniform slope bound fails at20')

    replayed = 0
    for v in range(4, 61):
        for u in range(1, 3001):
            if u % 3 == 0 or (3**v*u-1) % 4:
                continue
            r = (3**v*u-1)//4
            c = make_certificate(r)
            if c is not None:
                check_certificate(c)
                replayed += 1
            if v >= 21:
                require(c is not None, 'complete coverage at valuation >=21')

    for v in [127, 256, 1024]:
        for u0 in [1, 17, 109, 1000000007]:
            # Adjust to an admissible positive coprime-to3 unit modulo12.
            u = next(u0+i for i in range(12)
                     if (u0+i)%3 and (3**v*(u0+i)-1)%4 == 0)
            c = make_certificate((3**v*u-1)//4)
            require(c is not None, 'large valuation coverage')
            check_certificate(c)
            replayed += 1

    # Residual boundary: this construction does not cover the root425.
    require(make_certificate(425) is None, 'do not certify425 by reversing its prefix')
    # A member of exactly the old auxiliary self-loop family is now eliminated.
    witness = make_certificate((3**21*7-1)//4)
    require(witness is not None, 'self-loop-family witness covered')
    check_certificate(witness)
    r = witness['root']
    require(r % 432 == 425, 'witness belongs to old first-return self-loop family')
    first_return = iterate(r, 3)
    require((8*first_return-7)//9 == r, 'old normalizer precisely cancels return')
    require(first_return % 243 == 236, 'old c reduction is admissible')
    require(all(iterate(r, j)%27 != 20 for j in [1,2]), 'return is first positive return')

    # Sharpness is for this selected table, not for all possible certificates.
    v, u = 20, 13
    r20 = (3**v*u-1)//4
    candidate20 = 2**10*(2**(v-3)*9*u-1)
    require(candidate20 > r20, 'guard really matters at valuation20, t4')
    require(iterate(candidate20, v-1+10) == r20, 'identity survives while descent fails')
    print(json.dumps({'status': 'passed', 'finite_replays': replayed,
        'universal_theorem': 'all r=20 mod27 with v3(4r+1)>=21 have explicit smaller S ancestor',
        'covered_old_self_loop_example': witness,
        'uncovered_425': True,
        'valuation20_t4_counterexample_to_unguarded_descent':
            {'root':r20,'candidate':candidate20},
        'scope': 'guarded infinite family; no universal termination proof'}, indent=2))

if __name__ == '__main__':
    main()
