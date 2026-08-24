# Verification and reproduction manifest

This manifest maps promoted claims to their executable evidence. A successful
command verifies only the scope in the final column; it does not promote a
bounded computation or narrow formal theorem into a Collatz proof.

## Tested environment

Base audit on 2026-08-24 at
`8a93ea5e8377f16be5b54f5fe0de9f8d9a85b3a9`:

```text
Python 3.14.5
Lake 5.0.0-src+819816b
Lean 4.33.1 (commit 819816b2e0a3bf405af45ae5c7af2491d8f5bee6)
```

The Python checkers use the standard library. The Lean toolchain is pinned by
[`lean-toolchain`](../lean-toolchain).

The L14 regression was replayed under the same Python environment at artifact
commit `cc33bdb470da849a5eb9d63921dcd37a8f37e94d`.

The fixed-algebra YAH packet was independently replayed at Draft PR #8 head
`d5390326226eb27d4dd14f64ec3d52fe7d92cbe5` (parent
`e7a72cdc1fc6d5c45144c8bbb5925f6906541673`).

## Freshly replayed promoted checks

Run from the repository root.

| Claim ID | Command | Expected decisive output | Exact scope |
|---|---|---|---|
| `L14-3M1-NF` regression | `python -B verification\trajectory_normal_form_regression.py` | 500,000 odd starts, maximum 19 normalizer edges, counterfamily through `s=10000`, then `PASS` | Exact finite replay through `n<=1000000`; checks the local identities and scope regressions, not the universal prose theorem or Collatz. |
| `A-YAH-2LOCAL-001` | `python -B verification\yah_2local_edge_no_go.py` | `weighted strict lower bound = 1`, `W_(f,f) <= -1`, then `PASS` | Replays the 13-row cancellation for the stated unlabeled adjacent-edge additive class. |
| `A-YAH-2STATE-001` | `python -B verification\yah_two_state_semantic_label_no_go.py` | `model equations = 22`, `fixed-terminal legal contexts = 441`, `edge certificate rows = 50`, `edge supported labeled instances = 20`, then `PASS` | Reconstructs the fixed two-state labeled rule table, the two positive-integer cancellations, and exact fixed-terminal support for the no-first-removal corollary. |
| `A-YAH-AN1-001`; `A-YAH-2STATE-AN1-001` full | `python -S -B verification\yah_two_state_scalar_arctic_full_no_start.py` | Original 11-row and labeled 22-row cancellations, both mass 49 and zero delta; both `PASS` | Proves the coefficient-independent full/extended dimension-one arctic-natural no-first-removal theorem for the original and fixed labeled systems. |
| `A-YAH-AN1-001`; `A-YAH-2STATE-AN1-001` top | `python -S -B verification\yah_scalar_arctic_top\verify_top_certificates.py` | 10 cases, 491 integer Farkas lemmas, 426 RUP clauses, then `TOP_SCALAR_ARCTIC_NO_FIRST_STEP = PASS` | Encodes natural strictness as a gap of at least one, then Farkas-refutes the resulting nonnegative-real branch relaxations for all six original boundary and four reversed-dynamic labeled targets. Equal-state lifting gives the original-system Lemma-3.18 corollary. |
| `E-DP-MAXC` | `python -B verification\disproof_cycle_search.py` | 91 pairs, peak 47,517 states, 9 trivial encodings, 0 nontrivial candidates | Exact only for defaults `k<=40` and `0<D<=250000`; includes brute-force self-test through `k<=10`. |
| `E-TWOPUMP-DEP` | `lake env lean lean\CollatzWork\Disproof\TwoPumpDependency.lean` | Five theorem dependency reports containing only `propext` and `Quot.sound` | Checks the polynomial coefficient dependencies and vanishing resultant, not a cycle exclusion theorem. |
| Lean umbrella | `lake build` | `Build completed successfully` | Builds `InverseWordBoundary`, `RefinedMersenneChild`, `YAHFiniteObstruction` and their statement/data dependencies through the umbrella module. It does not import the two-pump module. |

All eight commands passed in the fresh audit. The YAH checkers currently
regenerate their evidence rather than comparing it automatically against the
retained finite-obstruction replay transcript
[`yah_finite_obstruction_replay_2026-08-24.txt`](yah_finite_obstruction_replay_2026-08-24.txt).
The cycle-DP output is retained in
[`disproof_cycle_search_output_2026-08-24.txt`](disproof_cycle_search_output_2026-08-24.txt).

In a fresh clone, run `lake build` before any direct `lake env lean` command:
the imported `.olean` files do not exist until the build has created them.

If `lake` is not on `PATH`, invoke the executable installed by `elan`; do not
hard-code another contributor's home directory into scripts or documentation.

## Narrow Lean boundary

| Module | Formalized statement | Axiom report / caveat |
|---|---|---|
| [`CollatzWork/InverseWordBoundary.lean`](../lean/CollatzWork/InverseWordBoundary.lean) | Equal-slope affine comparison and the exact `8x+5 / 8x+4` regression witness. | `equalSlopeSmaller` is axiom-free; the witness reports standard `propext`, `Quot.sound`. |
| [`CollatzWork/RefinedMersenneChild.lean`](../lean/CollatzWork/RefinedMersenneChild.lean) | Refined easy-child arithmetic, iterate identity, and coalescence. | Arithmetic theorem reports standard `propext`, `Classical.choice`, `Quot.sound`; remaining exported theorems report `propext`, `Quot.sound`. |
| [`CollatzWork/YAHFiniteObstructionStatement.lean`](../lean/CollatzWork/YAHFiniteObstructionStatement.lean) | Trusted finite rule/model statement layer and executable predicates used by the YAH certificate proofs. | This is the statement/data layer; correspondence to the pinned upstream rule blob remains a prose/source-review obligation. |
| [`CollatzWork/YAHFiniteObstruction.lean`](../lean/CollatzWork/YAHFiniteObstruction.lean) | Exact 13-, 8-, and 50-row cancellations, fixed-model equations, canonical embeddings for selected rows, pump identity, and ordered-additive no-go wrappers. | Core 8-/50-row cancellations and model equations are axiom-free; wrappers report only standard `propext`, `Quot.sound`; no global rewrite-relation or Collatz theorem is proved. |
| [`CollatzWork/Disproof/TwoPumpDependency.lean`](../lean/CollatzWork/Disproof/TwoPumpDependency.lean) | Two determinant dependencies, vanishing obstruction, and syzygy. | Direct module check reports only `propext`, `Quot.sound`; not imported by `CollatzWork.lean`. |

No module formalizes Round 6A, full L5, the L13 hard-child classification,
the cross-label recharge/rank theorem, the hard return map, YAH relative
termination, or Collatz.

## Retained historical diagnostics

These commands have committed outputs, but they were not all rerun in the
2026-08-24 final documentation pass.

| Area | Command | Retained output | Interpretation |
|---|---|---|---|
| Round 6A | `python -B verification\round-6a\collatz_round6a_checks.py` | [`round-6a/round6a_check_output.txt`](round-6a/round6a_check_output.txt), `PASS A`–`PASS G` | Indexing/construction stress tests; not a proof of the asymptotic theorem. |
| L8 Farey barrier | `python -B verification\round7_farey_coefficient_barrier.py` | [`round7_farey_coefficient_barrier_output_2026-08-23.txt`](round7_farey_coefficient_barrier_output_2026-08-23.txt) | Exact arithmetic certificate conditional on named external inputs. |
| L9–L12 oracle | `python -B verification\round7_first_crossing_oracle.py` | [`round7_first_crossing_oracle_output_2026-08-23.txt`](round7_first_crossing_oracle_output_2026-08-23.txt) | Finite regression/oracle only; it does not prove the universal prose statements. |
| Exhaustive one-shot L4/L5 class | `python -B verification\round7_exhaustive_inverse_word_classifier.py` | [`round7_exhaustive_inverse_word_classifier_output_2026-08-23.txt`](round7_exhaustive_inverse_word_classifier_output_2026-08-23.txt) | Exact for the configured finite cylinders and corrected one-shot class. |
| Accelerated macro sweep | `python -B verification\round7_accelerated_macro_coalescence_search.py` | [`round7_accelerated_macro_coalescence_output_2026-08-23.txt`](round7_accelerated_macro_coalescence_output_2026-08-23.txt) | Different certificate class from the ordinary `1903/145` sweep. |
| Survivor signatures | `python -B verification\round7_survivor_language_signatures.py` | [`round7_survivor_language_signatures_output_2026-08-23.txt`](round7_survivor_language_signatures_output_2026-08-23.txt) | Finite structural diagnostic; no small-automaton theorem. |

## Common interpretation errors

- `PASS` means that the checker reconstructed its finite algebra/certificate;
  it does not mean “Collatz passed.”
- The L14 checker is a finite regression. Its default million-integer bound
  does not prove the universal trajectory-normal-form theorem; that theorem is
  currently supported by a self-contained prose derivation and hostile replay.
- A clean Lean build checks only imported declarations and their stated
  hypotheses. It does not validate prose, novelty, source mapping, or omitted
  semantic bridges.
- `1903/145` and `1904/144` belong to different map/certificate conventions.
  Always cite the exact script and output.
- The old arbitrary-representative cycle DP is superseded. Only the max-`C`
  implementation and its bounded result may be cited.
- The project verification policy is
  [`lean/VERIFICATION_POLICY.md`](../lean/VERIFICATION_POLICY.md).
