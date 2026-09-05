---
node_id: AB-ROOT-BURST-DESCENT-001
node_type: lemma
tags: [collatz, guarded-descent, root-relative, modular-return, infinite-family]
---

# Guarded OOE bursts give smaller later returns from an infinite normalized family

**Verdict:** a proved sufficient condition for actual descent below the
immutable starting root, with an explicit infinite family in residue 20
modulo 27. The family has unbounded burst length. The condition is not
universal, and this note does not prove universal termination or claim
external novelty.

Throughout, T(n)=n/2 for even n and T(n)=(3n+1)/2 for odd n. An O denotes an
odd shortcut step and an E an even shortcut step. T^a is an actual iterate.

## 1. General guarded descent theorem

Let k>=1 and u>=1 be integers. Set

    n=8^k u-5.

Assume the exact exit divisibility condition

    2^k divides 9^k u-5.                              (EXIT)

Then u is automatically odd, and

    m=(9^k u-5)/2^k

is a positive integer satisfying

    T^(4k)(n)=m<n.

In particular, n has a smaller target through an actual forward orbit; no
reverse coalescence step or redefinition of the induction root is used.

### Exact path and proof

Because k>=1, (EXIT) forces u odd. After j complete OOE blocks, for every
0<=j<=k, the state is

    n_j=8^(k-j)9^j u-5.

For j<k, write A=8^(k-j-1)9^j u. Then the next block is exactly

    8A-5  →O 12A-7  →O 18A-10  →E 9A-5.

The displayed parities hold for every positive integer A. This proves

    T^(3k)(n)=9^k u-5.

The latter is divisible by 2^k by hypothesis. Its first k subsequent steps
are therefore E steps, giving T^(4k)(n)=m. Both n and m are positive because
8^k u-5>=3 and 9^k u-5>=4.

For strict descent, calculate

    2^k(n-m)=(16^k-9^k)u-5(2^k-1).

The factorization

    16^k-9^k=7 sum_(i=0)^(k-1) 16^(k-1-i)9^i
             >=7 sum_(i=0)^(k-1) 2^i
             =7(2^k-1)

shows that the right side is at least 2(2^k-1)>0. Hence m<n. QED.

The OOE part of the path identity requires only k>=1 and u>=1. Oddness of u
is needed to say that these are exactly the maximal consecutive OOE blocks:
under (EXIT), v2(n+5)=3k and n_k is even, so precisely k blocks occur.
The additional k even steps require (EXIT); no extrapolation past a failed
parity guard is allowed.

## 2. An explicit family in the normalized residue-20 target

For arbitrary integers j,t>=0, define

    k=7+18j,
    a_k=5*9^(-k) mod 2^k,                 0<=a_k<2^k,
    b_k=25*8^(-k) mod 243,                0<=b_k<243,
    d_k=(b_k-a_k)*(2^k)^(-1) mod 243,      0<=d_k<243,
    u_k=a_k+2^k d_k,
    u=u_k+243*2^k t,
    n=8^k u-5,
    m=(9^k u-5)/2^k.

All inverses exist: 9 is odd, and 8 and 2 are coprime to 243. The formula
is a constructive Chinese remainder calculation satisfying

    9^k u=5 mod 2^k,
    8^k u=25 mod 243.

Also a_k is odd and positive, so u_k>=1 and every displayed u is positive
and odd. Therefore the theorem above gives T^(4k)(n)=m<n.

The second congruence gives

    n=20 mod243,
    v3(n+7)=3.

Consequently n is already normal for the previously selected rule
c(y)=(8y-7)/9 on y=236 mod243. This is normality for that particular rule;
it does not assert that no other smaller coalescing predecessor exists.

For the target, k>=7 implies 9^k u=0 mod27, and

    2^k=2^7=20 mod27

because 2^18=1 mod27. Thus

    2^k m=-5=22 mod27,
    20*m=22 mod27,
    m=20 mod27.

Both endpoints therefore lie in the residue-20 target, and the later target
is strictly smaller than the original normalized root.

For each fixed j, varying t gives an infinite arithmetic progression of
roots. Varying j makes k and the certified path length 4k unbounded. Roots
for different k cannot coincide because their exact shadow depths are 3k.
These are all-parameter identities, not conclusions from finite tests.

## 3. The first return grows; the certified later return descends

The certificate deliberately does not require descent on the first return
to residue 20 modulo 27. Every root in this family has first four parities
OOEO, and the residues are exactly

    20 -> 17 -> 26 -> 13 -> 20.

The first positive-time return is therefore at time four, with

    y=T^4(n)=(27n+23)/16>n.

Moreover,

    y+7=27(n+5)/16,
    v3(y+7)=3,

since n+5=25 mod243. Hence y is also normal for c; the first growing return
cannot be dismissed by that selected c-normalization.

The guarded theorem instead certifies a smaller return at time 4k>4. It
does not claim that 4k is the first descending time or the next return time.
This provides an exact example of why requiring every first return to
decrease is stronger than requiring a later return below a fixed root.

### Smallest displayed burst length

For j=t=0,

    k=7, a_k=109, b_k=20, d_k=5, u=749,
    n=1570766843,
    T^4(n)=2650669049>n,
    T^28(n)=27987842<n.

The starting value and the two return values are all 20 modulo 27.

## 4. Complementarity with the valuation ancestor certificate

Every root in this burst family has the exact low valuation

    v3(4n+1)=4.

Indeed, writing n=20+243a gives 4n+1=81(1+12a), whose parenthesized
factor is 1 modulo3. Thus the family is outside a uniform ancestor theorem
whose hypothesis is v3(4n+1)>=13. Some roots may still satisfy that
theorem's additional lower-valuation branch guards; complete disjointness
is not claimed.

For the displayed k=7,u=749 example, the ancestor selector is

    v=4,
    w=(4n+1)/3^v,
    theta=2^(v-2)w mod9=4.

Its theta=4 branch is below every threshold in the refined inverse-tail
table (the smallest such threshold is 6). Thus this root is outside the
full stated guard of that selected ancestor certificate, but has the
forward descent proved here. At k=7, the translates t=0,1,2 give theta
values 4,7,1 respectively. The theta=7 translate overlaps the ancestor
certificate; the other two are outside its stated guards. This comparison
concerns the selected certificate, not every possible inverse argument.

## 5. Coverage and remaining bridge

This proves descent for the displayed congruence families, with exact
witness times and no convergence assumption. It excludes these roots from
being a least positive nonconvergent member of the residue-20 target, under
the usual strong-induction setup.

It does not establish that every normalized residue-20 root satisfies
(EXIT), that every root eventually enters one of these families, or that
the remaining roots have smaller coalescing targets. Other initial shadow
depth classes, exit divisibility failures, and subsequent recharge remain
uncovered. In particular, the separate q=10 recharge counterfamily shows
why the OOE shadow depth cannot simply be promoted to a universal rank.

The mathematical contribution here is the parameterized guarded root
certificate and its exact target-set specialization. The affine/parity-word
machinery and Chinese remainder theorem are standard. No claim that this
family is absent from prior work is made.

## 6. Verification record

`root_burst_descent_check.py` constructs both congruences directly, replays
the entire parity word with an independent T function, checks the first
return, checks strict descent, and checks the stated example. It also
rejects an absent-EXIT control. The checker uses explicit exceptions so its
verification cannot disappear under Python optimization.

**11. Process check:** every arithmetic-to-orbit bridge has an explicit
parity or divisibility guard. The parameterized proof is separate from the
finite computational replay. Formal verification, if supplied separately,
must identify whether it covers the general descent theorem or also the
CRT target specialization.

**12. Robustness check:** the conclusion is exact within its quantified
family. The first-return growth guards against silently strengthening the
claim into first-return descent. Universal coverage would require a new
argument for the explicitly uncovered cases; a larger finite test range
would not supply that argument.


## Connections

- **Depends on:** [actual shortcut convergence semantics](../../lean/CollatzWork/Convergence.lean).
- **Formalized by / pending:** [checked general descent theorem; CRT specialization pending](../../LEAN_TARGETS.md).
- **Verified by:** [manifest](../../verification/README.md) and [independent checker](../../verification/root_burst_descent_check.py).
- **Parallel to:** [refined ancestor selector](Residue20_Refined_Ancestor.md) and [depth-recharge obstruction](../routes/AC_shadow_debt_recharge.md).

- **Extended by:** [two-burst recharge escape](Two_Burst_Recharge_Escape.md) and [q2 exit descent](Q2_Exit_Descent.md), with new guards and original-root comparisons.
