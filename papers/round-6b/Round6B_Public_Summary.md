# Round 6B public summary

## Terminal finite-sensor approximation barrier

**Status:** unreviewed corollary/approximation result conditional on Round 6A; no proof or disproof of the Collatz conjecture; no certified novelty claim.

Round 6B asks what Round 6A implies when the correction term in a candidate fast ranking is approximated by a simpler model that becomes phasewise frozen on a rational periodic shadow.

Let

$$
V(n)=\alpha\log n+R(n)
$$

satisfy the same hypothetical universal descent guarantee as Round 6A. On a depth-$r$ positive periodic shadow, suppose a surrogate $G$ is constant on same-phase returns and define

$$
e_r=\max_j|R(n_j)-G(n_j)|.
$$

Because $G$ contributes no same-phase debt, for every same-phase pair

$$
R(n_i)-R(n_{i+km})
=
(R-G)(n_i)-(R-G)(n_{i+km})
\le 2e_r.
$$

Hence the maximal same-phase correction debt obeys

$$
\Delta_r\le2e_r.
$$

Round 6A supplies, on a repelling rational periodic orbit of length $m$, total valuation $A$, and multiplier $\lambda=3^m/2^A>1$, the necessary lower bound

$$
\liminf_{r\to\infty}\frac{\Delta_r}{r}
\ge
\alpha\log(\lambda)
\frac{m-\beta A}{m+\beta\log_2\lambda}.
$$

Combining the inequalities gives the Round 6B approximation-gap bound

$$
\boxed{
\liminf_{r\to\infty}\frac{e_r}{r}
\ge
\frac{\alpha\log(\lambda)}{2}
\frac{m-\beta A}{m+\beta\log_2\lambda}.
}
$$

Thus a successful universal fast corrected-log ranking cannot be approximated to sublinear error, on all relevant stress shadows, by a surrogate that becomes phasewise frozen there.

For the high-period family

$$
w_m=(2,1^{m-1}),
$$

the corresponding normalized approximation-gap lower bound tends to

$$
\frac{\rho_\beta}{2},
\qquad
\rho_\beta=\frac{1-\beta}{1+\beta\log_2(3/2)}.
$$

## Consequence for sensor architectures

The intended interpretation is that finite-sensor approximations, and countable sensor expansions with uniformly negligible tails, cannot rescue the fixed-fraction ranking architecture. Every finite truncation of a successful countable sensor construction would have to leave a residual that remains macroscopically important on some high-period periodic stress shadows.

## Why Round 6B is not the first review target

Round 6B is a short deduction from Round 6A plus phase freezing. It is one abstraction farther from the original Collatz dynamics. The mathematically decisive external review remains the rational-period lifting and quantitative β-debt theorem in Round 6A.

See [`../round-6a/Theorem_6A1_Public_Review_Note.md`](../round-6a/Theorem_6A1_Public_Review_Note.md).
