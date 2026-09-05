# Verification and reproduction manifest

This manifest maps promoted claims to their executable evidence. A successful
command verifies only the scope in the final column; it does not promote a
bounded computation or narrow formal theorem into a Collatz proof.

## Tested environment

Complete closure replay on 2026-08-24 against source state
`4a8845ef46c78e50b3c4303e3a3a110e3b66f045` and accepted mathematical
baseline `b75ffec58ae20ac26271ff7d59a71d3591467994` (before the navigation-only
patch that added the atlas and graph checker):

```text
Python 3.14.5
Lake 5.0.0-src+819816b
Lean 4.33.1 (commit 819816b2e0a3bf405af45ae5c7af2491d8f5bee6)
```

The Python checkers use the standard library. The Lean toolchain is pinned by
[`lean-toolchain`](../lean-toolchain).

Earlier artifact-level audits remain identifiable by their individual commit
hashes; the table below was replayed together at the closure head above.

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
| Lean umbrella | `lake build` | `Build completed successfully` | Current umbrella builds all twelve proof modules listed in [the imports](../lean/CollatzWork.lean), including the guarded `RootDescent` and complete uniform `ResidueAncestor` modules. The August baseline had imported only the first two. |

All eight commands passed in the fresh audit. The YAH checkers currently
regenerate their evidence rather than comparing against a committed stdout
transcript. The cycle-DP output is retained in
[`disproof_cycle_search_output_2026-08-24.txt`](disproof_cycle_search_output_2026-08-24.txt).

If `lake` is not on `PATH`, invoke the executable installed by `elan`; do not
hard-code another contributor's home directory into scripts or documentation.

## Repository knowledge-graph QA

The documentation graph has a separate standard-library check:

```powershell
python -B verification\check_note_graph.py
```

It verifies that local Markdown targets exist and that every Markdown note is
reachable from `README.md`. `NOTE_GRAPH = PASS` certifies navigation only; it
does not certify mathematics, citations, anchors, or novelty. The governing
format is [the portable note-graph standard](../methodology/NOTE_GRAPH_STANDARD.md).

## Narrow Lean boundary

| Module | Formalized statement | Axiom report / caveat |
|---|---|---|
| [`CollatzWork/InverseWordBoundary.lean`](../lean/CollatzWork/InverseWordBoundary.lean) | Equal-slope affine comparison and the exact `8x+5 / 8x+4` regression witness. | `equalSlopeSmaller` is axiom-free; the witness reports standard `propext`, `Quot.sound`. |
| [`CollatzWork/RefinedMersenneChild.lean`](../lean/CollatzWork/RefinedMersenneChild.lean) | Refined easy-child arithmetic, iterate identity, and coalescence. | Arithmetic theorem reports standard `propext`, `Classical.choice`, `Quot.sound`; remaining exported theorems report `propext`, `Quot.sound`. |
| [`CollatzWork/Disproof/TwoPumpDependency.lean`](../lean/CollatzWork/Disproof/TwoPumpDependency.lean) | Two determinant dependencies, vanishing obstruction, and syzygy. | Direct module check reports only `propext`, `Quot.sound`; now imported by `CollatzWork.lean`. |

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

## 2026-09-05 contribution checks

| Claim | Command / evidence | Scope |
|---|---|---|
| `L15-QUARTER-GAP` | `python -B verification/near_return_quarter_bound.py`; [retained output](near_return_quarter_bound_output_2026-09-05.txt) | Exact phase-maxima certificate and 107 base inequalities supporting the universal prose argument; not a finite orbit extrapolation or Lean proof. |
| `AB-FROZEN-DEBT-001` | `python -B verification/hard_return_frozen_debt_check.py`; [retained output](hard_return_frozen_debt_output_2026-09-05.txt) | Symbolic affine guards/factors for the universal family, plus 1,003 direct replay regressions. The general polynomial consequence is proved in prose. |
| `L0-COALESCENCE-LEAN` | `lake build` and `lake env lean lean/CollatzWork/Convergence.lean`; [retained CI axiom log](lean_convergence_ci_2026-09-05.txt) | Exact shortcut-map convergence/coalescence criteria and compatible-child induction rule; no universal certificate or Collatz proof. |

The [research pass](../ASTRA_RESEARCH_PASS_2026-09-05.md) records independent
review scopes, runtime limitations, source comparison, and recovery. Python
checks passed with Python 3.12.13; formal checking passed on the standard
GitHub Linux runner using the unchanged pinned Lean 4.33.1 release.
The [workflow](../.github/workflows/verify.yml) repeats these checks for pushes
and pull requests. A configured workflow is not a pass: inspect the actual
run and source commit when reviewing later changes.


## Second full-closure attempt, 2026-09-05

| Claim / experiment | Reproduction | Scope |
|---|---|---|
| `AB-3ADIC-RESET-001` | `python -B verification/three_adic_hard_return_check.py`; [output](three_adic_hard_return_output_2026-09-05.txt) | Uniform affine guards/cofactor factorizations; 515 witness replays and raw hard inputs below 20,000. Universal reset and polynomial consequence are proved in prose. |
| Primary-source counterexamples | `python -B verification/primary_bridge_counterexamples.py`; [output](primary_bridge_counterexamples_output_2026-09-05.txt) | Exact finite witnesses supporting the [source audit](../proof-search/sources/Primary_Bridge_Audit_2026-09-05.md); infinite measure and logical arguments are separate proofs. |
| `A-YAH-NAT2-B2-EXP` | [Search and exact SMT instances](yah_natural_matrix_2d/README.md) | Dimension 2 natural affine template: bound 2 UNSAT reported by Z3; bound 8 timeout. No independently checked UNSAT certificate or general no-go. |

The two standard-library counterexample checkers are CI gates. The optional
Z3 search is a retained bounded experiment, not a required CI gate.


## Third continuation checks

| Claim | Command / evidence | Scope |
|---|---|---|
| Universal `L15-QUARTER-GAP` and the threshold 16 | `lake build`; [formal scope](Quarter_Gap_Formal_Scope_2026-09-05.md), [axiom log](lean_quarter_gap_ci_2026-09-05.txt) | Complete actual-orbit auxiliary theorem, with all its arithmetic dependencies. No existence of coefficient stopping or global convergence. |
| Independent integer block audit | `python -B verification/block_arithmetic_certificate.py`; [output](block_arithmetic_certificate_output_2026-09-05.txt) | All 12 exact threshold regions, normalized bases 16..27 and failing 15, plus dyadic regressions. Lean does not import these answers. |
| `AB-FINITE-RESIDUE-001` | `python -B verification/finite_residue_hard_return_check.py`; [output](finite_residue_hard_return_output_2026-09-05.txt) | Uniform CRT families for 18 moduli and 90 positive replays totaling 6330 F edges; universal quantifiers have a prose proof. |
| Core obstruction, positive targets, composition loop | `python -B verification/core_residue_obstruction_check.py`; [output](core_residue_obstruction_output_2026-09-05.json) | Exact guarded affine identities and finite replay; the final inverse edge in the 425 loop is not a T step. |
| `B-MOD27-RANK-001` | `python -B verification/mod27_rank_check.py`; [output](mod27_rank_output_2026-09-05.txt) | All 25 core edges with symbolic all-input inequalities; 200000 state regressions and a 1024-step self-loop. Global stopping proof is in the source note, not Lean. |

The configured workflow repeats all four new Python checks. Claims about a
later revision require its own successful run; use the actual PR-head status.


## Fourth continuation: root-relative progress

| Claim | Reproduction / retained evidence | Scope |
|---|---|---|
| Guarded burst descent and generic ancestor identity | `lake build`; [initial exact-head CI/axioms](root_descent_ci_initial_2026-09-05.txt), [formal statement boundaries](../LEAN_TARGETS.md) | The exact Lean statements are checked on arbitrary natural parameters under explicit guards. The residue selectors are separate. |
| Six-row ancestor selector, uniform valuation21 | `python -B verification/residue20_valuation_inverse_check.py`; [output](residue20_valuation_inverse_output_2026-09-05.json) | All-parameter prose proof with24,930 finite actual-forward replays; exact v20 failure when removing the selected guard. |
| Refined ancestor selector, uniform valuation13 | `python -B verification/residue20_refined_ancestor_check.py`; [output](residue20_refined_ancestor_output_2026-09-05.json) | Complete uniform theorem now Lean-checked; these26,085 finite forward replays remain independent regression evidence. Individually sharper lower rows and the v12 selector failure retain separate prose/Python scope. |
| Infinite residue20 burst subfamily | `python -B verification/root_burst_descent_check.py`; [output](root_burst_descent_output_2026-09-05.txt) | CRT reconstruction and independent forward/parity replay; actual later return below the original start, despite an increasing first return. Infinite specialization proved in prose. |
| OOE-depth recharge obstruction | `python -B verification/check_shadow_debt_recharge.py`; [output](shadow_debt_recharge_output_2026-09-05.txt) |1,004 independent core-map and actual-orbit replays; the universal family and scoped polynomial consequence are proved in prose. |

All four Python checkers use explicit failures and are run both normally and under `python -O` in the existing exact-mathematics workflow. They import no external package or baseline return implementation. Finite replays do not establish universal convergence. [The continuation report](../ROOT_RELATIVE_PROGRESS_2026-09-05.md) records complementary coverage, semantic review and remaining obligations.


## Fifth continuation: recharge escape and complete ancestor formalization

| Claim | Reproduction / retained evidence | Scope |
|---|---|---|
| Complete uniform valuation13 ancestor theorem | `lake build`; [accepted CI/axioms](residue_ancestor_ci_2026-09-05.txt), [public statement](../lean/CollatzWork/ResidueAncestorStatement.lean) | End-to-end kernel proof from sole 3^13 divisibility hypothesis, including factorization, selector, target membership and strict root-relative order. |
| Q2 exit descent | `python -B verification/q2_exit_descent_check.py`; [output](q2_exit_descent_output_2026-09-05.json) |514 CRT and279 general guarded replays, through k1023; universal claims follow from prose algebra. Missing-exit control retained. |
| Two-burst recharge escape | `python -B verification/two_burst_recharge_escape_check.py`; [output](two_burst_recharge_escape_output_2026-09-05.txt) |43 growing CRT,75 general,24 padded cases; negative same-q recharge and missing-exit controls. The full theorem remains prose. |
| Complementary ancestors and first-return structure | `python -B verification/complementary_ancestor_check.py`; [output](complementary_ancestor_output_2026-09-05.json) |2004 fixed-cylinder,581 new-coordinate,3800 first-return and70 exact residual-recharge replays; universal prefix/selector and transition proofs remain prose. |

The three new dependency-free checkers join the existing four in the normal/optimized Python CI step. [The continuation report](../RECHARGE_ESCAPE_PROGRESS_2026-09-05.md) gives the exact coverage delta and remaining q5 target. Initial formal acceptance does not substitute for checking the final integrated revision's own CI run.
