# Public status — 2026-08-24

> **Historical snapshot.** Current integrated status and exact source heads are in the [2026-09-05 consolidated checkpoint](CONSOLIDATION_2026-09-05.md). Later formalizations and the exclusion of the old Thue–Morse candidate supersede corresponding pending language below.

## Verdict

**The Collatz conjecture remains unresolved.** This repository contains no
universal proof, positive nontrivial cycle, or rigorously divergent positive
orbit. It should not be presented as having solved the conjecture.

What the latest work does provide is a collection of exact, narrowly scoped
results that have survived adversarial replay. Their main value is to identify
which proposed proof and disproof mechanisms are sound, which are incomplete,
and which fail for precise reasons.

For claim-by-claim confidence, verification, importance, novelty, readiness,
scope exclusions, and immutable provenance, use the
[`proof-search/CLAIM_REGISTRY.md`](proof-search/CLAIM_REGISTRY.md). In
particular, distinguish a solved route-class obstruction from a
Collatz-equivalent reformulation and from the still-open universal claim.

For a visual path through those distinctions and every retained note, use the
[research atlas](ATLAS.md). It is a navigation layer; the registries remain
canonical for status.

## Plain-language summary

The strongest exact new auxiliary theorem concerns one infinite sequence of
accelerated powers of two, provided those powers are bounded. It constructs a
canonical endpoint residue and carry at every depth and proves that the code
comes from one positive odd integer exactly when the carries eventually vanish
(equivalently, the normalized endpoint residues tend to zero). If this fails,
positive carries recur and the endpoint representatives have the full cubic
root-growth rate. This is a precise test, not a proof that any important code
passes or fails it.

The project found a valid shortcut for one half of a carefully refined
Mersenne-like family: those inputs meet the orbit of a smaller positive integer,
so strong induction can handle that child. The other half grows under the same
macro and requires arbitrarily deep arithmetic refinement. Its successor cells
can be described exactly, but no decreasing rank covering all of them is known.

Several tempting global promotions were then ruled out:

- no finite collection of uniformly bounded direct-descent promises can cover
  all odd inputs greater than one;
- a minimal-counterexample near-return argument cannot be renewed after local
  descent, because minimality only gives a lower bound relative to the original
  root;
- simple additive termination potentials fail for the exact Collatz-equivalent
  rewrite system, and the failure persists under the audited two-state
  semantic labeling for both symbol and adjacent-edge weights;
- exact all-positive, Farkas, and RUP certificates rule out every standard
  first dimension-one arctic-natural step on the original eleven-rule YAH
  system: full/extended removal and both Lemma-3.18 top entry points. This does
  not cover higher-dimensional, different-carrier/label, transformed,
  non-coefficientwise, or local methods;
- cyclically rotating a two-pump parity-word equation gives an algebraically
  dependent condition, not a new nonzero resultant;
- natural affine combinations of hard-state label depth, parameter bit length,
  and replay debt cannot rank every hard successor.

The latest finite-route audits also show that adding more inverse words, prime
return blocks, roughness thresholds, or finite separated blocks cannot by
itself decide one fixed infinite orbit. Every finite script can have positive
realizations while the compatible infinite object is only `2`-adic. The live
bottleneck is therefore fixed-seed infinite-tail coupling, not a larger finite
search window.

These are proof-method audits, not a solution. They prevent future work from
mistaking the same gaps for a proof.

## Audited artifacts

This table is artifact-oriented and sometimes groups claims with different
verification levels. The atomic claim registry is canonical for promotion.

| Artifact | Status | What it establishes |
|---|---|---|
| [`proof-search/FAILURE_LEDGER.md`](proof-search/FAILURE_LEDGER.md) | Audited prose theorem | Exact Mersenne staircase and the impossibility of finite uniformly bounded direct-descent covers; scope limitations are explicit. |
| [`proof-search/routes/F_bounded_alphabet_endpoint_residue_gate.md`](proof-search/routes/F_bounded_alphabet_endpoint_residue_gate.md) | Audited exact auxiliary theorem plus checker | Characterizes positive realization of bounded valuation codes by eventual zero carry, endpoint-residue vanishing, and subcubic root growth. It does not decide the hard aperiodic codes or prove/disprove Collatz. |
| [`proof-search/lemmas/L14_ThreeNMinusOne_Trajectory_Normal_Form.md`](proof-search/lemmas/L14_ThreeNMinusOne_Trajectory_Normal_Form.md) | Audited prose theorem plus finite regression | Gives an exact decreasing odd-only normalizer to `1`, `7 mod 8`, or `27 mod 32`; explicitly rejects the wrong shortcut-map convention and the false claim that the terminal set exhausts other rewrites. Residual convergence remains Collatz-equivalent. |
| [`proof-search/lemmas/L15_Expanded_Rewrite_and_Mixed_Inverse_Words.md`](proof-search/lemmas/L15_Expanded_Rewrite_and_Mixed_Inverse_Words.md) | Audited stopped-useful theorem note plus checker | Adds exact predecessor rewrites, complete inverse fibers, canonical source reduction, mixed-word families, and a pure-`a=2` depth obstruction. The rewrite relation is nonconfluent and universal certificate coverage is Collatz-equivalent. |
| [`proof-search/routes/AB_direct_H_return_and_renewal_filters.md`](proof-search/routes/AB_direct_H_return_and_renewal_filters.md) | Audited stopped-useful route note plus checker | Gives exact partial hard-return arithmetic, conditional infinite-ray consequences, a one-way ghost filter, and two separate renewal gcd filters. It constructs or excludes no infinite positive ray. |
| [`proof-search/routes/AB_prime_renewal_finite_window_no_go.md`](proof-search/routes/AB_prime_renewal_finite_window_no_go.md) | Audited stopped-useful finite-window closure plus checker | Gives correction-prime criteria, the exact hard-word constants `5` and `23`, delayed prime returns, finite CRT concatenation, and rough-growth shadows. It shows why finite prime/sieve windows do not settle one fixed seed. |
| [`proof-search/disproof/CODEX_TM_MAHLER_ANCHOR_2026-08-24.md`](proof-search/disproof/CODEX_TM_MAHLER_ANCHOR_2026-08-24.md) | Provisional conditional note; `NO DISPROOF` | Defines a Thue--Morse `2`-adic anchor and proves a conditional divergence bound. Positive-ordinary membership is unproved, so this is not a witness or counterexample. |
| [`proof-search/lemmas/L13_Refined_Mersenne_Child_Macros.md`](proof-search/lemmas/L13_Refined_Mersenne_Child_Macros.md) | Audited theorem note | Easy-child coalescence, hard-child successor normalization, same-label replay debt, cross-label recharge, and the affine-rank obstruction. |
| [`lean/CollatzWork/RefinedMersenneChild.lean`](lean/CollatzWork/RefinedMersenneChild.lean) | Lean-checked, narrow | The easy-child arithmetic, iteration identity, and coalescence statement. It does not formalize the hard-family rank or Collatz. |
| [`proof-search/routes/A_yah_2local_edge_potential_no_go.md`](proof-search/routes/A_yah_2local_edge_potential_no_go.md) | Exact certificate plus checker | A 13-row cancellation excludes bounded-below adjacent-pair additive potentials for the stated rewrite contexts. It does not exclude matrix, automaton, or nonadditive orders. |
| [`verification/yah_2local_edge_no_go.py`](verification/yah_2local_edge_no_go.py) | Reproducible checker | Replays the exact cancellation certificate and prints `PASS`. |
| [`proof-search/routes/A_yah_two_state_semantic_label_no_go.md`](proof-search/routes/A_yah_two_state_semantic_label_no_go.md) | Exact labeled cancellation theorem | The fixed two-state suffix algebra cannot support additive labeled-symbol or adjacent-edge orders, including finite lexicographic tuples. It does not exclude other labels or nonadditive orders. |
| [`verification/yah_two_state_semantic_label_no_go.py`](verification/yah_two_state_semantic_label_no_go.py) | Standard-library exact checker | Reconstructs the labeled rules and replays the fixed-terminal positive-integer cancellations exactly. |
| [`proof-search/routes/A_yah_two_state_scalar_arctic_full_no_start.md`](proof-search/routes/A_yah_two_state_scalar_arctic_full_no_start.md) | Exact coefficient-independent theorem | Excludes every standard first dimension-one arctic-natural step on the original YAH system and the corresponding fixed labeling. It does not cover richer interpretation classes. |
| [`verification/yah_two_state_scalar_arctic_full_no_start.py`](verification/yah_two_state_scalar_arctic_full_no_start.py) | Standard-library exact checker | Verifies the original 11-rule and labeled 22-rule full/extended cancellations, both of mass 49. |
| [`verification/yah_scalar_arctic_top/verify_top_certificates.py`](verification/yah_scalar_arctic_top/verify_top_certificates.py) | Dependency-free exact checker plus payload | Checks 491 integer Farkas lemmas and 426 RUP clauses for all six boundary and four reversed-dynamic labeled top targets; equal-state lifting gives the original-system corollary. |
| [`proof-search/routes/AB_hard_boundary_return_system.md`](proof-search/routes/AB_hard_boundary_return_system.md) | Exact reduction theorem | Gives a total decreasing boundary normalizer and the Collatz-equivalent hard return map; `31 -> 182 -> 91` is the smallest replay-rank recharge witness. |
| [`lean/CollatzWork/Disproof/TwoPumpDependency.lean`](lean/CollatzWork/Disproof/TwoPumpDependency.lean) | Lean-checked, narrow | The two rotated determinant pairs satisfy exact dependencies, so the hoped cyclic constant resultant vanishes identically. |
| [`proof-search/disproof/CODEX_TWO_PUMP_DEPENDENCY_AUDIT_2026-08-24.md`](proof-search/disproof/CODEX_TWO_PUMP_DEPENDENCY_AUDIT_2026-08-24.md) | Audited derivation | Gives the coefficient provenance, factorization, scope, and prior-art classification for the two-pump route obstruction. |
| [`verification/disproof_cycle_search.py`](verification/disproof_cycle_search.py) | Exact bounded computation | Exhausts the reported finite `(k,q,D)` region using a corrected maximum-`C` dynamic program; it finds no nontrivial positive cycle candidate in that region. |
| [`proof-search/disproof/CODEX_DISPROOF_CYCLE_DP_AUDIT_2026-08-24.md`](proof-search/disproof/CODEX_DISPROOF_CYCLE_DP_AUDIT_2026-08-24.md) | Audit note | Proves why the fixed-bound DP merge is complete and states the finite boundary precisely. |

## Latest global gap

For a bounded infinite accelerated valuation code, define the canonical
endpoint representatives `M_k` and carries `t_k` as in the
[endpoint-residue gate](proof-search/routes/F_bounded_alphabet_endpoint_residue_gate.md).
The new theorem proves the exact dichotomy

```text
one positive odd realizing seed
    <=> t_k = 0 eventually
    <=> M_k / 3^k -> 0
    <=> limsup M_k^(1/k) < 3.
```

If these conditions fail, positive carries occur infinitely often and
`limsup M_k^(1/k)=3`. This converts a vague compactness problem into one exact
fixed-seed arithmetic gate, but it does not decide that gate for a proposed
aperiodic code.

The most concrete disproof target is an infinite guarded code built from
blocks `1^L 3` with `L>=3`. If one positive odd integer realized such a code,
the guarded block coordinate would strictly increase forever and give a
rigorously unbounded positive Collatz orbit. What remains unproved is exactly
whether the code's endpoint residues vanish/eventual carries stop. Proving
instead that every such code has infinitely many positive carries would close
this candidate family without proving Collatz.

The finite audits explain why the obvious local substitutes do not cross this
gate. Complete finite inverse words remain a nonconfluent, nonexhaustive
toolkit; every finite list of individually admissible prime-return blocks can
be realized in one positive prefix; and arbitrarily long growing rough
prefixes exist. The positive seed may change with the finite script. Passing
to a compatible infinite residue system produces a profinite or `2`-adic
object unless ordinary-positive stabilization is proved.

On the proof side, the older hard return map remains exact but
Collatz-equivalent, with known rank recharge. A proof still needs a genuinely
well-founded mechanism covering every guarded transition, or a sound
termination order for the exact rewrite system. A disproof still needs an
exactly replayed positive nontrivial cycle or one positive ordinary integer
that satisfies every guard of a divergent itinerary. The conditional
Thue--Morse anchor meets neither witness requirement because its positive-
ordinary membership is unproved.

## Reproduction

From the repository root:

```powershell
python -B verification\trajectory_normal_form_regression.py
python -B verification\expanded_rewrite_inverse_word_regression.py
python -B verification\bounded_alphabet_endpoint_residue_gate.py
python -B verification\direct_H_return_renewal_regression.py
python -B verification\prime_renewal_regression.py
python -B verification\yah_2local_edge_no_go.py
python -B verification\yah_two_state_semantic_label_no_go.py
python -S -B verification\yah_two_state_scalar_arctic_full_no_start.py
python -S -B verification\yah_scalar_arctic_top\verify_top_certificates.py
python -B verification\disproof_cycle_search.py
lake env lean lean\CollatzWork\Disproof\TwoPumpDependency.lean
lake build
```

Expected key outputs are:

- trajectory-normal-form regression: 500,000 odd starts, maximum 19
  normalizer edges, and `PASS`; this is finite regression evidence only;
- expanded-rewrite regression: 50,000 rewrite starts, 510 mixed words,
  10,001 members of the `91 mod 162` family, and `PASS`;
- endpoint-residue regression: 9,840 words over `{1,2,3}` through depth `8`,
  five reconstructed seeds, three boundary-code checks, and `PASS`; the
  infinite equivalence is proved in prose, not by exhaustion;
- direct-return/renewal regression: 50,000 typed parameters, 3,570 completed
  switching returns, 50,000 renewal states, and `PASS`;
- prime-renewal regression: 10,000 correction prefixes, 44 primes through
  `199`, one five-prime script, 48 rough-growth pairs, and `PASS`;
- rewrite cancellation checker: `PASS`;
- two-state semantic-label checker: `PASS`;
- scalar-arctic full checker: original 11 rows and labeled 22 rows, each with
  total multiplier 49, zero weighted count delta, and `PASS`;
- scalar-arctic top checker: 10 cases, 491 integer Farkas lemmas, 426 RUP
  clauses, and `PASS`;
- cycle DP: 91 eligible pairs, peak 47,517 merged states, 9 trivial
  `1-2` encodings, and 0 nontrivial candidates;
- two-pump Lean module: five theorem dependency reports containing only
  Lean's standard `propext` and `Quot.sound`.

The two-pump module is compiled directly by the command above; it is not yet
imported by the umbrella `CollatzWork.lean` file.

## What can be said publicly

> This is an AI-assisted, adversarially audited Collatz research archive. It
> does not claim a proof or disproof. Its strongest new auxiliary result gives
> an exact endpoint-carry characterization of positive realizability for
> bounded valuation codes. Additional stopped-useful results close several
> finite inverse-word, prime-return, roughness, and local-return mechanisms.
> The remaining fixed-seed infinite-tail step is stated explicitly rather than
> hidden.

Novelty is not certified. Several ingredients specialize classical Collatz
parity-vector and stopping-time arithmetic; project-specific packaging and
no-go certificates still require independent specialist review before any
priority claim.

## Provenance checkpoint

The complete combined snapshot described by this file has two accepted
mathematical component baselines. Endpoint, inverse-word, renewal, and
global-coupling artifacts are pinned at
`6c8f77ef2b0b360f8f353f4508dcfec58e980331`; its parent
`77fe81f17b71335f3e68349d9d8ae13d14dae0f1` is the reviewed documentation
snapshot and `67068bf0493c25514ebdd1b635ecd6a0e0af643f` is that branch's base.
Scalar-arctic artifacts are pinned at
`b75ffec58ae20ac26271ff7d59a71d3591467994`; its parent chain includes
`f8558a566b682e8dbc4465206f9c26ac9b17760c`, the preceding full scalar
certificate. Both chains include
`cc33bdb470da849a5eb9d63921dcd37a8f37e94d`, which first introduced L14.
Current-main commit `2e7eae2bb998b14e5443e6c440154130a0049467`
adds the portable atlas and graph QA without changing those mathematical
scopes. Exact scope notes are recorded in the linked files and Git history.

The nonexistent string `409cb63b69b5fb6af676166573e752f1f4a5ff38`
must never be used as provenance; the valid similarly prefixed object is
`409cb63d6805b00b3dcd96576ac172c58b16384e`.
