---
node_id: AB-FINITE-RESIDUE-001
node_type: route
routes: [AB]
tags: [collatz, rank-obstruction, residues, finite-shadow]
---

# Fixed finite residue sensors do not repair polynomial ranks for the original hard return

**Verdict:** an exact obstruction for a specified enriched rank class. This is
not a Collatz proof, a positive cycle, or a divergence claim.

**Input commit:** `b6eee8594714adc3b51d5005dd0b4ed8a76412e8`.
**Dependencies:** the repository's original boundary normalizer rho and hard
return F, and the F025/F026 affine hard macros. No novelty claim is made:
the ingredients are elementary parity-affine identities, finite permutations,
and the Chinese remainder theorem. No new literature search was conducted
for this bounded arithmetic continuation.

## Candidate and exact scope

The candidate mechanism augments the frozen measurements (L,e,b,D,R) by any
fixed finite collection of residue sensors. Such sensors may depend
arbitrarily on n modulo a fixed M. The proposed rank may then use a different
polynomial in n and bitlength(n) for each resulting state.

Theorem below defeats every fixed M, on actual edges of the original F.
It also covers sensors of the canonical parameter z or coprime cofactor
lambda when their moduli are fixed: at the frozen endpoints,
z=(n-11)/16 and lambda=(n+1)/12, so choosing a larger n-modulus preserves
those sensor values. Unbounded valuations or history-dependent state are
not covered by the fixed-modulus hypothesis.

## Theorem FR-1: arbitrary fixed modulus, exact expanding F path

For every integer M>=1 there exist j>=1, Q>=1, and n0>=1 such that every
n_t=n0+Qt, t>=0, follows 2j consecutive original hard-return edges

    A_0 -> B_0 -> A_1 -> B_1 -> ... -> A_j,

with A_0=n_t, and:

1. every A_i has (L,e,b,D,R)=(2,1,1,2,0);
2. every B_i has hard label (3,0) and b=1;
3. A_j == A_0 modulo M, and the initial residue is constant over all t;
4. A_j > 4^j A_0;
5. j can be taken at most m, where M=2^alpha 3^beta m and gcd(m,6)=1
   (take j=1 when m=1).

Here b=v3(n+1), T is the one-division shortcut map, and F is exactly the
original repository map rho(T^(L+2)(n)).

### Proof: affine word and its rational shadow

The two hard macros, whenever their indicated target guards hold, are

    A -> B=(27A+23)/16,             parity word OOEO,
    B -> A'=(81B+73)/32,            parity word OOOEO.

Consequently their composition is

    G(A)=(2187A+3031)/512.

The odd-denominator rationals

    x*=-3031/1675,      y*=-2707/1675

follow these exact two words, with G(x*)=x*. Their relevant residues are

    x* == 27 (mod128),       y* == 7 (mod32),       x* == 2 (mod9).

These are congruences in the 2-adic or 3-adic integers, using the inverse
of 1675 in the stated modulus. They say nothing about a positive rational
or integer cycle.

If an integer and an odd-denominator rational are equal modulo 2^K, they
have the same next parity. Under that common shortcut branch, their
difference becomes either one half or three halves of the previous
difference. Induction therefore preserves the prescribed first k parities
and congruence modulo 2^(K-k), for k<=K.

Fix M=2^alpha 3^beta m with gcd(m,6)=1. On residues modulo m the map

    g_m(r)=512^(-1)(2187r+3031)

is a permutation, since both 512 and 2187 are units modulo m. Let j be the
return period of residue zero. Then 1<=j<=m. For m=1 set j=1.
Put K=9j+max(alpha,7) and B=max(beta,2). The three coprime congruences

    n == x* (mod 2^K),
    n == x* (mod 3^B),
    n == 0  (mod m)

have one residue n0 modulo Q=2^K 3^B m. Its least nonnegative representative
is positive because n0==27 (mod128).

For every n=n0+Qt the 2-adic shadow argument enforces the entire repeated
word of length 9j. At each A_i, at least seven bits of precision remain,
so A_i==27 (mod128). At each B_i there are at least five bits remaining,
so B_i==7 (mod32). These are respectively hard labels (2,1) and (3,0).
Thus rho fixes every displayed endpoint, and all 2j macro edges really
are F edges. Positivity follows from starting positive and applying T.

For A_i=128k+27 the canonical parameter is z=8k+1 and

    11z+9=4(22k+5),

so D=2 and R=0 exactly. The rational x* is also a fixed point of G
modulo 3^B, since 512 and 1675 are units there. Hence every A_i remains
2 modulo9, so b=1. The intervening B_i=(27A_i+23)/16 are also 2 modulo9.

Modulo m, the A_i follow g_m and return to zero after j iterations.
Modulo 3^beta the initial fixed residue is preserved. Modulo 2^alpha,
the shadow congruence still holds at the endpoint because K-9j>=alpha.
CRT gives A_j==A_0 modulo M. Q is a multiple of M, so the initial
residue does not depend on t.

Finally,

    G(A)-4A=(139A+3031)/512>0

for every positive A. Iterating yields A_j>4^j A_0. This proves FR-1.

### Why simply extending the old two-edge family would have failed

A single G step preserves n modulo an odd p only if

    1675n+3031 == 0 (mod p).

This has no solution for p=5 or p=67: these primes divide 1675 but not
3031. The theorem genuinely needs a longer path. Modulo either such p,
g_p is translation by a nonzero residue and its period is exactly p.
For example M=5 uses ten F edges and M=67 uses 134 F edges.

## Theorem FR-2: polynomial ranks with arbitrary fixed residue dependence fail

For each measured state s=(L,e,b,D,R,n mod M), independently choose a real
polynomial P_s(N,H). Set Phi(n)=P_s(n,bitlength(n)). There need not be a
uniform degree bound or polynomial dependence on s.

If Phi is bounded below on all hard states, it cannot strictly decrease
on every hard-to-hard F edge. The same holds for any finite lexicographic
tuple whose coordinates individually satisfy that lower-bound property.

Proof: on the FR-1 progression, both endpoint states have the same s.
Their ratio tends to (2187/512)^j>1, and their bitlength difference is
positive and bounded. Write the restricted polynomial as

    P_s(N,H)=sum_{k=0}^d N^k q_k(H).

If d>=1, its leading q_d must have positive leading coefficient, or Phi
tends to minus infinity along the source progression. Thus the ratio of
endpoint polynomial values tends to (2187/512)^(jd)>1; the denominator
is eventually positive. If d=0, a nonconstant lower-bounded polynomial
in bitlength is eventually increasing; a constant gives equal values.
Every coordinate is therefore eventually nondecreasing between endpoints,
contradicting the strict decrease forced by 2j F edges.

The same proof works for z and bitlength(z), or lambda and
bitlength(lambda), on the frozen label class. A pure rank determined by
the finite measured state also fails immediately, since the endpoints
have identical state.

This is not an impossibility theorem for arbitrary nonpolynomial ranks,
unbounded arithmetic sensors, ordinal constructions, or ranks depending
on the full path history. Lower-bounded real-valued strict descent itself
is not claimed to be well-founded.

## A possible escape, and the observed recharge blocker

The word itself has a useful unbounded valuation sensor:

    H_A(n)=v2(1675n+3031),     H_B(n)=v2(1675n+2707).

On the two specified macros the exact identities

    1675B+2707 = (27/16)(1675A+3031),
    1675A'+3031 = (81/32)(1675B+2707)

give H_B=H_A-4 and H_A'=H_B-5. This sensor detects how much precision
remains in the repeated-word shadow, and escapes FR-2's fixed-modulus
hypothesis. It does not give a global rank: the actual hard edge

    F(91)=155,      H_A(91)=6,      H_A(155)=9

recharges it while the integer grows. Thus this local word-specific
valuation descends along the alternating word, but a global construction
still requires control of its change on other transitions. No recurrence
or no-recharge assumption may be silently added.

## Comparison with the stronger-root-core three-step family

The parallel continuation found, for every M,v>=1,

    n=1536Mv-5  -> T^3 ->  m=1728Mv-5.

Direct OOE replay passes through 2304Mv-7 and 3456Mv-10. Both endpoints
have (L,e,b,D,R)=(2,1,0,1,0), are 1 modulo3, and are equal modulo M.
Thus neither the original decreasing beta rule nor the new smaller
coalescence rule gamma(n)=(2n-1)/3 for n==2 (mod3) reduces these endpoints.
The debt identities are 11z_n+9=2(528Mv-1) and
11z_m+9=2(594Mv-1), proving D=1 exactly.

| Family | Exact transition relation | Frozen 3-adic depth | What its obstruction directly covers |
|---|---|---:|---|
| FR-1 repeated word | Original F edges, including original rho | 1 | Ranks required to decrease on every original hard F edge |
| Stronger-core family | T^3 OOE relation with canonical endpoints | 0 | Ranks required to decrease on this three-step relation or a graph that includes it |

The three-step relation is not one original F edge: a source with L=2
uses T^4 in the original definition. That extra step sends the target m
to 2592Mv-7==2 (mod3), before rho. Therefore the simpler new family
should not silently replace FR-1 in a theorem specifically about F.
Conversely, FR-1 has b=1 and is not an example of an irreducible root under
the stronger gamma rule. The two obstructions have distinct exact scopes.

## Verification and limits

Run the standard-library checker:

    python -B verification/finite_residue_hard_return_check.py

It reconstructs the rational word using exact fractions, constructs CRT
certificates for 18 moduli, checks each entire affine family uniformly in
t, and independently replays 90 positive paths totaling 6,330 F edges.
The all-moduli assertion is the proof above; the polynomial consequence
is also a proof rather than a finite polynomial search. No Lean
formalization is claimed.

The seed and word length depend on M. This construction does not produce
one positive integer with an infinite repeated word. Its exact rational
fixed point is negative, and the growing positive integer shadows are
finite. That distinction is essential to the unresolved Collatz boundary.

## Connections

- **Depends on:** [original hard return](AB_hard_boundary_return_system.md) and [F025](AB_frozen_debt_size_rank_no_go.md).
- **Compared with:** [stronger core and selected smaller targets](AB_ternary_normalized_core_residue_obstruction.md).
- **Verified by:** [exact checker](../../verification/finite_residue_hard_return_check.py).
- **Recorded in:** [continuation report](../../ASTRA_CONTINUATION_2026-09-05.md).
