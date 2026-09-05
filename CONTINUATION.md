# Continuation checkpoint

This is the restart pointer for mathematical work after the accepted Round-8
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

1. [Research atlas](ATLAS.md)
2. [Atomic claim registry](proof-search/CLAIM_REGISTRY.md)
3. [Approach registry](proof-search/APPROACH_REGISTRY.md)
4. [Failure ledger](proof-search/FAILURE_LEDGER.md)
5. [Verification manifest](verification/README.md)

## Current route state

| Routes | Status | Exact boundary |
|---|---|---|
| A, B, C | `ACTIVE` | No universal certificate candidate exists. Route A excludes the audited additive classes and every standard first dimension-one arctic-natural full/top step on the original YAH system and fixed two-state labeling. Richer classes remain open. |
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
- A standard first dimension-one arctic-natural YAH step, whether full,
  boundary-top, or reversed-dynamic-top, on the original system or the audited
  fixed labeling.
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
cancellations or scalar-arctic certificates, or Collatz.

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

## 2026-09-05 continuation delta

Read the [reviewed research pass](ASTRA_RESEARCH_PASS_2026-09-05.md) before
reopening these routes. L15 improves `d<s/3` to `d<s/4` and the existing
conditional frontier to `17,340,869,984` with L11. This does not reduce L12's
valuation ceiling or repair recursive renewal.

F025 rules out arbitrary-degree polynomial ranks in the existing parameter,
bitlength and debt variables, including coordinatewise lower-bounded finite
lex tuples. The concrete family beginning `47771 -> 80615 -> 204059` must
be a first falsification test for any proposed replacement.

The exact next proof-search admission question is: what additional arithmetic
state or stronger smaller-target relation distinguishes the frozen-debt
endpoints? Without such a mechanism, keep Route AB blocked. Formalizing the
new phase-block theorem is a bounded verification target, not a promised
route to closure. The new convergence criteria already passed pinned Lean CI.


### Second closure-attempt handoff

The [3-adic extension](proof-search/routes/AB_three_adic_rank_no_go.md)
shows that adding `v3(n+1)` and the coprime cofactor still leaves an expanding
family with frozen measurements. Test `244379 -> 412391 -> 1043867` and its
full affine family before reopening that rank class.

The [primary-source audit](proof-search/sources/Primary_Bridge_Audit_2026-09-05.md)
keeps finite ranked graphs available despite full-reachability nondefinability,
but rejects Chang v6's claimed WMH weakening and non-atomic uniqueness conclusion.
The [natural-matrix experiment](verification/yah_natural_matrix_2d/README.md)
has only a solver-reported bounded exclusion and a larger-bound timeout.
Do not repeat the same template or import the audited source claims as closure.
Route A can be reopened by a concrete different interpretation or transformation;
Route AB requires a mechanism that passes the strengthened frozen-state test.


## Third-pass handoff

Start with [ASTRA_CONTINUATION_2026-09-05.md](ASTRA_CONTINUATION_2026-09-05.md).
L15's universal quarter inequality and its integer mechanical dependency chain
are now Lean-verified. Do not repeat that formalization; arbitrary block lengths
and the 1024-block frontier refinement remain separate pending work.

The [explicit modulo27 rank](proof-search/sources/Sufficiency_Rank_Audit_2026-09-05.md)
provides a useful total frontend stopping at1,2,or20 mod27. Its first returns
still need a separate mechanism. Fixed-residue polynomial return ranks face
the new families, but smaller-target selection can remove those families;
see [the exact scope and positive macros](proof-search/routes/AB_ternary_normalized_core_residue_obstruction.md).

The 425 auxiliary loop is the first falsification test for any proposal that
combines return and inverse coalescence. Track the immutable induction root
and actual progress; never infer termination merely from separately valid
coalescence identities. The original-F arbitrary-modulus obstruction has
[its own distinct proof](proof-search/routes/AB_finite_residue_original_return_no_go.md).


## Fourth-pass handoff: root-relative progress

Start with [the committed research packet](ROOT_RELATIVE_PROGRESS_2026-09-05.md). Actual OOE burst descent under its exact divisibility guard and generic ancestor orbit semantics are now Lean-checked. The refined inverse-tail selector proves in prose that every positive residue20 root with v3(4r+1)≥13 has a smaller ancestor in the same class.

A hypothetical least nonconvergent residue20 root must therefore satisfy v3(r+7)∈{3,4} and v3(4r+1)≤12, and avoid all individually covered rows and guarded burst families. This remains an infinite residual set. The displayed selector does not certify425; its v12 sharpness witness is a failure of that selector only.

The highest-value next mathematical target is an exact recharge-or-escape lemma on this residual class: first isolate a growing return cylinder, then prove either a smaller coalescing target or a decrease in a justified unbounded measure across the complete excursion. Track the unchanged induction root. The q10→7→4→10 growing path is a required falsification test for q-only polynomial ranks. A bounded-depth first-return calculation or a larger replay limit cannot replace this theorem.

The more bounded verification target is to formalize the finite refined tail table and its slope/coverage argument using the checked generic ancestor prefix. This would raise verification confidence without resolving the residual mathematical bridge.
