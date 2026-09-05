---
node_id: B-S20-ANCESTOR-DEPTH-OBSTRUCTION-001
node_type: lemma
routes: [B, AB]
tags: [collatz, inverse-ancestor, bounded-cover, residual-set]
---

# An unbounded-depth obstruction for residue-20 ancestor covers

## Exact positive-integer statement

Use the shortcut map `T(n)=n/2` for even `n` and `(3n+1)/2` for odd `n`, and let `S={n>0:n=20 mod27}`. For every integer `L>=0` and `t>=0`, put

    r=47+3^(L+3)t.

Then there do not exist integers `m,b` such that

    0<m<r, m=20 mod27, 0<=b<=L, T^b(m)=r.       (1)

Consequently no finite family of fixed inverse words, or any strategy with a uniformly bounded actual ancestor time, covers all sufficiently large roots in S by strictly smaller S ancestors. This is a theorem about the specified ancestor relation, not a proof that any root fails to converge.

## Proof

Every inverse trajectory is a chronological word in `E(y)=2y` and `O(y)=(2y-1)/3`, with `O` allowed exactly when `y=2 mod3`. A word of length `b`, containing `o` odd inverses, has affine formula

    A(x)=(2^b*x-C)/3^o, C>=0.

At every prefix of length `j` with `o_j` odd inverses, its change when the input changes by `Delta` is `2^j*Delta/3^o_j`.

Suppose a word of length `b<=L` is legal from `r` and ends at `m in S`. Transfer the same word to the anchor `47`. At a prefix, the two values differ by

    2^j*3^(L+3-o_j)*t.

This is an integer divisible by 27 because `o_j<=b<=L`. In particular, immediately before an odd inverse it is divisible by 3, so the odd-inverse legality conditions transfer. Starting from positive 47, every legal E or O inverse remains a positive integer. Thus the transferred word ends at a positive integer `a=A(47)` with `a=20 mod27`.

The only positive S integer below 47 is 20, whose exact forward orbit is

    20,10,5,8,4,2,1,2,1,... .

It never reaches 47. Therefore `a>=47`. The affine formula yields

    2^b*47-C=3^o*a>=3^o*47.

Since `C>=0`, this forces `2^b>=3^o`. Returning to the original root,

    A(r)=a+(2^b/3^o)*(r-47)>=47+(r-47)=r.

This contradicts `m<r`, proving (1). The proof includes the empty inverse word.

## The obstruction survives the current ternary normalization

For `L>=1`, every displayed root satisfies

    v3(r+7)=3,
    v3(4r+1)=3,
    v3(128r-157)=3.

Indeed the corresponding anchor values are `54=27*2`, `189=27*7`, and `5859=27*217`, while the perturbations are divisible by81. These roots are c-normal and avoid both currently proved large-ternary-valuation guards.

For every prescribed `Q>=0`, there are infinitely many choices of `t` with `v2(r+5)=Q`: impose

    47+3^(L+3)t+5 = 2^Q mod2^(Q+1).

The coefficient `3^(L+3)` is odd, so this congruence has a unique class of solutions modulo `2^(Q+1)`. Thus no bound depending only on those three frozen ternary depths and a fixed chosen q can bound the required ancestor time over all these roots. This does not say that every root has some smaller S ancestor.

## Simultaneously defeat bounded forward descent and bounded ancestors

For arbitrary `H>=1` and `L>=1`, CRT gives infinitely many positive roots satisfying

    r=47 mod3^(L+3),
    r=-1 mod2^(H+1).

They have no smaller S ancestor at actual time at most L. Also, for every `1<=j<=H`, the actual shortcut orbit is

    T^j(r)=3^j*(r+1)/2^j-1 > r.

The displayed formula follows because the first H steps are odd, and its strict inequality is `(3^j-2^j)*(r+1)>0`. Therefore finite covers that use either bounded direct forward descent or bounded smaller-S-ancestor time cannot cover all sufficiently large roots in the normalized residual set.

This last claim permits arbitrary membership predicates for the finitely many cover pieces; only the certificate-time bound is used. It does not exclude bounded descriptions containing unbounded loops, variable-depth valuation macros, general forward/backward coalescence, or a genuine well-founded recursive graph.

## What this means for compactness

The increasing collection of inverse-word certificates cannot be replaced by a finite subcover merely because each word is decidable on a ternary cylinder. The anchor 47 has no strictly smaller S ancestor at all. Every bounded collection consequently misses an entire ternary neighborhood of 47, and that neighborhood contains arbitrarily large positive roots. Handling 47 as a finite base case does not eliminate its infinitely many arbitrarily close large ternary lifts.

A global strategy must provide an unbounded depth mechanism or use a stronger relation, such as forward/backward coalescence across an excursion. This is an explicit scope obstruction; it is not a no-go theorem for the unbounded valuation construction already present in PR17.

## Evidence and novelty limits

The proof is elementary affine inverse-word arithmetic and a CRT specialization. It is new relative to the audited project statements F008 and F018: F008 covers direct descent; F018 covers unrefined whole-family Mersenne coalescence. This theorem concerns arbitrary bounded inverse-ancestor searches within S and retains a fixed normalized ternary state. No external priority claim is made. The companion checker independently builds actual bounded inverse trees and forward orbits. Full Lean formalization is pending.

## Sharper obstruction on the current q5 target itself

The same proof applies with anchor20 in place of47:

    forall L,t>=0, r=20+3^(L+3)t
    implies no 0<m<r, m in S, T^b(m)=r with b<=L.

At the anchor, `A(20)>=20` follows immediately because20 is the least positive element of S; no forward-orbit computation is needed. This version freezes, for L>=3,

    v3(r+7)=3, v3(4r+1)=4, theta=4,
    v3(128r-157)=3.

It falls exactly in the older refined selector's uncovered (v,theta)=(4,4) branch.

The current q5 target is `r=22619+186624s=20+729(31+256s)`. For every L>=3 impose

    31+256s=0 mod3^(L-3).

Because256 is coprime to3, there is an infinite arithmetic progression of nonnegative s satisfying this condition. Each associated root has no smaller S ancestor in the first L inverse steps. All retain q(r)=5, since `r+5=32(707+5832s)` and the factor in parentheses is odd.

Thus **the exact current q5 cylinder admits no uniformly bounded-depth smaller-S-ancestor cover**. This does not prove that any root has no ancestor at a later time; nor does it preclude a whole-excursion forward descent theorem on that cylinder. It gives a precise reason to prioritize an unbounded mechanism over additional fixed inverse tails.

## Both bounded options fail together on the exact q5 target

Fix independently an ancestor-time bound L>=3, a growing-spell length J>=2, and a terminal depth e in {0,1,2,3}. Define

    P=3^(L-3), d=4(J-2)+e, Q=2^(d+1).

Choose s>=0 simultaneously satisfying

    s=-31*256^(-1) modP,
    s=(2^d-972)*8019^(-1) modQ.                 (2)

When P=1 the first congruence imposes no condition. Both inverses exist in their indicated rings, and P,Q are coprime, so CRT supplies a unique class modulo PQ and infinitely many nonnegative solutions. More explicitly, choose canonical representatives s3 in[0,P), s2 in[0,Q), and set

    s0=s3+P*((s2-s3)*P^(-1) modQ),
    s=s0+PQ*t, t>=0.

For every corresponding `r=22619+186624s`:

1. The first congruence gives `r=20 mod3^(L+3)`, so the anchor20 theorem excludes every smaller S ancestor of actual time at most L.
2. The second congruence gives `v2(972+8019s)=d` exactly. Since `11r+23=2^8(972+8019s)`, the [finite growing-spell theorem](Finite_Growing_First_Return_Spells.md) gives exactly J consecutive OOEO first returns, exact final q=e, and `T^j(r)>r` for every `1<=j<=4J`.
3. The original source remains in the named q5 cylinder, with the frozen ternary selector state described above.

Therefore for **arbitrary independently chosen bounds** on direct forward descent and smaller-S-ancestor time, infinitely many roots in the exact current q5 target fail both bounded certificates. This is a genuine simultaneous statement, rather than a union of unrelated counterfamilies. All four terminal exit depths remain possible.

The claim excludes finite bounded covers that choose either of these two exact relations. It leaves unbounded valuation macros, complete growing excursions with variable duration, and general coalescence available. It does not prove an infinite orbit or prohibit any all-root mechanism using those stronger objects.

## A complementary positive fact: periodic ghosts can yield ancestor cylinders

The obstruction should not be read as saying that negative periodic shadows resist every stronger target. Let a nonempty forward parity word have length ell, o odd steps, and affine formula

    F(x)=(3^o*x+C)/2^ell, C>0, D=3^o-2^ell>0.

Its fixed point is the negative rational `rho=-C/D`; D is coprime to6. Suppose the word is a legal rational periodic shortcut orbit and `rho=20 mod27` in the 3-adic sense. Then every positive integer satisfying

    r=rho mod3^(o+3)

has a positive smaller ancestor in S given by

    m=(2^ell*r-C)/3^o,
    T^ell(m)=r.

To prove legality, transfer the reversed cycle from the rational 3-adic integer rho to r. After j inverse letters with o_j odd inverses, the difference is `2^j*(r-rho)/3^o_j`, still divisible by27. Every odd inverse is legal modulo3, and positive integral inputs stay positive. The final difference from rho is divisible by27, proving m in S. Finally `m<r` follows from `2^ell<3^o` and C>0.

For example, the negative cycle through -61 has eleven shortcut steps, seven odd steps, and C=8479. Its inverse word yields the exact infinite family

    r=58988+59049t,
    m=55235+55296t,
    T^11(m)=r, 0<m<r, m=r=20 mod27,

for every t>=0. Thus a negative periodic orbit can obstruct a naive forward rank while also furnishing a useful inverse-ancestor certificate. This family is not a global exhaustion theorem and is not asserted to be new in the literature.


## Connections

- **Depends on:** [exact inverse-word affine semantics](L4_General_Inverse_Word_Coalescence.md) and positive one-step inverse legality.
- **Depends on:** [finite growing first-return spells](Finite_Growing_First_Return_Spells.md) for the target-specific forward clock and growth theorem.
- **Distinguishes:** [F008 and F018](../FAILURE_LEDGER.md), concerning bounded direct descent and unrefined Mersenne coalescence.
- **Strengthens / specializes:** [the current q5 residual analysis](Complementary_Ancestor_Cylinders.md).
- **Constrains:** bounded ancestor-only or bounded bidirectional cover synthesis on the q5 target.
- **Verified by:** [independent bounded-tree checker](../../verification/bounded_ancestor_depth_check.py) and [verification manifest](../../verification/README.md); actual inverse trees and forward trajectories, including combined CRT roots.
- **Formalized by / pending:** [Lean boundary](../../LEAN_TARGETS.md); no Lean assertion for this new theorem.

Independent adversarial review of the anchor transfer and simultaneous CRT by the separate growing-spell agent found no gap. The final checker evaluates 601,206 inverse-tree nodes over 547 roots, including160 simultaneous target roots; it covers inverse depths through24 and joint spells through128 (512 actual shortcut steps). Normal and optimized Python runs agree.
