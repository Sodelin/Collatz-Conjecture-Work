# F-POLY-RATCHET-001 — normalized fixed-cycle polynomial-ratchet obstruction

**Node ID:** `F-POLY-RATCHET-001:THEOREM`

**Node type:** `claim`
**Source date:** 2026-08-24  
**Source base:** `b3b9f4731937a2d7c999d1b8a6417c9e96597e46`  
**Verdict:** `PASS, scope-qualified / KILLED_SUBCLASS / STOPPED-USEFUL / NO DISPROOF`

This is the standalone extraction of one independently audited route result.
It excludes a normalized polynomial-divisibility mechanism on a fixed finite
cycle of accelerated Collatz macros. It supplies neither a positive
nontrivial cycle nor a positive integer with a divergent orbit.

## Canonical architecture

Index a directed cycle by `i` modulo `m`. On edge `i -> i+1`, fix an affine
macro

$$
M_i(x)=\frac{3^{u_i}x+b_i}{2^{v_i}},
\qquad u_i,v_i\ge1,\quad b_i\in\mathbb Z.
$$

For a genuine Collatz application, each macro must arise from a fixed
accelerated valuation word, and its exact valuation guards must be checked
separately. The affine formula alone does not establish that any positive
integer follows the edge.

At state `i`, let `F_i in Z[x]` be nonzero, nonconstant, primitive, and
normalized to have positive leading coefficient. Let `t_i>=0` be the least
exponent for which

$$
H_i(x)=2^{t_i}F_{i+1}(M_i(x))
$$

belongs to `Z[x]`. Assume exact polynomial divisibility

$$
H_i(x)=F_i(x)G_i(x),
\qquad G_i\in\mathbb Z[x]\setminus\{0\}. \tag{1}
$$

If (1) is inferred from equality on a guarded cell, that cell must contain
infinitely many distinct integers, so the identity extends to `Q[x]`.
Pointwise valuation inequalities, pointwise integer quotients, finite
interpolation, and congruences alone are outside this theorem.

Primitive positive-leading normalization, minimal power-of-two clearing, and
an integral quotient make the remaining content canonical. Arbitrary rational
rescaling of the `F_i` can otherwise manufacture or move apparent prime
factors between edges.

## Theorem

Under the preceding hypotheses:

1. All state degrees equal one common `d>=1`, and every `G_i` is a positive
   integer constant `c_i`.
2. With

   $$
   U=\sum_i u_i,\quad V=\sum_i v_i,\quad
   T=\sum_i t_i,\quad C=\prod_i c_i,
   $$

   one has

   $$
   t_i=dv_i\quad\text{for every }i,
   \qquad C=3^{dU}. \tag{2}
   $$

   In particular, every `c_i` is a power of `3`.
3. The scalar identities

   $$
   F_{i+1}(M_i(x))=\mu_iF_i(x),
   \qquad \mu_i=\frac{c_i}{2^{t_i}},
   $$

   satisfy

   $$
   \prod_i\mu_i=\left(\frac{3^U}{2^V}\right)^d. \tag{3}
   $$

   Thus the cycle-total valuation is

   $$
   v_p\!\left(\prod_i\mu_i\right)=
   \begin{cases}
   dU,&p=3,\\
   -dV,&p=2,\\
   0,&p\ne2,3.
   \end{cases}
   $$

   No normalized positive content gain at an odd prime `p!=3` exists in
   this architecture. The prime `3` is resonant and is not excluded.
4. Let the composed macro be

   $$
   N=M_{m-1}\circ\cdots\circ M_0
   =\frac{3^Ux+B}{2^V}=\lambda x+\beta,
   \qquad \lambda=\frac{3^U}{2^V}\ne1.
   $$

   Its unique rational fixed point is

   $$
   \alpha=\frac{B}{2^V-3^U}.
   $$

   The composed polynomial identity forces

   $$
   F_0(x)=A(x-\alpha)^d
   $$

   for some `A in Q*`. The surviving `3`-content is only the affine
   derivative acting on a power of displacement from the rational periodic
   point.
5. If an ordinary integer follows this same macro cycle forever, sampled once
   per cycle, it must equal `alpha`. Therefore it is periodic at the sampled
   phases, and `F_0` vanishes on it. The surviving `3`-adic eigenform does not
   generate a divergent positive orbit.

A positive integral, guard-valid `alpha` would be a positive Collatz cycle
candidate and must pass complete step-by-step replay. This theorem does not
exclude such a cycle.

## Proof

Taking degrees in (1) gives

$$
\deg F_{i+1}=\deg F_i+\deg G_i.
$$

Summing around the cycle makes the sum of the nonnegative quotient degrees
zero. Hence every quotient has degree zero and all `F_i` have one common
degree `d`. Positive leading coefficients make each constant quotient `c_i`
positive.

Minimal clearing makes `H_i` primitive at `2`. If `t_i>0` and every
coefficient were even, `t_i-1` would already clear the denominator. If
`t_i=0` and `H_i` had even content, invert the affine substitution and
multiply by the odd denominator `3^(u_i d)`; every coefficient of primitive
`F_(i+1)` would be even, a contradiction. Since `F_i` is primitive,
`c_i=content(H_i)` is therefore odd.

Let `ell_i>0` be the leading coefficient of `F_i`. Comparing leading
coefficients gives

$$
2^{t_i}\ell_{i+1}3^{u_id}=2^{v_id}c_i\ell_i. \tag{4}
$$

Multiplying (4) around the cycle cancels every `ell_i`:

$$
2^T3^{dU}=2^{dV}C. \tag{5}
$$

Because `C` is odd, uniqueness of the power-of-two times odd normal form gives
`T=dV` and `C=3^(dU)`. Full clearing gives `t_i<=v_i d`; the nonnegative
deficits sum to zero, so each is zero. This proves (2)--(3).

Composing the scalar identities gives

$$
F_0(N(x))=\lambda^dF_0(x).
$$

Set `Q(y)=F_0(alpha+y)`. Since `N(alpha+y)=alpha+lambda*y`,

$$
Q(\lambda y)=\lambda^dQ(y).
$$

Writing `Q(y)=sum_k a_k y^k` gives
`a_k(lambda^k-lambda^d)=0`. Because `lambda>0` and `lambda!=1`, distinct
integer powers of `lambda` are unequal. Thus only the degree-`d` term survives
and `F_0(x)=A(x-alpha)^d`.

Finally, suppose `x_k=N^k(x_0)` is integral for every `k`. Put

$$
D=2^V-3^U,\qquad y_k=Dx_k-B.
$$

Then

$$
y_k=\frac{3^{Uk}}{2^{Vk}}y_0.
$$

Integral persistence forces `2^(Vk)` to divide `y_0` for every `k`; hence
`y_0=0` and `x_0=alpha`. Evaluation at the fixed point gives
`F_0(alpha)=0`.

## Lean boundary and reproduction

The [Lean module](../../lean/CollatzWork/Disproof/PolynomialRatchet.lean)
checks only:

- uniqueness of a power of two times an odd factor;
- the normalized leading-coefficient telescope;
- exclusion of a positive divisor coprime to `3`; and
- vanishing of nonnegative quotient degrees whose sum is zero.

It does not formalize affine polynomial substitution, primitivity, minimal
clearing, guarded-cell identity, macro legality, the `3`-resonant eigenform
classification, or positive-natural membership. Those are exact prose
obligations. The source contains no `sorry`, `admit`, declared `axiom`, or
`unsafe`; its recorded dependencies are Lean's standard `propext` and
`Quot.sound`.

From the repository root:

```powershell
lake env lean lean\CollatzWork\Disproof\PolynomialRatchet.lean
```

Expected result: exit code `0` and four axiom reports containing only
`propext` and `Quot.sound`.

## Exact scope

This closes only one fixed finite directed macro cycle, primitive nonconstant
one-variable integral state polynomials, minimal power-of-two denominator
clearing, exact integral polynomial divisibility, and normalized content gain.

It does not cover branching or nonperiodic itineraries, pointwise valuation
inequalities, rational-function or Laurent quotients, multivariate or
changing-degree observables, state-dependent normalization, infinite state,
or nonpolynomial invariants. It supplies no improved cycle bound. No novelty
or priority claim is made.

## Connections

- **Verified by:** [independent hostile audit](CODEX_F_POLY_RATCHET_HOSTILE_AUDIT_2026-08-24.md).
- **Formalized by:** [Lean normalized arithmetic core](../../lean/CollatzWork/Disproof/PolynomialRatchet.lean) — only the arithmetic implications listed above.
- **Blocks:** [failure-ledger entry LEGACY-AUDITED-F027](../FAILURE_LEDGER.md#legacy-audited-f027--normalized-polynomial-divisibility-yields-a-non-3-valuation-ratchet) — only the canonically normalized fixed-cycle polynomial subclass.
- **Parallel to:** [two-pump dependency audit](CODEX_TWO_PUMP_DEPENDENCY_AUDIT_2026-08-24.md) — distinct fixed-word algebraic obstructions with no implication between them.
