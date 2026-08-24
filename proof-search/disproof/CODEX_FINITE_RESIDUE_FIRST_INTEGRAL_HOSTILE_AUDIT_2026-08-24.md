# Hostile audit of `F-FINITE-RESIDUE-FIRST-INTEGRAL-001`

**Date:** 2026-08-24  
**Pinned base:** `b3b9f4731937a2d7c999d1b8a6417c9e96597e46`  
**Verdict:** **PASS, scope-qualified — `STOPPED-USEFUL / KILLED_CLASS / NO DISPROOF`**

The all-modulus proof below was derived before the constructor artifacts were
read.  This audit verifies that the shot closes one narrow disproof
architecture.  It does not provide a positive nontrivial cycle, a positive
nonterminating orbit, or evidence from failure to find one.

## 1. Stable artifacts audited

- `proof-search/disproof/CODEX_FINITE_RESIDUE_FIRST_INTEGRAL_SHOT_2026-08-24.md`
  - SHA-256:
    `737224441621F0466A517E38E5CCDA1B745956640A76A6C715A8C1130A7F092D`
- `lean/CollatzWork/Disproof/FiniteResidueFirstIntegral.lean`
  - SHA-256:
    `EF19D5151CBE2C8C22824BAD1CE380063027136AA5924DC21FE2AC5E287A21FF`

The repository was at the requested detached base.  Neither constructor file
nor any earlier audited artifact was edited by this verifier.

## 2. Exact class and witness semantics

Let `m>=1`, let `S` be any set, and let

\[
I_m:\mathbb Z/m\mathbb Z\longrightarrow S
\]

satisfy

\[
I_m([C(n)]_m)=I_m([n]_m)                              \tag{1}
\]

for every positive integer `n`, where `C(n)=n/2` for even `n` and
`C(n)=3n+1` for odd `n`.

A genuinely constructed nonconstant `I_m` and explicit `n_0>0` with

\[
I_m([n_0]_m)\ne I_m([1]_m)                            \tag{2}
\]

would be a real Collatz counterexample certificate.  The map preserves the
positive naturals.  Induction using (1) keeps the color of every iterate equal
to the color of `n_0`; if an iterate were `1`, (2) would be contradicted.
Thus the orbit would never reach `1`.  If it were bounded, determinism on the
positive integers would force a nontrivial eventual cycle; otherwise it would
be unbounded.  Either case would refute the conjecture.

The shot does not construct such an object.  It proves that the required
nonconstant coloring cannot exist.

## 3. Even-period descent

Suppose `m=2d`.  For an arbitrary residue, choose a positive representative
`R` and form the two positive even lifts

\[
N=2R,\qquad N'=2R+m.
\]

They are congruent modulo `m`, while

\[
C(N)=R,\qquad C(N')=R+d.
\]

Applying (1) to both gives

\[
I_m([R]_m)=I_m([R+d]_m).                              \tag{3}
\]

Every fiber of reduction from modulus `2d` to modulus `d` therefore has one
color, so `I_m` factors uniquely through a coloring `I_d`.

The positivity and parity claims are exact.  A positive representative exists
also for the zero residue, and no parity condition on `R` is needed because
both displayed inputs are visibly even.

## 4. Odd three-factor descent

Strip all factors of two first.  If the remaining odd modulus is `m=3d`, then
`d` is odd.  Every residue modulo odd `m` has a positive odd representative
`N`.  Use

\[
N'=N+2d=N+2m/3.
\]

The displacement is even, so both lifts are positive and odd, and

\[
C(N')-C(N)=6d=2m.
\]

Their output residues coincide.  Equation (1) gives

\[
I_m(r)=I_m(r+2d).                                    \tag{4}
\]

Applying (4) at `r+2d` gives equality with `r+4d`, which is `r+d` modulo
`3d`.  Thus all three elements in each reduction fiber have the same color,
and `I_m` factors through modulus `d=m/3`.

Using separation `2m/3`, rather than `m/3`, is essential: it keeps the two
chosen lifts odd.  The constructor has the correct separation and iteration.

## 5. Inherited hypotheses

If `I_m=I_d\circ\pi`, then for every positive integer `n`,

\[
I_d([C(n)]_d)=I_m([C(n)]_m)=I_m([n]_m)=I_d([n]_d).
\]

Hence universal positive-step invariance descends.  The same substitutions
show that an alleged separation between `n_0` and `1` also descends.  If the
descended coloring is constant, its pullback is constant.  No witness is lost
or manufactured during the factor descent.

Iterating Sections 3 and 4 reduces every positive modulus uniquely to a
modulus `q` with `gcd(q,6)=1`.  The endpoint `q=1` is handled separately and
correctly: its residue domain is a singleton.

## 6. Coprime-period affine core

Let `gcd(q,6)=1` and `q>1`.  On `R=Z/qZ`, define

\[
A(x)=2x,\qquad B(x)=3x+1.
\]

Both maps are permutations.  For any `x`, applying (1) to a positive even
lift `2R_x` yields

\[
I(Ax)=I(x).                                          \tag{5}
\]

Because `q` is odd, every residue has a positive odd representative; applying
the odd branch to it yields

\[
I(Bx)=I(x).                                          \tag{6}
\]

Invariance under each permutation implies invariance under its inverse.
With functions applied from right to left, the constructor uses

\[
K=B^{-1}A^{-1}BA.
\]

The orientation and sign are correct:

\[
\begin{aligned}
K(x)
 &=B^{-1}\!\left(A^{-1}(6x+1)\right)\\
 &=B^{-1}(3x+1/2)\\
 &=(3x+1/2-1)/3\\
 &=x-1/6.
\end{aligned}                                       \tag{7}
\]

The translation increment `-6^{-1}` is a unit modulo `q`; consequently its
additive order is `q`, and the iterates of `K` visit every residue.  An
`A`- and `B`-invariant coloring is `K`-invariant and therefore constant.

Pulling constancy back through all factor maps proves the all-modulus theorem.

## 7. Lean replay and formal boundary

Independent reproduction used Lean 4.33.1:

```powershell
C:\Users\Owner\.elan\bin\lake.exe env lean lean\CollatzWork\Disproof\FiniteResidueFirstIntegral.lean
```

Result: exit code `0`.  All five printed theorem reports state that they
depend on no axioms.  A source inspection found no `sorry`, `admit`, declared
`axiom`, or `unsafe` declaration.

The formal module correctly proves only the abstract finite-action core:

1. invariance under a bijection gives invariance under a specified inverse;
2. invariance under `A` and `B` gives invariance under the right-to-left
   commutator `B^-1 A^-1 B A`;
3. invariance persists under finite iteration; and
4. transitivity of that commutator forces constancy.

Its use of right-inverse laws is sufficient for the direction proved.  The
calculation chains in `invariant_commutator` have the correct orientation.

As the constructor explicitly states, Lean does not formalize `Z/mZ`, the
positive parity-controlled lifts, factor descent, the affine calculation
(7), or translation transitivity.  The module is therefore an accurate
partial formal replay, not an end-to-end formalization of the all-modulus
theorem.

## 8. Registry, folklore, and cross-lane comparison

- `F006` concerns finite valuation-prefix enumeration.  This proof uses no
  prefix statistics and makes no inference from finite shadows.
- `F008` excludes bounded-horizon direct-descent covers.  The present theorem
  instead rules out a universal memoryless one-step first integral; it does
  not exclude ranked recursive residue graphs.
- `F009` rejects conclusions drawn from computation below a fixed threshold.
  This shot is symbolic for every modulus and performs no modulus sweep.
- `F010` rejects rational or 2-adic ghosts as positive witnesses.  Here a
  hypothetical coloring and `n_0` act directly on an ordinary positive orbit,
  so the witness implication would be legitimate; the class is killed before
  such a witness exists.
- `F015` concerns a bounded affine-coalescence search and is also distinct.

No literal version of this all-modulus constant-coloring statement occurs in
the repository claim registry, approach registry, failure ledger, or
continuation note.  The affine-permutation/translation argument is elementary
modular-semigroup folklore, so no literature novelty should be claimed.  The
result is narrower than the repository's finite-state residue routes because
it assumes one memoryless color determined solely by one fixed residue.

The separately accepted finite-prime-support S-unit lemma is orthogonal.  The
modulus here may contain arbitrary primes; the proof reduces its `2`- and
`3`-parts and then uses affine transitivity for every remaining composite or
prime modulus.  It neither assumes nor concludes a fixed prime-support bound
for a varying construction.

## 9. Exact scope and verdict

- **Claim ID:** `F-FINITE-RESIDUE-FIRST-INTEGRAL-001`.
- **Verdict:** **PASS, scope-qualified — `STOPPED-USEFUL / KILLED_CLASS / NO DISPROOF`.**
- **Killed class:** nonconstant memoryless colorings of one finite residue
  ring that are invariant under every positive step of the full Collatz map.
- **Positivity/integrality:** all factor-descent lifts are positive integers
  of the asserted parity; the theorem makes separation from `1` impossible.
- **Decisive mechanism:** `m->m/2`, then odd `m->m/3`, followed by the
  transitive translation `B^-1 A^-1 B A:x->x-1/6` when `gcd(m,6)=1`.
- **Prior-art status:** no exact repository duplicate; elementary folklore;
  no novelty or registry-edit recommendation.
- **Remaining gap:** one-sided residue traps, automata with memory, recursive
  residue graphs with ranks, state-dependent or growing moduli, non-residue
  invariants, and all direct cycle/divergence constructions.
- **Best next question:** can a finite positive-natural certificate retain
  genuinely path-dependent information while avoiding reduction to a
  memoryless invariant on one finite quotient?
