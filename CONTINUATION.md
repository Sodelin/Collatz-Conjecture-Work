# Continuation checkpoint

Use the [2026-09-05 consolidated checkpoint](CONSOLIDATION_2026-09-05.md) for all incorporated source heads and current scope. The guidance below preserves useful route-specific obligations from earlier passes. The latest PR17 guarded TwoBurst theorem is Lean-checked; the old fixed Thue–Morse positive-realization candidate is excluded by the newer analytic recurrence theorem.

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
6. [Generated notebook supplements](knowledge/README.md)
7. [Effective-flash review notes](proof-search/effective-flashes/README.md)

## Current route state

| Routes | Status | Exact boundary |
|---|---|---|
| A, B, C | `ACTIVE` | No universal certificate candidate exists. Route A excludes the audited additive classes and every standard first dimension-one arctic-natural full/top step on the original YAH system and fixed two-state labeling. Richer classes remain open; Routes B/C still need a global certificate rather than a larger finite tree. |
| E | `ACTIVE_LOW_COST` | No positive nontrivial cycle exists in the archive. Keep witness searches bounded and verify any candidate by exact iteration first. |
| F | `ACTIVE_LOW_COST` | The bounded-alphabet endpoint gate exactly characterizes positive realizability, and the specific fixed Thue–Morse candidate is now excluded. General hard aperiodic codes still require a decision of their own carry branch. No positive divergent witness exists. |
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


## Fifth-pass handoff: actual recharge escape

Read [RECHARGE_ESCAPE_PROGRESS_2026-09-05.md](RECHARGE_ESCAPE_PROGRESS_2026-09-05.md). The complete uniform ancestor theorem now has a Lean proof from `3^13 ∣ (4r+1)` alone; do not repeat its factorization/tail/coverage formalization. Lower individual row thresholds remain separate.

New guarded q1 and q2 exit families give actual later returns below the original root. The q1 family tolerates an unbounded larger recharge and two growing bursts. They do not supply all-unit coverage. The second ancestor coordinate removes every root with v3(128r−157)≥17 in the v3(r+7)=4 branch, plus two fixed cylinders. No rank or exhaustion theorem follows.

The next concrete mathematical target is the cylinder `r=22619+186624s`, s≥0. It has q(r)=5 and an increasing first return `y=38171+314928s`, with q(y)=4+v2(2386+19683s) unbounded. Its source has old ancestor state(v,theta)=(4,4), and its q2 unit is3mod8, so both older selected guards miss it. Prove a new smaller-target or whole-excursion descent certificate relative to r on a specified subcylinder; do not assume q decreases, or claim every member lacks all possible certificates. The all-residual-class bridge remains open.


## Sixth-pass handoff: finite spells do not give bounded global progress

The [general guarded two-burst orbit/descent theorem](lean/CollatzWork/TwoBurstStatement.lean) and its convergence transfer now have complete Lean proofs. Accepted source `8ba40e7b80afd56e3c86edbb864e969bd5121226` passed24 Lake tasks in [CI33978140043](https://github.com/Sodelin/Collatz-Conjecture-Work/actions/runs/33978140043). Do not repeat this formalization; its two arithmetic guards remain assumptions, while CRT, exact-valuation interpretation and extra-padding specializations remain prose.

The [exact OOEO spell theorem](proof-search/lemmas/Finite_Growing_First_Return_Spells.md) proves that every q≥4 residue20 root makes exactly `floor(v2(11r+23)/4)` consecutive OOEO first returns. The terminal q is the remainder modulo4. Every shortcut state through the spell remains above the immutable original root. On `r=22619+186624s`, all four exits occur with arbitrarily large spell length. This is a genuine local termination theorem, with a prose proof and exact Python replay; it does not establish root descent.

The [anchor and simultaneous CRT theorem](proof-search/lemmas/Bounded_Ancestor_Depth_Obstruction.md) now rules out a complete bounded-time cover even on that precise target: for any independent forward-descent and smaller-S-ancestor bounds, infinitely many roots fail both certificates simultaneously. The current ternary state and q5 are retained. F031/F032 record the exact excluded classes. More fixed inverse tails cannot close this target by those two relations.

The highest-value next bridge must handle unbounded mixed coalescence or whole-excursion progress relative to the unchanged root, including the accumulated OOEO growth, all four exit classes and possible re-entry. The local clock is not a global rank. The proved families and guarded escape results remain valid, while universal termination and total residual coverage remain unproved.

A separate Work-thread result was checked read-only: [PR19 at49721623303d76956c88db5c9906f8c7b4a586e1](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/49721623303d76956c88db5c9906f8c7b4a586e1/proof-search/lemmas/Finite_Palette_Bounded_Progress_Obstruction.md) excludes bounded-shortcut-horizon progress for arbitrary selection among a finite palette of eventually nondecreasing rank pieces. Its natural-valued theorem is Lean-checked; ordered-value and polynomial extensions are prose. Lean CI33976680139 used the unchanged pinned release on synthetic merge f37c3791eab42583541344d34c89421679b9e9dd, whose source tree has no changes relative to that PR head. This additive obstruction is not imported as a new local formal theorem and does not exclude our unbounded excursions. No external specialist or novelty review is implied.


### Positive continuation through independently long postspell growth

[ORIGINAL_ROOT_BRIDGE_PROGRESS_2026-09-05.md](ORIGINAL_ROOT_BRIDGE_PROGRESS_2026-09-05.md) is the latest packet. The [new guarded theorem](proof-search/lemmas/Postspell_Guarded_Root_Descent.md) proves actual original-root descent along (OOEO)^J O^H E^e for J≥2, H≥3 and e≥J+H. For every independently selected J,H, explicit parity recursion and CRT produce infinitely many q5 target-cylinder sources and a residue20 endpoint, choosing e=2 mod18 with at most17 padding steps. The example is `103791333467 ->(31 shortcut steps)951311`. The complete new proof remains prose with exact Python evidence; it is separate from the accepted Lean two-burst theorem.

The [complementary obstruction](proof-search/lemmas/Postspell_Odd_Run_Obstruction.md) proves that even fixed J and q2 permit an independently unbounded odd run. The positive result handles that growth only under its final-halving guard. The strongest remaining target is an escape/coalescence mechanism for failed-halving branches, tracking J,H, all intervening growth and the unchanged root through later recharge. Do not claim that the guarded CRT slice exhausts the cylinder or that universal termination follows.
