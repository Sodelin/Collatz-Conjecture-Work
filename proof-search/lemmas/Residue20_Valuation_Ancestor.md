---
node_id: B-RESIDUE20-VALUATION-ANCESTOR-2026-09-05
node_type: lemma
routes: [B, AB]
tags: [collatz, exact-coalescence, unbounded-valuation, immutable-root, proved-auxiliary]
---

# An explicit smaller residue-20 ancestor for every sufficiently deep 3-adic root

**Result.** Every positive integer `r = 20 (mod 27)` satisfying

$$
v_3(4r+1)\ge21
$$

has an explicitly constructed positive `m = 20 (mod 27)` with

$$
 m<r,\qquad T^b(m)=r.
$$

The target is compared directly with the immutable original root. The result
covers an infinite family that the existing internal rule
`c(r)=(8r−7)/9`, guarded by `r = 236 (mod 243)`, does not remove: every root
covered here has `v3(r+7)=3`. The six-way refinement below also covers many
roots with valuation between 4 and 20.

This is an elementary new repository specialization of the existing exact
inverse-word semantics, not a claim of new mathematics relative to the
literature. It is a proper partial family, not universal termination.

## 1. Definitions and exact construction

Use the positive shortcut map

$$
T(n)=\begin{cases}n/2&n\text{ even},\\(3n+1)/2&n\text{ odd}.\end{cases}
$$

Let `S={n>0:n=20 mod27}`. Fix `r` in `S`, and put

$$
v=v_3(4r+1),\qquad u=(4r+1)/3^v.
$$

Then `v>=3`, `u>0`, `3∤u`, and `3^v u=4r+1`. No parity restriction on `r`
is required. This note imposes `v>=4` to stay inside a class missed by the
existing internal c-normalizer.

Let

$$
t=2^{v-2}u\pmod9,\qquad t\in\{1,2,4,5,7,8\}.
$$

Choose `(h,e,v_min)` from this exact table:

| t | h | e | Required v_min | z_h mod27 | m/r leading coefficient |
|---:|---:|---:|---:|---:|---:|
| 1 | 1 | 6 | 13 | 2 | `192(2/3)^v` |
| 2 | 1 | 2 | 7 | 5 | `12(2/3)^v` |
| 4 | 2 | 10 | 21 | 17 | `4608(2/3)^v` |
| 5 | 2 | 4 | 11 | 8 | `72(2/3)^v` |
| 7 | 1 | 0 | 4 | 20 | `3(2/3)^v` |
| 8 | 2 | 4 | 11 | 8 | `72(2/3)^v` |

For `v>=v_min`, define

$$
\boxed{z_h=2^{v-h-1}3^h u-1,\quad m=2^e z_h,\quad b=v-h+1+e.}\tag{1}
$$

Then

$$
\boxed{0<m<r,\quad m\equiv20\pmod{27},\quad T^b(m)=r.}\tag{2}
$$

Thus the desired coalescence equality is `T^0(r)=T^b(m)`.

## 2. Exact inverse path and admissibility

Write the inverse operations as

$$
\mathsf E(y)=2y,\qquad
\mathsf O(y)=(2y-1)/3\quad(y\equiv2\pmod3).
$$

Starting from any `r = 20 mod27`, the chronological inverse word `O,E,O`
is admissible and has endpoint

$$
z=(8r-7)/9,
\qquad z+1=2(4r+1)/9=2\cdot3^{v-2}u.\tag{3}
$$

Indeed, the first odd inverse takes `r` to an odd integer `1 mod3`, the
even inverse takes it to `2 mod3`, and the next odd inverse is legal.

For `0<=k<=v-2`, the additional inverse word `O^k` is legal and gives

$$
\mathsf O^k(z)+1=(2/3)^k(z+1)
 =2^{k+1}3^{v-2-k}u.\tag{4}
$$

For the construction choose `k=v-h-2>=0`. Equations (3)–(4) give exactly
`z_h` in (1). Append `e` always-legal even inverses. The complete
chronological inverse word is

$$
\mathsf O\mathsf E\mathsf O\;
\mathsf O^{v-h-2}\;\mathsf E^e.
$$

Consequently the chronological **forward** shortcut parity word from `m` is

$$
\boxed{E^e\,O^{v-h-1}\,E\,O.}\tag{5}
$$

It has `b=e+v-h+1` steps. Reversing the individually verified inverse
operations proves `T^b(m)=r`; it is not an inference from an unguarded affine
identity. All intermediate integers are positive. In particular, `z_h` is
odd and positive because `v>=4` and `h` is either 1 or 2.

There is also a short direct verification of this entire parity word. Put
`L=v-h-1` and `a=3^h u`, which is odd. Starting from
`m=2^e(2^L a-1)`, e even steps give `2^L a-1`. Its next L states
follow odd branches and reach `3^L a-1=3^(v-1)u-1`. This is even.
Moreover `3^v u=4r+1` implies `3^(v-1)u=3 mod4`, so after one
even step the state is odd. The final odd step yields
`(3^v u-1)/4=r`. This proof is convenient for formalization using an
existing Mersenne-prefix iteration lemma.

## 3. Why the target stays in S

For `h=1`,

$$
z_1\equiv3t-1\pmod{27}.
$$

For `h=2`, since 2 has inverse 2 modulo3,

$$
z_2\equiv9(2t\bmod3)-1\pmod{27}.
$$

These give the fifth table column. Direct modular multiplication then yields
`2^e z_h = 20 mod27` in each of the six cases. The table is exhaustive
because `u` is coprime to3 and so is `2^{v-2}`.

This is why stopping the inverse odd run with either one or two remaining
3-adic powers is useful. Merely applying c and immediately demanding
membership in S would reject every root covered here.

## 4. Strict comparison with the immutable root

Eliminate u from (1):

$$
m=\alpha r+\beta,
\qquad
\alpha=\frac{2^{v-h+1+e}}{3^{v-h}},
\qquad
\beta=2^e\left(\frac{2^{v-h-1}}{3^{v-h}}-1\right)<0.\tag{6}
$$

The last sign follows from `v-h>=2`. Each table threshold makes
`alpha<1`, hence `m<r` for every admissible positive unit u, however large.
Increasing v multiplies alpha by `2/3`, so checking the threshold suffices.

Across the six cases,

$$
\alpha\le4608(2/3)^v.
$$

The exact endpoint comparison is

$$
4608\cdot2^{21}=9,663,676,416
<10,460,353,203=3^{21}.
$$

This proves complete coverage of the stated family `v>=21` without a
computational size cutoff, finite-time extrapolation, or probabilistic model.

The value 21 is the sharp uniform threshold for this prescribed six-row
selector. It is not a lower bound for every conceivable inverse strategy.
At `v=20,u=13`, the `t=4` branch gives

$$
r=11,332,049,303,
\qquad m=15,703,473,152>r,
\qquad T^{29}(m)=r.
$$

Thus dropping the valuation guard retains a correct orbit identity while
losing the strict order needed by induction. The individual nontrivial
thresholds are similarly the least coefficient-winning thresholds for the
chosen rows; the `t=7` row is restricted to `v>=4` by this note's c-normal
domain, although its coefficient is already winning at v=3.

## 5. Relation to the previous normalizer and its self-loop

For `v>=4`,

$$
4(r+7)=4r+1+27=27(3^{v-3}u+1).
$$

The factor in parentheses is `1 mod3`, so

$$
\boxed{v_3(r+7)=3.}
$$

All constructed roots are therefore c-normal for the old internal rule,
which requires `v3(r+7)>=5`. This result does not merely reapply that same
internal rule. Its first c-like inverse block leaves S, a variable-length odd
inverse run consumes the different valuation `v3(4r+1)`, and final doubling
returns to S with a strict comparison against the original root.

It also covers infinitely many members of the old auxiliary self-loop family.
For any `v>=21`, choose a positive u coprime to3 satisfying

$$
3^{v-3}u\equiv-1\pmod{64}.
$$

Then `r=(3^v u-1)/4 = 425 mod432`, so its first return followed by old
c-normalization is the exact self-loop `r -> r`. There are infinitely many
such units for every v. The new construction supplies a separate smaller
ancestor in S.

For example,

$$
v=21,\quad u=7,\quad r=18,305,618,105
$$

has `t=5,h=2,e=4`, producing

$$
\boxed{m=264,241,136<r,\qquad T^{24}(m)=r.}
$$

This example belongs to the previous self-loop family. By contrast, the
small root425 has `v=5,t=2`, below that row's threshold7, and is explicitly
**not** certified by this construction. The method never treats the fact
that the old auxiliary map loops as mathematical descent.

## 6. Uncovered cases and research consequence

The exact covered set is the six guarded rows, not all of S. Remaining cases
include every root with `v3(4r+1)=3`, plus values4 through20 that fall below
their applicable threshold. There is no proof that an arbitrary forward
orbit reaches the covered set, no bound on how the valuation recharges, and
no global well-founded return rank.

Combined with the existing stopping theorem, this strengthens a possible
least-nonconvergent-root analysis: a least nonconvergent member of S cannot
belong to the covered set. In particular it would satisfy

$$
v_3(4r+1)\le20.
$$

If one also applies the previously proved internal c-rule, such a least root
must satisfy `v3(r+7) in {3,4}`. These are conditional necessary properties
of a hypothetical least bad root. They do not prove such a root exists or
that it cannot exist.

The next useful mathematical target is control of the complementary bounded
valuation roots under a macro measured against the same immutable root.
Increasing a replay limit will not establish that control.

## 7. Verification and integration boundary

`residue20_valuation_inverse_check.py` reconstructs the target table by modular
arithmetic, checks the exact threshold inequalities, and independently
replays the **forward** shortcut map for24,930 guarded examples. These include
valuations through1024, both original-root parities, the explicit old
self-loop-family witness, and the valuation20 counterexample to unguarded
descent. Checks use explicit failures and remain active under `python -O`.

The universal proof is Sections2–4, not those finite replays. The checker
imports no baseline implementation. The generic orbit identity is Lean-checked as `rootDescentAncestor`; the exhaustive selector, target membership, and size-bound argument are proved here in prose and are not yet formalized.
The construction is an elementary use of `L4_General_Inverse_Word_Coalescence`
with a variable-length family of words; external novelty has not been audited.

**11. Process assessment.** Exact domain, parity branches, unit classes,
thresholds, positivity, and immutable-root comparison were checked separately.
The root425 was retained as a deliberate non-certificate. No claim of
exhaustive literature coverage is made.

**12. Robustness assessment.** The argument works for arbitrary integer size
and unbounded valuation under its guards. A correct orbit identity can fail
to decrease the root when the guard is removed, as the exact v20 witness
shows. This sharp boundary prevents interpreting the family theorem as a
universal bridge.


## Connections

- **Depends on:** [general inverse-word semantics](L4_General_Inverse_Word_Coalescence.md).
- **Strengthens / specializes:** [core residue obstruction and auxiliary loop](../routes/AB_ternary_normalized_core_residue_obstruction.md).
- **Verified by:** [replay manifest](../../verification/README.md) and [exact checker](../../verification/residue20_valuation_inverse_check.py).
- **Formalized by / pending:** [generic orbit identity and remaining scope](../../LEAN_TARGETS.md).
- **Prior art:** [sufficiency source audit](../sources/Sufficiency_Rank_Audit_2026-09-05.md).

- **Strengthened by:** [refined valuation13 selector](Residue20_Refined_Ancestor.md).
