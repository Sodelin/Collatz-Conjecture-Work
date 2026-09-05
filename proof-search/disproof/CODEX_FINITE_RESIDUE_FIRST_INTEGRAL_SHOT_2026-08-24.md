# F-FINITE-RESIDUE-FIRST-INTEGRAL-001

**Date:** 2026-08-24  
**Base:** `b3b9f4731937a2d7c999d1b8a6417c9e96597e46`  
**Verdict:** `STOPPED-USEFUL / KILLED_CLASS / NO DISPROOF`

## Exact claim tested

Let the full positive Collatz map be

$$
C(n)=
\begin{cases}
n/2,&n\text{ even},\\
3n+1,&n\text{ odd}.
\end{cases}
$$

For a modulus `m>=2` and an arbitrary set of colors `S`, consider a
residue-only function

$$
I_m:\mathbb Z/m\mathbb Z\longrightarrow S
$$

satisfying, for **every** positive integer `n`,

$$
I_m([C(n)]_m)=I_m([n]_m).                             \tag{1}
$$

The proposed divergence witness was a nonconstant `I_m` together with an
explicit positive integer `n_0` such that

$$
I_m([n_0]_m)\ne I_m([1]_m).                           \tag{2}
$$

If (1)--(2) held, the orbit of `n_0` could never reach `1`: iterating (1)
would make its color equal to the color of `1`.  Thus (after the positive
membership and exact invariance checks) this would have been a genuine
nontermination certificate, not an inference from a finite search.

The shot proves the following universal kill.

> **Theorem.** For every `m>=1`, every residue-only coloring satisfying (1)
> is constant.  Consequently (2) is impossible for every positive `n_0`.

This theorem closes only memoryless first integrals of one finite residue.
It says nothing about finite automata with state, traps, rankings, residue
graphs with progress measures, or non-residue invariants.

## Predeclared kill and hard stop

The cheapest kill was structural:

1. if `m` is even, compare two positive even lifts in the same class and
   force factorization through `m/2`;
2. once `m` is odd and divisible by `3`, compare same-parity positive odd
   lifts separated by `2m/3` and force factorization through `m/3`;
3. on the remaining modulus coprime to `6`, use the affine permutations
   `A(x)=2x` and `B(x)=3x+1`; their commutator is a generating translation.

The hard stop was a proof or counterexample to this exact universal theorem.
No modulus sweep, larger bound, DFA memory, trap, or graph widening was
allowed.  The expected durable artifact was an exact factor-descent proof and
a Lean replay of the finite-group core.  Compute class: constant symbolic
identities and a generic Lean compilation, with no enumeration.

## Lemma 1: an even modulus factors through half the modulus

Suppose `m=2d`.  Fix an arbitrary residue `r` modulo `m`.  Choose a positive
integer `R` representing it and put

$$
N=2R,\qquad N'=N+m.
$$

Both `N,N'` are positive and even, and they have the same residue modulo `m`.
Their Collatz images are

$$
C(N)=R,\qquad C(N')=R+d.
$$

Applying (1) to both lifts and using `[N']_m=[N]_m` gives

$$
I_m([R]_m)=I_m([R+d]_m).                              \tag{3}
$$

Because `r` was arbitrary, (3) holds on every residue.  The two elements in
each fiber of

$$
\pi:\mathbb Z/(2d)\mathbb Z\longrightarrow\mathbb Z/d\mathbb Z
$$

therefore have the same color.  Hence there is a unique function `I_d` with

$$
I_m=I_d\circ\pi.                                      \tag{4}
$$

No parity assumption was made about `R`; the actual lifts `2R` and `2R+m`
are even because `m` is even.

## Lemma 2: an odd modulus divisible by 3 factors through one third

Suppose `m=3d` is odd.  Then `d` is odd.  For any residue `r` modulo `m`, an
odd positive representative `N` exists: adding the odd modulus, if necessary,
switches parity without changing the residue.

Set

$$
N'=N+2d=N+2m/3.
$$

The displacement `2d` is even, so `N'` is also positive and odd.  Their odd
Collatz images satisfy

$$
C(N')-C(N)=3(2d)=2m,
$$

and hence have the same residue modulo `m`.  Invariance (1) gives

$$
I_m([r]_m)=I_m([r+2d]_m).                             \tag{5}
$$

Apply (5) once more starting at `r+2d`:

$$
I_m([r]_m)=I_m([r+4d]_m)=I_m([r+d]_m),                \tag{6}
$$

because `4d` and `d` differ by `m=3d`.  Thus all three elements of each
fiber of reduction modulo `d` have the same color, and `I_m` factors uniquely
through a function `I_d` on `Z/dZ`.

The use of `N,N+2m/3`, rather than representatives separated by `m/3`, is
what keeps both lifts odd.

## Lemma 3: invariance and the witness separation descend

In either factorization above, let `d` be `m/2` or `m/3` and write
`I_m=I_d \circ \pi`.  For every positive integer `n`,

$$
\begin{aligned}
I_d([C(n)]_d)
 &=I_m([C(n)]_m)\\
 &=I_m([n]_m)\\
 &=I_d([n]_d).
\end{aligned}                                        \tag{7}
$$

So the induced coloring is again invariant under every positive canonical
Collatz step.  Moreover, any alleged separation (2) becomes

$$
I_d([n_0]_d)\ne I_d([1]_d).                           \tag{8}
$$

Thus neither invariance nor the proposed positive witness can disappear
silently during factor descent.  Conversely, if the descended coloring is
constant, (4) makes the original coloring constant.

## Lemma 4: the modulus coprime to 6 has no nonconstant coloring

Assume `gcd(m,6)=1`.  Work in `R=Z/mZ` and define

$$
A(x)=2x,\qquad B(x)=3x+1.
$$

Both are permutations because `2` and `3` are units in `R`.

For any `x` in `R`, choose a positive integer representative `R_x` and apply
(1) to the positive even number `2R_x`.  Its input and output residues are
`A(x)` and `x`, respectively, so

$$
I_m(A(x))=I_m(x).                                     \tag{9}
$$

Because `m` is odd, every residue also has a positive odd representative.
Applying (1) to such a representative gives

$$
I_m(B(x))=I_m(x).                                     \tag{10}
$$

Invariance under a permutation implies invariance under its inverse: apply
(9), for example, at `A^{-1}(x)`.  Therefore `I_m` is invariant under

$$
K=B^{-1}A^{-1}BA.
$$

Writing `1/2`, `1/3`, and `1/6` for the corresponding units in `R`, direct
calculation gives

$$
\begin{aligned}
K(x)
 &=B^{-1}\!\left(A^{-1}(6x+1)\right)\\
 &=B^{-1}(3x+1/2)\\
 &=(3x+1/2-1)/3\\
 &=x-1/6.                                             \tag{11}
\end{aligned}
$$

Thus `K` is translation by the additive generator `-1/6`.  Indeed,
multiplication by the unit `-1/6` permutes all residues, so the iterates

$$
K^k(x)=x-k/6
$$

visit every element of `R`.  Since `I_m` is invariant under `K`, it has the
same value at every residue.  Hence it is constant.

## Completion for every modulus

Write uniquely

$$
m=2^r3^s q,\qquad \gcd(q,6)=1.
$$

Apply Lemma 1 exactly `r` times.  The remaining modulus is odd.  Apply Lemma
2 exactly `s` times.  Lemma 3 preserves the universal invariance and any
alleged separation at every stage.  The result is a coloring modulo `q`.

- If `q=1`, its domain is a singleton, so it is constant.
- If `q>1`, Lemma 4 makes it constant.

Pulling constancy back through all factorizations proves that `I_m` was
constant.  This proves the universal theorem and contradicts the required
positive-witness separation (2).

## Lean replay and formal boundary

The independent module
`lean/CollatzWork/Disproof/FiniteResidueFirstIntegral.lean` formalizes the
decisive finite-group implication without importing any prior disproof module:

1. invariance under a bijection implies invariance under an explicit inverse;
2. invariance under `A` and `B` implies invariance under
   `B^{-1} A^{-1} B A`;
3. invariance persists under every finite iterate; and
4. a transitive commutator forces the coloring to be constant.

The module intentionally does **not** formalize quotient types for `Z/mZ`,
the positive-lift constructions (3) and (5), factor descent (4)--(8), or the
modular arithmetic calculation (11).  Those are the exposed formalization
boundary; the exact paper proof above supplies them.  This is therefore a
partially formalized universal theorem, not a claim that Lean checked the
entire quotient/lift bridge.

Reproduce from the isolated worktree root:

```powershell
C:\Users\Owner\.elan\bin\lake.exe env lean lean\CollatzWork\Disproof\FiniteResidueFirstIntegral.lean
```

Expected result: exit code `0`; all five printed theorem reports say that
they depend on no axioms.

## Prior-art comparison and scope

No exact residue-only first-integral theorem was found in the repository
claim registry, approach registry, failure ledger, or continuation note.  It
is adjacent to Route B/C finite-residue ideas, but it neither analyzes a
recursive residue graph nor rules one out.  It differs from `F015`: the proof
is symbolic for every modulus and is not a bounded affine-coalescence miss.
It also makes no inference from absence of a witness.

The result is elementary enough that no literature novelty is claimed.  No
registry or ledger edit is proposed before independent replay and acceptance.
In particular, this result must not be promoted as evidence for the Collatz
conjecture: it only proves that one very small disproof-certificate class is
empty.

## Shot handoff

- **Claim ID:** `F-FINITE-RESIDUE-FIRST-INTEGRAL-001`.
- **Verdict:** `STOPPED-USEFUL / KILLED_CLASS / NO DISPROOF`.
- **Exact object/family:** a nonconstant memoryless coloring of one finite
  residue ring, invariant under every positive step of the full canonical
  Collatz map, plus a positive `n_0` separated in color from `1`.
- **Positivity and integrality:** every lift used above is explicitly positive
  and has the required parity.  The universal theorem rules out the color
  separation for every positive integer `n_0`.
- **Decisive equations/replay:** (3) forces `m -> m/2`; (5)--(6) force
  `m -> m/3`; (7)--(8) preserve invariance and separation; (11) is a
  transitive unit translation.  The finite-group implication is Lean-checked.
- **Prior-art status:** no exact repository duplicate found; adjacent to, but
  strictly narrower than, finite-state residue certificate routes.  No
  novelty claim and no registry edit.
- **Remaining gap:** invariants with finite or infinite memory, residue traps,
  ranked recursive graphs, state-dependent moduli, and all direct cycle or
  divergent-orbit constructions remain untouched.
- **Reproduction:** the single Lean command above; there is no search bound or
  numeric transcript.
- **Files:**
  `proof-search/disproof/CODEX_FINITE_RESIDUE_FIRST_INTEGRAL_SHOT_2026-08-24.md`
  and `lean/CollatzWork/Disproof/FiniteResidueFirstIntegral.lean`.
- **Single best next question:** can the quotient/lift bridge and modular
  affine calculation be formalized end to end in Lean, producing the full
  all-moduli constancy theorem without adding state, memory, or a search?
