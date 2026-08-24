# Verification and reproduction manifest

This manifest maps promoted claims to their executable evidence. A successful
command verifies only the scope in the final column; it does not promote a
bounded computation or narrow formal theorem into a Collatz proof.

## Tested environment

Fresh artifact audit on 2026-08-24 at
`6c8f77ef2b0b360f8f353f4508dcfec58e980331`, based on public
`origin/main` `67068bf0493c25514ebdd1b635ecd6a0e0af643f`:

```text
Python 3.14.5
Lake 5.0.0-src+819816b
Lean 4.33.1 (commit 819816b2e0a3bf405af45ae5c7af2491d8f5bee6)
```

The Python checkers use the standard library. The Lean toolchain is pinned by
[`lean-toolchain`](../lean-toolchain).

The L14 regression first entered the public history at artifact commit
`cc33bdb470da849a5eb9d63921dcd37a8f37e94d`. L15 and the three route checkers
below were added and freshly replayed at `6c8f77e...`.

## Freshly replayed promoted checks

Run from the repository root.

| Claim ID | Command | Expected decisive output | Exact scope |
|---|---|---|---|
| `L14-3M1-NF` regression | `python -B verification\trajectory_normal_form_regression.py` | 500,000 odd starts, maximum 19 normalizer edges, counterfamily through `s=10000`, then `PASS` | Exact finite replay through `n<=1000000`; checks the local identities and scope regressions, not the universal prose theorem or Collatz. |
| `L15-MIXED-INVERSE` regression | `python -B verification\expanded_rewrite_inverse_word_regression.py` | 50,000 odd rewrite starts, 12,500 inverse/source endpoints, 510 mixed words, 10,001 members of the `91 mod 162` family, 24 pure-`a=2` depths, then `PASS` | Finite replay of the displayed L15 identities and residue families. It does not prove the universal prose statements, certificate coverage, or Collatz. |
| `F-BOUNDED-ALPHABET-ENDPOINT-GATE-001` regression | `python -B verification\bounded_alphabet_endpoint_residue_gate.py` | 9,840 words over `{1,2,3}` through depth 8, five reconstructed seeds, three boundary-code checks, then `PASS` | Independent finite replay of endpoint representatives and carries. The infinite equivalence is proved in prose, not by exhaustion. The frozen transcript is [`bounded_alphabet_endpoint_residue_gate_output_2026-08-24.txt`](bounded_alphabet_endpoint_residue_gate_output_2026-08-24.txt). |
| `F-DIRECT-H-RETURN-ARITHMETIC-001` regression | `python -B verification\direct_H_return_renewal_regression.py` | 50,000 typed parameters, 3,570 completed switching returns, 50,000 renewal states, two nontrivial divisor witnesses, then `PASS` | Finite replay of the exact typed-edge domains, completed-return iff, renewal identities, and divisor-filter witnesses. It neither constructs nor excludes an infinite positive direct ray. |
| `F-PRIME-RETURN-001` regression | `python -B verification\prime_renewal_regression.py` | 10,000 correction prefixes, 10,000 hard parameters, 44 primes through 199, largest checked gap 178, one five-prime script, 48 rough-growth pairs, then `PASS` | Finite replay of the correction, CRT, return, and rough-growth constructions. It does not turn finite scripts into one infinite seed. |
| `A-YAH-2LOCAL-001` | `python -B verification\yah_2local_edge_no_go.py` | `weighted strict lower bound = 1`, `W_(f,f) <= -1`, then `PASS` | Replays the 13-row cancellation for the stated unlabeled adjacent-edge additive class. |
| `A-YAH-2STATE-001` | `python -B verification\yah_two_state_semantic_label_no_go.py` | `model equations = 22`, `fixed-terminal legal contexts = 441`, `symbol certificate rows = 8`, `edge certificate rows = 50`, then `PASS` | Reconstructs the fixed two-state labeled rule table and the two positive-integer cancellations. |
| `E-DP-MAXC` | `python -B verification\disproof_cycle_search.py` | 91 pairs, peak 47,517 states, 9 trivial encodings, 0 nontrivial candidates | Exact only for defaults `k<=40` and `0<D<=250000`; includes brute-force self-test through `k<=10`. |
| `E-TWOPUMP-DEP` | `lake env lean lean\CollatzWork\Disproof\TwoPumpDependency.lean` | Five theorem dependency reports containing only `propext` and `Quot.sound` | Checks the polynomial coefficient dependencies and vanishing resultant, not a cycle exclusion theorem. |
| Lean umbrella | `lake build` | `Build completed successfully` | Builds `InverseWordBoundary`, `RefinedMersenneChild`, and the umbrella module. It does not import the two-pump module. |

All ten commands passed in the fresh audit. The two YAH checkers currently
regenerate their evidence rather than comparing against a committed stdout
transcript. The cycle-DP output is retained in
[`disproof_cycle_search_output_2026-08-24.txt`](disproof_cycle_search_output_2026-08-24.txt).

If `lake` is not on `PATH`, invoke the executable installed by `elan`; do not
hard-code another contributor's home directory into scripts or documentation.

## Narrow Lean boundary

| Module | Formalized statement | Axiom report / caveat |
|---|---|---|
| [`CollatzWork/InverseWordBoundary.lean`](../lean/CollatzWork/InverseWordBoundary.lean) | Equal-slope affine comparison and the exact `8x+5 / 8x+4` regression witness. | `equalSlopeSmaller` is axiom-free; the witness reports standard `propext`, `Quot.sound`. |
| [`CollatzWork/RefinedMersenneChild.lean`](../lean/CollatzWork/RefinedMersenneChild.lean) | Refined easy-child arithmetic, iterate identity, and coalescence. | Arithmetic theorem reports standard `propext`, `Classical.choice`, `Quot.sound`; remaining exported theorems report `propext`, `Quot.sound`. |
| [`CollatzWork/Disproof/TwoPumpDependency.lean`](../lean/CollatzWork/Disproof/TwoPumpDependency.lean) | Two determinant dependencies, vanishing obstruction, and syzygy. | Direct module check reports only `propext`, `Quot.sound`; not imported by `CollatzWork.lean`. |

No module formalizes Round 6A, full L5, the L13 hard-child classification,
L14, L15, the bounded-alphabet endpoint gate, the cross-label recharge/rank
theorem, the hard return map, YAH relative termination, or Collatz.

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
- The L15 checker likewise validates finite instances of the inverse-fiber,
  source, mixed-word, and obstruction formulas. Universal coverage by
  forward-inverse certificates is explicitly unproved.
- The bounded-alphabet checker validates finite identities and boundary cases.
  The exact infinite theorem characterizes positive realizability by eventual
  zero carry, but it does not determine which side a proposed aperiodic code
  occupies.
- The two route-filter checkers validate exact finite instances of their
  algebraic constructions. Neither supplies the fixed-seed infinitary bridge
  that the prose notes explicitly leave open.
- A clean Lean build checks only imported declarations and their stated
  hypotheses. It does not validate prose, novelty, source mapping, or omitted
  semantic bridges.
- `1903/145` and `1904/144` belong to different map/certificate conventions.
  Always cite the exact script and output.
- The old arbitrary-representative cycle DP is superseded. Only the max-`C`
  implementation and its bounded result may be cited.
- The project verification policy is
  [`lean/VERIFICATION_POLICY.md`](../lean/VERIFICATION_POLICY.md).
