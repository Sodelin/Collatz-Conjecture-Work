# Latest and recommended reading

## Latest research state: Codex Cycle 1 / Round 7

The chronologically terminal research state is the 2026-08-23 hostile closure
audit of the Round-7 chain:

- [Cycle-1 closure audit](proof-search/CODEX_CYCLE_1_CLOSURE_AUDIT_2026-08-23.md)
- [Corrected L5 inverse-word completeness theorem](proof-search/lemmas/L5_Inverse_Word_Search_Completeness_Bound.md)
- [L12 hard-exit gap transition](proof-search/lemmas/L12_Hard_Exit_Gap_Valuation_Transition.md)
- [Mersenne-cylinder inverse-word no-go](proof-search/routes/AB_mersenne_inverse_word_no_go.md)
- [Independent bounded oracle](verification/round7_first_crossing_oracle.py)
- [Oracle output](verification/round7_first_crossing_oracle_output_2026-08-23.txt)
- [Lean equal-slope boundary proof](lean/CollatzWork/InverseWordBoundary.lean)
- [Lean clean-build record](verification/lean_inverse_word_boundary_build_output_2026-08-23.txt)

The audit found no proof or disproof. It corrected a false completeness claim
in L5, informally derived that the entire unrefined L4/L5 inverse-word class cannot reduce
the persistent Mersenne cylinders, and showed that L11 hard-exit inheritance
is not by itself a recursive renewal theorem.

The exact open bridge for this active synthesis is a total, non-circular,
well-founded transition mechanism that covers the infinite coefficient-
stopping branch and every finite first-contraction survivor. No such mechanism
or complete Route-AB certificate currently exists; other proof/disproof
architectures remain logically possible.

## Stable earlier external-review target: Round 6A

For the corrected-log / rational-period debt branch, start with:

- [Round 6A public review note](papers/round-6a/Theorem_6A1_Public_Review_Note.md)
- [Round 6A checker](verification/round-6a/collatz_round6a_checks.py)
- [Round 6A claim ledger](verification/round-6a/Collatz_Round6A_Claim_Ledger_2026-08-01.csv)
- [Round 6A checker output](verification/round-6a/round6a_check_output.txt)
- [Lean formalization targets](LEAN_TARGETS.md)

Round 6B remains the terminal extension of that older ranking-function branch.
The original Round 6A/6B dossiers are preserved in the source archive and
identified in the public SHA-256 manifest.

## Status

- Full Collatz proof: **no**
- Full Collatz disproof: **no**
- Independent specialist verification: **pending**
- Complete Lean formalization: **pending**
- Corrected L5 equal-slope boundary/witness: **formally type-checked on Lean 4.33.1**
- Novelty certification for Round-7 lemmas: **pending**
