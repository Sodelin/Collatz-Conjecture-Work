# Public status — 2026-08-24

## Verdict

**The Collatz conjecture remains unresolved.** This repository contains no
universal proof, positive nontrivial cycle, or rigorously divergent positive
orbit. It should not be presented as having solved the conjecture.

What the latest work does provide is a collection of exact, narrowly scoped
results that have survived adversarial replay. Their main value is to identify
which proposed proof and disproof mechanisms are sound, which are incomplete,
and which fail for precise reasons.

For claim-by-claim confidence, verification, importance, novelty, readiness,
scope exclusions, and immutable provenance, use the
[`proof-search/CLAIM_REGISTRY.md`](proof-search/CLAIM_REGISTRY.md). In
particular, distinguish a solved route-class obstruction from a
Collatz-equivalent reformulation and from the still-open universal claim.

## Plain-language summary

The project found a valid shortcut for one half of a carefully refined
Mersenne-like family: those inputs meet the orbit of a smaller positive integer,
so strong induction can handle that child. The other half grows under the same
macro and requires arbitrarily deep arithmetic refinement. Its successor cells
can be described exactly, but no decreasing rank covering all of them is known.

Several tempting global promotions were then ruled out:

- no finite collection of uniformly bounded direct-descent promises can cover
  all odd inputs greater than one;
- a minimal-counterexample near-return argument cannot be renewed after local
  descent, because minimality only gives a lower bound relative to the original
  root;
- simple additive termination potentials fail for the exact Collatz-equivalent
  rewrite system, and the failure persists under the audited two-state
  semantic labeling for both symbol and adjacent-edge weights;
- cyclically rotating a two-pump parity-word equation gives an algebraically
  dependent condition, not a new nonzero resultant;
- natural affine combinations of hard-state label depth, parameter bit length,
  and replay debt cannot rank every hard successor.

These are proof-method audits, not a solution. They prevent future work from
mistaking the same gaps for a proof.

## Audited artifacts

This table is artifact-oriented and sometimes groups claims with different
verification levels. The atomic claim registry is canonical for promotion.

| Artifact | Status | What it establishes |
|---|---|---|
| [`proof-search/FAILURE_LEDGER.md`](proof-search/FAILURE_LEDGER.md) | Audited prose theorem | Exact Mersenne staircase and the impossibility of finite uniformly bounded direct-descent covers; scope limitations are explicit. |
| [`proof-search/lemmas/L13_Refined_Mersenne_Child_Macros.md`](proof-search/lemmas/L13_Refined_Mersenne_Child_Macros.md) | Audited theorem note | Easy-child coalescence, hard-child successor normalization, same-label replay debt, cross-label recharge, and the affine-rank obstruction. |
| [`lean/CollatzWork/RefinedMersenneChild.lean`](lean/CollatzWork/RefinedMersenneChild.lean) | Lean-checked, narrow | The easy-child arithmetic, iteration identity, and coalescence statement. It does not formalize the hard-family rank or Collatz. |
| [`proof-search/routes/A_yah_2local_edge_potential_no_go.md`](proof-search/routes/A_yah_2local_edge_potential_no_go.md) | Exact certificate plus checker | A 13-row cancellation excludes bounded-below adjacent-pair additive potentials for the stated rewrite contexts. It does not exclude matrix, automaton, or nonadditive orders. |
| [`verification/yah_2local_edge_no_go.py`](verification/yah_2local_edge_no_go.py) | Reproducible checker | Replays the exact cancellation certificate and prints `PASS`. |
| [`proof-search/routes/A_yah_two_state_semantic_label_no_go.md`](proof-search/routes/A_yah_two_state_semantic_label_no_go.md) | Exact labeled cancellation theorem | The fixed two-state suffix algebra cannot support additive labeled-symbol or adjacent-edge orders, including finite lexicographic tuples. It does not exclude other labels or nonadditive orders. |
| [`verification/yah_two_state_semantic_label_no_go.py`](verification/yah_two_state_semantic_label_no_go.py) | Standard-library exact checker | Reconstructs the labeled rules and replays the fixed-terminal positive-integer cancellations exactly. |
| [`proof-search/routes/AB_hard_boundary_return_system.md`](proof-search/routes/AB_hard_boundary_return_system.md) | Exact reduction theorem | Gives a total decreasing boundary normalizer and the Collatz-equivalent hard return map; `31 -> 182 -> 91` is the smallest replay-rank recharge witness. |
| [`lean/CollatzWork/Disproof/TwoPumpDependency.lean`](lean/CollatzWork/Disproof/TwoPumpDependency.lean) | Lean-checked, narrow | The two rotated determinant pairs satisfy exact dependencies, so the hoped cyclic constant resultant vanishes identically. |
| [`proof-search/disproof/CODEX_TWO_PUMP_DEPENDENCY_AUDIT_2026-08-24.md`](proof-search/disproof/CODEX_TWO_PUMP_DEPENDENCY_AUDIT_2026-08-24.md) | Audited derivation | Gives the coefficient provenance, factorization, scope, and prior-art classification for the two-pump route obstruction. |
| [`verification/disproof_cycle_search.py`](verification/disproof_cycle_search.py) | Exact bounded computation | Exhausts the reported finite `(k,q,D)` region using a corrected maximum-`C` dynamic program; it finds no nontrivial positive cycle candidate in that region. |
| [`proof-search/disproof/CODEX_DISPROOF_CYCLE_DP_AUDIT_2026-08-24.md`](proof-search/disproof/CODEX_DISPROOF_CYCLE_DP_AUDIT_2026-08-24.md) | Audit note | Proves why the fixed-bound DP merge is complete and states the finite boundary precisely. |

## Latest global gap

For

```text
N_(L,epsilon)(z) = 2^L (4z + 2 epsilon + 1) - 1,
```

the hard-child successor is exactly normalizable, but a boundary does not stay
closed. Under the one-division shortcut map `T`, the compressed trajectory

```text
27 --T^4--> 47 --T^6--> 182 --T--> 91
```

has normalized labels

```text
(2,1,1) -> (4,1,0) -> (0,1,45) -> (2,1,5).
```

Thus an `r=0` boundary can immediately return to a hard state larger than the
original input. Requiring a uniformly valid coalescence with a smaller positive
start at that point is not a proved bridge. More generally, the statement that
every positive input `n>1` coalesces with some smaller positive start is
equivalent to Collatz itself: strong induction turns that property into Collatz,
while Collatz permits choosing the smaller start `1`.

The exact boundary reducer can be iterated to skip every non-hard label and
produce a closed return map `F` on the hard family.  This removes an ambiguity
from the route, but it does not create descent: the smallest hard source whose
normalized return both grows and recharges the current replay debt is

```text
31 --T^7--> 182 --T--> 91,
```

with debt `(D,R)` changing from `(0,0)` to `(6,1)`.  Universal termination of
this `F` system is equivalent to the original convergence claim.

The missing proof object is therefore still a genuinely well-founded mechanism
covering every guarded hard and boundary transition, or a sound termination
order for the exact Collatz-equivalent rewrite system. The missing disproof
object is still an exactly replayed positive nontrivial cycle or a positive
integer satisfying every guard of a divergent itinerary.

## Reproduction

From the repository root:

```powershell
python -B verification\yah_2local_edge_no_go.py
python -B verification\yah_two_state_semantic_label_no_go.py
python -B verification\disproof_cycle_search.py
C:\Users\Owner\.elan\bin\lake.exe env lean lean\CollatzWork\Disproof\TwoPumpDependency.lean
C:\Users\Owner\.elan\bin\lake.exe build
```

Expected key outputs are:

- rewrite cancellation checker: `PASS`;
- two-state semantic-label checker: `PASS`;
- cycle DP: 91 eligible pairs, peak 47,517 merged states, 9 trivial
  `1-2` encodings, and 0 nontrivial candidates;
- two-pump Lean module: five theorem dependency reports containing only
  Lean's standard `propext` and `Quot.sound`.

The two-pump module is compiled directly by the command above; it is not yet
imported by the umbrella `CollatzWork.lean` file.

## What can be said publicly

> This is an AI-assisted, adversarially audited Collatz research archive. It
> does not claim a proof or disproof. The latest reproducible results formalize
> one refined Mersenne-family coalescence macro, correct a bounded parity-cycle
> search, and give exact no-go certificates for several proposed proof and
> cycle-elimination mechanisms. The remaining universal termination/descent
> step is stated explicitly rather than hidden.

Novelty is not certified. Several ingredients specialize classical Collatz
parity-vector and stopping-time arithmetic; project-specific packaging and
no-go certificates still require independent specialist review before any
priority claim.

## Provenance checkpoint

The complete accepted mathematical snapshot described by this file is
`8a93ea5e8377f16be5b54f5fe0de9f8d9a85b3a9`. Its parent
`fa3de5b04337d8cbffc9a360074539b852496ca2` introduced the initial dated
public-status checkpoint; `e169d4bb7daf9fc4f70b1a0ab3297330846dccc8`
is the earlier hard-successor-rank commit in that ancestry. Exact scope notes
are recorded in the linked files and Git history.

The nonexistent string `409cb63b69b5fb6af676166573e752f1f4a5ff38`
must never be used as provenance; the valid similarly prefixed object is
`409cb63d6805b00b3dcd96576ac172c58b16384e`.
