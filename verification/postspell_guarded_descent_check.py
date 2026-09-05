#!/usr/bin/env python3
"""Exact construction and independent replay for guarded postspell descent."""
import json


def require(ok, message):
    if not ok:
        raise RuntimeError(message)


def v2(n):
    require(n > 0, 'nonpositive valuation input')
    return (n & -n).bit_length()-1


def T(n):
    return n//2 if n%2 == 0 else (3*n+1)//2


def parity_residue(word):
    residue, coefficient, intercept = 0,1,0
    for j, letter in enumerate(word):
        numerator = coefficient*residue+intercept
        require(numerator%2**j == 0, 'prefix affine quotient nonintegral')
        value = numerator//2**j
        bit = ((letter == 'O')-value)%2
        residue += bit*2**j
        if letter == 'O':
            intercept = 3*intercept+2**j
            coefficient *= 3
        else:
            require(letter == 'E', 'invalid parity letter')
    return residue


def construct(J,H,t):
    require(J >= 2 and H >= 3 and t >= 0, 'invalid theorem parameter')
    e = 2+18*((J+H+15)//18)
    word = 'OOEO'*J+'O'*H+'E'*e
    N = len(word)
    residue = parity_residue(word)
    require(residue%256 == 91, 'first eight parity bits disagree')
    B = 2**(N-8)
    seed = (((residue-22619)//256)*pow(729,-1,B))%B
    root = 22619+186624*(seed+B*t)
    require(root%2**N == residue, 'binary CRT condition failed')
    return root, e, word


def check(root,J,H,e,word):
    require(root%729 == 20 and root >= 22619, 'wrong source cylinder')
    require(v2(root+5) == 5, 'source q not five')
    require(J+H <= e < J+H+18 and e%18 == 2, 'padding mismatch')
    require(v2(11*root+23) == 4*J+2, 'wrong exact OOEO spell length')
    value = root
    y = z = None
    for j,letter in enumerate(word):
        require(value%2 == (letter == 'O'), 'independent actual parity mismatch')
        value = T(value)
        if j+1 <= 4*J+H:
            require(value > root, 'claimed growing phase descends')
        if j < 4*J:
            require(value%27 == (17,26,13,20)[j%4], 'first return residue mismatch')
        if j+1 == 4*J:
            y = value
            require(v2(y+5) == 2 and v2(y+1) == H, 'postspell exact depths wrong')
        if j+1 == 4*J+H:
            z = value
            require(z%2**e == 0, 'missing final even-run guard')
    require(0 < value < root and value%27 == 20, 'target descent/membership failure')
    require(z == value*2**e, 'final quotient mismatch')
    require(16**J*(11*y+23) == 27**J*(11*root+23), 'first phase formula mismatch')
    require(2**H*(z+1) == 3**H*(y+1), 'second phase formula mismatch')
    require(value*32**J*4**H < 27**J*3**H*(root+3), 'strict margin bound failed')
    return value


def main():
    require(parity_residue('OOEOOOEO') == 91, 'fixed prefix mismatch')
    count = 0
    example = None
    for J in (2,3,5,10,31,127):
        for H in (3,4,10,31,127,511):
            for t in (0,1,5):
                root,e,word = construct(J,H,t)
                target = check(root,J,H,e,word)
                if example is None:
                    example = {'J':J,'H':H,'e':e,'root':root,'target':target}
                count += 1
    # This independently known root has precisely two OOEO blocks and ten
    # more odd steps, but its endpoint is not divisible by the required2^20.
    source,J,H,e = 304592987,2,10,20
    value = source
    for letter in 'OOEO'*J+'O'*H:
        require(value%2 == (letter == 'O'), 'negative control growing path wrong')
        value = T(value)
    require(value%2**e != 0, 'negative control accidentally meets exit guard')
    require(v2(value) < J+H, 'negative control has enough minimal final halving')
    insufficient_root = 4501595
    insufficient_target = insufficient_root
    for letter in 'OOEO'*2+'O'*3+'E'*2:
        require(insufficient_target%2 == (letter == 'O'), 'insufficient-halving path wrong')
        insufficient_target = T(insufficient_target)
    require(insufficient_target == 10816031 > insufficient_root,
            'insufficient-halving growth example wrong')
    require(insufficient_root%27 == insufficient_target%27 == 20,
            'insufficient-halving target residue wrong')
    rejected = 0
    for args in ((1,3,0),(2,2,0),(2,3,-1)):
        try:
            construct(*args)
        except RuntimeError:
            rejected += 1
    require(rejected == 3, 'invalid construction accepted')
    print(json.dumps({'crt_replays':count,'max_spell_length':127,
                      'max_independent_odd_run':511,'missing_exit_control_v2':v2(value),
                      'invalid_parameter_controls':rejected,'insufficient_halving_target':insufficient_target,
                      'example':example,
                      'scope':'regression checks; infinite statements use integer proofs'},
                     sort_keys=True))


if __name__ == '__main__':
    main()
