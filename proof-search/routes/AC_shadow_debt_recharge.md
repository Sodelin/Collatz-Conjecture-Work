---
node_id: AC-SHADOW-DEBT-RECHARGE-001
node_type: route
tags: [collatz, shadow-debt, recharge, rank-obstruction]
---

# A growing core return recharges the OOE shadow depth exactly

**Status:** exact auxiliary obstruction for the specified rank class. This
does not prove or disprove Collatz and makes no external novelty claim.

Use the shortcut map T(n)=n/2 for even n and T(n)=(3n+1)/2 for odd n. Use
the hard set H, the gamma/beta normalizer eta, the stronger core C, and
S(h)=eta(T^(L(h)+2)(h)) exactly as defined in
[the core residue note](AB_ternary_normalized_core_residue_obstruction.md). In particular, eta
prioritizes gamma(n)=(2n-1)/3 when n=2 mod3; otherwise it applies the existing
strictly decreasing beta rule outside H, and stops at 1 or C.

The new coordinate q(n)=v2(n+5) detects the length of the growing OOE macro
G(n)=(9n+5)/8. It decreases by three on each legitimate G step. Nevertheless,
q can be fully recharged across a finite core path whose endpoint is larger
than its immutable starting root.

## Exact counterfamily

For every integer t>=0, put

    u = 6807 + 12288t,
    n = 1024u - 5 = 6970363 + 12582912t,
    m = (2187u - 7)/2 = 7443451 + 13436928t.

Then

    S^3(n)=m,
    T^11(n)=m,
    m-n=(139u+3)/2>0,
    q(n)=q(m)=10.

The three S edges have exact shadow depths

    10 -> 7 -> 4 -> 10.

All four core states have L=2, epsilon=1, b=v3(x+1)=0, and x=1 mod3.
The two endpoints also have D=v2(11z+9)=1 and R=floor(D/4)=0, where
z=(x-11)/16 is the canonical hard parameter. The endpoint size ratio tends
to 2187/2048>1 as t tends to infinity.

### Proof

The parameter u is positive, odd, and divisible by three. The identity

    729u+1 = 2048(2423+4374t)

shows v2(729u+1)=11 exactly. Three legitimate OOE blocks give

    n   = 1024u-5,
    n1  = 1152u-5 = 128(9u)-5,
    n2  = 1296u-5 = 16(81u)-5,
    x   = 1458u-5 = 2(729u)-5.

At the first three sources the values of q are 10, 7, and 4, respectively.
Each source is 11 mod16 and 1 mod3, hence is in C with L=2 and epsilon=1.
The final x is 1 mod4 and 1 mod3. Its forced OE continuation yields

    T^2(x)=(3x+1)/4=(2187u-7)/2=m.

Also

    m+5=3(729u+1)/2=1024(7269+13122t),

whose parenthesized factor is odd. Therefore q(m)=10, and m is again in C
with L=2 and epsilon=1.

To check that these actual orbit identities coincide with S, note that
L=2 at n,n1,n2. Their raw T^4 image is T(y), where y is their T^3 image.
Every such y is odd, so T(y)=2 mod3 and gamma(T(y))=y. For y=n1 or n2,
eta stops immediately. For y=x, eta applies beta(x)=(3x+1)/4=m and then
stops. Thus S(n)=n1, S(n1)=n2, and S(n2)=m with no omitted reductions.

Every core state displayed above is 1 mod3, giving b=0. At both endpoints,
write y=1024v-5 with v odd. Then z=64v-1 and

    11z+9=2(352v-1),

so D=1 exactly. Subtracting n from m proves the strict growth. The complete
shortcut word is (OOE)^3 OE, of length eleven. QED.

## Consequence for ranks using this unbounded coordinate

Let a label contain only (L,epsilon,b,D,R,n mod3,q), or any function of
those entries. On each label independently choose a real polynomial
P(n,bitlength(n)). No such function that is bounded below on C can strictly
decrease on every S edge. The same holds for a finite lexicographic tuple
whose every coordinate has this polynomial form and is bounded below on C.

**Proof.** Strict decrease on every edge implies strict decrease from n to
S^3(n)=m. All family endpoints have exactly the same fixed label, including
q=10. Consequently the same polynomial is evaluated at both endpoints.
Write P(n,B)=sum_j n^j a_j(B). If its highest nonzero n-degree k is positive,
lower boundedness along this family forces the leading coefficient of
a_k(B) to be positive. As m/n tends to 2187/2048 and the bitlength difference
is bounded, a_k(bitlength(m))/a_k(bitlength(n)) tends to one. Thus P is
eventually positive and its endpoint ratio tends to (2187/2048)^k>1. If
k=0, lower boundedness forces the resulting polynomial in bitlength to be
constant or eventually increasing. Either way it cannot strictly fall.
The zero polynomial is constant. A finite tuple has a common threshold
beyond which every coordinate is nondecreasing, which rules out strict
lexicographic decrease. QED.

**Scope:** this exact family does not freeze arbitrary additional modular
labels, additional unbounded valuations, or certificate history. The theorem
does not exclude such augmented ranks, nonpolynomial ranks, a changed return
map, or a method choosing a smaller coalescing target against the original
root. It specifically rules out assuming that naming q repairs the previous
polynomial size/bitlength rank architecture.

## Relation to constructive work

The q=3k exit family n=8^k u-5 (u odd) behaves differently. After k OOE
blocks it reaches 9^k u-5, which is even. If 2^k divides this endpoint, then
after k more E steps it reaches m=(9^k u-5)/2^k<n. Indeed,

    2^k(n-m)=(16^k-9^k)u-5(2^k-1)>0

for k>=1 and u>=1, because

    16^k-9^k = 7 sum_(i=0)^(k-1) 16^(k-1-i)9^i
             >= 7 sum_(i=0)^(k-1) 2^i
             = 7(2^k-1) > 5(2^k-1).

This guarded descent is compatible with the recharge
counterfamily: their initial shadow depths are in different congruence
classes modulo three, and the required exit divisibility cannot be assumed
for arbitrary inputs.

## Verification and limitations

`check_shadow_debt_recharge.py` independently reconstructs T, the canonical
labels, eta, and S. It checks the parameter identities and the complete
guarded path at boundary, moderate, and very large parameters. These are
regression checks; the all-parameter conclusion follows from the integer
identities and branch proof above. This note is not a Lean formalization.

**11. Process check:** the path is derived independently from exact formulas
and checked against the normalizer's branch priority. The critical semantic
check is S^3(n)=m, since an unguarded T identity alone would not suffice.

**12. Robustness check:** the conclusion survives unbounded numerical t by
symbolic affine identities. Its rank exclusion is conditional on the stated
function class; adding an unfrozen feature would require a new proof.


## Connections

- **Depends on:** [exact stronger core return](AB_ternary_normalized_core_residue_obstruction.md).
- **Strengthens / specializes:** [frozen polynomial-rank obstruction](AB_frozen_debt_size_rank_no_go.md).
- **Verified by:** [replay manifest](../../verification/README.md) and [independent checker](../../verification/check_shadow_debt_recharge.py).
- **Parallel to:** [guarded positive burst descent](../lemmas/Root_Relative_Burst_Descent.md).
