---
node_id: B-RESIDUE20-VALUATION13-ANCESTOR-2026-09-05
node_type: lemma
routes: [B, AB]
tags: [collatz, exact-coalescence, unbounded-valuation, immutable-root, proved-auxiliary]
---

# Refined tail certificates lower the uniform ancestor cutoff to valuation 13

**Proved auxiliary theorem.** Every positive `r = 20 mod27` with

\[
\boxed{v_3(4r+1)\ge13}
\]

has an explicitly constructed positive `m = 20 mod27` with `m<r` and
`T^b(m)=r`. No parity assumption on r is needed. This strengthens the simpler
valuation21 theorem by replacing just one of its six branches with five
short exact inverse-word certificates. The proof and its finite replay are
separate: the argument below is uniform for arbitrary integer size and
unbounded valuation.

The [valuation21 construction](Residue20_Valuation_Ancestor.md)
remains valid unchanged. This refinement is an elementary specialization of
existing inverse-word semantics, without a claim of external novelty or
universal termination.

## 1. Common prefix and the retained five branches

Use `T(n)=n/2` for even n and `T(n)=(3n+1)/2` for odd n. Define

\[
v=v_3(4r+1),\quad u=(4r+1)/3^v,\quad
 t=2^{v-2}u\bmod9\in\{1,2,4,5,7,8\}.
\]

For `v>=4` and `h in {1,2}`, put

\[
z_h=2^{v-h-1}3^h u-1.
\]

The exact prefix theorem is

\[
\boxed{T^{v-h+1}(z_h)=r.}\tag{1}
\]

Here is its complete parity justification. Since `3^v u=4r+1`, u is odd.
Let `L=v-h-1`. The first L steps from `z_h=2^L(3^h u)-1` are odd and reach
`3^(v-1)u-1`. This value is even. Moreover `3^(v-1)u = 3 mod4`, so its
half is odd. The final even step followed by an odd step gives
`(3^v u-1)/4=r`. Thus the forward prefix word is `O^L E O`.

Retain these five branches from the simpler theorem:

| t | h | Chronological inverse tail w | Minimum v | Uniform slope alpha |
|---:|---:|---|---:|---:|
|1|1|`EEEEEE`|13|`192(2/3)^v`|
|2|1|`EE`|7|`12(2/3)^v`|
|5|2|`EEEE`|11|`72(2/3)^v`|
|7|1|empty|4|`3(2/3)^v`|
|8|2|`EEEE`|11|`72(2/3)^v`|

Here `E(y)=2y` is an exact even inverse, and the target is `m=E^e(z_h)`.
All table guards prove `m in S`, `m<r`, and `T^(v-h+1+e)(m)=r` as in the
original proof. Only the t4 branch is changed below.

## 2. The five refined tails for t=4

When t4, choose `h=1` and write `z=z_1`. Then `z = 11 mod27`. The following
five disjoint residue guards exhaust this class. Words are read as
chronological inverse operations **starting from z**, with
`O(y)=(2y−1)/3` permitted only when `y=2 mod3`.

| Guard on z | Inverse word w | Exact target F(z) | Length | O count | Minimum v |
|---|---|---|---:|---:|---:|
|`38 mod81`|`EEO`|`(8z−1)/3`|3|1|6|
|`65 mod81`|`OEEE`|`(16z−8)/3`|4|1|7|
|`11 mod243`|`OEEEOE`|`(64z−38)/9`|6|2|8|
|`92 mod243`|`EEOEEOEE`|`(256z−44)/9`|8|2|11|
|`173 mod243`|`EEOOE`|`(32z−10)/9`|5|2|6|

Coverage is exact: reducing `z=11 mod27` modulo81 gives11,38,65. The first
is refined modulo243 into11,92,173; the other two are the first two rows.
No finite-sample extrapolation is involved.

Every inverse step is legal. For the first two rows the only odd inverse
starts from a value `2 mod3`. In the last three rows the second odd inverse
has, respectively, the intermediate form

\[
8(2z-1)/3,\quad 4(8z-1)/3,\quad(8z-1)/3,
\]

which the stated guards make `2 mod3`; the first odd inverse is legal as
well. This proves positive integral trajectories, not only integral final
formulas. Direct substitution of each guard in F gives

\[
\boxed{F(z)\equiv20\pmod{27}.}\tag{2}
\]

For an affine family, these checks can equivalently be made at the listed
residue because adding the listed modulus changes each needed intermediate
residue by a multiple of3 and changes F by a multiple of27.

Put `m=F(z)` and let ell be the tail length. The exact orbit equality is

\[
\boxed{T^{v+\ell}(m)=r.}\tag{3}
\]

The orientation is essential: starting from m, apply the parity word
`reverse(w)` to reach z, then `O^(v−2) E O` to reach r. A chronological
inverse word is not silently treated as a forward word in the same order.
The complete forward step count is `ell+v` because h1.

## 3. Uniform strict descent and the threshold13 proof

Write the tail formula as `F(z)=(A z−C)/D`, with A,D,C from its row. Here
`C>0`, and

\[
z_1=3(2/3)^v r+\left(\frac{2^{v-2}}{3^{v-1}}-1\right).
\]

The intercept in parentheses is negative. Therefore

\[
m=\alpha r+\beta,\quad
\alpha=\frac{3A}{D}(2/3)^v,\quad \beta<0.\tag{4}
\]

The five tail coefficient constants `3A/D` are, in table order,

\[
8,\quad16,\quad64/3,\quad256/3,\quad32/3.
\]

Their respective table thresholds are the first valuations for which the
chosen slope is below1. The largest of these constants is `256/3<192`.
Including all the retained branches gives the common estimate

\[
\alpha\le192(2/3)^v.
\]

Finally,

\[
\boxed{192\cdot2^{13}=1,572,864<1,594,323=3^{13}.}\tag{5}
\]

For every v≥13 this proves `alpha<1`; since the intercept is negative,
`m<r`. The guarded inverse path proves positivity. Equations (1)–(3) prove
coalescence and membership in S. These facts establish the theorem for all
admissible positive units u, with no upper bound on u or v.

## 4. Sharpness and boundaries

The threshold13 is sharp for this particular prescribed selector, not for
all possible coalescence methods. At `v=12,u=13`, one has t1, so its selected
six-doubling tail gives

\[
r=(3^{12}\cdot13-1)/4=1,727,183,
\]

\[
m=64(3\cdot2^{10}\cdot13-1)=2,555,840>r,
\qquad T^{18}(m)=r.
\]

The identity is correct and the required order is false. Thus extending the
uniform statement to v12 without changing this branch would be invalid.
No claim is made that this root lacks some other smaller certificate.

The earlier valuation20 counterexample to the *old* t4 selector is repaired
by the refined table. The same root

\[
r=11,332,049,303
\]

now has `z=10,223,615=38 mod81`, and the tail EEO gives

\[
\boxed{m=27,262,973<r,\qquad T^{23}(m)=r.}
\]

This improvement results from changing the exact inverse path, not from
reinterpreting the failed old inequality.

The old auxiliary first-return/c-normalization loop remains a required
stress test. An explicit member of that infinite family is

\[
r=(3^{13}\cdot103-1)/4=41,053,817=425\pmod{432}.
\]

The present construction gives

\[
\boxed{m=2,531,324<r,\qquad T^{15}(m)=r.}
\]

The old first return followed by c sends this root back to itself. The new
certificate makes a separate strict comparison with r. Root425 itself has
`v=5,t=2` and is still explicitly uncovered by this selector.

## 5. Exact mathematical gain and missing bridge

All covered roots have `v3(r+7)=3`, by
`4(r+7)=27(3^(v−3)u+1)`. Thus this is a partial positive result inside the
previous c-normal residue20 class.

Together with the earlier normalizer, a hypothetical least nonconvergent
root in S must satisfy both

\[
v_3(r+7)\in\{3,4\},\qquad v_3(4r+1)\le12,
\]

and must avoid the additional individually covered lower-valuation rows.
These are necessary conditions conditional on the existence of a least bad
root. They are not a proof that the residual class terminates.

This construction has no theorem controlling how the complementary roots
move under return, no theorem that a forward orbit eventually enters one of
these guarded families, and no global rank. The substantive next target is
that residual transition behavior against an immutable original root.

## 6. Reproduction and formal boundary

`residue20_refined_ancestor_check.py` checks the exact cylinder partition,
independently reconstructs inverse affine offsets, verifies every inverse
guard, and replays actual forward shortcut trajectories for26,085 examples.
Replay includes unbounded-form test cases at valuations127,256,1024, very
large unit tails, the old self-loop-family witness, the repaired v20 case,
and the v12 failure of unguarded descent. `python -O -B` passes; explicit
failure checks are not removed by optimized Python mode.

The universal proof is the finite exact tail table combined with the
parameterized prefix identity and inequalities (4)–(5). The replay is a
regression check. The refined selector is not yet Lean formalized. Its
arithmetic is suitable for the existing generic orbit/inverse semantics,
and the simpler valuation21 result can remain a separately checked corollary.

**11. Process assessment.** The variable prefix, finite residue coverage,
inverse-word orientation, integrality guards, and root-relative strict order
were reviewed separately. The finite search served only to propose five
words; the proof does not rely on search optimality or completeness.

**12. Robustness assessment.** The bound holds for all admissible units and
arbitrarily large valuations. Sharpness is explicitly scoped to this selected
table. The omitted residue/valuation cases and lack of a universal return
argument remain visible; no closure inference is justified.


## Connections

- **Depends on:** [generic ancestor prefix](../../lean/CollatzWork/RootDescent.lean) and [inverse-word semantics](L4_General_Inverse_Word_Coalescence.md).
- **Strengthens / specializes:** [six-row valuation21 construction](Residue20_Valuation_Ancestor.md).
- **Verified by:** [replay manifest](../../verification/README.md) and [independent refined checker](../../verification/residue20_refined_ancestor_check.py).
- **Formalized by / pending:** [exact scope and remaining finite tails](../../LEAN_TARGETS.md).
- **Parallel to:** [forward burst descent](Root_Relative_Burst_Descent.md).
