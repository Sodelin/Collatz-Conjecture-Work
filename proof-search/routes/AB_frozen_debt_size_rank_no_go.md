# Expanding hard-return family: an expanding hard-return family with frozen replay debt

Status: independently derived arithmetic obstruction; informal proof plus exact replay.
Collatz remains unresolved. No novelty claim; this is an elementary consequence
of the project's L13 affine macros. The bounded source comparison is in the [research pass](../../ASTRA_RESEARCH_PASS_2026-09-05.md).

**Node ID:** `AB-FROZEN-DEBT-001`  
**Node type:** `route`  
**Input commit:** `343ddb2cbfadb91af65328f2614c572dc91a2d69`  
**Date:** 2026-09-05

## Exact setting

Use the shortcut map T(n)=n/2 on even n and T(n)=(3n+1)/2 on odd n.
Use exactly L13's labels N_(L,e)(z)=2^L(4z+2e+1)-1, the hard set
L>=2 and e not congruent to L modulo 2, and the boundary-normalized return
map F from AB_hard_boundary_return_system.md. Let

    D_(L,e)(z)=v2((2^(L+2)-3^(L+1))*z-d_(L,e)),
    d_(L,e)=(3^(L+1+e)+3)/4-2^L(2e+1),
    R_(L,e)(z)=floor(D_(L,e)(z)/(L+2)).

In particular D_(2,1)(z)=v2(11z+9).

## Claim HD-1: a guarded two-step family

For every integer u>=0, define

    a(u)=65536u+47771 = N_(2,1)(4096u+2985),
    b(u)=110592u+80615 = N_(3,0)(3456u+2519),
    c(u)=279936u+204059 = N_(2,1)(17496u+12753).

Then

    F(a(u))=b(u),     F(b(u))=c(u),     c(u)>4a(u)>a(u),

and both endpoints have exactly the same label and debt:

    (L,e,D,R)(a(u))=(L,e,D,R)(c(u))=(2,1,2,0).

Moreover the endpoint parameters z_a=4096u+2985 and z_c=17496u+12753
satisfy z_c>4z_a, so their bitlengths satisfy ell(z_c)>=ell(z_a)+2.

### Proof

All three displayed label parameters are nonnegative, and both (2,1) and
(3,0) are hard. L13's exact macro is

    T^4(N_(2,1)(z))=27z+20,
    T^5(N_(3,0)(w))=81w+20.

Substitution gives respectively b(u) and c(u). Since these endpoints are
already hard, rho fixes each, and these T macros are exactly two F edges.
Direct subtraction gives

    c(u)-4a(u)=17792u+12975>0,
    z_c-4z_a=1112u+813>0.

The endpoint valuation arguments factor as

    11z_a+9 = 4(11264u+8211),
    11z_c+9 = 4(48114u+35073).

Both parenthesized integers are odd. Thus each D is exactly 2 and each R
is floor(2/4)=0. This proves the entire quantified claim.

## Claim HD-2: all eventually nondecreasing frozen-debt size ranks fail

There is no real-valued function Phi on the hard states satisfying both:

1. Phi(F(h))<Phi(h) on every hard-to-hard F edge;
2. its restriction to states (L,e,D)=(2,1,2) is eventually nondecreasing
   as a function of parameter z.

The same statement holds with parameter bitlength ell(z) replacing z,
provided the restriction depends on z only through ell(z).

### Proof

The two edges in HD-1 force Phi(c(u))<Phi(a(u)) for every u. But the endpoints
share label and debt, both tend to infinity, and their parameters and
bitlengths increase. This contradicts property 2 for sufficiently large u.

The statement is a necessary-condition obstruction. It does not assert that
lower-bounded real-valued strict descent, by itself, is well-founded.

## Claim HD-3: polynomial and finite lexicographic consequences

For each hard label s=(L,e), independently choose an arbitrary real polynomial

    P_s(Z,B,D,R).

There need not be a uniform degree bound or any polynomial dependence on the
label. Define

    Phi(N_s(z))=P_s(z,ell(z),D_s(z),R_s(z)).

If Phi is bounded below on all hard states, it cannot strictly decrease on
every hard-to-hard F edge. The result also holds for a finite lexicographic
tuple of such functions, when each coordinate is bounded below on all hard
states. In particular it includes polynomial functions of z and debt,
polynomial functions of bitlength and debt, and mixtures of the two.

### Proof for mixed z / bitlength polynomials

Freeze s=(2,1), D=2, R=0, and write

    Q(Z,B)=P_(2,1)(Z,B,2,0)=sum_{j=0}^k Z^j q_j(B),

where q_k is nonzero unless Q is the zero polynomial. All integer z with
D_(2,1)(z)=2 constitute the arithmetic class z=1 modulo 8. Consequently
there are arbitrarily large such z at every sufficiently large bitlength.
If k>=1, the leading coefficient of q_k must be positive: otherwise Q(z,ell(z))
tends to negative infinity along that class, contrary to lower boundedness.
Here powers of z dominate every fixed power of ell(z).

For the two endpoint sequences in HD-1, z_c/z_a tends to

    lambda=17496/4096=2187/512>1,

and ell(z_c)-ell(z_a) remains bounded. Hence

    Q(z_c,ell(z_c))/Q(z_a,ell(z_a)) -> lambda^k>1.

The denominator is eventually positive, so Q strictly increases on those
endpoint pairs for large u.

If k=0, Q is a polynomial q_0 in bitlength alone. Lower boundedness forces
its leading coefficient positive when its degree is positive, so it is
eventually increasing, and ell(z_c)>=ell(z_a)+2. If its degree is zero,
the endpoint values are equal. The zero polynomial case is also equal.

Thus every coordinate of any finite tuple is eventually nondecreasing from
a(u) to c(u). Such a tuple cannot be lexicographically strictly smaller at
c(u), while strict decrease on the two F edges would require exactly that.
The scalar assertion is the one-coordinate case.

This does not exclude nonpolynomial ranks, unbounded families of additional
features, arbitrary dependence on the entire integer, or a stronger
coalescence relation with smaller targets. Natural-valued polynomial ranks
are a special case of the excluded lower-bounded functions.

## How the family was derived

The exact transition (2,1)->(3,0) requires

    z=32v+9,      w=27v+8.

Requiring its successor to return to label (2,1) gives

    v=16q+13,    z=512q+425,
    w=432q+359,  z'=2187q+1818.

The source D is then 2. Requiring target D=2 forces q=5 modulo 8.
Writing q=8u+5 yields HD-1. Thus the mechanism is an exact pair of
cross-label edges that returns to the same measured debt while size grows.
It does not rely on increasing a finite brute-force search depth.

## Verification and limitations

Run:

    python -B verification/hard_return_frozen_debt_check.py

The checker reconstructs affine branch guards symbolically from integer
coefficients and separately replays the definitions of T, rho, F, label,
D and R on boundary and large integer parameters. This verifies the exact
arithmetic certificate; the polynomial-class consequence is the proof above,
not a finite test of all polynomials.

The mixed-polynomial argument was reconstructed independently by the parent
and a separate formal-semantics reviewer. The exact arithmetic certificate
was independently replayed. No Lean formalization of this no-go is claimed.

## Connections

- **Depends on:** [L13 macros and debt](../lemmas/L13_Refined_Mersenne_Child_Macros.md) and [hard return system](AB_hard_boundary_return_system.md).
- **Strengthens:** the F023 rank-class obstruction in the [failure ledger](../FAILURE_LEDGER.md).
- **Blocks:** polynomial size/debt ranks in [Route AB](../APPROACH_REGISTRY.md).
- **Verified by:** [verification manifest](../../verification/README.md).
- **Does not resolve:** the F024 universal return obligation in the [failure ledger](../FAILURE_LEDGER.md).
