# Latest accepted research state

Accepted mathematical component baselines:

- `6c8f77ef2b0b360f8f353f4508dcfec58e980331` — endpoint, inverse-word,
  renewal, and global-coupling artifacts;
- `b75ffec58ae20ac26271ff7d59a71d3591467994` — scalar-arctic full/top
  certificate artifacts.

## Verdict

**The Collatz conjecture remains unresolved.** There is no accepted universal
proof, positive nontrivial cycle, or rigorously divergent positive orbit in
this repository.

## What the accepted chain currently contains

- [`F-BOUNDED-ALPHABET-ENDPOINT-GATE-001`](proof-search/routes/F_bounded_alphabet_endpoint_residue_gate.md):
  an exact characterization of when one bounded infinite valuation code is
  realized by a positive odd orbit. Positive realization is equivalent to
  eventual zero carry and normalized endpoint-residue vanishing; the opposite
  branch has infinitely many positive carries and full cubic root growth. The
  theorem does not decide the branch for the hard aperiodic codes.
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
- [`L15-MIXED-INVERSE`](proof-search/lemmas/L15_Expanded_Rewrite_and_Mixed_Inverse_Words.md):
  an expanded but nonconfluent decreasing rewrite boundary, complete
  accelerated inverse fibers, mixed inverse-word congruences, and exact
  finite-route obstructions. Universal certificate coverage remains
  Collatz-equivalent.
- [Direct-return/renewal filters](proof-search/routes/AB_direct_H_return_and_renewal_filters.md)
  and the [prime-renewal finite-window no-go](proof-search/routes/AB_prime_renewal_finite_window_no_go.md):
  exact stopped-useful filters showing why local hard returns, finite prime
  scripts, and finite roughness windows do not settle one fixed infinite
  orbit.

The endpoint gate is the strongest exact new auxiliary theorem in this
snapshot. The YAH items are solved **route-class obstructions**. The
normalizers are **Collatz-equivalent reductions**, and the finite route tools
are **stopped-useful**. None is the still-open universal termination proof.

The [Thue--Morse anchor](proof-search/disproof/CODEX_TM_MAHLER_ANCHOR_2026-08-24.md)
is retained only as a provisional conditional construction. Its `2`-adic
value has not been proved to be a positive ordinary integer, so it is not a
counterexample or disproof.

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

Three narrow Lean modules exist; see [LEAN_TARGETS.md](LEAN_TARGETS.md). A full
proof-assistant formalization of L14, L15, the bounded-alphabet endpoint gate,
the route filters, the YAH scalar-arctic certificates, the prose chain, or
Collatz does not exist. Novelty and priority for project-specific claims are
not certified.

The [note-graph standard](methodology/NOTE_GRAPH_STANDARD.md) explains how to
use the same files as a GitHub knowledge base or optional Obsidian vault without
creating a second source of mathematical status.
