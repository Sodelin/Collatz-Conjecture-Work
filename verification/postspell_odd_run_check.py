#!/usr/bin/env python3
"""Actual-map regression checks for arbitrary growth after a fixed OOEO spell."""
import json


def require(ok, message):
    if not ok:
        raise RuntimeError(message)


def v2(n):
    require(n > 0, 'nonpositive valuation input')
    return (n & -n).bit_length()-1


def T(n):
    return n//2 if n%2 == 0 else (3*n+1)//2


def make_source(J, H, t, ancestor_bound=None):
    require(J >= 2 and H >= 3 and t >= 0, 'invalid theorem parameter')
    d = 4*J-6
    N = 2**(H-1)
    V = ((3+2**(H-2))*pow(27**J, -1, N)) % N
    M = 2**(d+H-1)
    residue = ((2**d*V-972)*pow(8019, -1, M)) % M
    if ancestor_bound is not None:
        require(ancestor_bound >= 3, 'ancestor bound too small for formula')
        P = 3**(ancestor_bound-3)
        ternary_residue = (-31*pow(256, -1, P)) % P
        residue += M*((ternary_residue-residue)*pow(M, -1, P) % P)
        M *= P
    s = residue+M*t
    return 22619+186624*s


def verify(root, J, H):
    require(root%729 == 20 and v2(root+5) == 5, 'wrong source cylinder')
    require(v2(11*root+23) == 4*J+2, 'wrong exact spell length')
    current = root
    for _ in range(J):
        for offset, parity in enumerate((1,1,0,1)):
            require(current%2 == parity, 'OOEO parity failure')
            current = T(current)
            require(current > root, 'descent during growing spell')
            require(current%27 == (17,26,13,20)[offset], 'first-return failure')
    y = current
    require(v2(y+5) == 2 and v2(y+1) == H, 'wrong exact postspell exit')
    for h in range(1, H+1):
        require(current%2 == 1, 'odd run ended prematurely')
        current = T(current)
        require(current > root, 'descent during odd run')
        require(2**h*(current+1) == 3**h*(y+1), 'odd formula mismatch')
    require(current%2 == 0, 'odd run not exact')
    require(current*16**J*2**H > root*27**J*3**H, 'overshoot lower bound')


def inverse_check(root, depth):
    states = {root}
    for _ in range(depth+1):
        require(all(not(0 < n < root and n%27 == 20) for n in states),
                'unexpected bounded smaller ancestor')
        states = {z for n in states for z in
                  ([2*n, (2*n-1)//3] if n%3 == 2 else [2*n])}


def main():
    replays = 0
    for J in (2,3,5,10,31,127):
        for H in (3,4,10,31,127,511):
            for t in (0,1,7):
                verify(make_source(J,H,t), J,H)
                replays += 1
    joint = 0
    for L in (3,4,7,10,13):
        for J,H in ((2,3),(2,20),(5,10)):
            root = make_source(J,H,0,L)
            require((root-20)%3**(L+3) == 0, 'ancestor congruence failed')
            verify(root,J,H)
            inverse_check(root,L)
            joint += 1
    require(make_source(2,10,0) == 304592987, 'example mismatch')
    rejected = 0
    for args in ((1,3,0),(2,2,0),(2,3,-1)):
        try:
            make_source(*args)
        except RuntimeError:
            rejected += 1
    require(rejected == 3, 'invalid parameters accepted')
    print(json.dumps({'ordinary_replays': replays, 'joint_inverse_controls': joint,
                      'max_spell_length':127, 'max_exact_postspell_odd_run':511,
                      'invalid_parameter_controls': rejected,
                      'scope':'regression checks; infinite statements use integer proofs'},
                     sort_keys=True))


if __name__ == '__main__':
    main()
