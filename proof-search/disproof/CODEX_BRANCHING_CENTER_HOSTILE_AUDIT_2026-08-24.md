# Hostile audit of `F-BRANCH-CENTER-001`

**Date:** 2026-08-24  
**Pinned base:** `b3b9f4731937a2d7c999d1b8a6417c9e96597e46`  
**Verdict:** **PASS, scope-qualified — `KILLED_ARCHITECTURE / NO DISPROOF`**

This audit was derived independently before the constructor files were read.
It verifies a narrow obstruction to one proposed branching-center ansatz.  It
does not supply a positive nontrivial Collatz cycle, a positive divergent
integer, or evidence from a bounded miss.

## 1. Audited architecture

For

\[
U_j(x)=\frac{3x+1}{2^j},
\]

the shot asks for rational centers `alpha,beta` and positive integer labels
`a,b,c` satisfying

\[
U_a(\alpha)=\alpha,\qquad
U_b(\alpha)=\beta,\qquad
U_c(\beta)=\alpha.
\]

The intended ordinary orbit would choose nonperiodically between the return
tokens `a` and `bc`.  Such a construction could escape fixed-word bounds only
if it also supplied one explicit positive integer, all exact canonical
valuation guards, and forward invariance for every step of that same orbit.
None of those witness conditions may be replaced by rational centers or
arbitrarily long finite shadows.

## 2. Independent center elimination

Clearing denominators gives

\[
(2^a-3)\alpha=1,                                    \tag{1}
\]

\[
2^b\beta=3\alpha+1,                                 \tag{2}
\]

\[
2^c\alpha=3\beta+1.                                 \tag{3}
\]

Multiplying (3) by `2^b` and applying (2) yields

\[
(2^{b+c}-9)\alpha=2^b+3.                             \tag{4}
\]

Multiply (4) by `2^a-3` and use (1).  This does not
divide by `alpha` or by `2^a-3`:

\[
2^{b+c}-9=(2^b+3)(2^a-3).
\]

After exact expansion and cancellation,

\[
2^b(2^c+3)=2^a(2^b+3).                              \tag{5}
\]

Because `b,c>0`, both parenthesized factors in (5) are odd.  Taking the exact
power of two on both sides therefore gives `b=a`.  Cancelling the common
power of two then gives `2^c+3=2^b+3`, hence `c=b`.  Thus

\[
a=b=c.                                               \tag{6}
\]

Equations (1) and (2) now imply `beta=alpha`.  Both outgoing labels and both
centers collapse, so the two return-token choices no longer define distinct
branches.

All cancellations are legitimate.  Powers of two are nonzero, and
`2^a-3` is never zero for an integer `a`.  The displayed derivation in fact
avoids dividing by either center expression before (5).

## 3. Positive-center classification

In the collapsed graph,

\[
\alpha=\beta=\frac{1}{2^a-3}.
\]

For positive `a`:

- `a=1` gives `alpha=-1`, which is not a positive-natural witness;
- `a=2` gives `alpha=1`, with exact guard
  `v_2(3\cdot1+1)=2`, the trivial orbit; and
- `a>=3` gives `0<alpha<1`, so the center is not a positive integer.

Consequently the collapsed graph contains neither a positive nontrivial
cycle nor a divergent positive integer.

## 4. Finite-denominator bridge and anchor obstruction

The constructor's corrected conditional bridge is sound.  Let a finite set
of rational centers have a fixed common denominator `D>0`, with `3` not
dividing `D`, and suppose an integer orbit and its current center take the
same exact branch `j_t>=1`.  Put

\[
q_t=D(n_t-\gamma_t)\in\mathbb Z.
\]

Then

\[
q_{t+1}=\frac{3q_t}{2^{j_t}},\qquad
q_t=\frac{3^tq_0}{2^{J_t}},\qquad
J_t=\sum_{r<t}j_r\ge t.                              \tag{7}
\]

If `q_0` is nonzero and `s=v_3(q_0)`, exact synchronization gives
`v_3(q_t)=s+t`.  Since each `q_t` is an integer,

\[
|q_t|\ge 3^{s+t}.                                    \tag{8}
\]

Writing `M=max |gamma|` over the finite center set gives the explicit
Archimedean consequence

\[
|n_t|\ge \frac{3^{s+t}}{D}-M.                        \tag{9}
\]

Thus this fixed-denominator discreteness really would convert nonzero exact
3-adic gain into unbounded Archimedean size, independently of `J_t`.

There is one wording boundary: (8) retains the initial power-of-three scale
`3^s`, not the absolute magnitude of the initial 3-free cofactor
`q_0/3^s`.  That cofactor can be divided by powers of two.  Its only needed
property is that a nonzero integral cofactor has absolute value at least one.

The same equation kills the anchor before this conditional escape can become
a Collatz witness.  Integral persistence in (7) requires

\[
2^{J_t}\mid 3^tq_0.
\]

Since powers of two are coprime to `3^t`, this forces
`2^{J_t}\mid q_0` for every `t`.  As `J_t>=t` is unbounded, a fixed nonzero
integer `q_0` cannot satisfy these conditions.  Hence only zero displacement
can synchronize forever with a fixed finite rational-center system.

The zero-displacement case is not a hidden divergence witness:
`v_3(0)` is not a finite strictly increasing valuation, and the orbit simply
equals its centers.  For the graph audited here, Section 3 leaves only the
trivial positive orbit at `1`.

This argument depends essentially on one fixed denominator and exact
single-step center synchronization.  For arbitrary rational comparison
points whose denominators grow with time, `D(n_t-\gamma_t)` need not be an
integer for one fixed `D`; bare rational 3-adic gain then supplies no such
Archimedean lower bound.

## 5. Lean replay

The constructor module proves exactly the arithmetic implication

```text
2^(b+c) + 3*2^b = 2^(a+b) + 3*2^a
    -> a = b and b = c
```

for positive natural labels.  Its custom odd-factor normal-form lemma is
correct, and the theorem does not smuggle in a Collatz or witness assumption.

Independent reproduction used Lean 4.33.1:

```powershell
C:\Users\Owner\.elan\bin\lake.exe env lean lean\CollatzWork\Disproof\BranchingCenter.lean
```

Result: exit code `0`.  The printed theorem dependencies are only
`propext`, `Quot.sound`, and, where reported, `Classical.choice`.  A source
scan found no `sorry`, `admit`, declared `axiom`, or `unsafe` declaration.

The Lean theorem formalizes the rigidity of equation (5).  The center
elimination, positive-center classification, common-denominator bridge, and
ordinary-anchor obstruction remain elementary exact prose arguments; they
are not claimed as formalized by this module.

## 6. Prior-art and scope comparison

- `F006` says finite valuation-prefix realizations do not control one
  infinite orbit.  This shot makes no such inference; the missing explicit
  infinite positive anchor remains mandatory.
- `F010` rejects rational or 2-adic periodic ghosts as positive witnesses.
  The fixed-denominator `2`-divisibility obstruction is a concrete instance
  of precisely that positive-membership boundary.
- `F022` concerns dependent equations obtained by cyclic rotation in a
  two-pump word.  Equation (5) is not an independent cyclic resultant and
  makes no claim to repair that route.
- Classical fixed-word affine algebra already governs each individual return
  token.  The exact two-center equation is not literally recorded in the
  repository registries, but its only added exclusion is this concrete
  three-edge graph.  It does not strengthen published cycle bounds or exclude
  general nonperiodic branching systems.

In particular, the result does **not** exclude larger graphs, infinitely many
or moving centers, nonsynchronized invariant sets, nonlinear observables, or
any positive-natural construction outside this exact architecture.

## 7. Final hostile verdict

- **Claim ID:** `F-BRANCH-CENTER-001`.
- **Verdict:** **PASS, scope-qualified — `KILLED_ARCHITECTURE / NO DISPROOF`.**
- **Exact killed family:** two rational centers with positive single-step
  edges `A-a->A`, `A-b->B`, `B-c->A`, where distinct return tokens are
  required.
- **Positivity/integrality:** only zero displacement can remain synchronized;
  after graph collapse the only positive integral center is the trivial
  fixed point `1`.
- **Decisive replay:** equations (1)--(7), plus successful Lean replay of
  `(5) -> (6)`.
- **Prior-art status:** a new local graph check at most; its global warning is
  already represented by `F006`/`F010`, and it is separate from `F022`.
- **Remaining gap:** all genuine positive-natural, fully guard-invariant
  nonperiodic mechanisms outside fixed finite exact rational-center
  synchronization.
- **Best next question:** can a finite specification enforce an ordinary
  positive nonperiodic orbit while its comparison/invariant data avoid both
  fixed-denominator synchronization and an equivalent hidden encoding of the
  desired orbit?
