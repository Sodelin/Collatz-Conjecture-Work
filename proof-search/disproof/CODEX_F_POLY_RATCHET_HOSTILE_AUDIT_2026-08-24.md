# Hostile audit: finite polynomial valuation ratchets

**Shot:** `F-POLY-RATCHET-001`  
**Status:** route obstruction only; no Collatz witness  
**Audit posture:** independently derived before reading the constructor artifact

## 1. Corrected verdict

A naive all-prime parity obstruction is false.  For the genuine one-step
accelerated macro

\[
M(x)=\frac{3x+1}{2}
\]

and the primitive polynomial `F(x)=x+1`, one has

\[
2F(M(x))=3F(x).
\]

Thus a legitimate minimal clearing of the power-of-two denominator can leave
positive `3`-content.  The exact residual result is:

* on a fixed finite cycle of genuine accelerated affine macros, exact
  polynomial divisibility forces every quotient polynomial to be constant;
* after primitive `Z[x]` normalization and minimal power-of-two clearing, all
  surviving content is a power of `3`, and the total content is exactly
  `3^(R d)`;
* hence no normalized positive net `p`-adic gain is possible for `p != 3`;
* the `p=3` survivor is only affine linearization about the unique rational
  periodic point; any integer that follows the macro cycle forever is that
  periodic point, where every nonconstant eigenform vanishes.

This is not a disproof and does not exclude pointwise, piecewise, nonperiodic,
or nonpolynomial valuation mechanisms.

## 2. Exact hypotheses

Index a directed state cycle by `i` modulo `m`.  Let

\[
M_i(x)=\frac{3^{r_i}x+b_i}{2^{s_i}}
\]

be fixed forward accelerated Collatz macros, with `r_i,s_i >= 1` and integer
`b_i`.  The usual exact valuation guards are part of legal orbit membership;
they are not implied by the affine formula.

Let `F_i in Z[x]` be nonzero, nonconstant, primitive polynomials, normalized
to have positive leading coefficient.  For each edge, let `t_i >= 0` be the
least exponent for which

\[
H_i(x):=2^{t_i}F_{i+1}(M_i(x))
\]

lies in `Z[x]`.  Suppose the proposed ratchet supplies an exact polynomial
factorization

\[
H_i(x)=p^{e_i}F_i(x)G_i(x),
\]

with `G_i` a nonzero polynomial.  If this equality is initially stated only
on a guarded cell, that cell must contain infinitely many distinct integers;
then the equality extends to `Q[x]`.  An empty or finite cell does not justify
a polynomial identity.

The displayed factor `p^(e_i)` is not itself canonical if `G_i` is allowed to
have rational coefficients.  The canonical edge content is defined below.

## 3. Degree collapse

Write `d_i=deg(F_i)` and `g_i=deg(G_i)`.  Since every `M_i` is nonconstant,

\[
d_{i+1}=d_i+g_i.
\]

Summing around the directed cycle gives

\[
0=\sum_i g_i.
\]

Every `g_i` is nonnegative, so every `G_i` is constant and all `d_i` have one
common value `d>=1`.  There is no leading-term cancellation loophole: the
factors are nonzero polynomials over a field.

Consequently each edge is a scalar eigen-identity

\[
F_{i+1}(M_i(x))=\mu_i F_i(x),\qquad \mu_i\in\mathbb Q^*.
\]

If some `F_i` or `G_i` is the zero polynomial, the valuation construction is
vacuous.  If the forms are constant, the nonconstant ratchet hypothesis has
been left and no unbounded polynomial observable is obtained.

## 4. Primitive parts and minimal denominator clearing

The full clearing exponent `s_i d` always works, so

\[
0\le t_i\le s_i d.
\]

Minimal clearing makes `H_i` primitive at `2`: not every coefficient of
`H_i` is even.  This is immediate when `t_i>0`, since otherwise `t_i-1`
would work.  If `t_i=0` and `H_i=2K` with `K in Z[x]`, invert the affine
substitution.  Multiplying by the odd number `3^(r_i d)` shows every
coefficient of `F_{i+1}` is even, contradicting primitivity.

Because `H_i` is an integer scalar multiple of primitive `F_i`, write

\[
H_i=c_iF_i,
\]

where `c_i=content(H_i)` is a positive odd integer.  This is the canonical
normalization.  A rational scalar multiplying a primitive integer polynomial
to another integer polynomial must be an integer; Bezout applied to the
coefficients of `F_i` proves this directly.

For an odd prime `p`, the actual edge gain of the scalar eigenline is
`v_p(c_i)`, since `2^(t_i)` is a `p`-adic unit.  For `p=2`, the multiplier
has valuation `-t_i`, so minimal clearing cannot create positive `2`-gain.

## 5. Content and leading-coefficient telescope

Let `ell_i>0` be the leading coefficient of `F_i`, and put

\[
R=\sum_i r_i,\quad S=\sum_i s_i,\quad T=\sum_i t_i,
\quad C=\prod_i c_i.
\]

Comparing leading coefficients on edge `i` gives

\[
c_i\ell_i
=\ell_{i+1}3^{r_i d}2^{t_i-s_i d}.
\]

Multiplication around the cycle cancels all `ell_i` and yields

\[
3^{Rd}=2^{Sd-T}C.
\]

Here `Sd-T>=0`, while `C` is odd.  Therefore

\[
T=Sd,\qquad C=3^{Rd}.
\]

Since each deficit `s_i d-t_i` is nonnegative, in fact every edge satisfies
`t_i=s_i d`.  Since each `c_i` is a positive integer and their product is a
pure power of `3`, every `c_i` is itself a power of `3`.

Equivalently, without choosing primitive representatives,

\[
\prod_i\mu_i=\left(\frac{3^R}{2^S}\right)^d.
\]

Thus the rescaling-invariant cycle valuation is

\[
v_p\!\left(\prod_i\mu_i\right)=
\begin{cases}
 Rd,&p=3,\\
 -Sd,&p=2,\\
 0,&p\ne2,3.
\end{cases}
\]

Rescaling a state form by `p^(u_i)` changes the two adjacent local gains by a
coboundary `u_{i+1}-u_i`; the sum around the cycle is unchanged.  A claimed
positive `p`-factor in `Q[x]` without primitive/content normalization is
therefore not evidence of valuation gain.

## 6. The surviving `p=3` identity is a fixed-point identity

Compose the macros once around the state cycle:

\[
N(x)=M_{m-1}\circ\cdots\circ M_0(x)
=\lambda x+\beta
=\frac{3^R x+B}{2^S},
\qquad \lambda=\frac{3^R}{2^S}\ne1.
\]

Composing the scalar polynomial identities gives

\[
F_0(N(x))=\lambda^dF_0(x).
\]

Let `alpha=beta/(1-lambda)=B/(2^S-3^R)` be the unique rational fixed point,
and set `Q(y)=F_0(alpha+y)`.  Then

\[
Q(\lambda y)=\lambda^dQ(y).
\]

Writing `Q(y)=sum_k a_k y^k`, distinct powers of the positive rational
`lambda != 1` are unequal.  Hence `a_k=0` for every `k != d`, and

\[
F_0(x)=A(x-\alpha)^d.
\]

The phase forms are transported powers of displacement from the corresponding
rational periodic-point phases.  The apparent `3`-adic gain is exactly the
`3^R` numerator of the affine derivative, not a new orbit generator.

## 7. Positive-natural and invariance gate

Suppose an integer `x_0` follows this same macro cycle forever.  Sampling once
per cycle gives `x_{k+1}=N(x_k)`.  Put

\[
D=2^S-3^R,\qquad y_k=Dx_k-B.
\]

Then

\[
y_k=\frac{3^{Rk}}{2^{Sk}}y_0.
\]

Every `y_k` is an integer.  Since `3` and `2` are coprime, `2^(Sk)` divides
`y_0` for every `k`, so `y_0=0`.  Therefore

\[
x_0=\frac{B}{2^S-3^R}=\alpha,
\]

and the sampled orbit is periodic.  Evaluating the eigen-identity at this
point also gives

\[
F_0(x_0)=\lambda^dF_0(x_0),
\]

so `F_0(x_0)=0`.  All phase forms vanish.  The `3`-adic valuation ratchet is
therefore vacuous on the only invariant integer.

If `3^R>2^S` and the Collatz offset `B` is positive, `alpha` is negative and
fails positive-natural membership.  If `2^S>3^R`, a positive integral
guard-valid `alpha` is a periodic Collatz orbit.  It would have to be replayed
as a cycle witness; it is not a divergent orbit.

For the one-edge counterexample above, legal use of `M(x)=(3x+1)/2` requires
`x congruent 3 (mod 4)`.  Repeating it gives

\[
x_k+1=\frac{3^k}{2^k}(x_0+1),
\]

so integrality for every `k` forces `x_0=-1`.  This is precisely the excluded
negative fixed point, and `F(-1)=0`.

## 8. Guard, quotient, and scope failures to reject

1. A pointwise inequality
   `v_p(F_{i+1}(M_i(n))) >= v_p(F_i(n))+e_i` on a residue cell does not imply
   polynomial divisibility.  For example, on `n congruent 1 (mod p)`,
   `v_p(n-1) >= v_p(n)+1`, but `x` does not divide `x-1` in `Q[x]`.
2. Pointwise integer quotients, congruences, or finite interpolation do not by
   themselves produce a polynomial `G_i`.  Exact zero remainder over `Q[x]`
   must be checked.
3. A rational identity can display any desired factor `p^e` by placing
   `p^(-e)` in the quotient.  Only normalized content or the invariant total
   multiplier has arithmetic meaning.
4. Empty cells make identities vacuous.  Finite cells give only finite orbit
   checks.  Infinite edge cells do not prove that their cyclic intersection
   is nonempty or forward invariant.
5. The classification does not cover branching or nonperiodic macro
   itineraries, rational-function or Laurent quotients, multivariate forms,
   changing degree, inequalities rather than identities, or nonpolynomial
   observables.
6. Even a valid unbounded valuation of a nonzero observable would still need
   positive-natural membership, exact forward invariance, and a bridge from
   observable growth to an unbounded Collatz orbit.

## 9. Claim boundary and prior-art status

The result is an elementary fixed-word affine/eigenform route obstruction.
The repository already classifies fixed valuation-word periodic-point
equations as classical and requires exact positivity, integrality, and guard
replay.  This audit neither strengthens published cycle bounds nor excludes
all polynomial or finite-state divergence constructions.

No positive nontrivial periodic orbit and no rigorously divergent positive
integer is supplied here.

## 10. Independent comparison with the constructor Lean artifact

The constructor artifact was released only after the derivation above was
complete.  It was compiled unchanged with:

```powershell
C:\Users\Owner\.elan\bin\lake.exe env lean lean\CollatzWork\Disproof\PolynomialRatchet.lean
```

The command exited with code `0`.  Its four axiom reports were:

```text
'CollatzWork.Disproof.twoPowerOddNormalFormUnique' depends on axioms: [propext, Quot.sound]
'CollatzWork.Disproof.normalizedLeadingTelescope' depends on axioms: [propext, Quot.sound]
'CollatzWork.Disproof.noNonresonantContentGain' depends on axioms: [propext, Quot.sound]
'CollatzWork.Disproof.quotientDegreesVanish' depends on axioms: [propext, Quot.sound]
```

The formal arithmetic statements are correct within their explicit premises:

* `twoPowerOddNormalFormUnique` proves uniqueness of `2^R * odd` form;
* `normalizedLeadingTelescope` proves exactly the normalized conclusions
  `R=d*K` and `H=3^(d*Q)` from the supplied leading-coefficient equation;
* `noNonresonantContentGain` correctly excludes a positive power of any base
  coprime to `3` dividing the normalized content product;
* `quotientDegreesVanish` correctly proves that nonnegative quotient degrees
  with sum zero all vanish.

The Lean file deliberately does **not** formalize the bridges from Collatz
macros and polynomial compositions to those arithmetic premises.  In
particular, primitivity, minimal clearing, odd content, exact infinite-cell
identity, the degree-sum equation, guard legality, forward invariance, the
`p=3` fixed-point classification, and positivity remain prose obligations.
The module describes itself as only the arithmetic core and explicitly does
not exclude `p=3`, so this boundary is scope-correct.

**Hostile-verifier verdict:** **PASS, scope-qualified** for the Lean arithmetic
core and the normalized `p != 3` route obstruction; **FAIL** for any broader
reading as an all-prime obstruction, a positive invariant-set theorem, or a
Collatz disproof.

## 11. Source-lane audit and release extraction

The original integrated source-lane journal was read only after the independent
derivation and Lean replay. It remains preserved in the isolated source
worktree but is intentionally excluded from this release because it also
contains unrelated exploratory Phase-A/B material. The standalone
[theorem packet](CODEX_F_POLY_RATCHET_SHOT_2026-08-24.md) is a scoped release
extraction of its Phase-C architecture: primitive positive-degree forms, a
fixed macro cycle, minimal clearing, integral polynomial quotients, and
canonical positive content. It explicitly excludes pointwise-only valuation
inequalities.

The degree equation, leading-coefficient equation, normalized conclusions,
`p=3` regression, 2-adic fixed-point argument, and eigenform classification
all agree with the independent derivation above.  The note also states the
correct witness verdict (`KILLED_SUBCLASS / NO DISPROOF`) and does not promote
the obstruction to a Collatz result.

The standalone packet carries all required handoff categories: claim ID,
verdict, exact family,
positivity/integrality, decisive equations, prior-art status, remaining gap,
reproduction, files, and exact scope. This provenance normalization does not
change the mathematical verdict.

The bridge from primitive polynomial macros to the arithmetic Lean hypotheses
remains a proved prose obligation rather than a theorem in the constructor
module.  Accordingly, any later registry promotion must retain the phrase
"Lean-checked arithmetic core" and must not describe the full polynomial or
positive-invariance theorem as Lean-formalized.
