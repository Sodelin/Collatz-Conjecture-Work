#!/usr/bin/env python3
"""Exact, dependency-free checks for the guarded multi-excursion theorem.

The universal argument is in ORIGINAL_ROOT_BRIDGE_PROGRESS_2026-09-05.md.
Finite tests are
regressions, never evidence of universal Collatz termination. No floating point
or assert statements are used in the trusted checking path.
"""
from __future__ import annotations

from dataclasses import dataclass
from fractions import Fraction
import itertools
import json
import random
from typing import Sequence


def require(ok: bool, message: str) -> None:
    if not ok:
        raise ValueError(message)


def natural(value: int, name: str, minimum: int = 0) -> None:
    require(type(value) is int and value >= minimum, f"invalid {name}")


def shortcut(n: int) -> int:
    natural(n, "positive start", 1)
    return n // 2 if n % 2 == 0 else (3 * n + 1) // 2


def valuation(n: int, p: int) -> int:
    natural(n, "valuation input", 1)
    require(p in (2, 3), "unsupported prime")
    result = 0
    while n % p == 0:
        n //= p
        result += 1
    return result


@dataclass(frozen=True)
class Block:
    j: int
    h: int
    tail: str

    def __post_init__(self) -> None:
        natural(self.j, "spell length", 2)
        natural(self.h, "odd-run length", 3)
        require(self.tail in ("EE", "EO"), "invalid failed-return tail")

    @property
    def word(self) -> str:
        return "OOEO" * self.j + "O" * self.h + self.tail


def affine(word: str) -> tuple[int, int, int]:
    """Return (A,C,D) for the guarded formula (A*n+C)/D."""
    require(type(word) is str and set(word) <= {"O", "E"}, "invalid word")
    a, c, d = 1, 0, 1
    for letter in word:
        if letter == "O":
            a, c = 3 * a, 3 * c + d
        d *= 2
    return a, c, d


def parity_residue(word: str) -> tuple[int, int]:
    """Construct the unique admissible residue without scanning starts."""
    require(type(word) is str and set(word) <= {"O", "E"}, "invalid word")
    r, a, c, d = 0, 1, 0, 1
    for letter in word:
        require((a * r + c) % d == 0, "prefix integrality failure")
        want = int(letter == "O")
        delta = (want - (a * r + c) // d) % 2
        r += delta * d
        if letter == "O":
            a, c = 3 * a, 3 * c + d
        d *= 2
    return r, d


def counts(blocks: Sequence[Block], j: int, h: int) -> tuple[int, int, int, int]:
    natural(j, "terminal spell length", 2)
    natural(h, "terminal odd-run length", 3)
    require(all(isinstance(b, Block) for b in blocks), "invalid block list")
    return j + sum(b.j for b in blocks), h + sum(b.h for b in blocks), len(blocks), sum(b.tail == "EO" for b in blocks)


def half_margin_halvings(blocks: Sequence[Block], j: int, h: int) -> int:
    """Least e>=1, e=2 mod18, satisfying the sufficient half-margin budget.

    This is not advertised as the least e causing actual descent.
    """
    js, hs, k, q = counts(blocks, j, h)
    a = 3 ** (3 * js + hs + q)
    offset = 4 * js + hs + 2 * k
    e0 = max(1, (2 * a - 1).bit_length() - offset)
    return e0 + (2 - e0) % 18


def source(blocks: Sequence[Block], j: int, h: int, e: int, t: int = 0) -> tuple[int, str]:
    counts(blocks, j, h)
    natural(e, "terminal even length", 1)
    natural(t, "progression parameter")
    word = "".join(b.word for b in blocks) + "OOEO" * j + "O" * h + "E" * e
    # One extra parity fixes exact final valuation. It is NOT counted in word.
    residue, modulus = parity_residue(word + "O")
    require(residue % 256 == 91, "source-prefix compatibility failed")
    binary = modulus // 256
    s0 = ((residue - 22619) // 256 * pow(729, -1, binary)) % binary
    r = 22619 + 186624 * (s0 + binary * t)
    require(r % modulus == residue, "CRT mismatch")
    return r, word


def replay(root: int, word: str) -> list[int]:
    natural(root, "positive root", 1)
    require(type(word) is str and set(word) <= {"O", "E"}, "invalid word")
    states = [root]
    for letter in word:
        n = states[-1]
        require(n % 2 == int(letter == "O"), "actual parity mismatch")
        states.append(shortcut(n))
    a, c, d = affine(word)
    require(d * states[-1] == a * root + c, "affine / actual-map mismatch")
    return states


def certify(root: int, blocks: Sequence[Block], j: int, h: int, e: int) -> dict:
    js, hs, k, q = counts(blocks, j, h)
    natural(e, "terminal even length", 1)
    natural(root, "source root", 4)
    require(root >= 22619 and (root - 22619) % 186624 == 0, "wrong root cylinder")
    require(e % 18 == 2, "terminal target residue guard")
    a = 3 ** (3 * js + hs + q)
    d = 2 ** (4 * js + hs + 2 * k + e)
    require(2 * a <= d, "unpaid cumulative budget")
    word = "".join(b.word for b in blocks) + "OOEO" * j + "O" * h + "E" * e
    states = replay(root, word)
    wa, wc, wd = affine(word)
    require((a, d) == (wa, wd), "symbolic totals disagree with actual word")
    require(wc < 3 * wa, "whole-word additive envelope failed")
    pos, aa, dd = 0, 1, 1
    returns = []
    for block in blocks:
        start = states[pos]
        end = states[pos + len(block.word)]
        require(start % 27 == end % 27 == 20, "failed block left S20")
        require(valuation(11 * start + 23, 2) == 4 * block.j + 2, "wrong exact spell")
        x = states[pos + 4 * block.j]
        z = states[pos + 4 * block.j + block.h]
        require(valuation(x + 1, 2) == block.h, "wrong exact odd run")
        require(valuation(z, 2) == (2 if block.tail == "EE" else 1), "wrong failed halving count")
        require(min(states[pos + 1:pos + len(block.word) + 1]) > start, "descent in failed block")
        ba, bc, bd = affine(block.word)
        require(bc + 3 * bd < 3 * ba, "shifted affine envelope failed")
        require(bd * (end + 3) < ba * (start + 3), "local shifted envelope failed")
        aa, dd = aa * ba, dd * bd
        require(dd * (end + 3) < aa * (root + 3), "root ledger reset or failed")
        # The existing ancestor selector only unwinds to a larger spell exit.
        if block.tail == "EO":
            require(valuation(4 * end + 1, 3) == block.h + 2, "EO ternary recharge")
            require((2 ** block.h * ((4 * end + 1) // 3 ** (block.h + 2))) % 9 == 7, "EO selector class")
            unit = (4 * end + 1) // 3 ** (block.h + 2)
            require(2 ** block.h * 3 * unit - 1 == x > root, "EO ancestor cancellation")
        else:
            require(valuation(4 * end + 1, 3) == block.h + 1, "EE ternary recharge")
            unit = (4 * end + 1) // 3 ** (block.h + 1)
            require((2 ** (block.h - 1) * unit) % 9 == 8, "EE selector class")
            candidate = 16 * (2 ** (block.h - 2) * 9 * unit - 1)
            require(candidate == 12 * x - 4 > root, "EE ancestor comparison")
        pos += len(block.word)
        returns.append({"time": pos, "value": end, "tail": block.tail})
    terminal_start = states[pos]
    terminal_x = states[pos + 4 * j]
    terminal_z = states[pos + 4 * j + h]
    require(min(states[pos + 1:pos + 4 * j + h + 1]) > root, "terminal growth crossed root")
    require(valuation(11 * terminal_start + 23, 2) == 4 * j + 2, "terminal exact spell")
    require(valuation(terminal_x + 1, 2) == h, "terminal exact odd run")
    require(valuation(terminal_z, 2) == e, "terminal even length not exact")
    endpoint = states[-1]
    require(endpoint % 27 == 20 and endpoint % 2 == 1, "terminal membership failed")
    require(d * endpoint < a * (root + 3), "whole-root envelope failed")
    require(0 < endpoint < root, "no original-root descent")
    return {"root": root, "endpoint": endpoint, "steps": len(word), "returns": returns,
            "halvings": e, "J": js, "H": hs, "K": k, "Q": q}


def rejection(call) -> None:
    try:
        call()
    except (ValueError, TypeError):
        return
    raise RuntimeError("negative control was accepted")


def self_test() -> dict:
    cases, max_k, max_steps = 0, 0, 0
    schedules = [[]]
    for k in range(1, 5):
        for tails in itertools.product(("EE", "EO"), repeat=k):
            schedules.append([Block(2 + i % 3, 3 + i % 4, tail) for i, tail in enumerate(tails)])
    rng = random.Random(20260905)
    for _ in range(32):
        schedules.append([Block(rng.randrange(2, 12), rng.randrange(3, 16), rng.choice(("EE", "EO")))
                          for _ in range(rng.randrange(1, 10))])
    schedules += [[Block(2, 3, "EE") for _ in range(64)],
                  [Block(2, 3, "EO") for _ in range(64)],
                  [Block(127, 511, "EE"), Block(31, 127, "EO")]]
    for blocks in schedules:
        for j, h in ((2, 3), (5, 10)):
            e = half_margin_halvings(blocks, j, h)
            js, hs, k, q = counts(blocks, j, h)
            require(2 ** (4 * js + hs + 2 * k + e) >= 2 * 3 ** (3 * js + hs + q), "budget selection")
            if e > 2:
                require(2 ** (4 * js + hs + 2 * k + e - 18) < 2 * 3 ** (3 * js + hs + q), "residue-constrained budget minimality")
            for t in (0, 1, 10**12):
                r, _ = source(blocks, j, h, e, t)
                result = certify(r, blocks, j, h, e)
                cases += 1
                max_k = max(max_k, k)
                max_steps = max(max_steps, result["steps"])
    # Independent rational closed forms versus the letter-by-letter composer.
    envelope_cases = 0
    for j in range(2, 22):
        for h in range(3, 23):
            a, b = Fraction(27, 16) ** j, Fraction(3, 2) ** h
            lam = a * b / 4
            intercept = b * (23 * a - 12) / 44 - Fraction(1, 4)
            require(b * (10 * a + 12) > 121, "uniform shift margin")
            for tail in ("EE", "EO"):
                expected_a = lam if tail == "EE" else 3 * lam
                expected_c = intercept if tail == "EE" else 3 * intercept + Fraction(1, 2)
                aa, cc, dd = affine(Block(j, h, tail).word)
                require(Fraction(aa, dd) == expected_a, "closed-form slope mismatch")
                require(Fraction(cc, dd) == expected_c, "closed-form intercept mismatch")
                require(expected_a > 2 and expected_c > 0, "failed block not uniformly growing")
                require(expected_c + 3 < 3 * expected_a, "closed-form shifted margin")
                envelope_cases += 1
    # Exhaust the affine/parity relation for all words of length <=8.
    parity_cases = 0
    for length in range(9):
        for letters in itertools.product("EO", repeat=length):
            word = "".join(letters)
            residue, modulus = parity_residue(word)
            for t in (1, 2):
                replay(residue + modulus * t, word)
                parity_cases += 1
    # Retain the old counterexample; parity alone does not repay its debt.
    old = replay(4501595, "OOEO" * 2 + "O" * 3 + "EE")[-1]
    require(old == 10816031 > 4501595, "old failed-halving control changed")
    rejection(lambda: certify(4501595, [], 2, 3, 2))
    # The terminal block can contract locally yet remain ABOVE the true root.
    schedule = [Block(2, 3, "EE")] * 16
    r, w = source(schedule, 2, 3, 20)
    trace = replay(r, w)
    terminal_start = trace[sum(len(b.word) for b in schedule)]
    require(r < trace[-1] < terminal_start, "root-reset false control did not instantiate")
    rejection(lambda: certify(r, schedule, 2, 3, 20))
    # A source with enough formal coefficient contraction but the wrong parity is rejected.
    e = half_margin_halvings([Block(2, 3, "EE")], 2, 3)
    r0, _ = source([Block(2, 3, "EE")], 2, 3, e)
    rejection(lambda: certify(r0 + 186624, [Block(2, 3, "EE")], 2, 3, e))
    invalid = [lambda: Block(1, 3, "EE"), lambda: Block(2, 2, "EE"),
               lambda: Block(2, 3, "OE"), lambda: Block(True, 3, "EE"),
               lambda: source([], 2, 3, 0), lambda: source([], 2, 3, 2, -1),
               lambda: affine("OX"), lambda: replay(0, ""),
               lambda: certify(1, [], 2, 3, 20)]
    for call in invalid:
        rejection(call)
    example_blocks = [Block(2, 3, "EE"), Block(2, 3, "EO")]
    e = half_margin_halvings(example_blocks, 2, 3)
    root, _ = source(example_blocks, 2, 3, e)
    example = certify(root, example_blocks, 2, 3, e)
    return {"status": "PASS", "family_replays": cases, "parity_replays": parity_cases,
            "closed_form_checks": envelope_cases,
            "max_failed_returns": max_k, "max_word_length": max_steps,
            "negative_controls": len(invalid) + 3, "example": example,
            "root_reset_control": {"root": r, "terminal_start": terminal_start, "endpoint": trace[-1],
                                   "local_descent": True, "original_root_descent": False},
            "scope": "guarded infinite families proved in prose; no all-root coverage or novelty claim"}


if __name__ == "__main__":
    print(json.dumps(self_test(), indent=2, sort_keys=True))
