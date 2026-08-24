# Continuation checkpoint

This is the restart pointer for mathematical work after the accepted Round-8
component baselines `6c8f77ef2b0b360f8f353f4508dcfec58e980331`
(endpoint/global-coupling artifacts) and
`b75ffec58ae20ac26271ff7d59a71d3591467994` (scalar-arctic artifacts).

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

1. [Research atlas](ATLAS.md)
2. [Atomic claim registry](proof-search/CLAIM_REGISTRY.md)
3. [Approach registry](proof-search/APPROACH_REGISTRY.md)
4. [Failure ledger](proof-search/FAILURE_LEDGER.md)
5. [Verification manifest](verification/README.md)

## Current route state

| Routes | Status | Exact boundary |
|---|---|---|
| A, B, C | `ACTIVE` | No universal certificate candidate exists. Route A excludes the audited additive classes and every standard first dimension-one arctic-natural full/top step on the original YAH system and fixed two-state labeling. Richer classes remain open; Routes B/C still need a global certificate rather than a larger finite tree. |
| E | `ACTIVE_LOW_COST` | No positive nontrivial cycle exists in the archive. Keep witness searches bounded and verify any candidate by exact iteration first. |
| F | `ACTIVE_LOW_COST` | The bounded-alphabet endpoint gate exactly characterizes positive realizability, but no hard aperiodic code has been shown to have eventual zero carry or infinitely many positive carries. No positive divergent witness exists. |
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
- for a fixed bounded hard valuation code, an exact proof of eventual zero
  carry (constructing one positive orbit) or of infinitely many positive
  carries (eliminating that code; a uniform theorem would eliminate the
  family); or
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

L15 expands the finite rewrite and inverse-word toolkit, but the relation is
nonconfluent and universal forward-inverse certificate coverage is itself
Collatz-equivalent. The pure exponent-`2` policy also has no uniform successful
depth. Do not continue by merely increasing finite inverse depth or adding
isolated rewrite rules.

The direct hard-return, renewal-gcd, and prime-return notes are
**stopped-useful**. They give exact local filters and prove that every finite
list of individually admissible distinct-prime blocks, and every finite
growth/roughness window of the stated kind, occurs in a positive prefix. They
therefore redirect work away from larger finite windows.

The exact live coupling object is in
[`F_bounded_alphabet_endpoint_residue_gate.md`](proof-search/routes/F_bounded_alphabet_endpoint_residue_gate.md).
For `1<=a_k<=A`, one positive ordinary realization exists exactly when the
canonical carries are eventually zero, equivalently when `M_k/3^k -> 0`.
Every finite prefix being positively realizable does not imply this condition.
For the guarded `{1,3}` block codes, positive realization would give a genuine
unbounded orbit; neither realization nor universal escape has been proved.

The conditional Thue--Morse anchor is paused at the same ordinary-membership
gate. Its `2`-adic series/product and conditional divergence bound are not a
positive witness and must not be described as a disproof.

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
- A standard first dimension-one arctic-natural YAH step, whether full,
  boundary-top, or reversed-dynamic-top, on the original system or the audited
  fixed labeling.
- Cyclic rotation alone as an independent two-pump resultant.
- Affine hard-state ranks using only the audited label depth, parameter
  bitlength, and replay debt.
- Treating the normalized hard return map as though it already decreases.
- Treating the L14 terminal set as irreducible, or silently replacing its
  fully accelerated odd map `U` by the one-division shortcut map `T`.
- Enlarging finite inverse-word or decreasing-rewrite catalogues without a
  coverage mechanism that survives nonconfluence.
- Enlarging finite prime-return, renewal, sieve, roughness, or separated-block
  windows; the exact finite constructions already realize them.
- Passing from compatible finite valuation prefixes to one positive infinite
  seed by compactness, CRT, or a profinite/`2`-adic limit.
- Treating the conditional Thue--Morse `2`-adic anchor as a positive ordinary
  integer without an exact membership proof.

See [FAILURE_LEDGER.md](proof-search/FAILURE_LEDGER.md) for the exact
counterexamples and reopening conditions.

## Formalization boundary

Use [LEAN_TARGETS.md](LEAN_TARGETS.md) and
[`lean/VERIFICATION_POLICY.md`](lean/VERIFICATION_POLICY.md). The existing
narrow modules are useful regressions; they do not formalize Round 6A, full L5,
the L13 hard/rank statements, the hard return equivalence, the YAH
cancellations or scalar-arctic certificates, L14, L15, the endpoint-residue
gate, the renewal/prime filters, or Collatz.

## Required handoff packet for any new claim

Provide:

1. claim ID and exact quantified statement;
2. map/domain/encoding conventions and scope exclusions;
3. dependencies and full Git object hash;
4. proof, checker, or Lean artifact plus reproducible command;
5. adversarial counterexample search and remaining blocker;
6. primary-source novelty classification using the grades in the
   [claim registry](proof-search/CLAIM_REGISTRY.md).
7. related node IDs and typed graph edges under the
   [note-graph standard](methodology/NOTE_GRAPH_STANDARD.md).

Do not spend a full search cycle unless the proposal names the old blocker and
the genuinely new mechanism that bypasses it.
