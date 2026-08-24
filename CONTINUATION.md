# Continuation checkpoint

This is the restart pointer for mathematical work after the accepted
mathematical baseline `b75ffec58ae20ac26271ff7d59a71d3591467994`.

## First: preserve the logical boundary

- Overall verdict: **unresolved**.
- A solved certificate-class obstruction is not a Collatz proof.
- A Collatz-equivalent return map or termination statement is not progress by
  itself; a new well-founded mechanism is required.
- A disproof requires an exactly replayed positive nontrivial cycle or a
  positive orbit with a rigorous divergence proof.
- Rational, negative, 2-adic, noncanonical, auxiliary-only, and finite-shadow
  loops do not pass the disproof gate.

Before proposing work, read:

1. [Atomic claim registry](proof-search/CLAIM_REGISTRY.md)
2. [Approach registry](proof-search/APPROACH_REGISTRY.md)
3. [Failure ledger](proof-search/FAILURE_LEDGER.md)
4. [Verification manifest](verification/README.md)
5. [Linked knowledge home](knowledge/mocs/CW-MOC-HOME.md)
6. [Effective-flash review notes](proof-search/effective-flashes/README.md)

## Current route state

| Routes | Status | Exact boundary |
|---|---|---|
| A, B, C | `ACTIVE` | No universal certificate candidate exists. Route A excludes unlabeled adjacent-edge weights, one fixed two-state additive symbol/edge algebra, and every first standard dimension-one arctic-natural full/top step for the original YAH system and that fixed labeling. Richer interpretation classes remain open. |
| E, F | `ACTIVE_LOW_COST` | No positive cycle or divergent positive witness exists. Keep witness searches bounded and exact. |
| AB, D, G, H, I | `BLOCKED_NO_MECHANISM` | Each has exact obstructions but no new mechanism that crosses them. |
| J | `BLOCKED_EQUIVALENT` as proof route | Any fixed computation leaves infinitely many cases. |

The [approach registry](proof-search/APPROACH_REGISTRY.md) is canonical if this
summary and an older route note disagree.

## Exact remaining proof object

A proof must provide at least one of the following with full semantics and
coverage:

- a well-founded interpretation for the exact YAH rewrite system, checking
  every rule/context and Collatz reflection; or
- a finite/regular guarded macro graph covering every positive input, with a
  genuinely well-founded rank on every back-edge; or
- another theorem that implies global descent for every odd `n>1` without
  assuming an equivalent form of the conjecture.

For the current hard-family synthesis, the return map in
[`AB_hard_boundary_return_system.md`](proof-search/routes/AB_hard_boundary_return_system.md)
is exact and closed, but its termination is Collatz-equivalent. The same-label
debt rank and every lower-bounded affine combination of the audited label
depth/bitlength/debt variables are already refuted. Reopening Route AB requires
a richer nonlinear/cross-label rank or a new uniformly smaller guarded target.

L14 supplies an alternative exact decreasing normalizer based on
`v_2(3x+1)` and `v_2(3x-1)`, terminating at `1`, `7 mod 8`, or `27 mod 32`.
It does not change the route status: universal convergence on that residual
set is Collatz-equivalent, and the set admits further finite reductions such
as `U^3(64s+55)=54s+47`. Do not treat the displayed L14 normal form as an
irreducibility or exhaustion theorem.

For the minimal-counterexample synthesis, L11 is one-shot. A continuation must
carry the immutable root across local descents, non-descending edges, infinite
coefficient-stopping branches, band exits, and the zero-gap cycle branch.

## Do not duplicate these searches

- Increasing depth in the same unrefined L4/L5 inverse-word class.
- Finite uniformly bounded direct-descent covers.
- The old arbitrary-representative cycle DP.
- Additive unlabeled adjacent-edge YAH weights.
- Additive symbol/edge scalar or finite-lex weights in the fixed two-state
  suffix algebra.
- A first standard dimension-one arctic-natural YAH step, either full/extended
  or through either Lemma-3.18 top entry point, for the original eleven rules
  or the audited fixed two-state labeling.
- Cyclic rotation alone as an independent two-pump resultant.
- Affine hard-state ranks using only the audited label depth, parameter
  bitlength, and replay debt.
- Treating the normalized hard return map as though it already decreases.
- Treating the L14 terminal set as irreducible, or silently replacing its
  fully accelerated odd map `U` by the one-division shortcut map `T`.

See [FAILURE_LEDGER.md](proof-search/FAILURE_LEDGER.md) for the exact
counterexamples and reopening conditions.

## Formalization boundary

Use [LEAN_TARGETS.md](LEAN_TARGETS.md) and
[`lean/VERIFICATION_POLICY.md`](lean/VERIFICATION_POLICY.md). The existing
narrow modules are useful regressions; they do not formalize Round 6A, full L5,
the L13 hard/rank statements, the hard return equivalence, the YAH
cancellations, the scalar-arctic full/top certificates, or Collatz.

## Required handoff packet for any new claim

Provide:

1. claim ID and exact quantified statement;
2. map/domain/encoding conventions and scope exclusions;
3. dependencies and full Git object hash;
4. proof, checker, or Lean artifact plus reproducible command;
5. adversarial counterexample search and remaining blocker;
6. primary-source novelty classification using the grades in the
   [claim registry](proof-search/CLAIM_REGISTRY.md).

Do not spend a full search cycle unless the proposal names the old blocker and
the genuinely new mechanism that bypasses it.
