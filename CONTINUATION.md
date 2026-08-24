# Continuation checkpoint

**Active ownership after 2026-08-23 handoff: Codex.**

This file is the restart pointer for the Collatz project. The prior version emphasized Round 6A/6B because those were the earlier stable audit artifacts. The active mathematical frontier has since moved into **Round 7**.

For the original transfer snapshot, read:

[`CODEX_HANDOFF_2026-08-23.md`](CODEX_HANDOFF_2026-08-23.md)

Then read the chronologically later hostile reconstruction:

[`proof-search/CODEX_CYCLE_1_CLOSURE_AUDIT_2026-08-23.md`](proof-search/CODEX_CYCLE_1_CLOSURE_AUDIT_2026-08-23.md)

## Current research frontier

### Stable earlier audit core

- Round 6A remains the best externally reviewable statement of the corrected-log / rational-period debt theorem.
- Round 6B remains the chronologically terminal extension of that older ranking-function branch.
- Neither resolves Collatz.

### Active Round-7 chain

Read in order:

1. `proof-search/lemmas/L0_Global_Descent_Equivalence.md`
2. `proof-search/lemmas/L2_Cylinder_Refinement_and_Slope_Pruning.md`
3. `proof-search/lemmas/L4_General_Inverse_Word_Coalescence.md`
4. `proof-search/lemmas/L5_Inverse_Word_Search_Completeness_Bound.md`
5. `proof-search/lemmas/L6_Minimal_Counterexample_Exit_Constraint.md`
6. `proof-search/lemmas/L8_Farey_Certified_Coefficient_Barrier.md`
7. `proof-search/lemmas/L9_First_Contraction_Mechanical_Envelope.md`
8. `proof-search/lemmas/L10_Near_Return_and_Dual_Residue_Certificate.md`
9. `proof-search/lemmas/L11_Near_Return_Hard_Exit_Inheritance.md`
10. `proof-search/lemmas/L12_Hard_Exit_Gap_Valuation_Transition.md`

The strongest current synthesis is:

> a hypothetical least counterexample either has infinite coefficient stopping time or, at its first contraction, obeys an exact near-mechanical prefix and tiny additive near-return constraint; inside the L11 band, both endpoints are hard `-1`-exit states and their positive gap obeys L12's exact valuation transition.

This is a necessary-condition branch architecture, **not a proof**. L11 does
not make it recursive: minimality keeps later iterates above the immutable
least counterexample, but does not keep them above each restarted endpoint or
guarantee another finite coefficient stopping time.

The Cycle-1 audit also corrected L5. A uniformly smaller affine inverse family
may have the same leading coefficient as the original family when its
intercept is smaller. The corrected complete class bound is `|w|<=t`, with
the equal-slope boundary occurring exactly at depth `t`.

## Main unsolved bridge

A closure theorem within the current L8-L12/Route-AB synthesis must address
every branch rather than merely enlarge a finite verification bound. It must:

1. rule out or absorb infinite coefficient stopping time;
2. handle finite contractions with odd count `s>=n_*`;
3. turn `s<n_*` endpoint inheritance into a total rooted transition system
   with a well-founded rank, including local descents into `[n_*,y)`;
4. close the zero-gap positive-cycle branch; and
5. supply complete coverage and exact semantics for any proposed finite graph.

The main active synthesis route is:

`proof-search/routes/AB_mixed_radix_coalescence_bridge.md`

The exact limitation of its current one-shot inverse-word semantics is:

`proof-search/routes/AB_mersenne_inverse_word_no_go.md`

That informal theorem derives that no unrefined L4/L5 inverse word, at any depth, can
reduce a Mersenne cylinder. Route AB now requires parameter refinement, an
explicit canonical-boundary mechanism, and a ranked recursive graph.

## Do not restart these dead ends without a new mechanism

Read:

`proof-search/FAILURE_LEDGER.md`

In particular, do not substitute:

- fixed-depth residue enumeration;
- average drift;
- bounded/local corrected-log corrections;
- rational/2-adic ghost trajectories;
- or a renamed global-descent statement

for the missing global arithmetic mechanism.

## Formalization priorities

Use `lean/VERIFICATION_POLICY.md`.

Best bounded Lean targets are L0, L2, L4, corrected L5, L6, L9, L10,
L11, L12, and the Mersenne no-go before trying to formalize the complete
conjecture. L8 should expose its external inputs explicitly as hypotheses
until independently imported/formalized.

## Existing executable record

Round 6A:

- `verification/round-6a/collatz_round6a_checks.py`
- `verification/round-6a/round6a_check_output.txt`
- `verification/round-6a/Collatz_Round6A_Claim_Ledger_2026-08-01.csv`

Round 7 includes:

- `verification/round7_exhaustive_inverse_word_classifier.py`
- `verification/round7_exhaustive_inverse_word_classifier_output_2026-08-23.txt`
- `verification/round7_farey_coefficient_barrier.py`
- `verification/round7_farey_coefficient_barrier_output_2026-08-23.txt`
- `verification/round7_first_crossing_oracle.py`
- `verification/round7_first_crossing_oracle_output_2026-08-23.txt`
- `lean/CollatzWork/InverseWordBoundaryStatement.lean`
- `lean/CollatzWork/InverseWordBoundary.lean`
- `verification/lean_inverse_word_boundary_build_output_2026-08-23.txt`
- the earlier affine/macro search diagnostics.

These scripts are diagnostic/certificate generators unless and until their semantics are independently proved/formalized.

The Lean files above type-check only the corrected equal-slope affine boundary
and its concrete `8x+5 / 8x+4` regression under pinned Lean 4.33.1. They do not
formalize all of L5 or any Collatz resolution theorem.

## Provenance and integrity

See:

- `PROVENANCE.md`
- `checksums/`
- `CODEX_HANDOFF_2026-08-23.md`

Git history provides public provenance from commit time onward. Earlier August 1–2 chronology remains supported by the preserved source artifacts and original checksum records, not by backdated Git commits.

## Claim discipline

As of this checkpoint:

- Full Collatz proof: **no**
- Full Collatz disproof: **no**
- Independent specialist verification: **pending**
- Complete Lean formalization: **pending**
- Novelty certification for Round-7 lemmas: **pending**

The project is now intentionally handed off to Codex to avoid parallel agents independently extending the same active branch.
