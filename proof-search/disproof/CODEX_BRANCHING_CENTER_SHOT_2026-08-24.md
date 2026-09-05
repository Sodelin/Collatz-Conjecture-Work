# F-BRANCH-CENTER-001 — two-center branching shot

**Date:** 2026-08-24  
**Base:** `b3b9f4731937a2d7c999d1b8a6417c9e96597e46`  
**Verdict:** `KILLED_ARCHITECTURE / NO DISPROOF`

This is one bounded symbolic shot in the fresh disproof lane.  It supplies
neither a positive nontrivial Collatz cycle nor a positive integer with a
proved divergent orbit.

## Predeclared selection packet

### Exact witness architecture

For a positive label `j`, let

$$
U_j(x)=\frac{3x+1}{2^j}.
$$

The proposed invariant system has two rational centers `alpha,beta` and the
single-step center edges

$$
A\mathrel{\mathop{\longrightarrow}^{a}}A,
\qquad
A\mathrel{\mathop{\longrightarrow}^{b}}B,
\qquad
B\mathrel{\mathop{\longrightarrow}^{c}}A,
$$

where `a,b,c` are positive.  At each visit to `A`, an intended ordinary
positive orbit would take either the one-token return `a` or the two-token
return `bc`; its sequence of choices would be non-eventually-periodic.  The
full witness would consist of:

1. explicit subsets `S_A,S_B` of the positive odd integers, with `S_A`
   partitioned into the exact `a`-guard and `b`-guard cells;
2. exact canonical guards `v_2(3n+1)=a,b,c` on their respective cells;
3. forward invariance under the displayed edges;
4. an explicit `n_0` in one of those cells whose orbit makes infinitely many
   genuine branch choices; and
5. nonzero displacement from the current rational center, so that the exact
   factor `3/2^j` on center differences could provide 3-adic gain.

The centers themselves were required to satisfy

$$
U_a(\alpha)=\alpha,\qquad
U_b(\alpha)=\beta,\qquad
U_c(\beta)=\alpha.
$$

The first positivity/integrality/invariance gate was an explicit positive
integer `n_0` and exact forward-invariant canonical cells.  Rational centers
alone were never to count as a witness.

### Why this was not a fixed-word or finite-shadow proposal

- The intended `a` versus `bc` choice sequence was non-eventually-periodic,
  so the proposed witness was not a fixed or eventually periodic macro word.
- A single explicit ordinary positive integer and exact forward invariance
  were mandatory, so a rational or 2-adic center could not pass the witness
  gate (`F010`).
- Successive choices had to belong to the one infinite orbit of that same
  integer.  No inference from realizability or statistics of finite prefixes
  was allowed (`F006`).
- No cycle-bound, state-count, coefficient, or orbit sweep was involved.

### Cheapest fatal test, stop, artifact, and compute class

The predeclared cheapest kill was exact elimination of `alpha,beta` from the
three center equations.  Equality or collapse of the allegedly distinct
branches kills the architecture before any anchor or asymptotic calculation.

The hard stop was the first exact contradiction/collapse in those equations;
there was to be no graph enlargement, longer word, or raised search bound.
The expected durable artifact was a scope-qualified center-consistency no-go
with an independent Lean arithmetic replay.  Compute class: constant-size
symbolic algebra plus one small Lean compilation; no enumeration.

## Constructor derivation

Clearing the three center equations gives

$$
(2^a-3)\alpha=1,                                      \tag{1}
$$

$$
2^b\beta=3\alpha+1,                                  \tag{2}
$$

$$
2^c\alpha=3\beta+1.                                  \tag{3}
$$

Multiplying (3) by `2^b` and using (2) yields

$$
(2^{b+c}-9)\alpha=2^b+3.                              \tag{4}
$$

Multiplying (4) by `2^a-3` and using (1), without first
dividing by any potentially zero expression, gives

$$
2^{b+c}-9=(2^b+3)(2^a-3).
$$

Exact expansion and cancellation of `-9` reduce this to

$$
2^{b+c}+3\,2^b=2^{a+b}+3\,2^a,                       \tag{5}
$$

or equivalently

$$
2^b(2^c+3)=2^a(2^b+3).                               \tag{6}
$$

Because `b,c>0`, both `2^c+3` and `2^b+3` are odd.  Uniqueness of the
power-of-two-times-odd normal form in (6) therefore gives

$$
b=a,\qquad 2^c+3=2^b+3.
$$

Applying the same normal-form uniqueness to `2^c=2^b` gives `c=b`.
Consequently

$$
a=b=c.                                                \tag{7}
$$

The first and second center equations now have the same right side and the
same power of two on the left, so `beta=alpha`.  Thus the two centers and the
two outgoing `A` labels collapse.  The required distinct two-center branch
does not exist.

## Positive-natural and escape audit

The primary kill (7) occurs before an integer anchor or invariant cells are
constructed.  It is therefore not legitimate to continue directly from the
rational centers to an escape claim.

There is also an exact, separate anchor obstruction inside this architecture.
Let `D>0` be a common denominator of the finitely many rational centers, and
suppose `3` does not divide `D`.  This 3-free choice is available here:
the denominator of `alpha=1/(2^a-3)` is prime to 3, and a denominator of
`beta=(3alpha+1)/2^b` divides `2^b(2^a-3)`.

For a hypothetical synchronized integer orbit `n_t`, let `gamma_t` be its
current center and set

$$
q_t=D(n_t-\gamma_t)\in\mathbb Z.
$$

An exact edge of label `j_t>=1` gives

$$
q_{t+1}=\frac{3q_t}{2^{j_t}},
\qquad
q_t=\frac{3^tq_0}{2^{J_t}},
\qquad
J_t=\sum_{r<t}j_r\ge t.                               \tag{8}
$$

If `q_0` is nonzero and `q_0=3^s u` with `3` not dividing `u`, then
integer persistence in (8) would give exact 3-adic gain
`v_3(q_t)=s+t`.  Hence `|q_t|>=3^{s+t}`; since the center set is finite,
this would imply an Archimedean escape bound for positive `n_t`.

But the same equation first destroys integrality.  Since `q_t` is an integer,
`2^{J_t}` divides `3^t q_0`; coprimality implies `2^{J_t}` divides `q_0`.
As `J_t>=t` for every `t`, no fixed nonzero integer `q_0` can satisfy these
divisibilities.  Thus only `q_0=0` can shadow exact finite rational centers
forever.  This is the concrete within-architecture `F010` gate: 3-adic gain
does not rescue an ordinary-integer anchor because its 2-adic integrality is
lost first.

In the collapsed graph, `q_0=0` means the putative integer anchor is the
fixed center

$$
\alpha=\frac1{2^a-3}.
$$

For `a=1` it is `-1`; for `a=2` it is `1`, the trivial Collatz orbit; and for
`a>=3` it lies strictly between `0` and `1`.  Hence this architecture contains
no positive nontrivial cycle and no positive divergent integer.

The divisibility observation in (8) also applies to a hypothetical finite
rational-center graph with a fixed common denominator and exact synchronized
single-step edges.  It does **not** exclude larger graph mechanisms in
general: they may lack exact rational-center synchronization, use longer or
state-dependent objects, use infinitely many centers, or use a different
invariant entirely.

## Lean replay

The new independent module proves:

```text
branchingCenterEquationRigid
    (a b c : Nat)
    (_ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hEq : 2 ^ (b + c) + 3 * 2 ^ b =
      2 ^ (a + b) + 3 * 2 ^ a) :
    a = b ∧ b = c
```

It imports only `Std.Tactic`; it does not import or modify the prior
polynomial-ratchet module.  Reproduce from the isolated worktree root with:

```powershell
C:\Users\Owner\.elan\bin\lake.exe env lean lean\CollatzWork\Disproof\BranchingCenter.lean
```

Expected result: exit code `0`.  The printed axiom reports contain only Lean's
standard `propext`, `Quot.sound`, and (for the `omega`-constructed arithmetic
witnesses) `Classical.choice`.

## Prior-art and exact scope

Repository comparison found no existing claim with equation (5) or this
exact two-center/three-edge collapse.  It therefore closes a concrete route
architecture not literally listed in the claim or failure registries.  Its
ordinary-anchor obstruction is, however, a precise instance of the warning
already recorded in `F010`, and it does not enlarge the published fixed-word
cycle exclusions.  It uses no finite-prefix inference (`F006`).  No failure
ledger or claim-registry edit is proposed before independent acceptance.

The formal result closes only the graph with rational centers, positive
single-step labels, and edges `A-a->A`, `A-b->B`, `B-c->A`, when a genuine
distinct branch is required.  It does not exclude larger graphs, longer edge
words, non-rational or moving centers, nonlinear invariant sets, or arbitrary
branching/nonperiodic Collatz constructions.

## Shot handoff

- **Claim ID:** `F-BRANCH-CENTER-001`.
- **Verdict:** `KILLED_ARCHITECTURE / NO DISPROOF`.
- **Exact object/family:** the two-rational-center, three-single-step-edge
  graph above, intended to support a non-eventually-periodic ordinary positive
  orbit using return tokens `a` and `bc`.
- **Positivity and integrality:** no nonzero positive-natural anchor survives;
  center consistency collapses first, and the independent common-denominator
  calculation forces any infinite integer displacement to be zero.  The only
  positive integral collapsed center is `1`, which is trivial.
- **Decisive equations/replay:** equations (1)--(8), with the rigidity of (5)
  replayed in Lean.
- **Prior-art status:** exact local equation absent from the registries; anchor
  failure is an exact `F010` instance; no overlap with bounded misses or a
  claim of improved cycle bounds.
- **Remaining gap:** essentially all genuinely state-dependent positive
  invariant constructions outside exact finite rational-center
  synchronization remain open.
- **Reproduction:** the one-command Lean invocation above.
- **Files:**
  `proof-search/disproof/CODEX_BRANCHING_CENTER_SHOT_2026-08-24.md` and
  `lean/CollatzWork/Disproof/BranchingCenter.lean`.
- **Single best next question:** can an explicit positive-natural invariant
  construction obtain a nonperiodic gain/escape mechanism without requiring
  an integer orbit to synchronize forever to finitely many exact rational
  affine centers?
