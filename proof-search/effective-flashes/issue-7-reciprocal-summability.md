# Issue #7 audit packet — reciprocal summability

**Node ID:** `Collatz-Conjecture-Work:FLASH-RECIPROCAL-SUMMABILITY`

**Node type:** `archive`

**Upstream:** [GitHub issue #7](https://github.com/Sodelin/Collatz-Conjecture-Work/issues/7)

**Current status:** primary-source and derivation checks passed; retain as an attributed corollary, not an independent novelty claim.

The [2026-09-05 primary-source review](../../research-review/consolidation-2026-09-05/ISSUE7_PROVENANCE.md) closes the former source gate using Garcia–Tal's university-hosted paper. It checks the exact restricted Hasse family, uniform interval estimate, dyadic shells, and shortcut/accelerated time change. MathOverflow513539 already contains the central summability/product/discrepancy argument. This packet adds no Collatz solution and has no Lean formalization.

## Exact internal identities

Let `n_0,n_1,...` be a positive odd orbit under the fully accelerated map

$$
U(n)=\frac{3n+1}{2^{\nu_2(3n+1)}}.
$$

Put

$$
a_j=\nu_2(3n_j+1),\qquad
A_k=\sum_{j=0}^{k-1}a_j,\qquad
x_k=\frac{2^{A_k}}{3^k},
$$

and

$$
S_k=\frac13\sum_{j=0}^{k-1}x_j,
\quad
P_k=\prod_{j=0}^{k-1}\left(1+\frac1{3n_j}\right),
\quad
q_k=\frac{3^k}{2^{A_k}n_k}.
$$

Then, for every `k>=0`,

$$
x_kn_k=n_0+S_k,
\qquad
P_k=1+\frac{S_k}{n_0},
\qquad
q_k=\frac1{n_0+S_k}=\frac1{n_0P_k}.
$$

Indeed, the affine correction `C_k` in
[`L1_Exact_Prefix_Descent_Bound.md`](../lemmas/L1_Exact_Prefix_Descent_Bound.md)
satisfies

$$
\frac{C_k}{3^k}
=\sum_{j=0}^{k-1}\frac{2^{A_j}}{3^{j+1}}
=S_k,
$$

so the first identity is L1 divided by `3^k`. Alternatively, the one-step
identity

$$
x_{j+1}n_{j+1}
=x_jn_j\left(1+\frac1{3n_j}\right)
$$

gives the product identity, and the formula for `q_k` follows by inversion.

## Source-verified summability corollary

The primary-source review verifies García–Tal (1999), Proposition1, equation(6) and Corollary1 for the shortcut map. Accelerated odd iterates satisfy `n_k=T^(A_k)(n_0)`, so they form a subsequence. For infinite orbit sets there are constants `K>0` and `beta<1` such that the set `O` of
distinct values in the orbit obeys

$$
\#\bigl(O\cap[a,a+X)\bigr)
\le KX^\beta\log(2X)
$$

in its claimed range. On the dyadic shell `[2^m,2^{m+1})`, this gives, for
every `s>beta`,

$$
\sum_{x\in O\cap[2^m,2^{m+1})}x^{-s}
\le K(m+2)2^{-m(s-\beta)}
$$

after harmless adjustment of the constant. Summing the geometric tail proves

$$
\sum_{x\in O}x^{-s}<\infty\qquad(s>\beta).
$$

In particular, an aperiodic orbit has no repeated value, so at `s=1`,

$$
\sum_{k\ge0}\frac1{n_k}<\infty.
$$

Consequently `n_k` tends to infinity,
`sum_j log(1+1/(3n_j))` converges, `P_k` tends to a finite positive limit,
and

$$
q_k\longrightarrow q_\infty=\frac1{n_0P_\infty}>0.
$$

Writing logarithms consistently in any one base then gives

$$
k\log 3-A_k\log2
=\log n_k+\log q_k\longrightarrow+\infty.
$$

The complementary bounded case is eventually periodic by determinism on a
finite state set; along such an infinite orbit the recurring factors in
`P_k` force `P_k` to infinity and hence `q_k` to zero.

## Audit boundary

The exact source hypotheses and shell deduction are recorded in the [durable review](../../research-review/consolidation-2026-09-05/ISSUE7_PROVENANCE.md). Orbit-set sums concern distinct values; aperiodicity permits time-indexed summability. Periodic orbits are the required false control because their finite orbit-set sum converges while their time-indexed reciprocal sum diverges.

[The overlapping MathOverflow post](https://mathoverflow.net/questions/513539/is-it-known-that-a-divergent-collatz-trajectory-must-have-summable-reciprocals) is public prior formulation of the core chain. No account-identity or independent-priority inference is made. This is an attributed prose corollary, not a new flagship theorem, universal boundedness proof, or positive counterexample.

## Connections

- **Depends on:** [L1 exact prefix identity](../lemmas/L1_Exact_Prefix_Descent_Bound.md)
- **Parallel to:** [Route F](../APPROACH_REGISTRY.md#f--divergence-disproof-lane)
- **Prior art:** [issue #7 provenance and MathOverflow gate](https://github.com/Sodelin/Collatz-Conjecture-Work/issues/7)
- **Formalized by / pending:** [Lean boundary](../../LEAN_TARGETS.md)
