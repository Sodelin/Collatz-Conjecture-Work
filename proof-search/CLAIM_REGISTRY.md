# Atomic claim and evidence registry

**Canonical baseline:**
`b75ffec58ae20ac26271ff7d59a71d3591467994` (2026-08-24).

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

| ID | Exact scoped claim | Grades | Why review it now | Primary missing evidence |
|---|---|---|---|---|
| `A-YAH-AN1-001` | The original eleven-rule YAH system admits no first standard dimension-one arctic-natural step, either full/extended or through the boundary/dynamic relative-top opportunities of YAH Lemma 3.18. | `C3 V2 I3 N2 R2` | Directly closes the scalar first-step slice of a method class central to the published YAH program. | External term-rewriting reconstruction; proof-assistant formalization; broader literature audit. |
| `A-YAH-2STATE-AN1-001` | The global 22-rule two-state labeling admits no first full/extended scalar arctic-natural step and none of the ten corresponding boundary/reversed-dynamic top targets is feasible. | `C3 V2 I3 N2 R2` | Exact 49-mass, Farkas, and RUP certificates over the unbounded coefficient domain. | External term-rewriting reconstruction; proof-assistant formalization; broader literature audit. |
| `A-YAH-2STATE-001` | In the fixed two-state suffix algebra, positive-integer cancellations exclude additive labeled-symbol and labeled-adjacent-edge orders, including every finite lexicographic tuple. | `C3 V2 I3 N2 R2` | Strongest potentially new exact finite certificate in the archive. | Independent term-rewriting specialist reconstruction; formal certificate; broader literature audit. |
| `A-YAH-2LOCAL-001` | A 13-row cancellation excludes bounded-below scalar adjacent-pair additive potentials on the stated canonical YAH contexts. | `C3 V2 I3 N2 R2` | Compact, reproducible route-class no-go. | Independent specialist reconstruction and exact placement among standard interpretation classes. |
| `6A-T1` | Under the stated fast-descent and repelling rational-period lift hypotheses, last-minimum density and same-phase correction debt obey the explicit asymptotic lower bounds. | `C2 V1 I3 N2 R2` | Strongest conceptual theorem candidate in the older corrected-log branch. | Positive-lift/endpoint/scaling reconstruction, Lean, and specialist review. The Python checker is diagnostic only. |
| `L13-RANK` | Same-label replay debt decreases exactly, but guarded cross-label successors recharge it arbitrarily; one exact edge refutes every lower-bounded affine combination in the stated label-depth/bitlength/debt class. | `C2 V1 I3 N2 R1` | Precisely stops the current simple-rank version of Route AB. | Lean or independent formal derivation; broader prior-art audit. |
| `L8-BARRIER` | Conditional on the named verified-range and Rozier–Terracol inputs, an exact Farey certificate forces coefficient stopping time at least `114,208,327,604`. | `C2 V2 I2 N2 R1` | Strong exact necessary-condition corollary with retained arithmetic certificate. | Import/formalize the external inputs and the local theorem chain. |

No entry is ready to submit as a Collatz proof or disproof. The YAH rows are
the best candidates for a narrow technical note after external review; Round
6A is the best theorem-level reconstruction target in the older branch.

## Complete promoted-claim inventory

### Endpoint and corrected-log branch

| ID | Exact scope | Grades | Evidence / provenance | Limitation |
|---|---|---|---|---|
| `G0` | The archive contains no accepted universal proof, positive nontrivial cycle, or rigorously divergent positive orbit. | `N/A` (archive status) | [Public status](../PUBLIC_STATUS_2026-08-24.md); accepted mathematical baseline `b75ffec58ae20ac26271ff7d59a71d3591467994`. | This is the status of the open problem and archive, not a graded project theorem. |
| `L0` | For the accelerated odd map, every odd `n>1` having a smaller iterate is equivalent to Collatz; a least counterexample cannot descend below itself. | `C3 V1 I3 N0 R1` | [L0](lemmas/L0_Global_Descent_Equivalence.md), commit `2456248bcb5f1c769d2ffdb369e8f63dfcd3a3be`. | Elementary equivalent reformulation; Lean pending; no progress without a descent mechanism. |
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
| `AB-BRIDGE` | Round-7 affine cylinders are an affine projection of the YAH mixed-base branch semantics; macro coalescence is a distinct certificate idea. | `C2 V1 I2 N1 R1` | [Representation bridge](routes/AB_mixed_radix_coalescence_bridge.md), commit `c7948930b1bf997c0ed0a9f857c5e0e6b2a71810`. | The certificate graph/rank is conjectural; Route AB is `BLOCKED_NO_MECHANISM`. |
| `AB-HARD-RETURN-001` | A total decreasing normalizer sends every positive input to `1` or the hard family; the induced return map is Collatz-equivalent. The smallest reported growth-plus-recharge witness is `31 -> 182 -> 91`. | `C2 V1 I3 N1 R1` | [Hard return system](routes/AB_hard_boundary_return_system.md), commit `8a93ea5e8377f16be5b54f5fe0de9f8d9a85b3a9`. | Compression/equivalence, not termination progress; “smallest” lacks a committed exhaustive transcript. |
| `A-YAH-2LOCAL-001` | The 13-row cancellation excludes bounded-below scalar adjacent-edge additive potentials in the stated canonical contexts. | `C3 V2 I3 N2 R2` | [Certificate note](routes/A_yah_2local_edge_potential_no_go.md), [checker](../verification/yah_2local_edge_no_go.py), commit `d1bc062c727041ed8e106478983e3b7281f33dae`. | Does not exclude labels, matrices, longer windows, or nonadditive orders. |
| `A-YAH-2STATE-001` | The fixed two-state suffix labeling cannot support the stated additive labeled-symbol orders; in fixed-terminal canonical contexts, labeled-edge scalar/finite-lex orders cannot make a first uniform rule-removal step. | `C3 V2 I3 N2 R2` | [Certificate note](routes/A_yah_two_state_semantic_label_no_go.md), [checker](../verification/yah_two_state_semantic_label_no_go.py), base commit `8a93ea5e8377f16be5b54f5fe0de9f8d9a85b3a9`, strengthened at `f8558a566b682e8dbc4465206f9c26ac9b17760c`. | One semantic algebra and additive locality class; adjacent-window potentials are not automatically YAH compositional interpretations. |
| `A-YAH-AN1-001` | On the original eleven-rule system, no first standard dimension-one arctic-natural rule-removal step exists: neither full/extended nor either Lemma-3.18 relative-top entry point. | `C3 V2 I3 N2 R2` | [Theorem note](routes/A_yah_two_state_scalar_arctic_full_no_start.md), [full checker](../verification/yah_two_state_scalar_arctic_full_no_start.py), [top checker](../verification/yah_scalar_arctic_top/verify_top_certificates.py), artifact commit `b75ffec58ae20ac26271ff7d59a71d3591467994`. | Does not cover dimension at least two, other carriers, transformations beyond those top shortcuts, or local systems. |
| `A-YAH-2STATE-AN1-001` | On the exact global 22-rule labeling, the 49-mass cancellation excludes every first full/extended scalar step; 491 integer Farkas lemmas and 426 RUP clauses exclude the six original boundary and four reversed-dynamic top targets. | `C3 V2 I3 N2 R2` | Same [theorem note](routes/A_yah_two_state_scalar_arctic_full_no_start.md), [full checker](../verification/yah_two_state_scalar_arctic_full_no_start.py), [top checker/payload](../verification/yah_scalar_arctic_top/verify_top_certificates.py), artifact commit `b75ffec58ae20ac26271ff7d59a71d3591467994`. | The labeled top result is a syntactic interpretation no-go, not a separately proved semantic-label top-reflection theorem; richer methods remain open. |

### Disproof lane and bounded diagnostics

| ID | Exact scope | Grades | Evidence / provenance | Limitation |
|---|---|---|---|---|
| `E-DP-MAXC` | For each fixed `(k,q)`, max-`C` residue merging is complete. The run with `k<=40` and `0<D<=250000` exhausts 91 pairs, retains at most 47,517 states, finds 9 trivial encodings and 0 nontrivial candidates. | `C3 V2 I0 N1 R1` | [Audit](disproof/CODEX_DISPROOF_CYCLE_DP_AUDIT_2026-08-24.md), [script](../verification/disproof_cycle_search.py), [output](../verification/disproof_cycle_search_output_2026-08-24.txt), commit `4e883e4deaa881b843f26473692c5483a220d91d`. | Bounded exact negative result only; far weaker than known global cycle exclusions. |
| `E-TWOPUMP-DEP` | Exact coefficient identities `aB=cC`, `gA=dE` force the cyclic two-pump resultant to vanish identically. | `C3 V3 I2 N1 R1` | [Audit](disproof/CODEX_TWO_PUMP_DEPENDENCY_AUDIT_2026-08-24.md), [Lean](../lean/CollatzWork/Disproof/TwoPumpDependency.lean), commit `974dbcb58ea40cf9365689a27de4df3ceafa0b75`. | Kills cyclic-rotation-only elimination; supplies no cycle or disproof. |
| `B-EXAMPLE` | `U^9(64x+15)=U(54x+13)` is an exact uniformly smaller coalescence example. | `C3 V2 I1 N1 R1` | Route-B note and checker, commit `4dc711439598933dc79cd00ecabff163df964621`. | Pedagogical example, not a covering certificate. |
| `B-SWEEPS` | The reported `1903/145`, `1904/144`, `15582/802`, and survivor-signature counts are exact only for their separately named finite certificate classes/ranges. | `C3 V2 I0 N1 R1` | Scripts and retained outputs under [verification](../verification/README.md). | Percentages and bounded misses are not evidence for or against Collatz. |

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

For Round 6A, the bounded search inspected classical rational-cycle/parity
machinery, including Lagarias's rational-cycle work, but found no exact
beta-debt formulation. This is still not a priority certification; the result
may be folklore or an immediate corollary.

## Reproduction and formal boundary

See [verification/README.md](../verification/README.md) for portable commands,
tested versions, expected outputs, and which claims are only bounded
computations. See [LEAN_TARGETS.md](../LEAN_TARGETS.md) for the three existing
narrow Lean modules and the unformalized theorem chain.
