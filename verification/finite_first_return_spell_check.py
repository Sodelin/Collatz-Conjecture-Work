#!/usr/bin/env python3
"""Exact checks for the finite OOEO spell theorem; no floating-point tests."""
import json


def require(condition, message):
    if not condition:
        raise RuntimeError(message)


def v2(n):
    require(n > 0, 'valuation requires a positive integer')
    return (n & -n).bit_length() - 1


def step(n):
    require(n > 0, 'shortcut map input must be positive')
    return n // 2 if n % 2 == 0 else (3*n+1) // 2


def check_spell(root, expected_length=None, expected_exit=None):
    require(root > 0 and root % 27 == 20, 'root outside S20')
    require(v2(root+5) >= 4, 'initial OOEO guard fails')
    depth = v2(11*root+23)
    length, terminal = divmod(depth, 4)
    if expected_length is not None:
        require(length == expected_length, 'CRT length mismatch')
    if expected_exit is not None:
        require(terminal == expected_exit, 'CRT terminal mismatch')
    current = root
    for j in range(length):
        require(v2(current+5) >= 4, 'premature guard loss')
        block_source = current
        for offset, parity in enumerate((1, 1, 0, 1)):
            require(current % 2 == parity, 'actual parity differs')
            current = step(current)
            require(current > block_source and current > root,
                    'positive-time state failed strict root growth')
            require(current % 27 == (17, 26, 13, 20)[offset],
                    'first return residue mismatch')
        require(16*current == 27*block_source+23, 'block formula mismatch')
        require(16**(j+1)*(11*current+23) == 27**(j+1)*(11*root+23),
                'independently replayed iterate differs from formula')
        require(v2(11*current+23) == depth-4*(j+1), 'clock mismatch')
    require(v2(current+5) == terminal, 'terminal shadow depth mismatch')
    require((current+5) % 16 != 0, 'spell can still extend')
    return current


def main():
    general = 0
    for root in range(20, 100000, 27):
        if v2(root+5) >= 4:
            check_spell(root)
            general += 1
    crt = 0
    max_length = 0
    for length in tuple(range(2, 31)) + (63, 127, 255, 511):
        for terminal in range(4):
            d = 4*(length-2)+terminal
            modulus = 2**(d+1)
            seed = ((2**d-972)*pow(8019, -1, modulus)) % modulus
            for t in (0, 1, 3):
                s = seed + modulus*t
                root = 22619+186624*s
                require(v2(root+5) == 5, 'source q5 mismatch')
                require(root % 729 == 20, 'source residual ternary mismatch')
                check_spell(root, length, terminal)
                crt += 1
                max_length = max(max_length, length)
    require(check_spell(22619) == 64415, 'base example mismatch')
    rejected = 0
    for invalid_root in (20, 425, 0, 19):
        try:
            check_spell(invalid_root)
        except RuntimeError:
            rejected += 1
    require(rejected == 4, 'guard rejection failed')
    print(json.dumps({'general_roots': general, 'crt_replays': crt,
                      'maximum_spell_length': max_length,
                      'all_four_exit_depths': True,
                      'negative_controls_rejected': rejected,
                      'scope': 'exact regression checks; universal claims use prose proof'},
                     sort_keys=True))


if __name__ == '__main__':
    main()
