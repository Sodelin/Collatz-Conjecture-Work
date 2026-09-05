# L10 — Near-return theorem and dual 2-adic/3-adic residue certificate

**Cycle:** Round 7, 2026-08-23  
**Status:** `PROVED_AUX` / `FORMAL_PENDING`  
**Novelty:** exact formulation not priority-certified; no novelty claim  
**Usefulness:** converts a paradoxical first coefficient contraction into a simultaneous tiny-residue problem at both endpoints  
**Collatz relevance:** necessary-condition sharpening only; not a resolution

## 1. Inputs from L9

Use the accelerated map

$$
T(n)=\begin{cases}
(3n+1)/2,&n\text{ odd},\\
n/2,&n\text{ even}.
\end{cases}
$$

Suppose `tau` is the first coefficient-contraction time for a positive integer `n` and let

$$
s=q_\tau
$$

be the number of odd branches in the first `tau` accelerated steps. L9 gives

$$
\tau=\lfloor s\log_2 3\rfloor+1
$$

and the exact affine formula

$$
\boxed{
T^\tau(n)=\frac{3^s n+C}{2^\tau}
}\tag{1}
$$

for a positive integer remainder `C` determined by the parity word.

L9's trivial `s=0`, `tau=1` edge has `T(n)=n/2<n`.  It is therefore
automatically excluded once the non-descending hypothesis in Section 2 is
imposed.  On the branch studied here, `s>=1` and `C>0`.

If the odd positions are

$$
p_1<\cdots<p_s,
$$

then

$$
\boxed{
C=\sum_{r=1}^s2^{p_r-1}3^{s-r}.
}\tag{2}
$$

L9 also proves

$$
C\le C_{\max}=3^{s-1}S_s,
\qquad
S_s=\sum_{r=1}^s2^{-\{(r-1)\log_2 3\}}.
\tag{3}
$$

Set

$$
\delta_s=\tau-s\log_2 3\in(0,1).
$$

Then

$$
2^\tau=3^s2^{\delta_s}.
\tag{4}
$$

## 2. Near-return theorem

Assume the first coefficient contraction is paradoxical/non-descending:

$$
T^\tau(n)\ge n.
$$

Write

$$
\boxed{T^\tau(n)=n+d}\tag{5}
$$

with integer `d>=0`.

From (1),

$$
2^\tau d
=C-(2^\tau-3^s)n.
\tag{6}
$$

Since the second term on the right is positive,

$$
2^\tau d<C
$$

unless `n=0`, which is excluded. Hence

$$
d<\frac{C}{2^\tau}
\le\frac{C_{\max}}{2^\tau}.
$$

Using (3) and (4),

$$
\frac{C_{\max}}{2^\tau}
=\frac{S_s}{3\,2^{\delta_s}}
<\frac{S_s}{3}
\le\frac{s}{3}.
$$

Therefore

$$
\boxed{
0\le d<\frac{s}{3}.
}\tag{7}
$$

Because `d` is an integer,

$$
\boxed{
d\le\left\lfloor\frac{s-1}{3}\right\rfloor.}\tag{8}
$$

### Interpretation

At its first multiplicative contraction, a paradoxical trajectory cannot jump to an unrelated large value. It must return to within fewer than `s/3` integers above its starting value after approximately `s log_2 3` accelerated steps.

For the L8 first Farey-allowed odd count

$$
s=72\,057\,431\,991,
$$

this gives the exact coarse bound

$$
d\le24\,019\,143\,996.
$$

This numerical substitution is only an illustration; theorem (7) is unconditional once the L9 first-contraction hypotheses hold.

## 3. Exact near-cycle identity

Define

$$
\boxed{D=2^\tau-3^s>0.}\tag{9}
$$

Equation (6) rearranges to

$$
\boxed{
C=Dn+2^\tau d.
}\tag{10}
$$

Thus a paradoxical first contraction is an exact integer near-cycle equation with two nonnegative coordinates `(n,d)`.

The cyclic case is exactly `d=0`, when

$$
C=Dn.
$$

The acyclic paradoxical case has `d>0` but, by (7), a very small additive defect compared with the astronomical multiplicative moduli at the L8 frontier.

## 4. Start residue modulo 2^tau

From (1), integrality gives

$$
3^s n+C\equiv0\pmod{2^\tau}.
$$

Because `3^s` is invertible modulo `2^tau`, the parity word determines a unique residue

$$
\boxed{
r_2(C)\equiv-C\,(3^s)^{-1}\pmod{2^\tau}.}\tag{11}
$$

Every positive integer realizing the parity word satisfies

$$
n\equiv r_2(C)\pmod{2^\tau}.
$$

For a non-descending first contraction, L9 also gives

$$
\boxed{
n\le\frac{C}{D}\le G(s).}\tag{12}
$$

Therefore whenever `G(s)<2^tau`, a paradoxical first contraction requires the least positive residue representative itself to satisfy

$$
\boxed{0<r_2(C)\le C/D.}\tag{13}
$$

## 5. Endpoint residue modulo 3^s

Let

$$
y=T^\tau(n).
$$

Equation (1) also gives

$$
2^\tau y\equiv C\pmod{3^s}.
$$

Since `2^tau` is invertible modulo `3^s`, the same parity word determines a unique endpoint residue

$$
\boxed{
r_3(C)\equiv C\,(2^\tau)^{-1}\pmod{3^s}.}\tag{14}
$$

Every endpoint of a positive integer realizing the word satisfies

$$
y\equiv r_3(C)\pmod{3^s}.
$$

Now solve (1) for `n`:

$$
n=\frac{2^\tau y-C}{3^s}.
\tag{15}
$$

Positivity of `n` requires

$$
y>\frac{C}{2^\tau}.
\tag{16}
$$

Non-descent `y>=n` is equivalent to

$$
Dy\le C,
$$

hence

$$
\boxed{
y\le\frac{C}{D}.}\tag{17}
$$

Therefore, whenever `C/D<3^s`, a paradoxical realization exists only if the least positive endpoint residue representative satisfies the narrow interval condition

$$
\boxed{
\frac{C}{2^\tau}<r_3(C)\le\frac{C}{D}.
}\tag{18}
$$

## 6. Dual-residue criterion

For any fixed first-contraction parity word with remainder `C`, the search for a paradoxical realization can therefore be phrased as a simultaneous residue problem:

### 2-adic/start side

$$
r_2(C)\equiv-C3^{-s}\pmod{2^\tau},
\qquad
0<r_2(C)\le C/D.
$$

### 3-adic/endpoint side

$$
r_3(C)\equiv C2^{-\tau}\pmod{3^s},
\qquad
C/2^\tau<r_3(C)\le C/D.
$$

The two sides are linked by

$$
r_3=T^\tau(r_2)
$$

for the canonical positive realization whenever the interval conditions hold.

This is not two independent random congruences. It is one exact mixed-radix compatibility condition seen from both ends. But it exposes the correct arithmetic target:

> a counterexample to coefficient stopping at its first contraction requires a parity word whose canonical start residue modulo `2^tau` and canonical endpoint residue modulo `3^s` are both extraordinarily small compared with their natural moduli.

## 7. Gap residue modulo D

From (10), reduction modulo `D` gives

$$
2^\tau d\equiv C\pmod D.
$$

If `D>1`, then

$$
\gcd(2^\tau,D)=1,
$$

so `2^tau` has a unique multiplicative inverse modulo `D` and

$$
\boxed{
d\equiv C(2^\tau)^{-1}\pmod D.}\tag{19}
$$

Combining this with (8), for `D>1` a paradoxical first contraction requires the canonical residue of `C(2^tau)^{-1}` modulo `D` to land in

$$
\boxed{
0\le d\le\left\lfloor\frac{s-1}{3}\right\rfloor.
}\tag{20}
$$

When `D=1`, reduction modulo `D` is the trivial congruence modulo one and
supplies no additional residue restriction; no modular-inverse representative
is needed.  The legitimate edge example `s=1`, `tau=2`, `n=1` lies in this
degenerate case.

At a near-critical Diophantine scale, `D` can be much smaller than `2^tau` or `3^s`, but it is still an exact third modulus tied to the additive near-return defect.

## 8. Why this still does not prove the CST or Collatz conjecture

The statement

> every first coefficient contraction actually descends

is the classical Coefficient Stopping Time (CST) conjecture of Terras in its first-crossing form. Proving that no parity word can satisfy the residue intervals above would therefore settle a known open problem, not merely discharge a routine lemma.

L10 should not disguise that wall.

Its contribution is to replace a vague paradoxical-prefix search by an exact finite certificate at each `(s, parity word)`:

1. compute `C` exactly;
2. compute `D=2^tau-3^s`;
3. compute the canonical residues `r_2`, `r_3`, and, when `D>1`, `d mod D`;
4. check the explicit short interval conditions.

The next useful theorem must exploit structure of the **near-mechanical first-contraction words from L9**, rather than attempting unrestricted parity enumeration.

## 9. Lean targets

Formalize:

1. near-return identity (6) and bound (7)-(8);
2. exact identity `C=D n+2^tau d`;
3. modular inverses and start-residue statement (11);
4. endpoint-residue statement (14);
5. interval equivalence (16)-(18);
6. gap-residue congruence (19)-(20) under `D>1`, with `D=1` proved
   separately to be the vacuous modulus-one case.

These are finite arithmetic statements once L9's affine prefix theorem is available.

## 2026-09-05 sharpening

[ L15's quarter-gap certificate](L15_Quarter_Gap_and_Rotation_Block_Certificate.md)
strengthens the gap estimate to `4d<s` and the sufficient inheritance condition
to `3*floor((s-1)/4)+1<n_*`. The original argument remains valid as a weaker
historical bound; its renewal and stopping-time limitations remain.


## Third-pass formalization update

The actual-orbit universal `3d<s` bound and its stronger `4d<s` replacement
are now [Lean-checked](../../verification/Quarter_Gap_Formal_Scope_2026-09-05.md).
Other dual-residue and source-level statements keep their original scope.
