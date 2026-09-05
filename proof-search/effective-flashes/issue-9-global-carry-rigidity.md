# Issue #9 audit packet — global block-schedule rigidity

**Node ID:** `Collatz-Conjecture-Work:FLASH-GLOBAL-CARRY-RIGIDITY`

**Node type:** `archive`

**Upstream:** [GitHub issue #9](https://github.com/Sodelin/Collatz-Conjecture-Work/issues/9)

**Status:** exact recurrence/no-realization result; carry corollary provisional

## Proved recurrence

Let a proposed accelerated valuation schedule have blocks

```text
1^{L_0} 3, 1^{L_1} 3, 1^{L_2} 3, ...,
```

where every `L_i>=3`. If a positive odd orbit under

$$
U(n)=\frac{3n+1}{2^{\nu_2(3n+1)}}
$$

realizes this schedule, let `N_i` be the state at the start of block `i` and
set `X_i=N_i+1`. Direct iteration through the `L_i` valuation-one steps and
the following valuation-three step gives

$$
\nu_2(X_i)=L_i+1,
\qquad
X_{i+1}=\frac{3^{L_i+1}}{2^{L_i+3}}X_i+\frac34.
$$

For `r<i`, define

$$
B_{r,i}=\sum_{j=r}^{i-1}(L_j+1),
\qquad
R_{r,i}=\frac{3^{B_{r,i}}}{2^{B_{r,i}+2(i-r)}}.
$$

Every block multiplier is at least `81/64`. Iterating the affine recurrence
and dividing by `R_{r,i}` therefore yields

$$
\frac{X_i}{R_{r,i}}
=X_r+\frac34\sum_{t=r}^{i-1}\frac1{R_{r,t+1}}
<X_r+\frac34\sum_{h\ge1}\left(\frac{64}{81}\right)^h
=X_r+\frac{48}{17}.
$$

Since `2^{L_i+1}` divides the positive integer `X_i`,

$$
L_i+1-\lambda B_{r,i}+2(i-r)
<\log_2\left(X_r+\frac{48}{17}\right),
\qquad
\lambda=\log_2(3/2).
$$

Thus any infinite schedule whose left-hand defect is unbounded above, for one
fixed `r`, cannot be realized by a positive orbit.

## Explicit nonrealizable schedule

Set `L_0=L_1=3`. Recursively, for `i>=2`, let

$$
B_i=\sum_{j=0}^{i-1}(L_j+1),
\qquad
L_i=\lfloor\lambda B_i\rfloor.
$$

Here `L_i>=3`, while

$$
L_i+1-\lambda B_i+2i
=\lfloor\lambda B_i\rfloor+1-\lambda B_i+2i>2i.
$$

The required bound therefore fails, proving that this infinite schedule is
not realizable. This is a genuinely global compatibility obstruction even
though each finite valuation word is realizable, as recorded by
[`F006`](../FAILURE_LEDGER.md#f006--arbitrary-finite-valuation-prefix-enumeration-proves-collatz).

The related finite-block non-descent inequality is recorded in
[`L1_Exact_Prefix_Descent_Bound.md`](../lemmas/L1_Exact_Prefix_Descent_Bound.md)
and discussed upstream in [issue #5](https://github.com/Sodelin/Collatz-Conjecture-Work/issues/5).

## Provisional carry corollary — not promoted

Issue #9 additionally proposes combining this recurrence with a carry
criterion to force recurring positive carries and a lower bound of the form
`limsup M_k/3^k>0`. The quantity `M_k`, the exact carry semantics, and the
claimed criterion are not defined or accepted in the canonical repository
state. No such corollary is asserted here. It remains a dependency to state,
prove, and audit independently before it can be connected to the recurrence.

This note is not Lean-formalized, adds no claim-registry row, is not
publication-ready, and neither proves Collatz nor constructs a positive
counterexample.

## Connections

- **Depends on:** [L1 exact prefix identity](../lemmas/L1_Exact_Prefix_Descent_Bound.md)
- **Blocks / blocked by:** [finite-prefix realizability failure F006](../FAILURE_LEDGER.md#f006--arbitrary-finite-valuation-prefix-enumeration-proves-collatz)
- **Parallel to:** [Route F](../APPROACH_REGISTRY.md#f--divergence-disproof-lane)
- **Formalized by / pending:** [Lean boundary](../../LEAN_TARGETS.md)
