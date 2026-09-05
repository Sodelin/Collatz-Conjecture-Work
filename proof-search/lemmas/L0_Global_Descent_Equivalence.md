# L0 — Global descent is equivalent to Collatz

**Status:** `PROVED_AUX` informally; elementary proof. Lean formalization pending.

**Correctness:** high-confidence  
**Priority:** prior-art / classical stopping-time formulation  
**Usefulness:** convergence-relevant  
**Collatz relevance:** exact equivalent formulation

## 1. Set-up

For a positive odd integer `n`, define the accelerated odd-to-odd Collatz map

$$
S(n)=\frac{3n+1}{2^{\nu_2(3n+1)}}.
$$

Then `S(n)` is again a positive odd integer and `S(1)=1`.

Write

$$
\operatorname{Reaches1}(n)
\quad\Longleftrightarrow\quad
\exists k\ge 0\; S^k(n)=1.
$$

Define the **global descent property**

$$
\operatorname{GD}:
\qquad
\forall n\in 2\mathbb Z+1,\; n>1
\Longrightarrow
\exists k\ge1\; S^k(n)<n.
$$

## 2. Theorem

For the accelerated odd map,

$$
\boxed{
\operatorname{GD}
\iff
\forall\text{ positive odd }n,\;\operatorname{Reaches1}(n).
}
$$

Since ordinary even Collatz steps merely remove powers of two before returning to an odd state, the right-hand side is equivalent to the ordinary Collatz conjecture on all positive integers.

## 3. Proof

### Collatz implies global descent

Assume every positive odd `n` reaches `1`. Let `n>1` be positive and odd. Choose `k` with

$$
S^k(n)=1.
$$

Because `n>1`, necessarily `k\ge1`, and

$$
S^k(n)=1<n.
$$

Thus `GD` holds.

### Global descent implies Collatz

Assume `GD`. We prove by strong induction on positive odd `n` that `n` reaches `1`.

- Base case: `n=1`, so zero iterations suffice.
- Inductive step: let odd `n>1`, and assume every smaller positive odd integer reaches `1`. By `GD`, choose `k\ge1` such that

  $$
  m=S^k(n)<n.
  $$

  The accelerated map preserves positive oddness, so `m` is a positive odd integer. By the induction hypothesis, some `j\ge0` satisfies

  $$
  S^j(m)=1.
  $$

  Therefore

  $$
  S^{k+j}(n)=1.
  $$

Hence every positive odd integer reaches `1`.

## 4. Minimal-counterexample corollary

If Collatz is false, let `n_*` be the least positive odd starting value whose accelerated orbit never reaches `1`. Then

$$
\boxed{S^k(n_*)\ge n_*\quad\text{for every }k\ge1.}
$$

Otherwise some iterate `m=S^k(n_*)<n_*` would be a smaller positive odd integer. By minimality, `m` reaches `1`, and therefore `n_*` reaches `1`, contradiction.

So a proof of Collatz may equivalently rule out a **minimal non-descending orbit**.

## 5. Why this is the root of the new search

This theorem gives the project an exact endpoint that is much smaller than the prose statement “all trajectories reach 1.” Every proof architecture must now answer:

> How does this route produce, for an arbitrary odd `n>1`, one certified iterate below `n`?

A route that produces only average contraction, density-one descent, arbitrarily long finite descent for selected residue classes, or a ranking obstruction has not crossed L0.

Conversely, any finite symbolic certificate, rewrite termination order, recursive residue graph, or global ranking that establishes `GD` immediately closes Collatz by strong induction.

## 6. Lean target

The formalization should be split into two tiny statements before importing any Round-6 machinery:

1. `accelerated_reachesOne_iff_standard_reachesOne`;
2. `globalDescent_iff_acceleratedCollatz`.

This should be the project's trusted top-level interface: later search code can target `GlobalDescent` rather than repeatedly reformalizing the entire conjecture.

## 7. Kill test

Any proposed “bridge lemma” should be tested by deleting its explanatory prose and asking whether its conclusion alone actually implies `GlobalDescent`. If not, record the remaining exact theorem-strength gap rather than describing the route as “close to Collatz.”

## Formal companion, 2026-09-05

The [trusted convergence statements](../../lean/CollatzWork/ConvergenceStatement.lean)
and [checked solution](../../lean/CollatzWork/Convergence.lean) formalize the
all-positive shortcut-map descent and smaller-coalescence equivalences.
They also connect the compatible Mersenne child to strong induction.
This is a precisely scoped companion, not a claim that every map-equivalence
or odd-only statement in this prose note was formalized. See the
[Lean boundary](../../LEAN_TARGETS.md) and [CI log](../../verification/lean_convergence_ci_2026-09-05.txt).
