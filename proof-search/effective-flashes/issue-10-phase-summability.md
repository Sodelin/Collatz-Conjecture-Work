# Issue #10 audit packet — phase and reciprocal summability

**Upstream:** [GitHub issue #10](https://github.com/Sodelin/Collatz-Conjecture-Work/issues/10)

**Status:** exact equivalence; equidistribution is conditional

Let `n_0,n_1,...` be a positive odd orbit under the fully accelerated map and
define

\[
a_k=\nu_2(3n_k+1),\qquad b_k=a_k-1,\qquad
B_k=\sum_{j=0}^{k-1}b_j,
\]

\[
\lambda=\log_2(3/2),\qquad
\varepsilon_k=\log_2\left(1+\frac1{3n_k}\right),\qquad
E_k=\sum_{j=0}^{k-1}\varepsilon_j.
\]

Taking logarithms of one accelerated step and summing gives the exact identity

\[
\log_2 n_k=\log_2 n_0+\lambda k-B_k+E_k.
\]

## Exact summability equivalence

For every such orbit,

\[
\boxed{
\sum_{k\ge0}\frac1{n_k}<\infty
\quad\Longleftrightarrow\quad
\sum_{k\ge0}2^{-(\lambda k-B_k)}<\infty.}
\]

For the forward implication, use
`epsilon_k <= 1/(3 ln(2) n_k)`: reciprocal summability bounds the increasing
sequence `E_k`, and the exact log identity makes the two summands comparable
by fixed positive constants. For the reverse implication, `E_k>=0` gives

\[
\frac1{n_k}
=\frac1{n_0}2^{-(\lambda k-B_k)}2^{-E_k}
\le\frac1{n_0}2^{-(\lambda k-B_k)}.
\]

## Conditional phase conclusion

Under either equivalent summability condition, `E_k` converges to a finite
limit. Since `B_k` is integral,

\[
\{\log_2n_k\}
=\{\log_2n_0+\lambda k+E_k\}.
\]

The number `lambda` is irrational: rationality would imply an equality
`2^p=(3/2)^q`, impossible by unique factorization. Irrational rotation is
uniformly distributed modulo one, and a perturbation converging to a constant
preserves uniform distribution. Hence the displayed phases are uniformly
distributed **only under the summability hypothesis**.

For the integer scale `m_k=floor(log_2 n_k)`, set

\[
V_k=\lfloor\log_2n_0+\lambda k+E_k\rfloor-\lfloor\log_2n_0\rfloor.
\]

Then

\[
m_k-m_0=V_k-B_k,
\qquad
V_k=\lambda k+O(1),
\]

and, because `epsilon_k` tends to zero, the eventual increments of `V_k` lie
in `{0,1}`.

## False control and route boundary

The fixed orbit `n_k=1` has divergent reciprocal series and phase constantly
zero. It is a direct false control against any unconditional phase-
equidistribution statement.

As a separate abstract control, let `b_k=1` at square indices and `b_k=0`
otherwise. Then `B_k=sqrt(k)+O(1)` and the proxy series above converges. The
associated growth proxy `y_k=2^{lambda k-B_k}` has one-step ratios `3/2` away
from the spikes and `3/4` at them. This abstract sequence is not asserted to
satisfy the `+1` divisibility constraints and is neither an orbit nor a
counterexample. It shows why phase or valuation marginals alone do not supply
the missing global compatibility bridge.

The reciprocal-summability input and its current provenance boundary are
separated in the [issue #7 packet](issue-7-reciprocal-summability.md); the
exact affine orbit identity is in
[`L1_Exact_Prefix_Descent_Bound.md`](../lemmas/L1_Exact_Prefix_Descent_Bound.md).

This note is not Lean-formalized, adds no claim-registry row, is not
publication-ready, and neither proves Collatz nor constructs a positive
counterexample.
