# Issue #7 audit packet — reciprocal summability

**Upstream:** [GitHub issue #7](https://github.com/Sodelin/Collatz-Conjecture-Work/issues/7)

**Status:** source-conditional and provenance-blocked; not an accepted claim

This packet separates exact orbit algebra from the external interval-count
hypothesis discussed in the issue. It does not certify the source theorem, its
translation to this map convention, or its novelty relationship to the
closely related MathOverflow discussion identified in the issue.

## Exact internal identities

Let `n_0,n_1,...` be a positive odd orbit under the fully accelerated map

\[
U(n)=\frac{3n+1}{2^{\nu_2(3n+1)}}.
\]

Put

\[
a_j=\nu_2(3n_j+1),\qquad
A_k=\sum_{j=0}^{k-1}a_j,\qquad
x_k=\frac{2^{A_k}}{3^k},
\]

and

\[
S_k=\frac13\sum_{j=0}^{k-1}x_j,
\quad
P_k=\prod_{j=0}^{k-1}\left(1+\frac1{3n_j}\right),
\quad
q_k=\frac{3^k}{2^{A_k}n_k}.
\]

Then, for every `k>=0`,

\[
x_kn_k=n_0+S_k,
\qquad
P_k=1+\frac{S_k}{n_0},
\qquad
q_k=\frac1{n_0+S_k}=\frac1{n_0P_k}.
\]

Indeed, the affine correction `C_k` in
[`L1_Exact_Prefix_Descent_Bound.md`](../lemmas/L1_Exact_Prefix_Descent_Bound.md)
satisfies

\[
\frac{C_k}{3^k}
=\sum_{j=0}^{k-1}\frac{2^{A_j}}{3^{j+1}}
=S_k,
\]

so the first identity is L1 divided by `3^k`. Alternatively, the one-step
identity

\[
x_{j+1}n_{j+1}
=x_jn_j\left(1+\frac1{3n_j}\right)
\]

gives the product identity, and the formula for `q_k` follows by inversion.

## Conditional summability consequence

Assume the external orbit-set estimate attributed in issue #7 to
García--Tal (1999) has been verified for the same shortcut/acceleration
convention: there are constants `K>0` and `beta<1` such that the set `O` of
distinct values in the orbit obeys

\[
\#\bigl(O\cap[a,a+X)\bigr)
\le KX^\beta\log(2X)
\]

in its claimed range. On the dyadic shell `[2^m,2^{m+1})`, this gives, for
every `s>beta`,

\[
\sum_{x\in O\cap[2^m,2^{m+1})}x^{-s}
\le K(m+2)2^{-m(s-\beta)}
\]

after harmless adjustment of the constant. Summing the geometric tail proves

\[
\sum_{x\in O}x^{-s}<\infty\qquad(s>\beta).
\]

In particular, an aperiodic orbit has no repeated value, so at `s=1`,

\[
\sum_{k\ge0}\frac1{n_k}<\infty.
\]

Consequently `n_k` tends to infinity,
`sum_j log(1+1/(3n_j))` converges, `P_k` tends to a finite positive limit,
and

\[
q_k\longrightarrow q_\infty=\frac1{n_0P_\infty}>0.
\]

Writing logarithms consistently in any one base then gives

\[
k\log 3-A_k\log2
=\log n_k+\log q_k\longrightarrow+\infty.
\]

The complementary bounded case is eventually periodic by determinism on a
finite state set; along such an infinite orbit the recurring factors in
`P_k` force `P_k` to infinity and hence `q_k` to zero.

## Audit boundary

The interval-count estimate is an external hypothesis here. Its bibliographic
source, precise set definition, and translation between shortcut-map
conventions have not been independently canonicalized in the repository.
Issue #7 also records a likely overlap with MathOverflow question 513539; the
identity and priority relationship is unresolved. The correction discussion
in [issue #2](https://github.com/Sodelin/Collatz-Conjecture-Work/issues/2#issuecomment-5396905245)
should be reviewed before any external claim is made.

This note is not Lean-formalized, adds no claim-registry row, is not
publication-ready, and neither proves Collatz nor constructs a positive
counterexample.
