---
node_id: AC-POSTSPELL-GUARDED-ROOT-DESCENT-001
node_type: lemma
routes: [B, AB]
tags: [collatz, actual-descent, immutable-root, recharge, infinite-family]
---

# Guarded root descent after independently unbounded return spells and odd runs

For every pair of integers J>=2 and H>=3, this note constructs an infinite
subfamily of the previous residual cylinder

    r=22619+186624s, s>=0,

whose actual shortcut word is

    (OOEO)^J O^H E^e,

where J+H<=e<J+H+18 and e=2 mod18. The complete word ends at a positive
integer m=20 mod27 with m<r. Every positive-time state before the final
even run exceeds the same original root r.

Both the number of growing first returns J and the subsequent exact odd-run
length H can be chosen independently and arbitrarily large. The final
halving guard is substantive. This is a new guarded coverage theorem for
the named cylinder, not an assertion that every root in that cylinder
satisfies the guard or that all Collatz trajectories terminate.

## 1. Uniform original-root margin

Use T(n)=n/2 for even n and (3n+1)/2 for odd n. Suppose r>3 follows the
actual word (OOEO)^J O^H, with J>=2 and H>=3, ending at z. Let e>=J+H,
and assume the exact arithmetic guard

    2^e divides z.                                      (EVEN-EXIT)

Set m=z/2^e. Then

    T^(4J+H+e)(r)=m,
    0<m<r.

Here the phrase 'follows the actual word' means every indicated parity is
satisfied. Section2 constructs that hypothesis and EVEN-EXIT together on
an explicit infinite arithmetic progression for every J,H.

### Exact orbit and margin proof

Write y=T^(4J)(r). The OOEO affine identity and ordinary odd-run identity
give

    y=(27/16)^J*(r+23/11)-23/11,
    z=(3/2)^H*(y+1)-1.

These are identities of actual integer iterates under their parity guards.
Consequently

    z < (3/2)^H*(27/16)^J*(r+3).

After dividing by2^e, use e>=J+H to get

    m < gamma*(r+3),
    gamma=(27/32)^J*(3/4)^H.

Both factors are between0 and1. Since J>=2 and H>=3,

    gamma <= (27/32)^2*(3/4)^3
          =19683/65536 <1/2.

Because r>3, (r+3)/2<r. Thus m<r with respect to the unchanged initial
root, irrespective of how large either growing phase becomes. Positivity
and integrality follow from the actual positive orbit and EVEN-EXIT. The
latter licenses e consecutive actual even steps. QED.

This bound is convenient, not asserted optimal. It cannot be used when
EVEN-EXIT fails, even if the preceding growing phases are correctly known.

## 2. Explicit complete parity and CRT construction

Choose arbitrary J>=2,H>=3 and put

    e=2+18*floor((J+H+15)/18),
    W=(OOEO)^J O^H E^e,
    N=4J+H+e.

Then e=2 mod18 and J+H<=e<J+H+18.

The following integer recursion constructs the unique binary residue
A(W) modulo2^N that realizes the entire word. Initialize

    a=0, A=1, C=0.

For j=0,...,N-1, let epsilon=1 for the next letter O and0 for E. The
already constructed j-letter prefix has exact affine expression

    T^j(n)=(A*n+C)/2^j

on n=a mod2^j. Compute

    x=(A*a+C)/2^j,
    delta=(epsilon-x) mod2,
    a <- a+delta*2^j.

If the next letter is O, also set

    C <- 3*C+2^j,
    A <- 3*A.

For E, leave A,C unchanged. At the end set A(W)=a.

The old numerator is divisible by2^j by induction. Replacing a by
 a+2^j changes its current iterate by the odd number A, so exactly one
choice delta in{0,1} enforces the next parity. The update preserves the
new affine expression and its integrality. Thus this recursion proves
existence and uniqueness of the full parity residue without testing an
unbounded list of starting values.

Since J>=2, the first eight letters are OOEOOOEO. The recursion for
that fixed prefix gives a=91 modulo256. Set

    B=2^(N-8),
    s0=((A(W)-22619)/256)*729^(-1) modB,
    s=s0+Bt, t>=0,
    r=22619+186624s.                                  (CRT-SOURCE)

The division by256 is exact because22619=91 mod256. The inverse exists
because729 is odd. Taking the canonical s0 in[0,B) gives nonnegative s
and positive r. Since186624=256*729, the construction yields

    r=A(W) mod2^N,
    r=20 mod729.

Hence the complete displayed word is an actual orbit for every t. Its
last e letters prove EVEN-EXIT. The margin in Section1 then proves m<r.
Varying t gives an infinite arithmetic progression for every independent
choice of J,H.

## 3. Exact spell length, further growth, and target membership

A source realizing the first two OOEO blocks has q(r)=5. Each of the
J blocks is a first return to S20 with residues20,17,26,13,20.
Immediately after these blocks, the next H>=3 letters are odd. Thus
 y=T^(4J)(r)=7 mod8 and q(y)=2. The OOEO spell has therefore ended after
exactly J blocks, as asserted by the finite-spell theorem.

The word O^H E ensures v2(y+1)=H exactly. Every step in every OOEO
block increases relative to that block's source; all H subsequent odd
steps also increase. Therefore every positive-time state before the final
even run exceeds the original r. The proof repays both entire growing
phases instead of restarting its comparison at a larger intermediate.

For the final target, H>=3 and the odd-run identity imply z=-1 mod27.
Since e=2 mod18, the elementary congruence2^18=1 mod27 gives2^e=4 mod27.
Hence

    4m=26 mod27,
    m=20 mod27.

Both endpoints of the complete descent belong to S20. This is a later
return; no decrease on individual first-return edges is claimed.

Every source in CRT-SOURCE lies in the previously named uncovered cylinder.
In particular r=20 mod729 implies v3(4r+1)=4 and the old ancestor selector
value theta=4, outside its guard. Writing r=32u-5 gives u=3 mod8, whereas
the earlier q2 k1 exit theorem requires u=7 mod8. These comparisons are
with those specific certificates, not claims of irreducibility under all
possible methods.

For J=2,H=3,e=20, the construction gives r=103791333467 and m=951311, with T^31(r)=m<r. The first eleven steps grow relative to r; the final twenty even steps repay that growth.

## 4. Why the guard remains a real open boundary

The separate postspell obstruction constructs, for the same independently
chosen J,H, sources whose spell and odd run have these exact lengths but
whose even endpoint lacks the required power of two. In that construction,
increasing its free parameter t by one changes z by

    2*729*3^(3J+H),

which is twice an odd integer. Thus one of each consecutive pair of t
values gives z=2 mod4, so v2(z)=1<J+H. There are infinitely many such
failed-exit sources for every J,H.

Even an actual even run and correct target residue are insufficient when
the halving bound is omitted. Taking J=2,H=3,e=2 gives the exact word
OOEOOOEOOOOEE and the example

    r=4501595, T^13(r)=10816031>r,

with both endpoints in S20. Its coefficient19683/8192 exceeds one.
This does not contradict the theorem, whose hypothesis requires e>=5
for this pair J,H.

More generally,
the parity construction here selects one source residue modulo2^N and
does not prove arbitrary sources eventually enter that residue.

Thus the theorem covers infinitely many roots of the formerly named
residual cylinder at every J,H. Its complement is not proved empty.
A global result still needs an unbounded escape/coalescence mechanism that
handles failed final-halving guards and later recharge.

## 5. Verification and evidence boundary

The checker reconstructs the parity residue, independently replays every
shortcut step, checks exact spell and odd-run lengths, verifies the final
target and original-root strict order, and rejects a source that has the
right growing phases but insufficient final even valuation. It also retains the insufficient-halving counterexample above and checks
three deliberately invalid parameter controls. All checks use explicit
failures and remain active under Python -O.

The proof above, not the finite sample, establishes the infinite families.
Full Lean formalization of this complete new selector is pending. The
construction uses classical affine parity and CRT machinery; no external
priority claim is made.

## Connections

- **Depends on:** [the exact finite-spell theorem](Finite_Growing_First_Return_Spells.md).
- **Complements:** [the postspell odd-run obstruction](Postspell_Odd_Run_Obstruction.md).
- **Strengthens / specializes:** the previous residual-cylinder target in [the earlier recharge packet](../../RECHARGE_ESCAPE_PROGRESS_2026-09-05.md).
- **Verified by:** [the actual-orbit checker](../../verification/postspell_guarded_descent_check.py) and [verification manifest](../../verification/README.md).
- **Formalized by / pending:** [Lean boundary](../../LEAN_TARGETS.md); this complete new theorem remains prose/Python.
- **Leaves open:** unguarded root-relative escape and universal termination.
