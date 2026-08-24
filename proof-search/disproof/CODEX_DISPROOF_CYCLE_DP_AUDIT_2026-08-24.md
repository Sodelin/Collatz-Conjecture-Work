# Audited bounded positive-cycle search

**Status: bounded exact search; not a proof or disproof of the Collatz conjecture.**

Date: 2026-08-24 (America/Los_Angeles)

## Acceptance gate and verdict

A Collatz disproof requires either an explicit nontrivial cycle of positive
integers, verified exactly, or an explicit positive integer whose orbit is
rigorously proved divergent. This search produced neither. Negative, rational,
or 2-adic cycles, finite shadows, finite search misses, and failed certificate
architectures do not meet the gate.

## Exact certificate

For the shortcut map

    T(n) = n/2          if n is even,
    T(n) = (3n+1)/2     if n is odd,

a parity word of length `k`, containing `q` odd symbols, has the affine form

    T^k(n) = (3^q n + C) / 2^k,

when the advertised parity word is followed. Scanning symbols from first to
last, starting at `C=0`, an even symbol maps `C` to `C`, while an odd symbol at
position `j` maps it to `3C+2^j`.

Put `D=2^k-3^q`. A positive fixed-point candidate requires `D>0`, `D | C`,
and `n=C/D>0`. Every reconstructed candidate is replayed with exact integers.

Integrality also forces the advertised parity word. The fixed-point equation
is `3^q n+C=2^k n`. If the first symbol is even, `C=2C_s`; reduction modulo
two forces `n` even, and division by two gives the suffix equation. If it is
odd, `C=3^(q-1)+2C_s`; reduction modulo two forces `n=2n_1+1`, whose first
successor is `3n_1+2`, and

    3^q n+C = 2[3^(q-1)(3n_1+2)+C_s].

Division by two gives the suffix equation. Induction proves the claim.

## Why the residue merge is complete

At each `(position, q_used, C mod D)` state, the program retains the maximum
exact `C` and a reconstructing word. For two congruent coefficients `C1<=C2`,
both branches preserve congruence and order:

    E: C -> C,
    O: C -> 3C+2^j.

Induction over every common suffix shows that the retained maximum dominates
every discarded prefix. At final residue zero, `max_C/D` is therefore the
largest positive integral start for the fixed `(k,q)`. If it is at most two,
all candidates for that pair are encodings of the trivial `1 <-> 2` shortcut
cycle. If it exceeds two, its reconstructing word is a nontrivial positive
candidate and exact replay verifies it.

The earlier arbitrary-representative DP was incomplete and is superseded. In
particular, `(k,q,D)=(4,2,7)` has merged residue-zero coefficients `7` and `14`;
the corrected DP retains `14`.

## Audited bounded result

The built-in tests compare all reachable residues and the maximum exact
residue-zero coefficient against brute force for every `k<=10`. A separate
independent audit replayed every integral word through `k<=13`. Both passed.

The recorded run examined exactly the eligible pairs satisfying

    1 <= k <= 40, 1 <= q <= k, and 0 < 2^k-3^q <= 250000.

It exhausted 91 `(k,q)` pairs, reached a peak of 47,517 merged states, found
nine encodings of the trivial `1 <-> 2` cycle, and found zero nontrivial
positive-cycle candidates.

This claim is exhaustive only for that finite region. Neither `k` nor `D` is
globally bounded here, so the result is not evidence of global cycle absence.

## Novelty and provenance

The parity-vector cycle equation is classical, and finite exact searches for
nontrivial cycles are established practice. No mathematical novelty is claimed.
This artifact's contribution is a reproducible, independently audited bounded
implementation checkpoint and a documented repair of the merge defect.

Related primary research includes David Barina's computational verification
work (DOI 10.1007/s11227-025-07337-0) and Christian Hercher's cycle-bound work
(`arXiv:2201.00406`). Those results are substantially stronger in their own
scopes; this repository run does not compete with them.

## Reproduction

From the repository root:

    python -m py_compile verification/disproof_cycle_search.py
    python verification/disproof_cycle_search.py --k-max 40 --d-max 250000

Expected stdout is recorded in
`verification/disproof_cycle_search_output_2026-08-24.txt`.
