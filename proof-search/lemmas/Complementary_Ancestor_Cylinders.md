---
node_id: B-SECOND-TERNARY-ANCESTOR-001
node_type: lemma
routes: [B, AB]
tags: [collatz, smaller-ancestor, unbounded-valuation, actual-return]
---

# Complementary ancestor cylinders and a second ternary-depth coordinate

Use the shortcut map T(n)=n/2 for even n and (3n+1)/2 for odd n; S is the positive integers congruent to20 modulo27. Inverse E(y)=2y is always legal; inverse O(y)=(2y−1)/3 is legal when y=2 modulo3. All words below are chronological inverse words. They are reversed to give actual forward parity words.

## Two elementary infinite families missed by the original selector

For every integer t≥0:

| Root r | Smaller ancestor m | Forward time | Inverse word |
|---|---|---:|---|
|4529+19683t|3179+13824t|9|OEOOEOEOO|
|17813+59049t|16679+55296t|11|OEOEEOOEOOO|

Both endpoints belong toS; m>0 and m<r term by term. The inverse endpoint formulas are respectively

    m=(512r−1357)/729,
    m=(2048r−4051)/2187.

The listed root congruences ensure every odd inverse is legal. One can verify the finitely many guards on the base root: adding 3^(o+3)t to the root changes each intermediate value after j odd inverses by 2^a3^(o+3−j)t, divisible by3 whenever another odd inverse remains. Endpoints change by2^length·27t, preservingS. Every legal inverse of a positive integer remains positive.

The first family has r=155 mod243; the second has r=74 mod243. Therefore both have exactly

    v3(r+7)=4,   v3(4r+1)=3.

Consequently every root is outside the full guarded domain of the original valuation13 ancestor selector, which requires v3(4r+1)≥4 even on its lower rows. Since the periods are odd, each family contains infinitely many roots of each prescribed exact q=v2(r+5), by the elementary CRT. In particular the families contain arbitrarily long OOE shadows.

These are elementary project-specific specializations of generic inverse-word arithmetic. No external novelty or exhaustive coverage claim is made.

## A uniform family with unbounded new ternary depth

Let r∈S and define

    v=v3(128r−157),   u=(128r−157)/3^v.

The input is positive because r≥20. If v≥17, there is an explicit m∈S with 0<m<r and T^b(m)=r. This is another unbounded-parameter family, wholly inside v3(r+7)=4 and v3(4r+1)=3.

Proof: v≥5 forces r=155 mod243. The chronological inverse prefix P=OEOOEOE is legal already for r=74 mod81 and gives

    z=(128r−238)/81,   z+1=3^(v−4)u.

Choose h∈{1,2}, and append k=v−h−4 legal odd inverses to obtain

    x_h=2^(v−h−4)3^h u−1.

For v≥17 these integers and all paths are positive. Set theta=2^(v−5)u mod9. Apply exactly the same finite residue-toS tail selector as in the existing refined valuation13 theorem: its five retained rows use h1 for theta1,2,7 and h2 for theta5,8; its theta4 branch uses h1 and the five guards on x1=11 mod27. Thus no new residue completeness assertion is needed.

Relative to the immutable root r, the coefficient of x_h is

    2^(v−h+3)/3^(v−h).

This is exactly four times the old selector's coefficient at the same v. The intercept is negative, because the defining equation here is 3^v u=128r−157. Appending any selected tail keeps the intercept negative. Hence the complete selector satisfies

    m=alpha r+beta,   beta<0,
    alpha≤768(2/3)^v.

The exact inequality

    768·2^17=100663296 <129140163=3^17

proves m<r uniformly for v≥17. Membership inS and actual forward equality follow by the guarded inverse path. If the tail has length ell, then

    b=7+(v−h−4)+ell=v−h+3+ell.

The selected uniform threshold17 cannot simply be changed to16: v16,u803 gives r270050915, theta1, and the six-doubling selected endpoint315752384>r, although the forward identity remains valid. This is selector sharpness, not an impossibility theorem for other certificates.

Together with the earlier results, a hypothetical least bad S-root must avoid these families too. In the branch r=155 mod243 it cannot have v3(128r−157)≥17. This is not a global well-founded rank or a proof that the complementary roots are forced into the covered set.

## Exact first-return transition shared by all sufficiently long OOE roots

For any r∈S with q=v2(r+5)≥4, the first four parities are OOEO, with residue path20,17,26,13,20. Thus the first positive return toS is

    y=(27r+23)/16>r.

Regardless of the root's original ternary labels, y=20 mod243, so

    v3(y+7)=3,   v3(4y+1)=4.

Write r+5=2^q u with u odd. Then

    y+5=27·2^(q−4)u−2.

Consequently q(y)=0 if q4; q(y)=1+v2(27u−1) if q5; and q(y)=1 if q≥6. The middle case is an explicit possible recharge, so these transitions are not claimed to rank every return.

The useful next concrete lemma is a descent certificate on a specified q5 recharge cylinder, measured against the root before the growing first return. This statement keeps both the source cylinder and the root comparison explicit; the alternative blanket demand that every root eventually escapes would merely restate the unresolved bridge.

The new Q2 exit theorem makes this target more precise. At its k1 boundary, its guard forces u7 mod8, which yields q(y)=3. The unbounded-recharge subcase is instead u3 mod8. Combining that condition with r20 mod729 gives the explicit residual cylinder

    r=22619+186624s,   u=707+5832s,   s≥0,
    y=38171+314928s,
    q(r)=5,   q(y)=4+v2(2386+19683s).

The final valuation is unbounded because19683 is odd. Every root in this cylinder has v3(4r+1)=4 and theta4, so the old refined ancestor table misses it; the Q2 k1 guard misses it because u3 mod8 rather than7. This is a concrete next-target cylinder, not a proof that its roots lack other certificates or a claim that its first-return growth persists forever.

## Continuation: exact clock and bounded-cover limits

The [finite growing-spell theorem](Finite_Growing_First_Return_Spells.md) now gives the exact number of consecutive OOEO first returns, `floor(v2(11r+23)/4)`, and the terminal depth in {0,1,2,3}. Every state through that spell exceeds the original root. On the named q5 cylinder, all four exit depths occur at arbitrarily large spell lengths.

The [simultaneous bounded-cover obstruction](Bounded_Ancestor_Depth_Obstruction.md) constructs infinitely many roots in this same cylinder that defeat independently prescribed bounds on both direct forward descent and smaller residue20 ancestor time. These facts leave variable-duration whole excursions and general coalescence available; they do not assert irreducibility under those stronger relations.

## Verification scope

The companion checker reconstructs every inverse guard, independently replays the actual forward map, and tests the fixed cylinders, the uniform new-coordinate family, the unguarded v16 counterexample, and the first-return transition. Finite tests support the algebraic proof; they do not establish its universal quantifiers. None of these new selectors is yet Lean formalized.


## Connections

- **Depends on:** [inverse-word semantics](L4_General_Inverse_Word_Coalescence.md) and [the refined finite tail table](Residue20_Refined_Ancestor.md).
- **Strengthens / specializes:** [the root-relative residual analysis](../../ROOT_RELATIVE_PROGRESS_2026-09-05.md), inside the v3(r+7)=4 branch.
- **Strengthened by:** [the exact finite OOEO clock](Finite_Growing_First_Return_Spells.md) and [the target-specific bounded-cover obstruction](Bounded_Ancestor_Depth_Obstruction.md).
- **Parallel to:** [q2 exit descent](Q2_Exit_Descent.md) and [growing two-burst escape](Two_Burst_Recharge_Escape.md).
- **Verified by:** [manifest](../../verification/README.md) and [independent checker](../../verification/complementary_ancestor_check.py).
- **Formalized by / pending:** [formal scope](../../LEAN_TARGETS.md); the new prefix and this selector remain prose.
