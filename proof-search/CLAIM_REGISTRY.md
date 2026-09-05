# Atomic claim and evidence registry

**Canonical integration:** the [2026-09-05 consolidated checkpoint](../CONSOLIDATION_2026-09-05.md) identifies all eight exact source heads. Earlier component hashes remain provenance for their particular claims.

**Global verdict:** Collatz is unresolved. No row below is a universal proof,
a positive nontrivial cycle, or a rigorously divergent positive orbit.

This file answers five different questions for each promoted claim:

1. How strongly should the exact scoped statement be trusted internally?
2. What verification has actually been retained?
3. How important is it to the project?
4. What does the primary-source audit say about novelty?
5. How ready is it for external release?

The grades are ordinal audit labels, not probabilities and not estimates that
Collatz is true. A formally checked prior-art identity can have `C3/V3` but
`N0/I1`; a potentially new claim can have `N2` but only `C1/V1`.

## Rating key

### Scoped confidence (`C`)

| Grade | Meaning |
|---|---|
| `C0` | Rejected, false as stated, or superseded. |
| `C1` | Plausible/provisional; a material proof gap remains. |
| `C2` | Internally supported by a self-contained derivation and hostile review, but not fully formal or externally reconstructed. |
| `C3` | Robust within the exact stated scope: exact replay/checker or narrow formal proof, with semantics audited. |
| `C4` | Independently verified by an external specialist or peer review. No repository-specific claim has this grade. |

### Verification (`V`)

| Grade | Retained evidence |
|---|---|
| `V0` | Assertion or scratch only. |
| `V1` | Self-contained prose derivation/internal audit. |
| `V2` | Exact executable checker or independent exact replay; finite programs prove only their stated finite scope. |
| `V3` | Lean kernel-checked exact statement with the recorded axiom footprint. |
| `V4` | Independent human specialist or peer-reviewed verification. No repository-specific claim has this grade. |

### Importance (`I`)

| Grade | Meaning |
|---|---|
| `I0` | Archival or bounded diagnostic. |
| `I1` | Local lemma or regression artifact. |
| `I2` | Reusable certificate or meaningful method obstruction. |
| `I3` | Materially closes, redirects, or precisely isolates a major route. |
| `I4` | Complete proof/disproof. No row qualifies. |

### Novelty (`N`)

| Grade | Meaning |
|---|---|
| `N0` | Known in substance in primary prior art. |
| `N1` | Routine specialization, elementary repackaging, or implementation artifact. |
| `N2` | Exact project form not found in a bounded primary-source audit; priority remains uncertified. |
| `N3` | Broad systematic audit found no match; priority still not certified. No row is assigned this grade. |
| `N4` | Priority externally certified. No row qualifies. |
| `N?` | The exact formulation has not received a sufficient novelty audit. |

### Release readiness (`R`)

| Grade | Meaning |
|---|---|
| `R0` | Do not promote. |
| `R1` | Audited repository artifact/supporting result. |
| `R2` | Coherent specialist-review packet, still requiring human correctness and novelty review. |
| `R3` | Submission-ready standalone result. No row qualifies. |
| `R4` | Peer-reviewed/published project result. No row qualifies. |

## Highest-value external-review targets

The compact YAH method-obstruction packet and the sharp eventual threshold16 certificate merit separate focused review. The new Thue–Morse exclusion has a complete analytic argument but its full coding bridge is not Lean-checked and its novelty remains unassessed. The endpoint/carry characterization, guarded original-root families and stopped-route cores remain useful supporting artifacts. No ranking here certifies priority or converts an auxiliary result into a Collatz solution.

PR8 now supplies the finite additive YAH Lean certificates. It does **not** supply a Lean proof of the scalar-arctic full/top results. See [formal boundaries](../LEAN_TARGETS.md), [the separate candidate](../publication/YAH_SCALAR_ARCTIC_CANDIDATE.md), and [the bounded novelty review](../research-review/novelty-2026-09-05/REPORT.md).

## Complete promoted-claim inventory

### Endpoint and corrected-log branch

| ID | Exact scope | Grades | Evidence / provenance | Limitation |
|---|---|---|---|---|
| `G0` | The archive contains no accepted universal proof, positive nontrivial cycle, or rigorously divergent positive orbit. | `N/A` (archive status) | [Public status](../PUBLIC_STATUS_2026-08-24.md); accepted component baselines `6c8f77ef2b0b360f8f353f4508dcfec58e980331` and `b75ffec58ae20ac26271ff7d59a71d3591467994`. | This is the status of the open problem and archive, not a graded project theorem. |
| `F-BOUNDED-ALPHABET-ENDPOINT-GATE-001` | For `1<=a_k<=A`, the canonical endpoint representatives have eventual zero carry iff the infinite code is realized by one positive odd orbit iff their normalized residues vanish iff their root growth is strictly below `3`; otherwise positive carries recur and the root limsup is `3`. | `C2 V2 I3 N2 R2` | [Endpoint-residue gate](routes/F_bounded_alphabet_endpoint_residue_gate.md), [checker](../verification/bounded_alphabet_endpoint_residue_gate.py), [frozen output](../verification/bounded_alphabet_endpoint_residue_gate_output_2026-08-24.txt), artifact commit `6c8f77ef2b0b360f8f353f4508dcfec58e980331`. | Exact characterization only. It does not decide eventual carry for a proposed aperiodic hard code, construct a positive divergent orbit, or prove Collatz. |
| `L0` | For the accelerated odd map, every odd `n>1` having a smaller iterate is equivalent to Collatz; a least counterexample cannot descend below itself. | `C3 V3 I3 N0 R1` | [L0](lemmas/L0_Global_Descent_Equivalence.md), commit `2456248bcb5f1c769d2ffdb369e8f63dfcd3a3be`. | [Convergence.lean](../lean/CollatzWork/Convergence.lean) checks direct-descent/convergence equivalences for the stated map. No progress without a universal descent mechanism. |
| `6A-T1` | Quantitative beta-debt necessity on the stated repelling rational-period shadows. | `C2 V1 I3 N2 R2` | [Review note](../papers/round-6a/Theorem_6A1_Public_Review_Note.md), claim ledger/checker/output, commit `c3d1da2c5dc8db296089745951dda1cd8e89bb9d`. | Unreviewed; lift, endpoint valuation, scaling, and the proof chain are not Lean-checked. |
| `6A-SUPPORT` | Principal-row realizations, prescribed minima, rational-period lift/scaling, debt-tail frontiers, arbitrary `F(v_2(n+1))` obstruction, and finite-center freezing, at the scopes stated in the Round 6A packet. | `C1 V1 I2 N? R1` | Same Round 6A packet; diagnostic checker prints `PASS A`–`PASS G`. | Several claims are prerequisites for `6A-T1`; checker agreement is not a universal proof. |
| `6A-C2/C3` | The `w_m=(2,1^(m-1))` normalized necessary debt rate tends to the stated `rho_beta`; suitable repelling orbits defeat two-sided local boundedness. | `C2 V1 I2 N2 R1` | Same review note and commit. | Conditional on the same unformalized 6A foundation. |
| `6B` | A phase-frozen surrogate satisfying the Round 6A hypotheses has the stated positive linear approximation-error lower bound. | `C2 V1 I2 N2 R1` | [Round 6B summary](../papers/round-6b/Round6B_Public_Summary.md), commit `7d8bdf9bb11210eb690e251eeb7122bae30d299d`. | Conditional on Round 6A; finite/countable-sensor interpretations require the exact freezing and uniform-tail hypotheses. |

### Exact affine, inverse-word, and least-counterexample chain

| ID | Exact scope | Grades | Evidence / provenance | Limitation |
|---|---|---|---|---|
| `L1` | Exact affine prefix formula and `n <= C/(2^A-3^t)` for a non-descending contracting prefix. | `C2 V1 I2 N0 R1` | [L1](lemmas/L1_Exact_Prefix_Descent_Bound.md), commit `0e21e1dca3fa48121f523094505faece9abb467e`. | Classical arithmetic; Lean pending. |
| `L2` | Binary refinement changes the endpoint odd-count exponent by `0` or `1`, with binomial cylinder counts; strict slope contraction gives eventual family descent. | `C2 V1 I2 N0 R1` | [L2](lemmas/L2_Cylinder_Refinement_and_Slope_Pruning.md), commit `ac4f7a119af899a0fdccb792e9196b73b591cf01`. | Classical parity-vector machinery; Lean pending. |
| `L3` | The stated trailing-ternary-2 condition yields an explicit coalescing family and strong-induction edge when the coefficient is smaller. | `C2 V1 I1 N1 R1` | [L3](lemmas/L3_Trailing_Ternary_Two_Coalescence.md), commit `90f6a39f9a4a252ad74d8ae92def24f27b756f23`. | Elementary specialization; finite counts are diagnostic. |
| `L4` | Exact guarded affine semantics for one whole-family inverse word, including the empty suffix; includes `T^12(4096x+1023)=T^10(3072x+767)`. | `C2 V2 I2 N1 R1` | [L4](lemmas/L4_General_Inverse_Word_Coalescence.md) and accelerated checker, commit `4dc711439598933dc79cd00ecabff163df964621`. | One-shot unrefined certificate language only; generic theorem not in Lean. |
| `L5` | In that L4 class, strict-slope winners have inverse depth at most `t-1`; equal-slope winners have depth exactly `t` and need smaller intercept. | `C2 V1 I2 N1 R1` | [Corrected L5](lemmas/L5_Inverse_Word_Search_Completeness_Bound.md), commit `016ccd7f1a82ba802531a5b649848d994d18bcc8`. | Full theorem is prose. The narrower equal-slope comparison/witness is `C3/V3` in [Lean](../lean/CollatzWork/InverseWordBoundary.lean). |
| `L6` | A least nonterminating odd integer must occupy the complementary hard mod-4 initial-exit class; the easy class coalesces with a smaller positive integer. | `C2 V1 I2 N1 R1` | [L6](lemmas/L6_Minimal_Counterexample_Exit_Constraint.md), commit `bf5e4a65a0a239349f300c42bc746dbc03d338a0`. | Does not eliminate the infinite hard family; Lean pending. |
| `L7` | Conditional on the cited verified-range and Rozier–Terracol inputs, no coefficient contraction occurs through 301,993 accelerated steps. | `C2 V2 I1 N1 R1` | [L7](lemmas/L7_Least_Counterexample_Coefficient_Barrier.md) and checker. | Quantitatively superseded by L8; external inputs are not formalized here. |
| `L8` | Conditional on two named external inputs, the exact Farey certificate gives the `114,208,327,604` barrier. | `C2 V2 I2 N2 R1` | [L8](lemmas/L8_Farey_Certified_Coefficient_Barrier.md), checker/output. | Conditional; Lean pending. |
| `L9` | A first coefficient contraction obeys the exact deadline/mechanical-envelope and displacement-penalty statements. | `C2 V1 I2 N? R1` | [L9](lemmas/L9_First_Contraction_Mechanical_Envelope.md), accepted in `8850e353e3d6425979ba46698232f5ded5fbc7bc`. | Prose theorem; oracle checks only a finite range. |
| `L10` | A non-descending first contraction has the stated near-return defect and linked 2-adic/3-adic/gap residues. | `C2 V1 I2 N? R1` | [L10](lemmas/L10_Near_Return_and_Dual_Residue_Certificate.md), same accepted chain. | Necessary conditions only; reaches the open coefficient-stopping wall. |
| `L11` | Under `s<n_*`, the one-shot first-contraction endpoint inherits the L6 hard condition and `4|d`. | `C2 V1 I1 N? R1` | [L11](lemmas/L11_Near_Return_Hard_Exit_Inheritance.md). | Not renewable: minimality is relative to the immutable root, not each new endpoint. |
| `L12` | Positive gaps between two hard states obey the stated unequal/equal valuation transition and frontier bounds. | `C2 V1 I2 N? R1` | [L12](lemmas/L12_Hard_Exit_Gap_Valuation_Transition.md) and bounded oracle. | Lean pending; oracle range is finite. |
| `F019` | The inference that L11 automatically renews L9–L10 is false; `7,11,10` is the exact local-contraction witness. | `C3 V1 I3 N1 R1` | [Failure ledger](FAILURE_LEDGER.md#f019--l11-hard-exit-inheritance-automatically-renews-l9-l10), closure audit `f0edef162190b98c4264def50fea9edaa6982956`. | A rooted total transition/rank remains missing. |

### Mersenne, mixed-radix, and route-class obstructions

| ID | Exact scope | Grades | Evidence / provenance | Limitation |
|---|---|---|---|---|
| `A-ARB/A-CYL` | No finite cover of all odd `n>1` by direct-descent promises with uniformly bounded positive horizons; the power-of-two-cylinder version is weaker. | `C3 V1 I2 N0 R1` | [Failure ledger F008](FAILURE_LEDGER.md#f008--finite-depth-residue-tree), repaired through commit `409cb63d6805b00b3dcd96576ac172c58b16384e`. | Known finite-method obstruction; does not exclude ranked recursion or unbounded derivations. |
| `BLIND-PALETTE-001` | No arbitrary selector among finitely many eventually nondecreasing natural-valued functions yields strict progress within a uniform finite number of shortcut steps at every sufficiently large input. | `C3 V3 I2 N? R1` | [Proof and comparison](lemmas/Finite_Palette_Bounded_Progress_Obstruction.md), [trusted statement](../lean/CollatzWork/FinitePaletteObstructionStatement.lean), [Lean solution](../lean/CollatzWork/FinitePaletteObstruction.lean), and [verification record](../verification/README.md). | Finite palette and bounded horizon only; real/polynomial extensions are prose, global novelty unaudited, external review absent. Does not subsume every hard-return obstruction in PR #16. |
| `B-INV` | On `M_K(x)=2^K(x+1)-1`, every uniformly admissible unrefined L4 inverse word after any uniform forward time has at least the original slope; equality reconstructs the family. | `C2 V1 I3 N2 R1` | [All-depth no-go](routes/AB_mersenne_inverse_word_no_go.md), commit `409cb63d6805b00b3dcd96576ac172c58b16384e`. | Exact one-shot class only; parameter refinement/nonlinear ranked recursion remain open. |
| `L13-EASY` | For the parity-compatible refined family, `m=(3N-1)/4` is positive, smaller, and exactly coalesces. | `C3 V3 I2 N0 R1` | [L13](lemmas/L13_Refined_Mersenne_Child_Macros.md), [Lean](../lean/CollatzWork/RefinedMersenneChild.lean), commit `7be9977cddc2fe3786eb27d71e7914ff1e214509`. | Published in substance (not novel); hard child remains. |
| `L13-HARD` | Through `0<=t<=L+2`, no uniformly admissible unrefined L4 inverse word produces an eventually smaller hard-child family; successor cells are exactly normalized by `v_2(Y+1)` and the mod-4 odd quotient. | `C2 V1 I3 N2 R1` | [L13](lemmas/L13_Refined_Mersenne_Child_Macros.md), final arithmetic commit `e169d4bb7daf9fc4f70b1a0ab3297330846dccc8`. | Retain the time and certificate-class qualifier; not Lean-formalized. |
| `L13-RANK` | Same-label replay debt decreases, cross-label transitions can recharge it arbitrarily, and the exact guarded edge refutes the stated lower-bounded affine rank class. | `C2 V1 I3 N2 R1` | L13 equations (20)–(27), commit `e169d4bb7daf9fc4f70b1a0ab3297330846dccc8`. | Does not exclude richer state, nonlinear ranks, or all finite automata. |
| `L14-3M1-NF` | The stated `v_2(3x+/-1)` reducer sends every positive odd `n` through finitely many strictly smaller convergence-equivalent macro edges to `1`, `7 mod 8`, or `27 mod 32`. | `C2 V1 I2 N1 R1` | [L14 theorem and hostile corrections](lemmas/L14_ThreeNMinusOne_Trajectory_Normal_Form.md), [finite regression](../verification/trajectory_normal_form_regression.py), artifact commit `cc33bdb470da849a5eb9d63921dcd37a8f37e94d`. | The residual universal assertion is Collatz-equivalent; the normal form is not maximal; the universal proof is prose and not Lean-formalized. |
| `L15-MIXED-INVERSE` | Two further decreasing predecessor rewrites give the stated nonconfluent irreducible set; complete accelerated inverse fibers, canonical source reduction, mixed inverse-word congruences, the `91 mod 162` coalescence family, and the pure-`a=2` depth obstruction hold at their displayed scopes. | `C2 V2 I2 N1 R1` | [L15](lemmas/L15_Expanded_Rewrite_and_Mixed_Inverse_Words.md), [regression](../verification/expanded_rewrite_inverse_word_regression.py), artifact commit `6c8f77ef2b0b360f8f353f4508dcfec58e980331`. | The rewrite system is nonconfluent and not exhaustive. Universal forward-inverse certificate coverage is Collatz-equivalent; fixed-depth pure-`a=2` failure does not exclude adaptive mixed words. |
| `AB-BRIDGE` | Round-7 affine cylinders are an affine projection of the YAH mixed-base branch semantics; macro coalescence is a distinct certificate idea. | `C2 V1 I2 N1 R1` | [Representation bridge](routes/AB_mixed_radix_coalescence_bridge.md), commit `c7948930b1bf997c0ed0a9f857c5e0e6b2a71810`. | The certificate graph/rank is conjectural; Route AB is `BLOCKED_NO_MECHANISM`. |
| `AB-HARD-RETURN-001` | A total decreasing normalizer sends every positive input to `1` or the hard family; the induced return map is Collatz-equivalent. The smallest reported growth-plus-recharge witness is `31 -> 182 -> 91`. | `C2 V1 I3 N1 R1` | [Hard return system](routes/AB_hard_boundary_return_system.md), commit `8a93ea5e8377f16be5b54f5fe0de9f8d9a85b3a9`. | Compression/equivalence, not termination progress; “smallest” lacks a committed exhaustive transcript. |
| `F-DIRECT-H-RETURN-ARITHMETIC-001` | The four displayed partial hard-boundary transitions and the exact completed-switching criterion `v_2(3u+5)=3k+1` hold; an infinite positive direct ray would grow, switch infinitely, and be aperiodic. | `C2 V2 I2 N1 R1` | [Direct-return note](routes/AB_direct_H_return_and_renewal_filters.md), [regression](../verification/direct_H_return_renewal_regression.py), artifact commit `6c8f77ef2b0b360f8f353f4508dcfec58e980331`. | The direct system is partial. The conditional consequences neither construct nor exclude an infinite positive ray and do not control trajectories that exit the hard set. |
| `F-RENEWAL-GCD-FILTER-001` | Renewal blocks satisfy the displayed affine identity; a separately hypothesized common odd divisor of all states or all shifted states must divide the corresponding gcd-of-lengths expression. | `C2 V2 I1 N1 R1` | Same [direct-return and renewal note](routes/AB_direct_H_return_and_renewal_filters.md) and checker, artifact commit `6c8f77ef2b0b360f8f353f4508dcfec58e980331`. | Neither persistent-divisor hypothesis is proved for generic orbits; the two hypotheses cannot be merged. |
| `F-PRIME-RETURN-001 / D-HARD-PRIME-REFRESH-001` | Finite-word correction divisors exactly control prime return; the hard words have correction primes `5` and `23`; delayed pure-`1` returns, finite CRT concatenations, and finite rough-growth shadows exist exactly as stated. | `C2 V2 I2 N1 R1` | [Prime-renewal no-go](routes/AB_prime_renewal_finite_window_no_go.md), [regression](../verification/prime_renewal_regression.py), artifact commit `6c8f77ef2b0b360f8f353f4508dcfec58e980331`. | Closes finite-window prime/roughness mechanisms only. The realizing seed depends on the finite script, so no infinite positive orbit follows. |
| `A-YAH-2LOCAL-001` | The 13-row cancellation excludes bounded-below scalar adjacent-edge additive potentials in the stated canonical contexts. | `C3 V3 I3 N2 R2` | [Certificate note](routes/A_yah_2local_edge_potential_no_go.md), [Lean scope](routes/A_yah_finite_obstruction_formal_audit.md), [checker](../verification/yah_2local_edge_no_go.py), commit `d1bc062c727041ed8e106478983e3b7281f33dae`. | Does not exclude labels, matrices, longer windows, or nonadditive orders. |
| `A-YAH-2STATE-001` | For the fixed two-state suffix labeling, the Lean wrappers exclude additive labeled-symbol and labeled-edge weights that orient every locally valid dynamic row strictly and every auxiliary row weakly. | `C3 V3 I3 N2 R2` | [Certificate note](routes/A_yah_two_state_semantic_label_no_go.md), [Lean scope](routes/A_yah_finite_obstruction_formal_audit.md), [checker](../verification/yah_two_state_semantic_label_no_go.py), base commit `8a93ea5e8377f16be5b54f5fe0de9f8d9a85b3a9`, strengthened at `f8558a566b682e8dbc4465206f9c26ac9b17760c`. | One semantic algebra and additive locality class. The broader first-uniform-rule-removal support argument remains prose/Python V2; it is not the Lean wrapper statement. Adjacent-window potentials are not automatically YAH compositional interpretations. |
| `A-YAH-AN1-001` | On the original eleven-rule system, no first standard dimension-one arctic-natural rule-removal step exists: neither full/extended nor either Lemma-3.18 relative-top entry point. | `C3 V2 I3 N2 R2` | [Theorem note](routes/A_yah_two_state_scalar_arctic_full_no_start.md), [full checker](../verification/yah_two_state_scalar_arctic_full_no_start.py), [top checker](../verification/yah_scalar_arctic_top/verify_top_certificates.py), artifact commit `b75ffec58ae20ac26271ff7d59a71d3591467994`. | Does not cover dimension at least two, other carriers, transformations beyond those top shortcuts, or local systems. |
| `A-YAH-2STATE-AN1-001` | On the exact global 22-rule labeling, the 49-mass cancellation excludes every first full/extended scalar step; 491 integer Farkas lemmas and 426 RUP clauses exclude the six original boundary and four reversed-dynamic top targets. | `C3 V2 I3 N2 R2` | Same [theorem note](routes/A_yah_two_state_scalar_arctic_full_no_start.md), [full checker](../verification/yah_two_state_scalar_arctic_full_no_start.py), [top checker/payload](../verification/yah_scalar_arctic_top/verify_top_certificates.py), artifact commit `b75ffec58ae20ac26271ff7d59a71d3591467994`. | The labeled top result is a syntactic interpretation no-go, not a separately proved semantic-label top-reflection theorem; richer methods remain open. |

### Disproof lane and bounded diagnostics

| ID | Exact scope | Grades | Evidence / provenance | Limitation |
|---|---|---|---|---|
| `E-DP-MAXC` | For each fixed `(k,q)`, max-`C` residue merging is complete. The run with `k<=40` and `0<D<=250000` exhausts 91 pairs, retains at most 47,517 states, finds 9 trivial encodings and 0 nontrivial candidates. | `C3 V2 I0 N1 R1` | [Audit](disproof/CODEX_DISPROOF_CYCLE_DP_AUDIT_2026-08-24.md), [script](../verification/disproof_cycle_search.py), [output](../verification/disproof_cycle_search_output_2026-08-24.txt), commit `4e883e4deaa881b843f26473692c5483a220d91d`. | Bounded exact negative result only; far weaker than known global cycle exclusions. |
| `E-TWOPUMP-DEP` | Exact coefficient identities `aB=cC`, `gA=dE` force the cyclic two-pump resultant to vanish identically. | `C3 V3 I2 N1 R1` | [Audit](disproof/CODEX_TWO_PUMP_DEPENDENCY_AUDIT_2026-08-24.md), [Lean](../lean/CollatzWork/Disproof/TwoPumpDependency.lean), commit `974dbcb58ea40cf9365689a27de4df3ceafa0b75`. | Kills cyclic-rotation-only elimination; supplies no cycle or disproof. |
| `B-EXAMPLE` | `U^9(64x+15)=U(54x+13)` is an exact uniformly smaller coalescence example. | `C3 V2 I1 N1 R1` | Route-B note and checker, commit `4dc711439598933dc79cd00ecabff163df964621`. | Pedagogical example, not a covering certificate. |
| `B-SWEEPS` | The reported `1903/145`, `1904/144`, `15582/802`, and survivor-signature counts are exact only for their separately named finite certificate classes/ranges. | `C3 V2 I0 N1 R1` | Scripts and retained outputs under [verification](../verification/README.md). | Percentages and bounded misses are not evidence for or against Collatz. |

### Provisional conditional artifacts — not promoted as proof or disproof

| ID | Exact conditional scope | Grades | Evidence / provenance | Unresolved gate |
|---|---|---|---|---|
| `C-TM-MAHLER-ANCHOR-001` | The displayed Thue--Morse valuation code defines a specific odd `2`-adic anchor with an exact product identity; **if** that anchor is a positive ordinary integer, its accelerated orbit is exact and diverges at the displayed exponential lower rate. | `C0 V1 I0 N? R0` (candidate excluded; conditional identity retained) | [Conditional anchor note](disproof/CODEX_TM_MAHLER_ANCHOR_2026-08-24.md), artifact commit `6c8f77ef2b0b360f8f353f4508dcfec58e980331`. | The exact positive realization is now excluded by [F-TM-POSITIVE-EXCLUSION-001](disproof/TM_Prefix_Return_Exclusion_2026-09-05.md). Preserve this as a historical conditional identity, not a live membership target or a disproof. |

## Superseded, rejected, or quarantined statements

These items are `C0/R0` and must not be promoted.

| Statement | Exact disposition | Replacement |
|---|---|---|
| “Strict leading-coefficient decrease is necessary,” and therefore every successful inverse word has depth at most `t-1`. | False. Equal slope plus smaller intercept can coalesce; `8x+5` and `8x+4` are the regression. | Corrected L5 with total bound `|w|<=t`. |
| Arbitrary-first-representative residue DP proves no nontrivial candidate in the searched region. | Incomplete because the quotient/exact `C` was discarded when residue states merged. | Max-`C` DP at `4e883e4deaa881b843f26473692c5483a220d91d`. |
| L11 hard inheritance automatically renews L9–L10 at each endpoint. | False; minimality is relative to the fixed root. | F019 rooted three-way split. |
| “Complete hard child” without a time/certificate-class qualifier. | Overbroad. | `L13-HARD` only through `t<=L+2` followed by a uniformly admissible unrefined L4 inverse word. |
| A finite bounded direct-descent cover might prove Collatz. | False for all odd `n>1` when horizons are uniformly bounded. | `A-ARB/A-CYL`; ranked recursion remains logically open. |
| The scalar YAH no-go rules out matrix interpretations generally or proves YAH termination. | False promotion. | It closes only the standard dimension-one arctic-natural first step: full/extended and the two Lemma-3.18 top entry points. Higher-dimensional, different-carrier/label, transformed, non-coefficientwise, and local methods remain open. |
| The hard return map is a new descent theorem. | False promotion. | It is an exact Collatz-equivalent reformulation with a recharge witness. |
| The L14 terminal set exhausts finite trajectory-preserving rewrites or local affine normal forms. | False. For every `s>=0`, `U^3(64s+55)=54s+47<64s+55`; L13 also coalesces `23` with `17`. | L14 is exact only relative to its displayed `(a,c)` reducer. Other refinements remain possible, but no global residual rank is known. |
| Cyclic rotation supplies an independent two-pump resultant. | False: the resultant is identically zero. | `E-TWOPUMP-DEP`. |
| `1903/145` and `1904/144` are contradictory reruns. | False: they refer to different ordinary/accelerated/certificate classes. | Always name the script, map convention, depth, and class. |
| `409cb63b69b5fb6af676166573e752f1f4a5ff38` is a valid provenance hash. | False; no such object is accepted. | `409cb63d6805b00b3dcd96576ac172c58b16384e`. |

The longer do-not-repeat explanations are in [FAILURE_LEDGER.md](FAILURE_LEDGER.md).

## Primary-source novelty audit

The classifications above were checked against primary sources. The main
conclusions are:

- The exact mixed-base rewrite system, its Collatz equivalence, and the use of
  natural/arctic matrix interpretations are published by Yolcu, Aaronson, and
  Heule: [paper](https://doi.org/10.1007/s10817-022-09658-8),
  [official artifact](https://github.com/emreyolcu/rewriting-collatz).
- Semantic labeling is a classical termination transformation due to Zantema:
  [paper](https://doi.org/10.3233/FI-1995-24124). No exact published match was
  located for the repository's 13-, 8-, 11-, 22-, 50-, or top-certificate YAH
  cancellations. That
  makes them `N2`, not certified novel. YAH itself identifies nonexistence of
  suitable matrix interpretations for its mixed-base system as an interesting
  possible result; the new theorem establishes only the dimension-one
  arctic-natural first-step subcase, including its two special top entry
  points.
- Parity-residue and affine-word mechanics are classical; see Terras
  ([1976](https://www.impan.pl/en/publishing-house/journals-and-series/acta-arithmetica/all/30/3/101028/a-stopping-time-problem-on-the-positive-integers)),
  Everett ([1977](https://doi.org/10.1016/0001-8708(77)90087-1)), and Lagarias
  ([1985](https://doi.org/10.1080/00029890.1985.11971528)).
- The Mersenne staircase/coalescence mechanism is prior art. See
  Andrei–Masalagiu ([1998](https://doi.org/10.1007/s002360050117)),
  Andrei–Kudlek–Niculescu
  ([2000](https://doi.org/10.1007/s002360000039)), and Hercher's Lemma 9
  ([2023](https://cs.uwaterloo.ca/journals/JIS/VOL26/Hercher/hercher5.html)).
  Therefore `L13-EASY` is `N0`; its exact notation and Lean packaging do not
  create mathematical priority.
- Monks proved every nonconstant arithmetic progression sufficient
  ([2006](https://doi.org/10.1090/S0002-9939-06-08567-4)). Since
  `7+8*N_0` is one component of the L14 terminal set, the consequence that
  convergence on that terminal set suffices for Collatz is known in stronger
  form. The exact decreasing two-branch packaging was not located in the
  bounded audit, but is elementary repackaging and is graded `N1`, not novel.
- Fixed parity-word cycle equations are classical in Böhm–Sontacchi
  ([1978](https://www.bdim.eu/item?id=RLINA_1978_8_64_3_260_0)) and Crandall
  ([1978](https://doi.org/10.1090/S0025-5718-1978-0480321-3)). Word powers and
  cyclic algebra are developed by Trümper
  ([2014](https://doi.org/10.1155/2014/756917)). The two-pump syzygy is an
  elementary route obstruction, not a certified new cycle theorem.
- Stronger published cycle/computational bounds include Hercher's exclusion of
  `m<=91` local-minimum cycles and Bařina's verified convergence range
  ([2025](https://doi.org/10.1007/s11227-025-07337-0)). The project DP is
  reproducible software engineering, not a competitive global bound.
- Wang's E-sequence construction and Kramer's endpoint representatives supply
  closely related finite-prefix, backward-integrality, and endpoint-rate
  machinery. The bounded-alphabet converse/full-rate dichotomy was not located
  in the bounded audit, so it is `N2`, not a certified priority claim. The
  direct-return, inverse-word, correction-prime, and finite-CRT packages are
  elementary specializations and are graded `N1`.
- The Thue--Morse anchor historical calculation has not received a sufficient priority audit and is
  not promoted. Its proposed positive-integer membership is now excluded by `F-TM-POSITIVE-EXCLUSION-001`; the historical conditional calculation is not a disproof.

For Round 6A, the bounded search inspected classical rational-cycle/parity
machinery, including Lagarias's rational-cycle work, but found no exact
beta-debt formulation. This is still not a priority certification; the result
may be folklore or an immediate corollary.

## Reproduction and formal boundary

See [verification/README.md](../verification/README.md) for portable commands,
tested versions, expected outputs, and which claims are only bounded
computations. See [LEAN_TARGETS.md](../LEAN_TARGETS.md) for the twelve existing
Lean proof modules and the unformalized theorem chain.

## Reviewed additions from the 2026-09-05 pass

Input commit: `343ddb2cbfadb91af65328f2614c572dc91a2d69`.
These rows extend the older baseline without promoting Collatz or certifying novelty.

| ID | Exact scope | Grades | Evidence | Limitation |
|---|---|---|---|---|
| `L15-QUARTER-GAP` | Every existing non-descending first coefficient contraction with odd count s has `4d<s`. | `C3 V3 I2 N1 R1` | [Trusted statement and complete kernel proof](../verification/Quarter_Gap_Formal_Scope_2026-09-05.md), exact independent reconstruction. | No stopping-finiteness, renewal or cycle exclusion. The separate 1024-block frontier refinement remains prose/exact Python. |
| `AB-FROZEN-DEBT-001` | Explicit two-return family freezes label/debt while size grows; rules out lower-bounded label-dependent polynomials in z, bitlength, D, R, and finite lex tuples with coordinatewise lower bounds. | `C2 V2 I3 N1 R1` | [Proof](routes/AB_frozen_debt_size_rank_no_go.md), [checker](../verification/hard_return_frozen_debt_check.py), independent mixed-polynomial review. | Does not exclude every nonlinear/nonpolynomial/additional-state rank; not Lean-formalized. |
| `L0-COALESCENCE-LEAN` | For the exact shortcut map, all-positive convergence is equivalent to universal smaller coalescence and all-start descent; local compatible-child induction is justified. | `C3 V3 I2 N0 R1` | [Trusted definitions](../lean/CollatzWork/ConvergenceStatement.lean), [proof](../lean/CollatzWork/Convergence.lean), [CI log](../verification/lean_convergence_ci_2026-09-05.txt). | Universal premises remain unproved; the original odd-only L0 prose statement is not silently relabeled as fully formalized. |

See [the research pass](../ASTRA_RESEARCH_PASS_2026-09-05.md) for process and
inference audits. No entry is externally peer-reviewed or resolution-level.


### Second closure-attempt delta

| ID | Exact scope | Grades | Evidence | Limitation |
|---|---|---|---|---|
| `AB-3ADIC-RESET-001` | Raw hard return resets `v3(Y+1)` to 1; a two-edge family freezes `(L,e,b,D,R)` while cofactor grows, excluding the stated lower-bounded polynomial/cofactor finite-lex ranks. | `C2 V2 I2 N1 R1` | [Proof](routes/AB_three_adic_rank_no_go.md), [checker](../verification/three_adic_hard_return_check.py). | Additional-state/nonpolynomial/coalescence mechanisms remain available; not Lean-formalized. |
| `SOURCE-WMH-COLLAPSE-001` | Chang v6's summable projected-TV condition forces every fixed-depth discrepancy to zero and is equivalent to its displayed existential-depth OEC. | `C2 V2 I2 N0 R1` | [Definitions and proof](sources/Primary_Bridge_Audit_2026-09-05.md); separate cold reconstruction. | Audits exact source quantifiers; no positive-integer convergence theorem. |
| `SOURCE-NONHAAR-001` | Explicit Bernoulli valuation coding gives a non-atomic non-Haar Syracuse-invariant probability measure. | `C2 V2 I2 N0 R1` | [Construction](sources/Primary_Bridge_Audit_2026-09-05.md), finite inverse-branch checks, separate cold reconstruction. | 2-adic support; no divergent positive integer. Refutes asserted uniqueness conclusion, not every conditional spectral statement. |

`A-YAH-NAT2-B2-EXP` is a bounded solver experiment, not a promoted universal
theorem: [exact encoding and outcomes](../verification/yah_natural_matrix_2d/README.md).
The Dhiman–Pandey encoding limitation does not prohibit Route B's finite
ranked graph; the [source audit](sources/Primary_Bridge_Audit_2026-09-05.md)
supplies an explicit separating example.


## Third continuation: verified arithmetic and scoped return mechanisms

| ID | Exact scope | Grades | Evidence / limitation |
|---|---|---|---|
| `L9-INTEGER-LEAN` | Actual-orbit affine identity, universal mechanical upper bound and exact first coefficient-crossing time. | `C3 V3 I2 N0 R1` | [Formal scope](../verification/Quarter_Gap_Formal_Scope_2026-09-05.md). Does not include all L9 extremizer/displacement claims. |
| `L15-SIXTEEN-ENVELOPE` | `4*Cmax(s)<=s*3^s` for every s>=16, with exact failure at15 establishing the sharp eventual threshold. | `C3 V3 I2 N1 R1` | [Universal proof](../lean/CollatzWork/QuarterGapUniversal.lean); no priority claim or global-convergence consequence. |
| `AB-FINITE-RESIDUE-001` | For every fixed modulus, expanding original-F paths freeze all stated endpoint data; excludes the specified polynomial/finite-lex ranks. | `C2 V2 I2 N1 R1` | [Proof](routes/AB_finite_residue_original_return_no_go.md). Applies to ranks on every original F edge, not arbitrary smaller-target strategies. |
| `AB-CORE-RESIDUE-OBSTRUCTION-001` | Explicit expanding core and residue-20 return families freeze arbitrary fixed residue refinements; specified polynomial ranks fail. | `C2 V2 I2 N1 R1` | [Proof and exact smaller-target escapes](routes/AB_ternary_normalized_core_residue_obstruction.md). Further target selection removes these witnesses; no all-certificates claim. |
| `B-MOD27-RANK-001` | A finite lexicographic rank stops every positive shortcut orbit at1,2,or20 mod27. | `C2 V2 I2 N0 R1` | [Explicit rank](sources/Sufficiency_Rank_Audit_2026-09-05.md), known Monks theorem reconstructed; no rank across20 returns. |
| `AB-COMPOSITION-LOOP-001` | First return followed by decreasing inverse coalescence can loop:425 ->638 ->319 ->479 ->c425. | `C2 V2 I2 N0 R1` | [Exact cycle in the auxiliary system and clock audit](routes/AB_ternary_normalized_core_residue_obstruction.md). Final edge is inverse coalescence; this is not a Collatz cycle. |

The [third-pass report](../ASTRA_CONTINUATION_2026-09-05.md) records proof
scope, source roles, successful CI and explicit reopening conditions.


## Fourth continuation: constructive root-relative families

| ID | Exact scope | Grades | Evidence / limitation |
|---|---|---|---|
| `AB-ROOT-BURST-DESCENT-001` | Arbitrarily long actual OOE bursts followed by k even steps descend below the original start under 2^k m+5=9^k u, with k,u,m>0. | `C3 V3 I2 N1 R1` | [Trusted Lean statements and proof](../LEAN_TARGETS.md). The guard is not universal; the additional residue20 CRT specialization remains prose/V2. |
| `AB-ROOT-ANCESTOR-SEMANTICS-001` | q>0 and 3^(L+1)q=4r+1 give the exact ancestor orbit identity T^(e+L+2)(2^e(2^Lq−1))=r. | `C3 V3 I1 N0 R1` | [Formal boundary](../LEAN_TARGETS.md). No smaller-target, residue or all-root coverage conclusion in this declaration. |
| `B-RESIDUE20-VALUATION-ANCESTOR-2026-09-05` | Every positive r=20 mod27 with v3(4r+1)≥21 has an explicit smaller ancestor in that residue class, via the prescribed six-row selector. | `C2 V2 I2 N1 R1` | [Uniform proof](lemmas/Residue20_Valuation_Ancestor.md), independent forward replay; improved by the next row. Selector and inequalities not Lean-formalized. |
| `B-RESIDUE20-VALUATION13-ANCESTOR-2026-09-05` | Every natural r with 3^13 dividing 4r+1 has a positive smaller ancestor m=20 mod27 whose actual forward orbit reaches r. | `C3 V3 I2 N1 R1` | [Complete kernel-checked public theorem](../LEAN_TARGETS.md), [exact CI evidence](../verification/residue_ancestor_ci_2026-09-05.txt). All factorization/selector/size/orbit bridges are proved. Individually sharper lower rows in the prose note retain C2/V2 scope; no global return control. |
| `AC-SHADOW-DEBT-RECHARGE-001` | A growing three-edge stronger-core path resets q=v2(n+5) from10 through7,4 back to10 while freezing the stated endpoint labels; the specified lower-bounded polynomial/finite-lex ranks fail. | `C2 V2 I2 N1 R1` | [Exact family and scoped no-go](routes/AC_shadow_debt_recharge.md). No arbitrary additional-modulus or all-certificate exclusion. |

These are repository-level elementary specializations, not priority claims. Universal termination remains unproved; none has external specialist or peer-reviewed verification.


## Fifth continuation: escape through actual recharge

| ID | Exact scope | Grades | Evidence / limitation |
|---|---|---|---|
| `AC-TWO-BURST-RECHARGE-ESCAPE-001` | For positive k,l,u,v,m satisfying 9^k*u+1=2^(3l+1)*v and 2^(k+l)*m+5=3*9^l*v, T^(4(k+l)+2)(2*8^k*u−5)=m<2*8^k*u−5. The general guarded two-burst excursion and convergence transfer compare to the unchanged root. | `C3 V3 I2 N1 R1` | [Trusted statement](../lean/CollatzWork/TwoBurstStatement.lean), [kernel proof](../lean/CollatzWork/TwoBurst.lean), [accepted CI/axioms](../verification/two_burst_ci_2026-09-05.txt). The guards are explicit assumptions, not universal coverage. CRT, exact-valuation interpretation and extra even padding remain separate prose results. |
| `AC-TWO-BURST-CRT-001` | An explicit residue20 CRT slice realizes two growing bursts with unbounded larger recharge; bounded extra even padding supplies guarded examples at every q=3k+1, k≥1. | `C2 V2 I2 N1 R1` | [Algebraic specializations and controls](lemmas/Two_Burst_Recharge_Escape.md), independent actual-orbit replay. Complete CRT and padding formalizations remain pending; no all-unit or universal escape assertion. |
| `AC-Q2-EXIT-DESCENT-2026-09-05` | For k≥0,e≥max(2,k+1),u≥1 with 2^(e+1) dividing 27*9^k*u−29, the exact word (OOE)^k OOO E^e descends below 4*8^k*u−5. CRT supplies infinite residue20 families at every q=3k+2, outside the previous selected ancestors. | `C2 V2 I2 N1 R1` | [Uniform proof](lemmas/Q2_Exit_Descent.md) and actual replay. First-return growth requires k≥1; k0 handled separately. Guard not universal; not Lean-formalized. |
| `B-SECOND-TERNARY-ANCESTOR-001` | Every positive residue20 root with v3(128r−157)≥17 has an explicit smaller residue20 ancestor; two additional fixed cylinders and an exact first-return transition are included with separate scopes. | `C2 V2 I2 N1 R1` | [New-prefix proof and boundaries](lemmas/Complementary_Ancestor_Cylinders.md), actual inverse/forward replay. Uniform family lies wholly in v3(r+7)=4,v3(4r+1)=3. Old finite tails are reused; the new prefix/selector is not Lean-formalized. |

The q5 cylinder `22619+186624s` is a precise remaining transition target, not a claimed escape theorem or an irreducibility result. These elementary specializations carry no external priority claim. Global verdict remains unresolved.


## Sixth continuation: exact local clock and simultaneous cover obstruction

| ID | Exact scope | Grades | Evidence / limitation |
|---|---|---|---|
| `AC-GROWING-FIRST-RETURN-SPELL-001` | Every residue20 root with q=v2(r+5)≥4 has exactly floor(v2(11r+23)/4) consecutive OOEO first returns, terminating at q in {0,1,2,3}. Every positive-time state during the spell exceeds the original root. The q5 target realizes every exit and arbitrarily long spells. | `C2 V2 I2 N1 R1` | [Uniform proof and exact CRT](lemmas/Finite_Growing_First_Return_Spells.md), independent actual-orbit replay. This clock is local to the itinerary; neither subsequent descent nor a rank across re-entry is proved. Aggregate theorem is prose/Python, not Lean. |
| `B-S20-ANCESTOR-DEPTH-OBSTRUCTION-001` | For every independent pair of finite bounds on direct forward descent and smaller residue20 ancestor time, infinitely many roots in the exact q5 cylinder 22619+186624s fail both certificates. Anchor20 and anchor47 lifts separately exclude bounded ancestor covers. | `C2 V2 I2 N1 R1` | [Anchor-transfer proof and simultaneous CRT](lemmas/Bounded_Ancestor_Depth_Obstruction.md), independent inverse-tree and forward replay. Covers either of those two exact bounded relations; unbounded valuation macros and general mixed coalescence remain available. Not Lean-formalized. |

Both proofs were reconstructed internally and exercised with explicit-failure checkers in normal and optimized Python. These grades concern their scoped statements; external novelty and specialist review remain unaudited. No universal termination, total return rank, or infinite positive counterexample follows.


### Postspell extension: independently unbounded growth with guarded compensation

| ID | Exact scope | Grades | Evidence / limitation |
|---|---|---|---|
| `AC-POSTSPELL-GUARDED-ROOT-DESCENT-001` | Every actual word (OOEO)^J O^H E^e with r>3, J≥2, H≥3 and e≥J+H ends at a positive m<r. For each independent J,H, explicit CRT supplies infinite roots in 22619+186624s with e=2 mod18 and J+H≤e<J+H+18, whose targets are20 mod27. | `C2 V2 I2 N1 R1` | [Uniform margin, parity recursion and CRT proof](lemmas/Postspell_Guarded_Root_Descent.md), independent reconstruction and actual-map replay. The final-halving guard is substantive; arbitrary-source coverage and complete Lean formalization remain open. |
| `AC-POSTSPELL-ODD-RUN-OBSTRUCTION-001` | At every fixed OOEO spell length J≥2 and q2 exit, the following exact odd-run length H≥3 is independently unbounded on explicit infinite q5 subfamilies. All4J+H states exceed the original root; bounded smaller-ancestor exclusion can be imposed simultaneously. | `C2 V2 I2 N1 R1` | [Exact construction and overshoot proof](lemmas/Postspell_Odd_Run_Obstruction.md), forward replay and optional inverse-tree controls. Excludes a discharge bound depending only on J and q2, not one tracking H/full root or a guarded exit theorem. Not Lean-formalized. |

The positive family repays both growing phases relative to the original root. The negative family shows why its exit guard cannot be omitted. Neither proves every root meets that guard, and universal termination remains unresolved.


## Unique integrated contributions from PR12

| ID | Exact scope | Grades | Evidence / provenance | Limitation |
|---|---|---|---|---|
| `F-BRANCH-CENTER-001` | In the exact two-rational-center graph with positive single-step edges `A-a->A`, `A-b->B`, `B-c->A`, center consistency forces `a=b=c` and the two centers to coincide; fixed-denominator synchronization leaves only zero displacement. | `C2 V2 I1 N1 R1` | [Shot](disproof/CODEX_BRANCHING_CENTER_SHOT_2026-08-24.md), [hostile audit](disproof/CODEX_BRANCHING_CENTER_HOSTILE_AUDIT_2026-08-24.md), [Lean arithmetic core](../lean/CollatzWork/Disproof/BranchingCenter.lean). | Kills only this two-center/three-single-edge architecture. Larger graphs, moving or nonrational centers, and nonsynchronized invariant sets remain open; no disproof. |
| `F-FINITE-RESIDUE-FIRST-INTEGRAL-001` | Every memoryless coloring of one finite residue ring that is invariant under every positive step of the full Collatz map is constant. | `C2 V2 I2 N1 R1` | [Shot](disproof/CODEX_FINITE_RESIDUE_FIRST_INTEGRAL_SHOT_2026-08-24.md), [hostile audit](disproof/CODEX_FINITE_RESIDUE_FIRST_INTEGRAL_HOSTILE_AUDIT_2026-08-24.md), [Lean group-action core](../lean/CollatzWork/Disproof/FiniteResidueFirstIntegral.lean). | Does not exclude automata with memory, traps, recursive ranked residue graphs, changing moduli, or Collatz. |
| `F-POLY-RATCHET-001` | For the stated normalized class of primitive positive-degree integer state polynomials transported around a fixed finite cycle of genuine affine macros, integral polynomial divisibility collapses to scalar eigenidentities; normalized content gain at a base coprime to `3` is impossible, while the `p=3` survivor is fixed-point displacement. | `C2 V2 I2 N1 R1` | [Standalone theorem packet](disproof/CODEX_F_POLY_RATCHET_SHOT_2026-08-24.md), [hostile audit](disproof/CODEX_F_POLY_RATCHET_HOSTILE_AUDIT_2026-08-24.md), [Lean arithmetic core](../lean/CollatzWork/Disproof/PolynomialRatchet.lean). | Kills only the canonically normalized polynomial-eigen/divisibility subclass. It does not exclude nonlinear or component-coupled ratchets generally and supplies no witness. |
| `F-SMOOTH-RATIO-SEMICONJ-001` | A positive accelerated Collatz orbit whose successive-state ratio converges to a finite real limit eventually reaches the fixed orbit `1`; in particular no unbounded positive accelerated orbit has a convergent ratio. | `C2 V1 I1 N1 R1` | [Exact route packet and hostile reconstruction](disproof/CODEX_SMOOTH_RATIO_SEMICONJUGACY_SHOT_2026-08-24.md). | Kills pointwise ratio-convergent termwise generators only. Oscillatory ratios and growing valuation complexity remain open; no novelty claim or disproof. |



## Unique integrated contributions from PR20

| ID | Exact scope | Grades | Evidence / limitation |
|---|---|---|---|
| `FINITE-PARITY-COLLISION-001` | Equal first k parity bits of actual shortcut orbits imply equal residues modulo `2^k`; distinct starts differ by at least `2^k`. | `C3 V3 I2 N1 R1` | [Trusted statement and proof](../lean/CollatzWork/PrefixCollision.lean), [verification](../verification/Blind_Recurrence_Verification_2026-09-05.md). Elementary parity arithmetic; no infinite recurrence claim. |
| `AFFINE-REPETITION-BOUND-001` | Coprime fixed affine recurrences with positive shifted initial height satisfy the stated denominator-power budget; `2*32^d<27^d*(n+1)` implies `10d+27<27n`. | `C3 V3 I2 N1 R1` | [Formal proof](../lean/CollatzWork/AffineRepetition.lean). Numerical return bound is conditional; changing blocks do not share a proved budget. |
| `F-TM-POSITIVE-EXCLUSION-001` | Any positive realization of a nonerasing fixed binary Thue–Morse valuation encoding lies on a cycle. The specific `(1),(2)` anchor and fixed `(1^p,3)/(1^q,3)` encodings, p,q≥3, have no positive realization. | `C2 V1 I2 N? R1`; finite supporting checks `V2` | [Complete analytic proof](disproof/TM_Prefix_Return_Exclusion_2026-09-05.md). Supersedes PR6 anchor's pending positive-membership gate. Full coding/odd-word argument is not Lean-checked; no exclusion of arbitrary aperiodic words or nontrivial cycles. |
