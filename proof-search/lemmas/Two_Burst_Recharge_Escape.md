---
node_id: AC-TWO-BURST-RECHARGE-ESCAPE-001
node_type: lemma
tags: [collatz, actual-descent, shadow-debt, recharge, immutable-root, infinite-family]
---

# A growing excursion can recharge more shadow debt and still escape below its original root

**Verdict:** a proved, guarded infinite family of actual forward descents.
The first segment grows, recharges an arbitrarily larger OOE shadow depth,
and enters a second growing burst. A certified even run then returns below
the original root. This supplies progress through a specific recharge
mechanism; it does not prove that arbitrary recharge events escape or that
all Collatz trajectories terminate. No external novelty claim is made.

Use the shortcut map T(n)=n/2 for even n and T(n)=(3n+1)/2 for odd n. Let
q(n)=v2(n+5), and let G(n)=(9n+5)/8 denote the legitimate three-step OOE
macro. Every iterate below is an actual forward T iterate.

## 1. General two-burst theorem with explicit guards

Let k,l,u,v be positive integers, put K=k+l, and assume

    9^k u+1 = 2^(3l+1) v,       v odd,             (RECHARGE)
    2^K divides 3*9^l v-5.                        (EXIT)

Set

    n=2*8^k u-5,
    x=2*9^k u-5,
    y=(3*9^k u-7)/2=3*2^(3l)v-5,
    z=3*9^l v-5,
    m=z/2^K.

Then all these values are positive integers, u is odd, and

    T^(3k)(n)=x,
    T^2(x)=y,
    T^(3l)(y)=z,
    T^K(z)=m,
    T^(4K+2)(n)=m<n.                              (DESCENT)

The complete guarded word is

    (OOE)^k OE (OOE)^l E^K.

Its shadow depths at the four segment boundaries are

    q(n)=3k+1, q(x)=1, q(y)=3l, q(z)=0.

Thus this is a recharge event followed by a separately certified escape.
If k>=3, then y>n; if also l>=k+1, the recharged depth satisfies q(y)>q(n).

### Actual path proof

(RECHARGE) forces u odd. The identity G(a)+5=9(a+5)/8 gives, for
0<=i<=k,

    G^i(n)=2*8^(k-i)9^i u-5.

The first k blocks are legitimate: before each block the state is 3 mod8,
and its next three parities are OOE. At the end, x+5=2*9^k u has valuation
one, so x=1 mod4. Its forced OE continuation is exactly

    T^2(x)=(3x+1)/4=(3*9^k u-7)/2=y.

The displayed recharge equality gives y+5=3*2^(3l)v and q(y)=3l exactly.
Therefore a second run of precisely l OOE blocks reaches

    G^l(y)=3*9^l v-5=z.

This z is even. Its divisibility by 2^K licenses K actual consecutive
even steps, giving m. There is no extrapolation across a failed parity
guard and no reverse normalization step.

All inputs are positive: n>=11, y>=10, and z>=22. The orbit identities
and the positive integral quotient imply m>=1.

### Strict descent proof against the same original n

Multiply the difference n-m by the positive integer 2^(3l+K+1). Exact
substitution gives

    2^(3l+K+1)(n-m)
      = [4*16^K-3*9^K]u
        -5*2^(3l+1)(2^K-1)-3*9^l.               (MARGIN)

Because K>=2 and l<=K-1,

    4*16^K-3*9^K > 2*16^K = 32*16^(K-1),
    5*2^(3l+1)(2^K-1) < 20*16^(K-1),
    3*9^l <= 3*16^(K-1).

For the first inequality, 3*(9/16)^K<=27/16<2. The other two follow
directly from l<=K-1. Since u>=1, (MARGIN) is strictly greater than
9*16^(K-1)>0. Hence m<n. QED.

### Growth and recharge are genuine

At the first recharge endpoint,

    y-n=[(3*9^k-2^(3k+2))u+3]/2.

For k=3 the coefficient is 139>0; it remains positive for k>=3 because
(9/8)^k increases. Thus y>n for k>=3. Every G block also grows: its
endpoint exceeds its source by (source+5)/8>0. Therefore z>y>n.

In fact, all positive-time states before the final E block exceed n when
k>=3. Inside a G block the two O steps increase, and its E endpoint is
still larger than the block's source. The connector's O step increases,
and its E endpoint y is larger than n. Consequently actual descent below
n occurs during the certified final even run, after both growing bursts.

## 2. Explicit CRT construction in residue 20 modulo 27

For any positive k,l with K=k+l, define

    A = 5*(3*9^l)^(-1) mod 2^K,
    M2 = 2^(3l+K+1),
    B = (2^(3l+1)A-1)*9^(-k) mod M2,
    C = 25*(2*8^k)^(-1) mod 243,
    D = (C-B)*M2^(-1) mod 243,
    u0 = B+M2*D,
    u = u0+243*M2*t,                 t>=0,
    v = (9^k u+1)/2^(3l+1).

Residues are chosen in their standard nonnegative ranges. Every inverse
exists. A and B are odd, so u0 and all displayed u are positive and odd.

The binary congruence gives

    9^k u+1 = 2^(3l+1)A mod 2^(3l+K+1),

so v is integral and v=A mod2^K. In particular v is odd, which proves
the exact recharge guard, and 3*9^l v-5=0 mod2^K proves (EXIT).

The ternary congruence gives

    n=2*8^k u-5=20 mod243,
    v3(n+7)=3,
    v3(4n+1)=4.                                   (ROOT)

Hence n is normal for the selected internal reduction c(a)=(8a-7)/9
on a=236 mod243. Normality here is only for that selected rule; it is
not a claim of irreducibility under all coalescence identities.

When K=7 mod18, the endpoint also belongs to residue20 modulo27.
Indeed, l>=1 gives z=3*9^l v-5=-5 mod27, while 2^K=20 mod27. Therefore
2^K*m=-5 mod27 implies m=20 mod27.

## 3. Both burst lengths and the added recharge are unbounded

Take arbitrary integers j,t>=0 and specialize

    k=3+j,
    l=4+17j,
    K=7+18j,

with u,v constructed in Section2. Then

    q(n)=10+3j,
    q(y)=12+51j,
    q(y)-q(n)=2+48j,
    T^(30+72j)(n)=m<n,
    n=20 mod243,
    m=20 mod27.

The first recharge endpoint y and the second-burst endpoint z both exceed
the original n. Nevertheless the subsequent even run proves an actual
smaller return to the target set. Varying t gives an infinite arithmetic
progression at each j, while j makes both burst lengths and the amount
of added recharge unbounded. Different j have different exact q(n).

The first positive return to residue20 still occurs at time4, with residues

    20 -> 17 -> 26 -> 13 -> 20,

and T^4(n)=(27n+23)/16>n. The theorem uses a later return; it does not
assert descent on each first-return edge or identify the first descent time.

### Explicit example beyond the earlier two positive guards

For j=t=0, the construction gives

    k=3, l=4, K=7,
    A=119, M2=1048576, B=230039, C=136,
    u=213090967, v=18962807,
    n=218205150203,
    T^11(n)=y=233014972411>n,       q: 10 -> 12,
    T^23(n)=z=373244930176>n,
    T^30(n)=m=2915976017<n.

Both n and m are20 mod27; n is20 mod243. The source q(n)=10 is not
divisible by three, so it is outside the earlier single-burst q=3k guard.
It also has v=v3(4n+1)=4 and ancestor selector

    theta = 2^(v-2)*((4n+1)/3^v) mod9 = 1.

The selected ancestor table's theta1 row requires v>=13, so this root
is outside that table's full stated guard. This is a comparison with the
existing certificate, not a claim that every conceivable ancestor method
fails for this root.

The coverage gain is infinite. At fixed j, adding one CRT translate t
adds 243*2^(4K+2) to n. Writing n=20+243a gives theta=4+3a mod9; the
translate therefore adds three to theta modulo9. The selectors cycle
through1,4,7. At valuation4, the theta1 and theta4 branches are outside
the existing ancestor guards, while theta7 overlaps. At j=0 the cycle
is exactly1,4,7 for t=0,1,2. Thus infinitely many new guarded roots lie
outside both earlier positive guards.

### Even-run padding covers guarded families at every q=3k+1

The clean slice above uses K=7 mod18 so exactly K final E steps return to
the target residue. This restriction on K is unnecessary if extra forced
even steps are allowed. For arbitrary positive k,l, put K=k+l and choose

    h=7+18*floor((K+10)/18),
    K<=h<K+18, h=7 mod18.

Replace (EXIT) by 2^h dividing z. The original theorem still proves
m_K=z/2^K<n, and the extra h-K even steps give

    m_h=z/2^h<=m_K<n,
    T^(3K+2+h)(n)=m_h,
    m_h=20 mod27.

The CRT construction changes only by replacing K with h in its binary
moduli: take A=5*(3*9^l)^(-1) mod2^h and M2=2^(3l+h+1), leaving the
ternary source congruence unchanged. This proves guarded infinite families
at every initial depth q=3k+1 with k>=1. Choosing l>=k+1 gives strictly
larger recharge, and k>=3 retains the growing first segment. It does not
cover every source at any one of those depths; the two exact guards remain
essential.

## 4. Controls and uncovered cases

The general formula for a q=3k+1 exit, without assuming either new guard,
is

    y=(3*9^k u-7)/2,
    q(y)=v2(9^k u+1)-1.

The older growing recharge family u=6807+12288t,k=3 has q(n)=q(y)=10,
and y>n. It remains a valid negative control. Our two-burst theorem
requires the recharged depth to equal3l, followed by (EXIT); that control
does not satisfy the recharge guard for any integer l.

Even the correct recharged depth alone is insufficient to license the
final even run. For k=3,l=4,u=2081431, the source is20 mod243 and the
recharged depth is12, but v=185225 gives

    (3*9^4*v-5) mod128=118,

so (EXIT) fails. No descent conclusion is drawn from this certificate for
that input. The checker must reject both this missing-exit control and
the older q10 recharge control.

This theorem leaves arbitrary q=3k+1 roots, recharge to depths not divisible
by three, insufficient final even divisibility, and other uncontrolled
excursions unresolved. It gives no universal entrance theorem for its CRT
families. Extending it to all remaining roots would require a new argument.

## 5. Verification and evidence boundaries

`two_burst_recharge_escape_check.py` reconstructs CRT independently and
replays the entire shortcut word with explicit branch checks. It verifies
both the exact margin identity and strict descent, the positive prefix,
the larger recharge, the target residues, the ancestor comparison, and
the two negative controls. Large parameters test the implementation;
the all-parameter claims follow from the integer proof above.

**11. Process check:** the two vulnerable bridges are divisibility-to-parity
and descent relative to the original source. Both are explicit, and the
negative controls distinguish genuine guard coverage from a merely correct
affine expression. This note is a prose proof with an executable checker,
not a Lean formalization.

**12. Robustness check:** the result tolerates unbounded burst lengths and
unbounded increases in shadow depth under its stated guards. The original
q10 obstruction remains intact. Universal termination would require proof
that every residual root obtains an appropriate escape certificate; extra
finite sampling cannot provide that coverage.


## Connections

- **Depends on:** [the OOE burst identity](Root_Relative_Burst_Descent.md).
- **Strengthens / specializes:** [root-relative progress packet](../../ROOT_RELATIVE_PROGRESS_2026-09-05.md) with an actual increasing recharge followed by descent.
- **Parallel to:** [q2 exit descent](Q2_Exit_Descent.md).
- **Parallel to:** [the q10 recharge obstruction](../routes/AC_shadow_debt_recharge.md), retained outside this theorem's guards.
- **Verified by:** [manifest](../../verification/README.md) and [independent checker](../../verification/two_burst_recharge_escape_check.py).
