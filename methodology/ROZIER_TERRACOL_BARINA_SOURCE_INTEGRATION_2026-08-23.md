# Source integration — paradoxical prefixes + verified base range

**Date:** 2026-08-23  
**Purpose:** integrate two external results that materially strengthen the Round-7 minimal-counterexample lane.

## Sources

### Rozier–Terracol

Olivier Rozier and Claude Terracol, **“Paradoxical behavior in Collatz sequences,”** *Discrete Mathematics* 349 (2026), 115167. DOI: `10.1016/j.disc.2026.115167`. Current arXiv version: `arXiv:2502.00948v5`.

They use the accelerated map

\[
T(n)=\begin{cases}
(3n+1)/2,&n\text{ odd},\\
n/2,&n\text{ even}.
\end{cases}
\]

For a length-`j` prefix with `q` odd terms they write

\[
T^j(n)=C_j(n)n+E_j(n),
\qquad
C_j(n)=\frac{3^q}{2^j}.
\]

Their Theorem 2.4 proves the exact remainder bounds

\[
\frac{3^q-2^q}{2^j}
\le E_j(n)\le
\frac{3^q-2^q}{2^q}.
\]

The upper bound occurs for a specific extremal parity vector with the odd terms shifted to the end.

They call a finite prefix **paradoxical** when `C_j(n)<1` but the endpoint has not descended below the start.

Theorem 5.3 reports that there are no paradoxical sequences with

\[
93\le j\le301\,993.
\]

The paper separately enumerates 593 known paradoxical sequences in its small-start regime and proves additional start-range exclusions. The route below uses only the exact theorem statements needed for the prefix-length exclusion.

Primary links:

- `https://arxiv.org/abs/2502.00948`
- `https://doi.org/10.1016/j.disc.2026.115167`

### Barina

David Barina, **“Improved verification limit for the convergence of the Collatz conjecture,”** *The Journal of Supercomputing* 81, 810 (2025). DOI: `10.1007/s11227-025-07337-0`.

The paper reports computational verification of convergence for all starting values through the bound

\[
2^{71}.
\]

The associated public project currently reports verification slightly beyond this (`2075*2^60`, approximately `2^71.02`), but Round 7 deliberately uses the conservative published `2^71` threshold.

Primary links:

- `https://link.springer.com/article/10.1007/s11227-025-07337-0`
- `https://pcbarina.fit.vut.cz/`
- source repository: `https://github.com/xbarin02/collatz`

## 1. New interaction with the minimal-counterexample route

Assume Collatz is false and let `n_*` be the least positive integer whose orbit does not reach `1`.

Barina's verified range gives

\[
n_*>2^{71}.
\]

Minimality gives

\[
T^j(n_*)\ge n_*
\]

for every `j>=0`, because an iterate below `n_*` would itself converge and therefore pull `n_*` into the convergent orbit.

Hence whenever

\[
C_j(n_*)=\frac{3^{q_j}}{2^j}<1,
\]

the length-`j` prefix is paradoxical in the Rozier–Terracol sense.

This converts their paradoxical-sequence exclusions into exact constraints on the parity count of a hypothetical least counterexample.

## 2. Short-prefix bound from Theorem 2.4

If a prefix is paradoxical, then

\[
(1-C_j)n_*
\le E_j(n_*).
\]

Using Theorem 2.4,

\[
n_*
\le
\frac{(3^q-2^q)/2^q}{1-3^q/2^j}
=
\boxed{
\frac{2^{j-q}(3^q-2^q)}{2^j-3^q}
}
=:F(j,q).
\]

An exact integer-arithmetic sweep committed in

`verification/round7_paradoxical_prefix_barrier.py`

checks every pair with `1<=j<=183` and `3^q<2^j`. It finds

\[
F(j,q)<2^{71}
\]

for all of them.

Thus a least counterexample above the verified range cannot have a coefficient-contracting prefix of length at most 183.

The first pair for which this crude extremal bound reaches `2^71` is

\[
(j,q)=(184,116).
\]

This `184` threshold is a derived finite corollary, not claimed as new literature.

## 3. Stronger combined consequence

The Rozier–Terracol Theorem 5.3 exclusion covers every paradoxical length

\[
93\le j\le301\,993.
\]

Our exact short-prefix calculation covers all coefficient-contracting non-descending prefixes

\[
1\le j\le183.
\]

Together they cover every

\[
1\le j\le301\,993.
\]

Therefore a hypothetical least counterexample has no coefficient contraction during its first `301,993` accelerated steps:

\[
\boxed{
3^{q_j(n_*)}\ge2^j
\quad\text{for every }1\le j\le301\,993.
}
\]

Equivalently, if its coefficient stopping time

\[
\tau(n_*)=\min\{j\ge1:3^{q_j(n_*)}<2^j\}
\]

is finite, then

\[
\boxed{\tau(n_*)\ge301\,994.}
\]

This is recorded as `L7_Least_Counterexample_Coefficient_Barrier.md`.

## 4. Why this is useful but not a proof

This theorem sharply restricts the initial parity-count process of any least counterexample. It does **not** show that such a parity prefix cannot occur.

Indeed long near-critical / expanding parity prefixes are a central Collatz obstruction. The theorem converts a vague requirement into a finite exact one:

> a least counterexample must remain on or above the multiplicative critical line for more than 300,000 accelerated steps.

The next research question is whether this finite but very long critical-prefix constraint is incompatible with the positive-integer arithmetic constraints already derived from the `-1`/Mersenne exit and mixed-radix coalescence structure.

## 5. Claim discipline

- Rozier–Terracol theorem statements: **external peer-reviewed result**.
- Barina `2^71` verification: **external peer-reviewed computational result**.
- finite `j<=183` sweep: **project exact computation derived from Theorem 2.4**.
- combined `301,994` lower bound for a least counterexample's coefficient stopping time: **project corollary of external results + exact finite computation**.
- novelty: **not claimed** until a dedicated priority search checks whether this exact corollary has already been stated.
- Collatz relevance: **necessary condition on a hypothetical minimal counterexample, not a proof**.
