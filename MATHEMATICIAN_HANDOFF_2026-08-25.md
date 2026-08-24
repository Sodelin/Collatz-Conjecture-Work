# Mathematician handoff — 2026-08-25

> **Bottom line:** the Collatz conjecture is still unresolved. No universal
> proof and no disproof has passed independent reconstruction in this project.
> In particular, the project has not produced a positive nontrivial cycle or a
> positive orbit rigorously proved to diverge.

This is a review snapshot of an AI-assisted, adversarially audited research
archive. It is designed to let a mathematician separate exact narrow results,
equivalent reformulations, bounded computations, and unfinished ideas without
reading the full historical log first.

- Current public `origin/main` integrated here:
  `2e7eae2bb998b14e5443e6c440154130a0049467`, including the portable
  [research atlas](ATLAS.md) and note-graph QA.
- Accepted endpoint/global-coupling artifact snapshot reviewed here:
  `6c8f77ef2b0b360f8f353f4508dcfec58e980331`; its branch base is
  `67068bf0493c25514ebdd1b635ecd6a0e0af643f`.
- Accepted scalar-arctic artifact snapshot reviewed here:
  `b75ffec58ae20ac26271ff7d59a71d3591467994`.
  These hashes identify the two mathematical component histories combined by
  this review branch; none is itself a correctness or novelty certificate.
- Snapshot cutoff: the audited packets explicitly named in Sections 4, 5,
  and 11 through 2026-08-24. Live research may continue independently; a
  result not named here is not silently included.
- Canonical complete inventory before the cutoff:
  [claim registry](proof-search/CLAIM_REGISTRY.md).
- Canonical route state before the cutoff:
  [approach registry](proof-search/APPROACH_REGISTRY.md).

Hashes identify content. They do not certify correctness, novelty, public
priority, or peer review.

## 1. Exact conventions and acceptance gates

Three related maps occur in the archive. This handoff uses distinct names to
avoid a common source of false identities.

For positive integers, the ordinary Collatz map is

\[
C(n)=\begin{cases}
n/2,&n\equiv0\pmod2,\\
3n+1,&n\equiv1\pmod2.
\end{cases}
\]

The one-division shortcut map is

\[
S(n)=\begin{cases}
n/2,&n\equiv0\pmod2,\\
(3n+1)/2,&n\equiv1\pmod2.
\end{cases}
\]

On positive odd integers, the accelerated odd map is

\[
A(n)=\frac{3n+1}{2^{v_2(3n+1)}}.
\]

Some source files call the shortcut map `T`; others call the accelerated map
`T`. The L14/L15 and new route artifacts call the accelerated map `U`; in this
handoff, `U=A`. Every identity below states which convention it uses.

The proof gate is a gap-free proof that every positive odd integer reaches
`1` under `A` (equivalently, every positive integer reaches `1` under `C` or
`S`). An equivalent return map or termination problem is not a proof unless
its universal termination is also established.

The disproof gate is either:

1. an explicit positive nontrivial finite cycle, with every valuation and map
   step replayed exactly; or
2. an explicit positive starting integer together with a rigorous proof that
   its orbit never reaches `1` (and, if called divergent, is unbounded).

The accelerated trivial cycle is `{1}`; the corresponding ordinary cycle is
`1 -> 4 -> 2 -> 1`. “Nontrivial” excludes these presentations of the same
orbit.

Negative cycles, rational or 2-adic fixed points, noncanonical rewrite loops,
finite computations without a witness, and counterexamples to proof methods do
not pass the disproof gate.

## 2. How to read the evidence

The repository deliberately distinguishes four questions.

| Label used here | Meaning |
|---|---|
| **Lean-checked** | Lean checks the exact declaration in the linked module with the recorded axiom footprint. It does not check omitted prose, source attribution, or novelty. |
| **Checker-replayed** | An exact program reconstructs the stated finite algebra, certificate, or bounded enumeration. It proves only that scope. |
| **Independently reconstructed prose** | At least one hostile audit reconstructed the complete displayed argument, but there is no kernel-checked theorem. |
| **Provisional / do not cite** | A material proof, semantic, provenance, or audit obligation is still open. |

None of these labels is a probability that Collatz is true. The ordinal
`C/V/I/N/R` rubric and every pre-cutoff promoted claim appear in the
[claim registry](proof-search/CLAIM_REGISTRY.md).

## 3. Current review status in plain language

The archive has three different kinds of useful statement:

- **Solved route-class obstructions.** Exact certificates show that several
  tempting mechanisms cannot work in their stated classes. These are genuine
  theorems about proof architectures, not the Collatz conjecture.
- **Collatz-equivalent reformulations.** Global descent, termination of the
  exact Yolcu–Aaronson–Heule (YAH) rewrite system, and termination of the
  normalized hard-return map re-express the universal problem. They do not
  solve it.
- **Narrow positive lemmas.** Selected residue families coalesce with smaller
  starts, and a least counterexample would obey strong residue restrictions.
  No accepted theorem resolves every resulting terminal case or proves
  convergence for all positive integers.

The strongest new exact gate in this snapshot is
`F-BOUNDED-ALPHABET-ENDPOINT-GATE-001`: for every bounded infinite valuation
code it characterizes positive-integer realizability by eventual vanishing of
an explicit carry sequence, equivalently by decay of normalized endpoint
representatives. It does **not** determine the branch for any unresolved
aperiodic hard code. The finite YAH cancellations and the full/top
dimension-one scalar-arctic certificates are the most developed externally
reviewable route-class obstructions, and the strongest formal artifacts remain
three narrow Lean modules. None is a proof or disproof of Collatz.

The new inverse-word, direct-return, renewal, and prime-return notes sharpen
the route map. In particular, every finite valuation script and every finite
concatenation of the stated prime-return blocks can be realized by positive
starts, but this never produces one positive start realizing an infinite
script. That fixed-seed infinite-tail passage is the central unresolved
coupling issue, not a technicality.

Publication readiness is correspondingly limited:

- **Submission-ready proof/disproof:** none.
- **Best candidate for a narrow technical note:** the checker-backed YAH
  additive and scalar-arctic obstructions, after independent term-rewriting
  specialist review, formal certification, and a broader novelty search.
- **Research-review material:** the bounded-alphabet endpoint gate, L14/L15,
  the direct hard-return and prime-renewal filters, the L13 hard/rank
  obstruction, and the scalar YAH two-rule contradiction. Round 6A and the
  Thue--Morse 2-adic anchor remain provisional.
- **Verification infrastructure:** the max-`C` DP and the two-pump Lean module.
- **Classical corollaries or routine specializations:** the Mersenne easy child,
  trajectory normal form, fixed-seed expansion threshold, finite-prime-support
  and periodic-tail lemmas, and the memoryless single-modulus first-integral
  obstruction. These are useful but should not be marketed as new Collatz
  theorems.

## 4. Accepted and rigorously scoped repository results

This is the short review set, not a replacement for the complete atomic
registry. Each statement below has immutable Git provenance.

| Claim | Exact accepted scope | Evidence and Git object | Importance and novelty classification |
|---|---|---|---|
| Equal-slope inverse boundary | For affine families with equal slope, eventual strict comparison is exactly intercept comparison; the concrete coalescence is `S^3(8x+5)=3x+2=S^3(8x+4)`. | [Lean module](lean/CollatzWork/InverseWordBoundary.lean), object `016ccd7f1a82ba802531a5b649848d994d18bcc8`. | Narrow formal regression; elementary/prior-art arithmetic, not a new Collatz theorem. |
| Refined Mersenne easy child | For `L>=2`, `q=4z+2 epsilon+1`, `N=2^L q-1`, and `epsilon == L (mod 2)`, the integer `m=(3N-1)/4` satisfies `0<m<N` and `S^(L+2)(N)=S^L(m)=(3^L q-1)/4`. | [L13 note](proof-search/lemmas/L13_Refined_Mersenne_Child_Macros.md), [Lean module](lean/CollatzWork/RefinedMersenneChild.lean), object `7be9977cddc2fe3786eb27d71e7914ff1e214509`. | Valid strong-induction edge for one child. Published in substance in the Mersenne-staircase literature; `N0`, no novelty claim. |
| Refined Mersenne hard-child boundary | On the parity-incompatible child, no uniform forward time `0<=t<=L+2` followed by a uniformly admissible unrefined L4 inverse word yields an eventually smaller positive affine family. The successor cells and the stated replay debt are exact. | [L13 note](proof-search/lemmas/L13_Refined_Mersenne_Child_Macros.md), object `e169d4bb7daf9fc4f70b1a0ab3297330846dccc8`. | Major route boundary, prose-audited rather than Lean-checked. It does not cover parameter refinement, richer state, or nonlinear ranks. |
| Hard-state affine-rank obstruction | Same-label replay decreases the recorded debt, but guarded cross-label transitions recharge it arbitrarily. The guarded edge `17,184,927 -> 97,873,535` refutes every lower-bounded affine combination in the exact label-depth/bitlength/debt class. | L13 equations (20)–(27), object `e169d4bb7daf9fc4f70b1a0ab3297330846dccc8`. | Project-specific route obstruction; exact packaging not priority-certified. It does not refute all ranks or all finite automata. |
| Hard-boundary return system | A total decreasing normalizer sends each positive state to `1` or the hard family. The induced hard return map is Collatz-equivalent. The smallest recorded growth-plus-recharge witness is `31 --S^7--> 182 --S--> 91`. | [Return-system note](proof-search/routes/AB_hard_boundary_return_system.md), object `8a93ea5e8377f16be5b54f5fe0de9f8d9a85b3a9`. | Exact compression and route map, not termination progress. The reported minimality of the witness lacks a committed exhaustive transcript. |
| Finite bounded-horizon cover no-go | No finite cover of all odd `n>1` by cells with uniformly bounded positive direct-descent horizons can prove descent: for any maximum horizon `K`, a sufficiently large `2^m-1` has `S^j(2^m-1)>2^m-1` for every `1<=j<=K`. | [Failure ledger F008](proof-search/FAILURE_LEDGER.md#f008--finite-depth-residue-tree), repaired object `409cb63d6805b00b3dcd96576ac172c58b16384e`. | Known finite-method obstruction. Ranked recursion and unbounded derivations remain open. |
| Unlabeled YAH adjacent-edge no-go | No bounded-below scalar potential obtained by summing weights of adjacent pairs on the stated canonical YAH contexts can be weak on all auxiliary rule instances and strict on both dynamic rules. | [Certificate](proof-search/routes/A_yah_2local_edge_potential_no_go.md), [checker](verification/yah_2local_edge_no_go.py), object `d1bc062c727041ed8e106478983e3b7281f33dae`. | A 13-row cancellation gives `W_(f,f)<=-1`, contradicting boundedness on `^f^m$`. Exact match not located; priority uncertified. Labels, matrices, longer windows, and nonadditive orders remain. |
| Fixed two-state labeled YAH no-go | For the exact two-state suffix algebra in the note, neither additive labeled-symbol nor additive labeled-adjacent-edge weights can orient the required rules; the same positive cancellation kills every finite lexicographic tuple of such weights. | [Certificate](proof-search/routes/A_yah_two_state_semantic_label_no_go.md), [checker](verification/yah_two_state_semantic_label_no_go.py), object `8a93ea5e8377f16be5b54f5fe0de9f8d9a85b3a9`. | Exact 8-row and 50-row certificates. Potentially interesting but only one algebra/locality class; priority uncertified. |
| Original-system scalar-arctic no-start (`A-YAH-AN1-001`) | On the original eleven-rule YAH system, no first standard dimension-one arctic-natural step exists: neither full/extended removal nor either Lemma-3.18 boundary/dynamic relative-top opportunity. | [Theorem note](proof-search/routes/A_yah_two_state_scalar_arctic_full_no_start.md), [full checker](verification/yah_two_state_scalar_arctic_full_no_start.py), [top checker](verification/yah_scalar_arctic_top/verify_top_certificates.py), object `b75ffec58ae20ac26271ff7d59a71d3591467994`. | Exact 49-mass, Farkas, and RUP certificates. Higher dimensions, other carriers, transformed/non-coefficientwise orders, and local systems remain open; priority is uncertified. |
| Fixed-label scalar-arctic no-start (`A-YAH-2STATE-AN1-001`) | On the exact global 22-rule two-state labeling, no first full/extended scalar step exists and none of the six original boundary or four reversed-dynamic top targets is feasible. | Same [theorem note](proof-search/routes/A_yah_two_state_scalar_arctic_full_no_start.md), full/top checkers, and object `b75ffec58ae20ac26271ff7d59a71d3591467994`. | The labeled top result is a syntactic interpretation no-go, not a separately proved semantic-label top-reflection theorem. Richer methods remain open. |
| Two-pump cyclic dependency | For the exact determinant coefficients in the audit, `aB=cC` and `gA=dE`; hence `cgAC-adBE=0` identically. Cyclic rotation supplies no independent constant resultant. | [Audit](proof-search/disproof/CODEX_TWO_PUMP_DEPENDENCY_AUDIT_2026-08-24.md), [Lean module](lean/CollatzWork/Disproof/TwoPumpDependency.lean), object `974dbcb58ea40cf9365689a27de4df3ceafa0b75`. | Formal route-design obstruction, not a cycle exclusion. Elementary specialization of classical fixed-word algebra; no priority claim. |
| Corrected max-`C` cycle DP | For each fixed `(k,q)`, keeping the maximum exact affine coefficient `C` in each residue state is complete. With `k<=40` and `0<D=2^k-3^q<=250000`, the run exhausts 91 pairs, peaks at 47,517 merged states, finds 9 trivial `1`/`2` encodings and 0 nontrivial candidates. | [Audit](proof-search/disproof/CODEX_DISPROOF_CYCLE_DP_AUDIT_2026-08-24.md), [script](verification/disproof_cycle_search.py), [output](verification/disproof_cycle_search_output_2026-08-24.txt), object `4e883e4deaa881b843f26473692c5483a220d91d`. | Exact bounded computation only, much weaker than published cycle/computational bounds. The earlier arbitrary-representative DP is superseded. |
| Conditional coefficient-stopping barrier | Assuming the named `2^71` verified range and the Rozier–Terracol input, a least counterexample has no coefficient contraction before accelerated time `114,208,327,604`. | [L8 statement](proof-search/lemmas/L8_Farey_Certified_Coefficient_Barrier.md), checker/output indexed in the [verification manifest](verification/README.md), statement object `03f4049cca8b5c5cc87856b8ac807e126ef8e5d2`. | Strong necessary-condition certificate, conditional on external inputs and not Lean-formalized. It is not a global convergence theorem. |
| `3n-1` trajectory normal form (`L14-3M1-NF`) | Every positive odd input admits a finite strictly decreasing chain of convergence-equivalent rewrites ending at `1` or `H=(7+8N_0) union (27+32N_0)`. The displayed reducer is not exhaustive, and its residual assertion is Collatz-equivalent. | [L14 note](proof-search/lemmas/L14_ThreeNMinusOne_Trajectory_Normal_Form.md), [regression](verification/trajectory_normal_form_regression.py), first artifact object `cc33bdb470da849a5eb9d63921dcd37a8f37e94d`. | Exact prose theorem plus finite regression. Elementary sufficient-set packaging, not a solution and no novelty claim. |

The [failure ledger](proof-search/FAILURE_LEDGER.md) records the exact
supersession boundary for older claims, including the invalid L5 strict-slope
necessity, the first cycle-DP merge, and the attempted renewable near-return
argument.

## 5. Additional accepted and rigorously scoped snapshot results

This section preserves useful short results from the earlier handoff and adds
the independently audited artifacts at `6c8f77e...`. Artifact status is stated
per result: some older items remain self-contained handoff prose, L14 is now a
standalone public-base artifact, and Sections 5.8--5.11 link standalone review
artifacts. None is end-to-end formalized, a priority claim, or a Collatz
solution. The conditional Thue--Morse construction is not accepted here; it is
quarantined in Section 11.

### 5.1 Scalar relative interpretations of the YAH system

Let each rewrite symbol `s` act by a strictly increasing self-map
`P_s : N -> N`, and interpret concatenation compositionally. Require the
dynamic rule `t$ -> 2$` to be strict and the auxiliary rule `^2 -> ^ft` only
to be weak. No such scalar interpretation exists. In the exact 11-rule source,
the two dynamic rules are `f$ -> $` and `t$ -> 2$`; the other nine preserve
represented value and include `^2 -> ^ft`. Thus the two-rule contradiction
already excludes an interpretation making both dynamic rules strict and all
auxiliary rules weak.

Under `I(uv)=P_u o P_v`, set `z=P_$(x)`. Strictness and weakness give

\[
P_t(z)>P_2(z)\ge P_f(P_t(z)).
\]

Every strictly increasing self-map of `N` is extensive: `P_f(y)>=y` for every
`y`. Taking `y=P_t(z)` is a contradiction. With the reverse composition
convention, strict monotonicity cancels the outer `$`, while the weak rule and
extensivity of `P_f` give
`P_2(z)>=P_t(P_f(z))>=P_t(z)>P_2(z)`.

This kills arbitrary-degree scalar polynomial interpretations as a special
case, and even scalar **relative** interpretations with the dynamic rules
strict and auxiliary rules weak. It does not touch multidimensional or matrix
orders, arctic orders, semantic labeling, special constant treatment of
boundaries, reachable-only interpretations, non-scalar ordered algebras, maps
that do not satisfy the stated strict monotonicity, or noncompositional or
genuinely context-sensitive semantics. No exact external match was found in a
bounded source check; that is not a novelty certificate.

### 5.2 Deterministic trajectory normal form (`L14`)

The complete standalone proof is now the public-base artifact
[L14](proof-search/lemmas/L14_ThreeNMinusOne_Trajectory_Normal_Form.md), with
finite replay in
[`trajectory_normal_form_regression.py`](verification/trajectory_normal_form_regression.py).
It supersedes the earlier three-cylinder least-counterexample sieve. Treat
`1` as terminal. For a positive odd `x>1`,
put

\[
a=v_2(3x+1).
\]

If `a>=2`, use the actual accelerated edge `x -> A(x)`; it strictly decreases
because `A(x)<=(3x+1)/4<x`. If `a=1`, put

\[
c=v_2(3x-1),\qquad p=(3x-1)/2^c,
\]

where `p` is positive odd. There are two decreasing cases. If `c=2j+3` with
`j>=0`, then

\[
A^{j+2}(x)=A(3^j p),\qquad 3^j p<x.
\]

The abstract rewrite is `x ~> 3^j p`. It is a coalescence edge, not generally
an edge of the orbit of `x`, but it preserves the property “reaches `1`.” If
`c=2j+2` with `j>=2`, then

\[
A^{j+1}(x)=2\cdot3^j p+1<x.
\]

Every nonterminal abstract edge therefore strictly decreases a positive
integer. Deterministic rewriting ends at `1` or in exactly one of

\[
H_1=\{4u+3:u>0\text{ odd}\},\qquad
H_2=\{16u+11:u>0\text{ odd}\},
\]

which are the cases `c=2` and `c=4`. The former `64u+43` family is
superseded: `c=6` is already the `j=2` decreasing case,

\[
A^3(x)=18p+1<x.
\]

This is an exact finite normal-form reduction, not a proof of Collatz. In
particular, the coalescing abstract rewrites do not show that the original
orbit itself enters `H_1` or `H_2`, and no accepted theorem resolves those two
terminal families.

Classification: **`PROVED_AUX / STOP_EQUIVALENT / NO COLLATZ PROOF`**. The
displayed rewrite is deterministic, strictly decreasing, and
reachability-preserving only in the abstract sense stated above. L14 also
records exact counterexamples to treating its terminal set as exhaustive for
all finite trajectory-preserving rewrites.

### 5.3 Finite prime support forces eventual periodicity

Let `(n_i)` be a positive odd accelerated orbit, `n_(i+1)=A(n_i)`. If the
union `P` of the prime divisors of all `n_i` is finite, then `(n_i)` is
eventually periodic.

Set `a_i=v_2(3n_i+1)` and

\[
x_i=2^{a_i}n_{i+1},\qquad y_i=-3n_i.
\]

For the finite set of places supported on `P` together with `2` and `3`, both
terms are rational S-units and

\[
x_i+y_i=1.
\]

Finiteness of the two-variable S-unit equation gives only finitely many pairs
`(x_i,y_i)`. Since `y_i=-3n_i`, only finitely many orbit states occur;
determinism gives eventual periodicity.

Consequently, every non-eventually-periodic—and hence every unbounded—positive
Collatz orbit contains infinitely many distinct odd prime divisors among its
odd states. A counterexample with finite prime support would eventually enter
a positive nontrivial cycle. This is a direct corollary of classical S-unit or
Størmer finiteness, not a standalone breakthrough and not a priority claim.

### 5.4 Exact two-center branching ansatz collapses

For `j>=1`, put `U_j(x)=(3x+1)/2^j`. Consider exactly the rational-center
graph

```text
A --a--> A
A --b--> B
B --c--> A
```

with positive labels and center equations
`U_a(alpha)=alpha`, `U_b(alpha)=beta`, `U_c(beta)=alpha`. Eliminating the
centers gives

\[
2^b(2^c+3)=2^a(2^b+3).
\]

Uniqueness of the power-of-two part forces `a=b`, then `c=b`; hence
`alpha=beta`. The collapsed center is `1/(2^a-3)`, whose only positive
integral guarded case is `a=2`, `alpha=1`, the trivial accelerated cycle.

More generally, if an integer orbit is **exactly synchronized edge by edge**
to a finite rational-center system with a fixed common denominator `D`, then
the scaled displacement has the form

\[
q_t=D(n_t-\gamma_t)=\frac{3^t q_0}{2^{J_t}},\qquad J_t\ge t.
\]

If every `q_t` is integral, unbounded powers of two divide `q_0`, so `q_0=0`.
This kills only the fixed finite-center, exact-synchronization ansatz. It does
not exclude larger graphs with different semantics, moving centers, nonlinear
invariant sets, or a genuine divergent orbit. A narrow Lean file and audit
notes were replayed in the source lane, but they were untracked and are not
part of this Git snapshot; the Lean result covered only the displayed natural
number equation rigidity, not the prose bridge.

### 5.5 Memoryless single-modulus residue first integrals are constant

Let `m>=1`, let `S` be any set, and let

\[
I_m:\mathbb Z/m\mathbb Z\longrightarrow S
\]

satisfy

\[
I_m([C(n)]_m)=I_m([n]_m)
\]

for every positive integer `n`, where `C` is the ordinary Collatz map from
Section 1. Then `I_m` is constant. Consequently, no positive `n_0` can be
separated from `1` by a memoryless coloring of one fixed residue modulus.

If `m=2d`, the positive even lifts `2R` and `2R+m` force
`I_m(R)=I_m(R+d)`, so the coloring factors through modulus `d`. Once the
modulus is odd, if `m=3d`, positive odd lifts separated by `2d` have Collatz
outputs differing by `2m`; hence
`I_m(r)=I_m(r+2d)=I_m(r+d)`, and the coloring again factors through `d`.
After stripping all factors of `2` and `3`, define the residue permutations

\[
P(x)=2x,\qquad Q(x)=3x+1.
\]

Positive even and odd lifts make the coloring invariant under `P` and `Q`.
Their right-to-left commutator is

\[
Q^{-1}P^{-1}QP(x)=x-1/6.
\]

Because `-1/6` is a unit modulo the remaining modulus, this translation is
transitive, so the coloring is constant.

The complete all-moduli argument was independently reconstructed in prose.
An untracked source-lane Lean module was also replayed: all five declarations
reported no axioms. It checks only the abstract facts that invariance passes
to the displayed commutator and that invariance under a transitive map forces
constancy. It does **not** formalize `Z/mZ`, the positive parity-controlled
lifts, factor descent, the affine commutator calculation, or translation
transitivity, and it is not a public artifact of this review branch. For
audit provenance, the frozen, untracked source-lane files at detached base
`b3b9f473...` were:

- `proof-search/disproof/CODEX_FINITE_RESIDUE_FIRST_INTEGRAL_SHOT_2026-08-24.md`,
  SHA-256
  `737224441621F0466A517E38E5CCDA1B745956640A76A6C715A8C1130A7F092D`;
- `lean/CollatzWork/Disproof/FiniteResidueFirstIntegral.lean`, SHA-256
  `EF19D5151CBE2C8C22824BAD1CE380063027136AA5924DC21FE2AC5E287A21FF`;
- `proof-search/disproof/CODEX_FINITE_RESIDUE_FIRST_INTEGRAL_HOSTILE_AUDIT_2026-08-24.md`,
  SHA-256
  `F69FD82B43D9B5CC34857E0134091A216181B4D02A21798102D9B393C53ED0EA`.

Classification: **`STOPPED-USEFUL / KILLED_CLASS / NO DISPROOF`**. This kills
only memoryless first integrals determined by one fixed finite modulus. It
does not exclude finite-state memory, forward traps, ranked recursive residue
graphs, state-dependent or growing moduli, non-residue invariants, or a
Collatz counterexample. The argument is classified as elementary
modular-semigroup folklore; no novelty or priority claim is made.

### 5.6 Fixed-seed threshold for expansion blocks

For `F-EXPANSION-BLOCK-THRESHOLD-001`, let `x_0=N` be one fixed positive odd
accelerated orbit and put `a_i=v_2(3x_i+1)`. If `L>=1` and

\[
a_s=a_{s+1}=\cdots=a_{s+L-1}=1,
\]

then

\[
x_{s+k}+1=\frac{3^k(x_s+1)}{2^k}\quad(0\le k\le L),
\]

and exactness of the final valuation gives

\[
2^{L+1}\mid x_s+1.
\]

Every accelerated step also satisfies

\[
x_{i+1}+1\le\frac32(x_i+1).
\]

Consequently

\[
2^{L+1}\le x_s+1\le(3/2)^s(N+1),
\]

so the exact fixed-seed threshold is

\[
\boxed{L+1-s\log_2(3/2)\le\log_2(N+1).}
\]

The `+1`, accelerated-time index `s`, and dependence on the single seed `N`
are essential. The inequality allows the permitted run length to grow with
`s`; it is neither a uniform bounded-word theorem nor a convergence proof.

### 5.7 Eventually periodic valuation tails are exact cycles

For `A-VALUATION-TAIL-RIGIDITY-001`, suppose an actual positive accelerated
orbit has an exactly periodic valuation tail, aligned from an odd state `y`.
Let one period be `w=(a_0,...,a_(r-1))`, put

\[
A_i=\sum_{h<i}a_h,\qquad B=\sum_{i=0}^{r-1}a_i,
\]

and define

\[
D_w=\sum_{i=0}^{r-1}3^{r-1-i}2^{A_i}.
\]

One period acts by

\[
F(z)=A^r(z)=\frac{3^rz+D_w}{2^B}.
\]

For the aligned tail states `y_k=F^k(y)`, set

\[
\Delta_k=(2^B-3^r)y_k-D_w.
\]

Then `Delta_k` is an integer and

\[
\Delta_k=\frac{3^{rk}\Delta_0}{2^{Bk}}.
\]

Since `3` is odd, integrality for every `k` forces `2^(Bk)` to divide
`Delta_0` for every `k`; hence `Delta_0=0`. Therefore

\[
\boxed{A^r(y)=y,\qquad y=\frac{D_w}{2^B-3^r},\qquad 2^B>3^r.}
\]

The period need not be primitive, and no boundedness hypothesis is required.
This assertion begins only at an **infinite repeated tail**. In contrast,
`V-PREFIX-FULLSHIFT-001` records that every finite exact valuation word is
realized by infinitely many positive starting integers, so it supplies no
finite forbidden-word or finite-separation theorem. Nothing here proves that
a relevant trajectory becomes periodic or restricts its valuations to
`{1,3}`; any density or alphabet condition of that kind remains conditional.

### 5.8 Expanded decreasing rewrites and mixed inverse words (`L15`)

The standalone [L15 note](proof-search/lemmas/L15_Expanded_Rewrite_and_Mixed_Inverse_Words.md)
adds two elementary decreasing predecessor rewrites to L14. For a positive odd
endpoint `x`,

\[
x\equiv2\pmod3
\quad\Longrightarrow\quad
y=\frac{2x-1}{3}<x,
\qquad U(y)=x,
\]

and

\[
x\equiv4\pmod9
\quad\Longrightarrow\quad
y=\frac{8x-5}{9}<x,
\qquad U^2(y)=x.
\]

The resulting decreasing relation terminates, with irreducibles exactly

\[
\{1\}\cup\{h\in\mathcal H:h\bmod9\in\{0,1,3,6,7\}\}.
\]

It is **not confluent**: `11` can reduce to `1` or to the irreducible `7`.
Thus “normal form” here never means a unique canonical endpoint.

L15 also states the complete accelerated inverse fibers

\[
U(y)=x
\iff
y=\frac{2^a x-1}{3}>0
\]

with the exact parity class of `a`, an elementary canonical-source reduction
to odd multiples of `3`, and the mixed inverse-word formula

\[
x_i=\frac{2^{A_i}x-B_i}{3^i}.
\]

The word `(2,2,1,1)` yields the exact family

\[
U^4(71+128t)=91+162t,
\qquad 71+128t<91+162t.
\]

This proves that even the enlarged irreducible set is not an exhaustive list
of finite reductions. Universal coverage by forward-inverse coalescence
certificates is logically equivalent to Collatz, not a missing routine lemma.
The note separately gives, for every depth `K`, a CRT family defeating the
uniform pure-exponent-`2` inverse policy. It does not defeat mixed words,
adaptive search, forward merges, or a global invariant.

Classification: **`PROVED_AUX / STOP_EQUIVALENT / NO COLLATZ PROOF`**.
Evidence: [finite regression](verification/expanded_rewrite_inverse_word_regression.py),
which checks the displayed finite identities and families but not universal
certificate coverage.

### 5.9 Direct hard-family returns and renewal filters

The [direct-return note](proof-search/routes/AB_direct_H_return_and_renewal_filters.md)
works with the actual accelerated orbit on the L14 hard families
`H_1(u)=4u+3` and `H_2(u)=16u+11`. Its typed transition system is explicitly
partial. The four guarded edges are

\[
\begin{array}{lll}
AA:&u\equiv3\pmod4,&u\mapsto(3u+1)/2,\\
AB:&u\equiv9\pmod{16},&u\mapsto3(u-1)/8,\\
BA:&u\equiv1\pmod4,&u\mapsto(9u+5)/2,\\
BB:&u\equiv15\pmod{16},&u\mapsto(9u+1)/8.
\end{array}
\]

A completed switching return `AB BB^(k-1) BA` exists exactly when

\[
v_2(3u+5)=3k+1,
\]

and if its terminal parameter is `v`, then

\[
2\cdot8^k(v+2)=9^k(3u+5).
\]

Every defined typed edge grows. An infinite positive typed ray would therefore
be unbounded, switch types infinitely often, and be aperiodic. The note does
not construct or exclude such a ray, and excluding it would not control paths
that repeatedly exit the partial system.

For a renewal block `x+1=2^R q`, with
`b=v_2(3^R q-1)` and `y=U^R(x)`, the exact identity is

\[
2^{R+b}y=3^R x+(3^R-2^R).
\]

If one odd `d` divides every renewal state, then
`d\mid3^g-2^g`, where `g` is the gcd of the renewal lengths. Separately, if
one odd `d` divides every shifted state `x_i+1`, then
`d\mid2^h-1`, where `h` is the gcd of the `b_i`. Neither persistent-divisor
hypothesis is proved for generic orbits, and the two hypotheses must not be
merged.

Classification: **`STOPPED-USEFUL / NO PROOF OR DISPROOF`**. The formulas are
cheap exact filters for candidate itineraries and incorrect renewal arguments;
they do not supply the missing global rank or fixed positive seed. Evidence:
[finite regression](verification/direct_H_return_renewal_regression.py).

### 5.10 Prime renewal and the finite-window no-go

For a finite valuation word, put

\[
A_t=\sum_{i<t}a_i,
\qquad
C_t=\sum_{j<t}3^{t-1-j}2^{A_j}.
\]

The [prime-renewal note](proof-search/routes/AB_prime_renewal_finite_window_no_go.md)
records

\[
2^{A_t}n_t=3^t n_0+C_t.
\]

If `p>=5` is prime and `p\mid n_0`, then

\[
\boxed{p\mid n_t\iff p\mid C_t}.
\]

The two forced hard words give the exact endpoint corrections

\[
4U^2(n)-9n=5
\quad(n\in H_1),
\qquad
16U^3(n)-27n=23
\quad(n\in H_2),
\]

so the corresponding endpoint gcds divide `5` and `23`; both bounds are
sharp. For a pure valuation-`1` block,
`C_t=3^t-2^t`, and every prime `p>=5` first returns after
`ord_p(3/2)` steps for a suitable positive seed. These delays are unbounded as
the prime varies.

More decisively for route selection, every finite concatenation of
individually admissible return blocks for pairwise distinct designated primes
is realized by one positive orbit segment, by a valuation-cylinder CRT.
Likewise, for arbitrary finite `L,Y`, the family

\[
n_t=3^t2^{L+1-t}M-1
\]

with `M` the product of the odd primes at most `Y` realizes `L` maximal-growth
valuation-`1` steps while every displayed state avoids every prime at most
`Y`.

Classification: **`STOPPED-USEFUL / FINITE-WINDOW CLASS CLOSED / NO PROOF OR
DISPROOF`**. Finite prime-return, roughness, or bounded-window restrictions do
not settle the global problem. The seed produced by CRT depends on the finite
script. Passing to all prefixes produces a profinite or 2-adic specification,
not automatically one positive natural number. Evidence:
[finite regression](verification/prime_renewal_regression.py).

### 5.11 Bounded-alphabet endpoint-residue gate

This is the strongest new exact global-coupling theorem in the snapshot. Read
the complete proof in
[`F_bounded_alphabet_endpoint_residue_gate.md`](proof-search/routes/F_bounded_alphabet_endpoint_residue_gate.md).
Fix `1<=a_k<=A`, put

\[
q_k=\sum_{i<k}a_i,
\qquad C_0=0,
\qquad C_{k+1}=3C_k+2^{q_k},
\]

and let `1<=M_k<3^k` be the unique representative satisfying

\[
2^{q_k}M_k\equiv C_k\pmod{3^k}
\]

for `k>=1`, with `M_0=0`. Define the integer carry `t_k` by

\[
2^{a_k}M_{k+1}=3M_k+1+t_k3^{k+1}.
\]

Then `0<=t_k<2^{a_k}`, and the following are equivalent:

1. the infinite code is realized by a positive odd accelerated orbit;
2. `t_k=0` eventually;
3. `M_k/3^k -> 0`;
4. `limsup M_k^(1/k)<3`.

If realization fails, positive carries occur infinitely often,

\[
\limsup\frac{M_k}{3^k}\ge2^{-A},
\qquad
\limsup M_k^{1/k}=3.
\]

The converse is not a 2-adic sleight of hand: eventual zero carries give an
exact positive odd tail, and the nested `3`-power congruences reconstruct
positive integral odd predecessors with the required exact valuations.

For the guarded `{1,3}` block family

\[
(1^{L_0}3)(1^{L_1}3)\cdots,
\qquad L_i\ge3,
\]

a positive realization would be an unbounded positive orbit and hence a
Collatz disproof. The theorem reduces that construction to eventual zero
carry (equivalently endpoint decay), while infinitely many carries exclude a
given code. **Neither branch has been proved for an unresolved infinite hard
code.** Every finite prefix is positively realizable, so no finite collection
of separated blocks can decide this infinitary question.

Classification: **`PROVED_AUX / GLOBAL REALIZABILITY GATE / UNRESOLVED
BRANCH`**. The exact converse/dichotomy was not located in the bounded source
search, but it is elementary and carries no priority or broad novelty claim.
Evidence: [checker](verification/bounded_alphabet_endpoint_residue_gate.py)
and [frozen output](verification/bounded_alphabet_endpoint_residue_gate_output_2026-08-24.txt).

## 6. Decisive corrections and counterexamples

These are especially useful when reviewing future claims.

1. **Equal slope can still coalesce.** Under the shortcut map,
   `S^3(8x+5)=3x+2=S^3(8x+4)`. A search that requires strict leading-slope
   decrease is incomplete.
2. **Minimality is rooted, not renewable.** With root `7` and endpoint `11`,
   the shortcut path `11 -> 17 -> 26 -> 13 -> 20 -> 10` has a local decrease
   `11 -> 10` but stays above the root. This invalidates automatic renewal of
   the near-return argument.
3. **Hard-boundary normalization does not create descent.** The exact return
   `31 --S^7--> 182 --S--> 91` grows and recharges the current replay debt.
4. **A finite direct-descent cover cannot handle Mersenne starts.** For fixed
   `K`, choose `m>K`; then the first `K` shortcut iterates of `2^m-1` have the
   form `3^j 2^(m-j)-1` and exceed the start.
5. **Finite cycle search remains finite.** The max-`C` DP's zero-candidate
   result applies only to its stated 91 `(k,q)` pairs; `k` and `D` are
   unbounded globally.
6. **Prime recycling is not growing prime support.** For example,
   `15 -> 23 -> 35 -> 53 -> 5 -> 1` under `A`; adjacent coprimality does not
   prevent a prime from reappearing later.
7. **The old third terminal cylinder was spurious.** When
   `v_2(3x-1)=6`, the exact identity `A^3(x)=18p+1<x` applies. The
   `64u+43` family is therefore removed; only `H_1` and `H_2` remain in the
   trajectory normal form.
8. **The enlarged decreasing rewrite is not confluent or exhaustive.** From
   `11`, one reduction reaches `1` while another reaches irreducible `7`; the
   mixed word `(2,2,1,1)` also reduces every `91+162t` from a smaller source.
9. **Finite scripts do not produce an infinite positive seed.** Dyadic
   cylinders and CRT realize every stated finite valuation/prime-return script,
   but their compatible inverse limit may be only a 2-adic or profinite ghost.
10. **Endpoint characterization is not endpoint control.** The bounded-alphabet
    gate says exactly what eventual zero carry would mean; it does not prove
    eventual zero carry, or infinitely many carries, for the unresolved hard
    codes.

## 7. Formal-check boundary

The reviewed lineage contains exactly three narrow Lean developments relevant
to this handoff:

| Module | Kernel-checked scope | Remaining prose obligation |
|---|---|---|
| [InverseWordBoundary.lean](lean/CollatzWork/InverseWordBoundary.lean) | Equal-slope affine comparison and the `8x+5 / 8x+4` witness. | Full inverse-word guards and class completeness are not formalized. |
| [RefinedMersenneChild.lean](lean/CollatzWork/RefinedMersenneChild.lean) | Easy-child arithmetic, iterate identity, and coalescence. | Hard-child classification, successor normalization, rank recharge, and coverage are prose. |
| [TwoPumpDependency.lean](lean/CollatzWork/Disproof/TwoPumpDependency.lean) | Determinant dependencies, zero resultant, and syzygy. | It proves no existence or nonexistence theorem for a positive cycle. |

The first two are imported by the umbrella build. The two-pump module must be
compiled directly. The exact dependency reports contain only the standard
axioms recorded in the [verification manifest](verification/README.md); no
accepted module uses `sorryAx`.

There is no Lean formalization of the complete YAH semantics, any YAH
cancellation or scalar-arctic certificate, the hard-child rank theorem, the
hard-return equivalence, Round 6A, L14, L15, the direct-return or renewal
filters, the prime-window no-go, the bounded-alphabet endpoint gate, the
expansion-threshold/tail lemmas, the S-unit/branching lemmas, the conditional
Thue--Morse construction, or Collatz.
The untracked residue-first-integral module checks only the abstract
finite-action core described in Section 5.5. It is not part of this Git
snapshot, and the all-moduli quotient/lift theorem remains a prose obligation.

## 8. Reproduction commands and expected outcomes

Run from the repository root with the pinned toolchain. The Python checkers use
only the standard library.

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
python -B verification\check_note_graph.py
```

Expected decisive outputs:

- L14: 500,000 odd starts through `n=1,000,000`, maximum 19 normalizer
  edges, counterfamily through `s=10,000`, then `PASS`;
- L15: 50,000 odd rewrite starts, 12,500 inverse/source endpoints, 510
  mixed words, 10,001 members of the `91 mod 162` family, 24 pure-`a=2`
  depths, then `PASS`;
- bounded-alphabet gate: 9,840 words through depth 8, the five seeds
  `1,3,7,27,429111` reconstructed, the all-`1`, all-`2`, and periodic
  `1113` boundary cases replayed, then exactly
  `PASS: exact finite identities and boundary regressions` and the following
  `SCOPE:` line;
- direct-return/renewal: 50,000 typed parameters, 3,570 completed switching
  returns, 50,000 renewal states, two nontrivial divisor witnesses, then
  `PASS`;
- prime renewal: 10,000 correction prefixes, 10,000 hard parameters, 44
  primes through `199`, largest checked gap `178`, one five-prime/38-step
  script, 48 rough-growth pairs, then `PASS`;
- adjacent-edge YAH: `weighted strict lower bound = 1`,
  `W_(f,f) <= -1`, then `PASS`;
- fixed two-state YAH: `model equations = 22`,
  `fixed-terminal legal contexts = 441`, `symbol certificate rows = 8`,
  `edge certificate rows = 50`, then `PASS`;
- scalar-arctic full/extended: original 11-row and labeled 22-row
  cancellations, both with total multiplier 49 and zero weighted delta, then
  both `PASS`;
- scalar-arctic top: 10 cases, 491 integer Farkas lemmas, 426 RUP clauses,
  then `TOP_SCALAR_ARCTIC_NO_FIRST_STEP = PASS`;
- max-`C` DP: 91 pairs, peak 47,517 states, 9 trivial encodings, 0
  nontrivial candidates;
- direct two-pump Lean replay: five dependency reports with only `propext` and
  `Quot.sound`;
- umbrella Lean: `Build completed successfully`;
- note graph: 56 Markdown notes, 273 local links, 0 broken links, 0
  unreachable notes, then `NOTE_GRAPH = PASS`.

The fresh combined audit recorded all twelve claim/check/build commands plus
the separate note-graph command as passing with Python 3.14.5, Lake
`5.0.0-src+819816b`, and Lean 4.33.1. The exact command-to-claim mapping,
formal axiom boundary, and retained historical diagnostics are in the
[verification manifest](verification/README.md). A checker `PASS` validates
only its displayed finite or algebraic scope; it does not machine-check the
universal prose proofs or Collatz.

## 9. Route table at the snapshot cutoff

These statuses classify mechanisms, not whether the broader proof or disproof
objective is allowed to continue.

| Status | Route or artifact | Exact meaning at cutoff |
|---|---|---|
| **LIVE / FOCAL** | Bounded-alphabet endpoint carries | Positive realization is exactly eventual zero carry, equivalently normalized endpoint decay. For guarded `{1,3}` hard-block codes, eventual zero carry would construct a positive divergent orbit; infinitely many carries exclude the chosen code. Neither branch is known for an unresolved infinite code. |
| **LIVE / FOCAL** | Fixed-seed infinite-tail coupling | Every relevant finite script has positive realizations, but those starts vary with the prefix. A useful next result must control the canonical endpoint sequence or one fixed positive seed across the infinite tail; another finite CRT or larger bound does not address this gate. |
| **LIVE** | Richer/context-sensitive YAH termination | Scalar symbol/edge/function classes have cancellations, and the standard first dimension-one scalar-arctic full/top routes are closed; matrix, multidimensional, transformed, nonadditive, or richer context semantics remain possible. Any candidate must orient every required rule and preserve the published Collatz reflection. |
| **LIVE** | Finite guarded residue graph with a genuine rank | Finite bounded-depth trees are dead, but a concrete finite graph with exact whole-family edges and a proved well-founded back-edge rank would be new. No such graph/rank is currently known. |
| **LIVE** | Augmented-state ranking | A concrete nonlocal or richer symbolic rank may evade the periodic-shadow and hard-recharge barriers. Guessing another bounded scalar correction does not. |
| **LIVE** | Positive cycle/divergence construction | Exact low-cost witness search remains legitimate. A divergent construction must permit infinitely growing prime support or else it becomes eventually periodic by the S-unit corollary. |
| **STOPPED-USEFUL** | Refined Mersenne easy child and hard boundary | One child closes by induction; the other has exact successor cells and exact obstructions for the tested inverse/rank classes. A richer cross-label mechanism is needed. |
| **LIVE / OPEN-USEFUL** | L14/L15 decreasing rewrite and direct hard returns | Every positive odd input rewrites downward to an explicitly smaller residual set, but L15 proves the relation nonconfluent and nonexhaustive. The direct typed hard-return system is partial; an infinite ray would be aperiodic and unbounded, but no such ray is constructed or excluded. |
| **STOPPED-USEFUL** | Pure exponent-`2` fixed-depth inverse policy | For every proposed uniform depth, an exact CRT family remains irreducible while the repeated least exponent-`2` predecessors only grow and then terminate. Mixed/adaptive words and forward merges remain live. |
| **STOPPED-USEFUL** | Finite prime-return and roughness windows | Arbitrarily delayed prime returns, any finite list of pairwise-distinct designated return blocks, and arbitrarily long rough growth shadows all occur in positive finite orbit segments. Only a fixed-seed global invariant could revive this direction. |
| **STOPPED-USEFUL** | Fixed finite-prime-support divergence | Impossible unless the orbit is eventually periodic. This redirects divergence architectures toward unbounded prime support. |
| **STOPPED-USEFUL** | Two-center branching and two-pump elimination | Both exact ansatzes collapse for algebraic reasons. Larger/different constructions remain untouched. |
| **STOPPED-USEFUL** | Memoryless single-modulus residue first integrals (`KILLED_CLASS`) | Every coloring of one fixed finite residue ring invariant under every positive ordinary Collatz step is constant. Finite-state memory, forward traps, ranked residue graphs, state-dependent or growing moduli, non-residue invariants, and direct witnesses remain untouched. |
| **STOPPED-USEFUL** | Eventually periodic exact valuation tails | Infinite repetition of an aligned finite valuation word forces its exact positive cycle equation. No theorem makes a relevant tail periodic; all finite valuation words remain realizable. |
| **DEAD** | Finite uniformly bounded direct-descent cover | Mersenne starts defeat every maximum horizon. |
| **DEAD** | Unrefined one-shot Mersenne inverse-word closure | The all-depth slope theorem closes exactly that certificate class, not ranked recursion or refinement. |
| **DEAD** | Scalar YAH relative interpretation by strictly increasing `N`-self-maps | The two-rule contradiction already applies with the dynamic rule strict and the auxiliary rule weak. |
| **DEAD** | The audited fixed two-state additive YAH classes | The 8-row and 50-row cancellations kill scalar and every finite-lex tuple within that exact algebra/locality class. |
| **DEAD** | Current hard-state affine rank and cyclic two-pump resultant | The guarded recharge edge kills the stated affine rank class; the resultant is identically zero. |
| **PROVISIONAL** | Round 6A beta-debt theorem package | Highest-value older conceptual reconstruction target, but key lift/endpoint/scaling obligations lack Lean and independent specialist review. Do not cite it as an established Collatz theorem. |
| **PROVISIONAL** | Auxiliary YAH normalization/confluence flash | The bounded independent audit stopped without a verdict. It is omitted from Accepted Results and must not be cited as proved. |
| **PROVISIONAL / NO DISPROOF** | Thue--Morse 2-adic anchor | The displayed 2-adic product and conditional divergence calculation are exact, but the essential assertion that the 2-adic value is one positive ordinary integer is unproved. Finite-prefix realizations do not fill that gap. |

A stopped shot never closes the overall research objective. It closes only its
exact architecture; live lanes continue under the project's earned-continuation
gate.

## 10. Active missing lemmas

These are concrete research objects rather than a disguised request to “prove
Collatz.”

1. **Resolve one bounded hard code at the endpoint gate.** For a fully
   specified infinite guarded code
   `(1^(L_0)3)(1^(L_1)3)...` with every `L_i>=3`, prove either eventual zero
   carry for its canonical `M_k` (which reconstructs one positive divergent
   orbit) or infinitely many positive carries (which excludes that code).
   Finite-prefix realizability, numerical decay over a growing cutoff, or the
   assertion that compatible residues “converge to a seed” is insufficient.
2. **A fixed-seed global coupling invariant.** Give an exact invariant or
   rank controlling one ordinary positive seed across infinitely many blocks.
   It must distinguish ordinary-integer stabilization from a nonordinary
   2-adic/profinite limit. More finite prime windows, finite CRT scripts, or
   larger brute-force bounds do not address this lemma.
3. **A non-scalar YAH certificate.** Exhibit a finite, checkable ordered
   algebra (for example a specific matrix/vector or context-sensitive order)
   that makes the two dynamic rules strict, the nine auxiliary rules weak,
   is well-founded on every canonical encoded input, and satisfies the exact
   published simulation/reflection theorem. This is a finite certificate with
   explicit inequalities, not the bare assertion that all orbits terminate.
4. **A guarded macro graph with a specified well-founded rank.** Give the
   finite states, congruence guards, exact affine macro edges, and a concrete
   rank decrease on every back-edge, including the known Mersenne successor
   cells and recharge edge. “Every state eventually descends” by itself is
   equivalent to Collatz and is not an acceptable missing lemma.
5. **A rooted transition/rank for the L15 residual set.** L14 reduces every
   positive odd input abstractly to `1` or `H_1 union H_2`, and L15 shrinks
   the irreducibles by two predecessor rules. The rewrite is nonconfluent,
   coalescence need not be an orbit edge, and the displayed direct return map
   is partial. A completion must control exits and recurrent residual
   transitions without assuming the desired smaller iterate.
6. **The Round 6A formal foundation.** Independently reconstruct the positive
   rational-period lift, endpoint valuation, same-phase scaling, and beta-debt
   chain. These are specific conditional lemmas useful for judging a proposed
   ranking class; proving them would still not prove Collatz.
7. **A genuine disproof object.** For a cycle, provide the positive integer,
   parity/valuation word, divisibility, and exact replay. For divergence,
   provide a positive forward-invariant mechanism whose orbit is rigorously
   nonterminating and, if claimed unbounded, controls its necessary growing
   prime support.

## 11. Provisional or do-not-cite material

- Round 6A remains a specialist-review target, not an accepted global theorem.
- The YAH auxiliary-normalization/confluence flash did not finish its audit.
- [`C-TM-MAHLER-ANCHOR-001`](proof-search/disproof/CODEX_TM_MAHLER_ANCHOR_2026-08-24.md)
  is an artifact, but **not an accepted disproof result**. For the
  Thue--Morse code `a_i=1+t_i`, it defines the exact 2-adic value

  \[
  N=\frac19\prod_{m\ge0}\left(1-(8/9)^{2^m}\right)-6
  \]

  and proves that, **if** `N` is a positive ordinary integer, its accelerated
  orbit follows that code and diverges at least geometrically. The membership
  premise \(N\in\mathbb Z_{>0}\) is wholly unproved. The object currently
  supplied is only an element of \(\mathbb Z_2\); finite positive realizations
  of every prefix do
  not turn it into an ordinary positive integer. Status:
  **`PAUSED_AWAITING_EXACT_2_ADIC_MEMBERSHIP / NO DISPROOF / DO NOT CITE AS A
  COUNTEREXAMPLE`**.
- Artifact presence, a hostile internal replay, or an exact finite checker is
  not external specialist review and is not a novelty or priority certificate.
- Bounded survivor percentages, finite cycle searches, and finite verification
  ranges are diagnostics. They are not statistical evidence that Collatz is
  true or false.
- “Exact form not found” is not a novelty or priority certificate.

## 12. Claims explicitly not being made

This project does **not** claim:

- a proof or disproof of the Collatz conjecture;
- external specialist validation or peer review of a repository-specific
  claim;
- that the YAH rewrite system has or lacks a termination proof in general;
- that semantic labeling, matrix interpretations, finite automata, or all
  nonlinear ranks fail;
- that the hard child is completely classified beyond the stated time and
  unrefined inverse-word class;
- that a finite computation excludes all cycles or proves convergence;
- that an equivalent hard-return system constitutes progress toward its
  universal termination;
- that the S-unit corollary rules out a nontrivial cycle;
- that the residue-first-integral obstruction excludes finite-state memory,
  forward traps, ranked recursive residue graphs, state-dependent or growing
  moduli, non-residue invariants, or a Collatz counterexample;
- that the trajectory normal form makes the original orbit enter `H_1` or
  `H_2`, or that either terminal family is solved;
- that the L14/L15 rewrite is confluent, canonical, or exhaustive over all
  finite trajectory-preserving reductions;
- that the direct typed hard-family system is total, or that an infinite
  positive typed ray exists or has been excluded;
- that the expansion-block inequality uniformly bounds run length when `s`
  varies, or applies across different seeds without its `N+1` term;
- that a relevant valuation tail is eventually periodic or uses only the
  alphabet `{1,3}`;
- that realizability of every finite valuation or prime-return script produces
  one positive integer realizing the corresponding infinite script;
- that the bounded-alphabet endpoint gate proves eventual zero carry or
  infinitely many carries for every aperiodic code;
- that the Thue--Morse 2-adic anchor is a positive ordinary integer, a
  divergent positive orbit, or a counterexample;
- that finite prime-return, roughness, or delayed-recycling conditions constrain
  a fixed infinite orbit beyond the exact finite scopes stated here;
- or that any potentially project-specific certificate is novel in the
  publication-priority sense.

## 13. Primary-source map and novelty discipline

- Exact YAH system and Collatz equivalence: Yolcu, Aaronson, and Heule,
  [“An Automated Approach to the Collatz Conjecture”](https://doi.org/10.1007/s10817-022-09658-8)
  and their [official artifact](https://github.com/emreyolcu/rewriting-collatz).
- Semantic labeling: Zantema,
  [“Termination of Term Rewriting by Semantic Labelling”](https://doi.org/10.3233/FI-1995-24124).
- Parity/stopping-time arithmetic: Terras
  ([1976](https://doi.org/10.4064/aa-30-3-241-252)), Everett
  ([1977](https://doi.org/10.1016/0001-8708(77)90087-1)), and Lagarias
  ([1985](https://doi.org/10.1080/00029890.1985.11971528)).
- Sufficient-set context for L14: Monks
  ([2006](https://doi.org/10.1090/S0002-9939-06-08567-4)) and Monks et al.
  ([2012 preprint](https://arxiv.org/abs/1204.3904)). These results are
  substantially stronger than merely observing that convergence on the L14
  terminal union suffices.
- Infinite exponent-code and endpoint context: Wang's
  [E-sequence paper](https://arxiv.org/abs/1809.02278), Kramer's
  [endpoint-rate framework](https://arxiv.org/abs/2607.10041), and
  Bernstein--Lagarias
  ([1996](https://doi.org/10.4153/CJM-1996-060-x)). The exact bounded-alphabet
  converse/dichotomy in Section 5.11 was not located in the bounded search;
  this is not a priority certificate.
- Mersenne staircase/coalescence: Andrei–Masalagiu
  ([1998](https://doi.org/10.1007/s002360050117)),
  Andrei–Kudlek–Niculescu
  ([2000](https://doi.org/10.1007/s002360000039)), and Hercher's Lemma 9
  ([2023](https://cs.uwaterloo.ca/journals/JIS/VOL26/Hercher/hercher5.html)).
- Fixed-word cycle algebra: Böhm–Sontacchi
  ([1978](https://www.bdim.eu/item?id=RLINA_1978_8_64_3_260_0)), Crandall
  ([1978](https://doi.org/10.1090/S0025-5718-1978-0480321-3)), and Trümper
  ([2014](https://doi.org/10.1155/2014/756917)).
- Inputs used conditionally by L8: Bařina's verified-range result
  ([2025](https://doi.org/10.1007/s11227-025-07337-0)) and
  Rozier–Terracol's harmonic-mean obstruction
  ([2026](https://doi.org/10.1016/j.disc.2026.115167), Corollary 4.4).
- S-unit finiteness: Evertse
  ([1984](https://doi.org/10.1007/BF01388644)) and
  Evertse–Győry–Stewart–Tijdeman
  ([1988](https://ir.cwi.nl/pub/1716/1716D.pdf)); the finite-support argument
  is also an immediate Størmer-type corollary.

The exact finite YAH cancellations remain candidates for a narrow technical
note after specialist reconstruction and a broader literature search. The
bounded-alphabet endpoint theorem is the most important new route gate, but it
is presented as an elementary strengthening/package relative to Wang and
Kramer, not as a broad novelty claim. Every other result above is classified
as prior art, a routine specialization, a project-specific route obstruction
of uncertified novelty, or an internal verification artifact. In particular,
the normal-form, inverse-word, renewal, prime-window, single-modulus,
fixed-seed-threshold, finite-prefix, and periodic-tail statements carry no
priority claim merely because their exact packaging was not found quickly.

## 14. Suggested review order

For a first mathematical review:

1. Read Sections 1–3 and verify the current-main hash, the two mathematical
   component hashes, and the proof/disproof gates. Nothing in this packet is
   presented as a Collatz solution.
2. Read the [bounded-alphabet endpoint gate](proof-search/routes/F_bounded_alphabet_endpoint_residue_gate.md)
   first. Check the carry bounds, the positive-orbit growth bound, and every
   integrality/parity step in the eventual-zero-carry converse; then run its
   checker. This is the strongest new theorem and the most consequential
   independent-audit target.
3. Read [L14](proof-search/lemmas/L14_ThreeNMinusOne_Trajectory_Normal_Form.md)
   and [L15](proof-search/lemmas/L15_Expanded_Rewrite_and_Mixed_Inverse_Words.md),
   then run both regressions. Check especially the map convention,
   termination-equivalence, nonconfluence witness, mixed-word congruence, and
   the explicit equivalence boundary at universal certificate coverage.
4. Read the [direct-return](proof-search/routes/AB_direct_H_return_and_renewal_filters.md)
   and [prime-renewal](proof-search/routes/AB_prime_renewal_finite_window_no_go.md)
   notes, then run their regressions. Verify that every conclusion is finite or
   conditional and that no CRT paragraph silently changes the seed with the
   prefix.
5. Replay all four YAH checkers and inspect their linked additive and
   scalar-arctic notes; then compile the three narrow Lean modules and compare
   declarations with the prose scopes in Sections 4 and 7.
6. Check the max-`C` DP completeness proof before interpreting its bounded
   output. Audit L13 and the older short results only as needed for route
   context.
7. Read the [Thue--Morse note](proof-search/disproof/CODEX_TM_MAHLER_ANCHOR_2026-08-24.md)
   last and only as provisional work. The decisive question is not the formal
   product identity; it is the entirely open assertion that its 2-adic value
   is a positive ordinary integer.
8. Use the [research atlas](ATLAS.md),
   [claim registry](proof-search/CLAIM_REGISTRY.md),
   [failure ledger](proof-search/FAILURE_LEDGER.md), and
   [verification manifest](verification/README.md) for the complete archive.

The highest-value referee questions are narrow: whether the endpoint-gate
converse is completely airtight, whether one can control its carry branch for
a specified infinite hard code without importing a 2-adic ghost, whether the
YAH cancellations are correctly situated in termination theory, and whether
the hard-rank obstruction has a meaningful generalization. None should be
framed as checking a claimed solution, because no solution is claimed.
