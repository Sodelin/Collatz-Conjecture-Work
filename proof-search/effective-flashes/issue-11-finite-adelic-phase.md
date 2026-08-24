# Issue #11 audit packet — finite adelic phase freedom

**Node ID:** `Collatz-Conjecture-Work:FLASH-FINITE-ADELIC-PHASE`

**Node type:** `archive`

**Upstream:** [GitHub issue #11](https://github.com/Sodelin/Collatz-Conjecture-Work/issues/11)

**Status:** exact finite-prefix theorem; no fixed-orbit conclusion

## Finite-prefix phase theorem

For every `k>=1`, every word of positive valuations
`(a_0,...,a_{k-1})`, and every nonempty phase interval
`0<=alpha<beta<=1`, infinitely many positive odd seeds realize that exact
accelerated valuation word and have endpoint `n_k` satisfying

\[
\{\log_2 n_k\}\in(\alpha,\beta).
\]

Here an endpoint exactly on a chosen boundary may be discarded; the open
interval is the durable statement.

## Proof

Let

\[
A_k=\sum_{j=0}^{k-1}a_j,
\qquad
C_k=\sum_{j=0}^{k-1}3^{k-1-j}2^{A_j},
\]

with `A_j=sum_{i<j}a_i`. By
[`L1_Exact_Prefix_Descent_Bound.md`](../lemmas/L1_Exact_Prefix_Descent_Bound.md),
every realization must obey

\[
2^{A_k}n_k=3^kn_0+C_k.
\]

Because `2^{A_k}` is invertible modulo `3^k`, this selects one endpoint class

\[
n_k\equiv2^{-A_k}C_k\pmod{3^k}.
\]

Combining it with odd parity selects one class modulo `2\cdot3^k`. For each
integer `m`, consider

\[
J_m=(2^{m+\alpha},2^{m+\beta}).
\]

Its length tends to infinity. Once `|J_m|>2\cdot3^k`, it contains a member of
every residue class modulo `2\cdot3^k`; choose an odd endpoint in the selected
class. For all sufficiently large choices,

\[
n_0=\frac{2^{A_k}n_k-C_k}{3^k}
\]

is positive. Backward recursion

\[
n_j=\frac{2^{a_j}n_{j+1}-1}{3}
\]

then gives positive odd integers. Since each `n_{j+1}` is odd,
`3n_j+1=2^{a_j}n_{j+1}` has exact 2-adic valuation `a_j`. Letting `m` grow
produces infinitely many seeds, and membership in `J_m` gives the requested
endpoint phase.

## Why this does not control one orbit

The construction chooses a new seed for each finite word and phase target.
It does not control the nested representatives selected by one fixed positive
orbit, exactly the compatibility gap recorded by
[`F006`](../FAILURE_LEDGER.md#f006--arbitrary-finite-valuation-prefix-enumeration-proves-collatz).

Conditionally on reciprocal summability, the exact log identity in the
[issue #10 packet](issue-10-phase-summability.md) gives

\[
n_k\le K(3/2)^k
\]

for one fixed orbit and some constant `K`; hence eventually `n_k<3^k`.
There is at most one representative of a fixed class modulo `2\cdot3^k` in
that range, whereas the interval-length phase construction becomes automatic
only at scale comparable to or above `3^k`. Thus finite-prefix phase freedom
cannot be transferred to that distinguished representative.

The narrow route conclusion is only this: finite-prefix phase exclusion or
averaging cannot by itself control the nested sub-modulus representatives of
one orbit. This does not close all residue, adelic, or S-unit methods.

This note is not Lean-formalized, adds no claim-registry row, is not
publication-ready, and neither proves Collatz nor constructs a positive
counterexample.

## Connections

- **Depends on:** [L1 exact prefix identity](../lemmas/L1_Exact_Prefix_Descent_Bound.md)
- **Depends on:** [conditional phase review](issue-10-phase-summability.md)
- **Blocks / blocked by:** [finite-prefix inference failure F006](../FAILURE_LEDGER.md#f006--arbitrary-finite-valuation-prefix-enumeration-proves-collatz)
- **Parallel to:** [Route F](../APPROACH_REGISTRY.md#f--divergence-disproof-lane)
