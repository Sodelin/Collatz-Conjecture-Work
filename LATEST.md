# Latest accepted research state

Accepted mathematical baseline:
`3619c756e136318520153ced00ce30eaf37ed33d` (2026-08-24).

## Verdict

**The Collatz conjecture remains unresolved.** There is no accepted universal
proof, positive nontrivial cycle, or rigorously divergent positive orbit in
this repository.

## What the accepted chain currently contains

- [`L14-3M1-NF`](proof-search/lemmas/L14_ThreeNMinusOne_Trajectory_Normal_Form.md):
  an exact strictly decreasing normalizer for the fully accelerated odd map,
  terminating at `1`, `7 mod 8`, or `27 mod 32`. The remaining convergence
  assertion is Collatz-equivalent, and the note records explicit
  counterexamples to the rejected claim that this terminal set exhausts other
  finite/local affine rewrites.
- [`A-YAH-2STATE-001`](proof-search/routes/A_yah_two_state_semantic_label_no_go.md):
  exact 8-row and 50-row cancellations kill additive labeled-symbol and
  labeled-edge orders, including finite lexicographic tuples, for one fixed
  two-state semantic algebra; the edge certificate now proves that no such
  fixed-terminal potential can make its first uniform rule-removal step.
- [`A-YAH-AN1-001`](proof-search/routes/A_yah_two_state_scalar_arctic_full_no_start.md):
  exact 49-mass, Farkas, and RUP certificates prove that the original
  eleven-rule YAH system has no first standard dimension-one arctic-natural
  step: neither full/extended removal nor either Lemma-3.18 top entry point.
  The fixed 22-rule labeling is certified as well. Higher-dimensional,
  different-carrier/label, transformed, non-coefficientwise, and local methods
  remain open.
- [`AB-HARD-RETURN-001`](proof-search/routes/AB_hard_boundary_return_system.md):
  an exact decreasing boundary normalizer and closed hard return map. Universal
  termination of that return map is Collatz-equivalent; the smallest reported
  growth-plus-recharge witness is `31 -> 182 -> 91`.
- [`F-BRANCH-CENTER-001`](proof-search/disproof/CODEX_BRANCHING_CENTER_HOSTILE_AUDIT_2026-08-24.md):
  the exact two-rational-center/three-single-edge branching architecture
  collapses; its eliminated arithmetic equation has a narrow Lean replay.
- [`F-FINITE-RESIDUE-FIRST-INTEGRAL-001`](proof-search/disproof/CODEX_FINITE_RESIDUE_FIRST_INTEGRAL_HOSTILE_AUDIT_2026-08-24.md):
  every memoryless coloring of one fixed finite residue ring preserved by all
  positive ordinary Collatz steps is constant; the finite-action core is
  Lean-checked.
- [`F-POLY-RATCHET-001`](proof-search/disproof/CODEX_F_POLY_RATCHET_SHOT_2026-08-24.md):
  canonical normalization closes the fixed-cycle primitive-polynomial
  divisibility/eigenform subclass; its arithmetic telescope is Lean-checked.
- [`F-SMOOTH-RATIO-SEMICONJ-001`](proof-search/disproof/CODEX_SMOOTH_RATIO_SEMICONJUGACY_SHOT_2026-08-24.md):
  a positive accelerated orbit with a finite successive-state-ratio limit
  eventually reaches `1`.

The YAH items and the four Route-F additions are solved **route-class
obstructions**. Both normalizers are **Collatz-equivalent reductions**. None
is the still-open universal termination proof or a disproof witness.

## Current reading order

1. [README](README.md) — two-minute enthusiast/researcher map.
2. [Research atlas](ATLAS.md) — visual dependency map, typed route links, and the complete note index.
3. [Public status](PUBLIC_STATUS_2026-08-24.md) — plain-language verdict and latest gap.
4. [Atomic claim registry](proof-search/CLAIM_REGISTRY.md) — confidence, verification, importance, novelty, readiness, and evidence.
5. [Approach registry](proof-search/APPROACH_REGISTRY.md) — live route statuses.
6. [Failure ledger](proof-search/FAILURE_LEDGER.md) — superseded and killed mechanisms.
7. [Verification manifest](verification/README.md) — portable commands and exact scopes.

The older [Cycle-1 closure audit](proof-search/CODEX_CYCLE_1_CLOSURE_AUDIT_2026-08-23.md)
and [Round 6A review note](papers/round-6a/Theorem_6A1_Public_Review_Note.md)
remain preserved as historical branch checkpoints.

## Formal status

Six narrow Lean modules exist; see [LEAN_TARGETS.md](LEAN_TARGETS.md). A full
proof-assistant formalization of the prose chain or Collatz does not exist.
Novelty and priority for project-specific claims are not certified.

The [note-graph standard](methodology/NOTE_GRAPH_STANDARD.md) explains how to
use the same files as a GitHub knowledge base or optional Obsidian vault without
creating a second source of mathematical status.
