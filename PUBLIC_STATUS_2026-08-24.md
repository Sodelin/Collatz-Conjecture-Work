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

For a visual path through those distinctions and every retained note, use the
[research atlas](ATLAS.md). It is a navigation layer; the registries remain
canonical for status.

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
- exact all-positive, Farkas, and RUP certificates rule out every standard
  first dimension-one arctic-natural step on the original eleven-rule YAH
  system: full/extended removal and both Lemma-3.18 top entry points. This does
  not cover higher-dimensional, different-carrier/label, transformed,
  non-coefficientwise, or local methods;
- cyclically rotating a two-pump parity-word equation gives an algebraically
  dependent condition, not a new nonzero resultant;
- a two-rational-center/three-single-edge branching construction collapses
  before it supplies an ordinary positive anchor;
- a memoryless invariant coloring of one fixed finite residue ring must be
  constant;
- canonical primitive-polynomial divisibility on one fixed macro cycle
  collapses to scalar eigenforms and supplies no divergent integer; and
- a positive accelerated orbit with a finite successive-state-ratio limit
  eventually reaches `1`;
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
| [`proof-search/lemmas/L14_ThreeNMinusOne_Trajectory_Normal_Form.md`](proof-search/lemmas/L14_ThreeNMinusOne_Trajectory_Normal_Form.md) | Audited prose theorem plus finite regression | Gives an exact decreasing odd-only normalizer to `1`, `7 mod 8`, or `27 mod 32`; explicitly rejects the wrong shortcut-map convention and the false claim that the terminal set exhausts other rewrites. Residual convergence remains Collatz-equivalent. |
| [`proof-search/lemmas/L13_Refined_Mersenne_Child_Macros.md`](proof-search/lemmas/L13_Refined_Mersenne_Child_Macros.md) | Audited theorem note | Easy-child coalescence, hard-child successor normalization, same-label replay debt, cross-label recharge, and the affine-rank obstruction. |
| [`lean/CollatzWork/RefinedMersenneChild.lean`](lean/CollatzWork/RefinedMersenneChild.lean) | Lean-checked, narrow | The easy-child arithmetic, iteration identity, and coalescence statement. It does not formalize the hard-family rank or Collatz. |
| [`proof-search/routes/A_yah_2local_edge_potential_no_go.md`](proof-search/routes/A_yah_2local_edge_potential_no_go.md) | Exact certificate plus checker | A 13-row cancellation excludes bounded-below adjacent-pair additive potentials for the stated rewrite contexts. It does not exclude matrix, automaton, or nonadditive orders. |
| [`verification/yah_2local_edge_no_go.py`](verification/yah_2local_edge_no_go.py) | Reproducible checker | Replays the exact cancellation certificate and prints `PASS`. |
| [`proof-search/routes/A_yah_two_state_semantic_label_no_go.md`](proof-search/routes/A_yah_two_state_semantic_label_no_go.md) | Exact labeled cancellation theorem | The fixed two-state suffix algebra cannot support additive labeled-symbol or adjacent-edge orders, including finite lexicographic tuples. It does not exclude other labels or nonadditive orders. |
| [`verification/yah_two_state_semantic_label_no_go.py`](verification/yah_two_state_semantic_label_no_go.py) | Standard-library exact checker | Reconstructs the labeled rules and replays the fixed-terminal positive-integer cancellations exactly. |
| [`proof-search/routes/A_yah_two_state_scalar_arctic_full_no_start.md`](proof-search/routes/A_yah_two_state_scalar_arctic_full_no_start.md) | Exact coefficient-independent theorem | Excludes every standard first dimension-one arctic-natural step on the original YAH system and the corresponding fixed labeling. It does not cover richer interpretation classes. |
| [`verification/yah_two_state_scalar_arctic_full_no_start.py`](verification/yah_two_state_scalar_arctic_full_no_start.py) | Standard-library exact checker | Verifies the original 11-rule and labeled 22-rule full/extended cancellations, both of mass 49. |
| [`verification/yah_scalar_arctic_top/verify_top_certificates.py`](verification/yah_scalar_arctic_top/verify_top_certificates.py) | Dependency-free exact checker plus payload | Checks 491 integer Farkas lemmas and 426 RUP clauses for all six boundary and four reversed-dynamic labeled top targets; equal-state lifting gives the original-system corollary. |
| [`proof-search/routes/AB_hard_boundary_return_system.md`](proof-search/routes/AB_hard_boundary_return_system.md) | Exact reduction theorem | Gives a total decreasing boundary normalizer and the Collatz-equivalent hard return map; `31 -> 182 -> 91` is the smallest replay-rank recharge witness. |
| [`lean/CollatzWork/Disproof/TwoPumpDependency.lean`](lean/CollatzWork/Disproof/TwoPumpDependency.lean) | Lean-checked, narrow | The two rotated determinant pairs satisfy exact dependencies, so the hoped cyclic constant resultant vanishes identically. |
| [`proof-search/disproof/CODEX_TWO_PUMP_DEPENDENCY_AUDIT_2026-08-24.md`](proof-search/disproof/CODEX_TWO_PUMP_DEPENDENCY_AUDIT_2026-08-24.md) | Audited derivation | Gives the coefficient provenance, factorization, scope, and prior-art classification for the two-pump route obstruction. |
| [`proof-search/disproof/CODEX_BRANCHING_CENTER_HOSTILE_AUDIT_2026-08-24.md`](proof-search/disproof/CODEX_BRANCHING_CENTER_HOSTILE_AUDIT_2026-08-24.md) | Independent hostile audit plus Lean core | Closes only the exact two-center/three-single-edge architecture. |
| [`proof-search/disproof/CODEX_FINITE_RESIDUE_FIRST_INTEGRAL_HOSTILE_AUDIT_2026-08-24.md`](proof-search/disproof/CODEX_FINITE_RESIDUE_FIRST_INTEGRAL_HOSTILE_AUDIT_2026-08-24.md) | Independent hostile audit plus partial Lean core | Proves constancy for memoryless invariant colorings of one fixed finite residue ring; stateful residue systems remain open. |
| [`proof-search/disproof/CODEX_F_POLY_RATCHET_SHOT_2026-08-24.md`](proof-search/disproof/CODEX_F_POLY_RATCHET_SHOT_2026-08-24.md) | Standalone theorem, hostile audit, and Lean arithmetic core | Closes only the canonically normalized fixed-cycle primitive-polynomial divisibility/eigenform subclass. |
| [`proof-search/disproof/CODEX_SMOOTH_RATIO_SEMICONJUGACY_SHOT_2026-08-24.md`](proof-search/disproof/CODEX_SMOOTH_RATIO_SEMICONJUGACY_SHOT_2026-08-24.md) | Hostile-reconstructed exact prose theorem | Rules out divergent positive accelerated generators whose full successive-state ratio has a finite real limit. |
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
powershell -NoProfile -ExecutionPolicy Bypass -File verification\run_release_checks.ps1
```

Expected key outputs are:

- trajectory-normal-form regression: 500,000 odd starts, maximum 19
  normalizer edges, and `PASS`; this is finite regression evidence only;
- rewrite cancellation checker: `PASS`;
- two-state semantic-label checker: `PASS`;
- scalar-arctic full checker: original 11 rows and labeled 22 rows, each with
  total multiplier 49, zero weighted count delta, and `PASS`;
- scalar-arctic top checker: 10 cases, 491 integer Farkas lemmas, 426 RUP
  clauses, and `PASS`;
- cycle DP: 91 eligible pairs, peak 47,517 merged states, 9 trivial
  `1-2` encodings, and 0 nontrivial candidates;
- two-pump Lean module: five theorem dependency reports containing only
  Lean's standard `propext` and `Quot.sound`;
- the three new Lean cores compile with the exact axiom footprints in the
  [release receipt](verification/RELEASE_AUDIT_2026-08-24.md); and
- note graph: all 58 Markdown notes reachable, no broken local Markdown links.

The four disproof modules are compiled directly by the wrapper; none is
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
`3619c756e136318520153ced00ce30eaf37ed33d`. Its parent is the navigation
snapshot `2e7eae2bb998b14e5443e6c440154130a0049467`; its ancestry includes
`b75ffec58ae20ac26271ff7d59a71d3591467994`, the preceding scalar-certificate
baseline, `cc33bdb470da849a5eb9d63921dcd37a8f37e94d`, the trajectory-normal-form
snapshot, and `8a93ea5e8377f16be5b54f5fe0de9f8d9a85b3a9`, the preceding
route-obstruction baseline. Exact scope notes are
recorded in the linked files and Git history.

The nonexistent string `409cb63b69b5fb6af676166573e752f1f4a5ff38`
must never be used as provenance; the valid similarly prefixed object is
`409cb63d6805b00b3dcd96576ac172c58b16384e`.
