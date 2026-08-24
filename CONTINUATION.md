# Continuation checkpoint

**Active ownership after 2026-08-23 handoff: Codex.**

This file is the restart pointer for the Collatz project. The prior version emphasized Round 6A/6B because those were the earlier stable audit artifacts. The active mathematical frontier has since moved into **Round 7**.

For the complete transfer state, read first:

[`CODEX_HANDOFF_2026-08-23.md`](CODEX_HANDOFF_2026-08-23.md)

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

The strongest current synthesis is:

> a hypothetical least counterexample must remain multiplicatively noncontracting for an enormous prefix (conditional on L8's external inputs); its first possible non-descending contraction has an exact near-mechanical parity structure; its endpoint must be a very small additive near-return; and, when the odd-count is smaller than the least counterexample, that endpoint inherits the same hard `-1`-exit state.

This is a recursive necessary-condition architecture, **not a proof**.

## Main unsolved bridge

The next high-value theorem should close the recursive state space rather than merely enlarge a finite verification bound.

Target:

> show that repeated near-critical / near-return / hard-exit states either force descent below the least counterexample, enter a finite well-founded mixed-radix macro graph, or become incompatible with any positive integer.

The main active synthesis route is:

`proof-search/routes/AB_mixed_radix_coalescence_bridge.md`

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

Best bounded Lean targets are L0, L2, L4, L5, L6, L9, L10, and L11 before trying to formalize the complete conjecture. L8 should expose its external inputs explicitly as hypotheses until independently imported/formalized.

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
- the earlier affine/macro search diagnostics.

These scripts are diagnostic/certificate generators unless and until their semantics are independently proved/formalized.

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
