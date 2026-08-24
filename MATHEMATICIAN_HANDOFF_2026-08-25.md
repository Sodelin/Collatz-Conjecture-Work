# Mathematician handoff — 2026-08-25

> **Bottom line:** the Collatz conjecture is still unresolved. No universal
> proof and no disproof has passed independent reconstruction in this project.
> In particular, the project has not produced a positive nontrivial cycle or a
> positive orbit rigorously proved to diverge.

This is a review snapshot of an AI-assisted, adversarially audited research
archive. It is designed to let a mathematician separate exact narrow results,
equivalent reformulations, bounded computations, and unfinished ideas without
reading the full historical log first.

- Public repository snapshot reviewed here:
  `b3b9f4731937a2d7c999d1b8a6417c9e96597e46`.
- Its accepted mathematical parent-line snapshot:
  `8a93ea5e8377f16be5b54f5fe0de9f8d9a85b3a9`.
- Snapshot cutoff: the audited stable packets explicitly named in Sections 4
  and 5 through this PR update on 2026-08-24. Live lanes may continue
  independently; a result not named here is not silently included.
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
`T`. Every identity below states which convention it uses.

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

## 3. Current public status in plain language

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

The strongest externally reviewable project-specific artifacts are the finite
YAH cancellation certificates. Their exact forms were not found in a bounded
primary-source audit, but priority is not certified. The strongest formal
artifacts are three narrow Lean modules. None is a proof or disproof of
Collatz.

Publication readiness is correspondingly limited:

- **Submission-ready proof/disproof:** none.
- **Best candidate for a narrow technical note:** the checker-backed YAH
  cancellations, after independent term-rewriting specialist review, formal
  certification, and a broader novelty search.
- **Research-review material:** the L13 hard/rank obstruction, the scalar YAH
  two-rule contradiction, and Round 6A. The first two are narrow route results;
  Round 6A remains provisional.
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
| Two-pump cyclic dependency | For the exact determinant coefficients in the audit, `aB=cC` and `gA=dE`; hence `cgAC-adBE=0` identically. Cyclic rotation supplies no independent constant resultant. | [Audit](proof-search/disproof/CODEX_TWO_PUMP_DEPENDENCY_AUDIT_2026-08-24.md), [Lean module](lean/CollatzWork/Disproof/TwoPumpDependency.lean), object `974dbcb58ea40cf9365689a27de4df3ceafa0b75`. | Formal route-design obstruction, not a cycle exclusion. Elementary specialization of classical fixed-word algebra; no priority claim. |
| Corrected max-`C` cycle DP | For each fixed `(k,q)`, keeping the maximum exact affine coefficient `C` in each residue state is complete. With `k<=40` and `0<D=2^k-3^q<=250000`, the run exhausts 91 pairs, peaks at 47,517 merged states, finds 9 trivial `1`/`2` encodings and 0 nontrivial candidates. | [Audit](proof-search/disproof/CODEX_DISPROOF_CYCLE_DP_AUDIT_2026-08-24.md), [script](verification/disproof_cycle_search.py), [output](verification/disproof_cycle_search_output_2026-08-24.txt), object `4e883e4deaa881b843f26473692c5483a220d91d`. | Exact bounded computation only, much weaker than published cycle/computational bounds. The earlier arbitrary-representative DP is superseded. |
| Conditional coefficient-stopping barrier | Assuming the named `2^71` verified range and the Rozier–Terracol input, a least counterexample has no coefficient contraction before accelerated time `114,208,327,604`. | [L8 statement](proof-search/lemmas/L8_Farey_Certified_Coefficient_Barrier.md), checker/output indexed in the [verification manifest](verification/README.md), statement object `03f4049cca8b5c5cc87856b8ac807e126ef8e5d2`. | Strong necessary-condition certificate, conditional on external inputs and not Lean-formalized. It is not a global convergence theorem. |

The [failure ledger](proof-search/FAILURE_LEDGER.md) records the exact
supersession boundary for older claims, including the invalid L5 strict-slope
necessity, the first cycle-DP merge, and the attempted renewable near-return
argument.

## 5. Accepted snapshot additions without standalone Git artifacts

The following seven statements were independently reconstructed for this
handoff after `b3b9f473...`. Their proofs are short enough to audit below, but
the source lanes did not publish standalone artifacts into the reviewed Git
lineage. They therefore have **no standalone public artifact commit at the
cutoff**. Treat them as accepted scoped prose in this snapshot, not as
end-to-end formalized or priority-bearing repository theorems.

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

### 5.2 Deterministic trajectory normal form

`A-TRAJECTORY-NORMAL-FORM-001` supersedes the earlier three-cylinder
least-counterexample sieve. Treat `1` as terminal. For a positive odd `x>1`,
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

Classification: **`OPEN-USEFUL / NO PROOF`**. The rewrite is deterministic,
strictly decreasing, and reachability-preserving only in the abstract sense
stated above.

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

## 7. Formal-check boundary

The public snapshot contains exactly three narrow Lean developments relevant
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

There is no Lean formalization of the complete YAH semantics, either YAH
cancellation certificate, the hard-child rank theorem, the hard-return
equivalence, Round 6A, the trajectory-normal-form/expansion-threshold/tail
lemmas, the S-unit/branching lemmas, or Collatz.
The untracked residue-first-integral module checks only the abstract
finite-action core described in Section 5.5. It is not part of this Git
snapshot, and the all-moduli quotient/lift theorem remains a prose obligation.

## 8. Reproduction commands and expected outcomes

Run from the repository root with the pinned toolchain. The Python checkers use
only the standard library.

```powershell
python -B verification\yah_2local_edge_no_go.py
python -B verification\yah_two_state_semantic_label_no_go.py
python -B verification\disproof_cycle_search.py
lake env lean lean\CollatzWork\Disproof\TwoPumpDependency.lean
lake build
```

Expected decisive outputs:

- adjacent-edge YAH: `weighted strict lower bound = 1`,
  `W_(f,f) <= -1`, then `PASS`;
- fixed two-state YAH: `model equations = 22`,
  `fixed-terminal legal contexts = 441`, `symbol certificate rows = 8`,
  `edge certificate rows = 50`, then `PASS`;
- max-`C` DP: 91 pairs, peak 47,517 states, 9 trivial encodings, 0
  nontrivial candidates;
- direct two-pump Lean replay: five dependency reports with only `propext` and
  `Quot.sound`;
- umbrella Lean: `Build completed successfully`.

Fresh QA for this review branch used Python 3.14.5, Lake
`5.0.0-src+819816b`, and Lean 4.33.1. All five promoted commands above passed
with those decisive outputs. The direct Lean module reported only `propext`
and `Quot.sound`; the umbrella build also reproduced the documented
`Classical.choice` dependency of `refinedChild_arithmetic`. A source scan of
all three modules found no `sorry`, `admit`, `sorryAx`, declared `axiom`, or
`unsafe` token.

Historical diagnostic commands and their retained outputs are indexed in
[verification/README.md](verification/README.md). A `PASS` from those scripts
validates only their exact finite or algebraic scope. In this fresh QA, five of
the six listed historical diagnostics passed. The file-path command
`python -B verification\round7_survivor_language_signatures.py` failed before
running its diagnostic with `ModuleNotFoundError: No module named
'verification'`; its package-style import is not portable under that invocation.
The committed historical transcript remains available, but the listed fresh
command is not currently reproducible. This caveat does not affect any of the
five promoted checks above.

## 9. Route table at the snapshot cutoff

These statuses classify mechanisms, not whether the broader proof or disproof
objective is allowed to continue.

| Status | Route or artifact | Exact meaning at cutoff |
|---|---|---|
| **LIVE** | Non-scalar/context-sensitive YAH termination | Scalar symbol/edge/function classes have small cancellations, but matrix, multidimensional, nonadditive, or richer context semantics remain possible. Any candidate must orient every required rule and preserve the published Collatz reflection. |
| **LIVE** | Finite guarded residue graph with a genuine rank | Finite bounded-depth trees are dead, but a concrete finite graph with exact whole-family edges and a proved well-founded back-edge rank would be new. No such graph/rank is currently known. |
| **LIVE** | Augmented-state ranking | A concrete nonlocal or richer symbolic rank may evade the periodic-shadow and hard-recharge barriers. Guessing another bounded scalar correction does not. |
| **LIVE** | Positive cycle/divergence construction | Exact low-cost witness search remains legitimate. A divergent construction must permit infinitely growing prime support or else it becomes eventually periodic by the S-unit corollary. |
| **STOPPED-USEFUL** | Refined Mersenne easy child and hard boundary | One child closes by induction; the other has exact successor cells and exact obstructions for the tested inverse/rank classes. A richer cross-label mechanism is needed. |
| **LIVE / OPEN-USEFUL** | Trajectory normal form with terminals `H_1,H_2` | Every positive odd input abstracts downward to `1` or one of two terminal families. Coalescence edges preserve reachability but need not be orbit edges; neither terminal family is resolved. |
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

A stopped shot never closes the overall research objective. It closes only its
exact architecture; live lanes continue under the project's earned-continuation
gate.

## 10. Active missing lemmas

These are concrete research objects rather than a disguised request to “prove
Collatz.”

1. **A non-scalar YAH certificate.** Exhibit a finite, checkable ordered
   algebra (for example a specific matrix/vector or context-sensitive order)
   that makes the two dynamic rules strict, the nine auxiliary rules weak,
   is well-founded on every canonical encoded input, and satisfies the exact
   published simulation/reflection theorem. This is a finite certificate with
   explicit inequalities, not the bare assertion that all orbits terminate.
2. **A guarded macro graph with a specified well-founded rank.** Give the
   finite states, congruence guards, exact affine macro edges, and a concrete
   rank decrease on every back-edge, including the known Mersenne successor
   cells and recharge edge. “Every state eventually descends” by itself is
   equivalent to Collatz and is not an acceptable missing lemma.
3. **A rooted transition/rank for `H_1` and `H_2`.** The trajectory normal form
   reduces every positive odd input abstractly to `1` or these two families,
   but a coalescing rewrite is not necessarily an orbit edge. A completion
   must control both families, finite and infinite coefficient-stopping, and
   nonperiodic valuation coupling without assuming the desired smaller orbit
   iterate. Such an assumption would only restate Collatz.
4. **The Round 6A formal foundation.** Independently reconstruct the positive
   rational-period lift, endpoint valuation, same-phase scaling, and beta-debt
   chain. These are specific conditional lemmas useful for judging a proposed
   ranking class; proving them would still not prove Collatz.
5. **A genuine disproof object.** For a cycle, provide the positive integer,
   parity/valuation word, divisibility, and exact replay. For divergence,
   provide a positive forward-invariant mechanism whose orbit is rigorously
   nonterminating and, if claimed unbounded, controls its necessary growing
   prime support.

## 11. Provisional or do-not-cite material

- Round 6A remains a specialist-review target, not an accepted global theorem.
- The YAH auxiliary-normalization/confluence flash did not finish its audit.
- Uncommitted source-lane files are not immutable GitHub artifacts. The seven
  short results in Section 5 are preserved here with
  their full accepted scope; any stronger source-lane wording is excluded.
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
- that the expansion-block inequality uniformly bounds run length when `s`
  varies, or applies across different seeds without its `N+1` term;
- that a relevant valuation tail is eventually periodic or uses only the
  alphabet `{1,3}`;
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

The exact finite YAH cancellations are the leading candidates for a narrow
technical note after specialist reconstruction and a broader literature
search. Every other result above is classified as prior art, a routine
specialization, a project-specific route obstruction of uncertified novelty,
or an internal verification artifact. The single-modulus first-integral
obstruction is classified as elementary modular-semigroup folklore; no
priority claim is made for its exact packaging. The new normal-form,
fixed-seed threshold, finite-prefix full-shift, and periodic-tail statements
are elementary parity/affine consequences; no novelty claim is made for their
packaging.

## 14. Suggested review order

For a first mathematical review:

1. Read Sections 1–3 of this file and confirm that the acceptance gates match
   your convention.
2. Replay the two YAH checkers, then inspect their linked certificate notes.
3. Compile the three narrow Lean modules and compare the declarations with the
   prose scopes in Sections 4 and 7.
4. Audit L13's easy identity, hard-child qualifier, and recharge edge; then
   read the hard-return note to see why closure is still equivalent to Collatz.
5. Check the max-`C` DP completeness proof before interpreting its bounded
   output.
6. Independently reconstruct the seven short snapshot additions in Section 5.
7. Use the [claim registry](proof-search/CLAIM_REGISTRY.md),
   [failure ledger](proof-search/FAILURE_LEDGER.md), and
   [verification manifest](verification/README.md) for the complete archive.

The highest-value referee questions are narrow: whether the YAH cancellations
are correctly situated in termination theory, whether the hard-rank obstruction
has a meaningful generalization, and whether Round 6A's conditional theorem
survives specialist reconstruction. None of those reviews should be framed as
checking a claimed solution, because no solution is claimed.
