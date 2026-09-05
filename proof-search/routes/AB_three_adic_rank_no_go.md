---
node_id: AB-3ADIC-RESET-001
node_type: route
routes: [AB, C]
tags: [collatz, valuation, rank-obstruction]
---

# Second closure attempt: exact 3-adic reset and a frozen-coordinate obstruction

**Verdict:** the attempted closure mechanism fails its first exact falsification test.
Collatz remains unresolved. These are auxiliary arithmetic statements, not a
general impossibility theorem for richer coordinates or a novelty claim.

## Proposed mechanism and primary-source check

The new candidate state augments L13's hard label and replay debt with

    b(n)=v3(n+1),     lambda(n)=(n+1)/(2^v2(n+1) * 3^b(n)).

Then gcd(lambda(n),6)=1, and n+1=2^a 3^b lambda uniquely. This is the
coordinate system in Jennifer Williams, *A Coordinate System for Collatz
Dynamics*, arXiv:2607.01718v1, pp.2–3 and 10–11. Raw PDF pages were read using
alphaXiv `answer_pdf_queries`, not its generated intermediate report.

Primary source: [Williams, v1](https://arxiv.org/abs/2607.01718v1);
[boundary formulas](https://arxiv.org/pdf/2607.01718v1#page=10).

The interior map (a,b,lambda)->(a-1,b+1,lambda) is exact while a>=2.
The paper explicitly leaves prediction of the full boundary-transition
sequence untreated (p.11) and lists lambda-recurrence as an open problem
(p.19). Thus it provides no independently established global rank or smaller
coalescence target to import.

One wording claim should not be imported: boundary transitions need not
enter a *different* skeleton. The boundary state n=5 has lambda=1, and its
next odd iterate is 1, also lambda=1. This does not affect the factorization
identity used below.

## Exact raw hard-macro transition

Use the repository shortcut map T and hard return F. Let a hard source be

    h=2^L 3^b lambda-1,     L>=2, b>=0, gcd(lambda,6)=1.

The hard guard is 3^(L+b)lambda=3 modulo 4. L13 gives

    Y=T^(L+2)(h)=(3^(L+b+1)lambda-1)/4.

Consequently

    Y+1=3(3^(L+b)lambda+1)/4.

Since L+b>=2, the parenthesized integer is 1 modulo 3. Therefore

    v3(Y+1)=1                                             (RESET)

for every hard source, regardless of its initial b or lambda. Set

    r=v2(3^(L+b)lambda+1)-2,
    lambda'=(3^(L+b)lambda+1)/2^(r+2).

The hard guard ensures r>=0, and the exact raw target coordinates are

    (a',b',lambda')=(r,1,lambda'),
    gcd(lambda',6)=1.

If Y is itself hard, rho(Y)=Y and this is exactly the F transition. Hence
along every consecutive sequence of raw hard-to-hard edges, b is identically
one after the first edge. Extra 3-adic depth alone cannot distinguish these
successive states.

For completeness, the existing decreasing beta rules are also exact in
these coordinates. For x=2^a3^b lambda-1>1:

* a=0: beta(x)+1=(3^b lambda+1)/2;
* a=1: beta(x)+1=(3^(b+1)lambda+1)/2;
* a>=2 and a compatible label: beta(x)+1=2^(a-2)3^(b+1)lambda.

Thus the compatible rule changes (a,b,lambda) to (a-2,b+1,lambda).
For the a=1 rule the new 3-adic depth is zero. For the a=0 rule it is zero
whenever b>0; if b=0, the numerator must be factored. These are bookkeeping
identities; beta termination was already justified by decreasing x.

## Exact positive witness family

Take the F025 family with its parameter restricted to u=9t+3, t>=0. Define

    A(t)=589824t+244379,
    B(t)=995328t+412391,
    C(t)=2519424t+1043867.

The fully guarded identities are

    T^4(A(t))=B(t),       T^5(B(t))=C(t).

All three states are hard, so F(A)=B and F(B)=C. Their coordinate table is:

| State | L | epsilon | b=v3(n+1) | lambda |
|---|---:|---:|---:|---|
| A(t) | 2 | 1 | 1 | 49152t+20365 |
| B(t) | 3 | 0 | 1 | 41472t+17183 |
| C(t) | 2 | 1 | 1 | 209952t+86989 |

The factorizations n+1=2^L*3*lambda prove these valuations exactly: each
displayed cofactor is odd and is not divisible by three. Moreover the source
and final endpoint have D=2 and R=0 by F025 (or by the checker below).

Thus both endpoints have the same augmented finite measurements

    (L,epsilon,b,D,R)=(2,1,1,2,0),

while

    lambda(C)-4lambda(A)=13344t+5529>0.

They remain in the same row a+b=3 and the same phase of the hard label, while
the coprime cofactor increases by more than fourfold. Their cofactor ratio
tends to 2187/512>1.

## Consequence for the candidate rank mechanism

No function strictly decreasing on every hard-to-hard F edge can be
eventually nondecreasing in lambda on the frozen-coordinate class
(L,epsilon,b,D,R)=(2,1,1,2,0).

In particular, for each augmented label (L,epsilon,b,D,R), independently
choose any real polynomial in lambda and bitlength(lambda). If the resulting
function is bounded below on hard states, it cannot strictly decrease on all
hard-to-hard F edges. The same applies to every finite lexicographic tuple
whose coordinates individually have this lower-bound property.

Proof: two F edges force strict endpoint decrease on the displayed family.
Restrict any polynomial coordinate to the common augmented label, and write
it as sum_j lambda^j q_j(bitlength(lambda)). A nonconstant leading term with
positive lambda degree must have positive leading coefficient, or the
function tends to minus infinity along this positive family. Powers of
lambda dominate powers of its bitlength. The endpoint ratio then tends to
(2187/512)^j>1. If the lambda degree is zero, a lower-bounded nonconstant
bitlength polynomial eventually increases, and endpoint bitlength increases
by at least two. A constant polynomial gives equal endpoint values.
Every coordinate is eventually nondecreasing, contradicting strict scalar
or lexicographic decrease over the two edges.

This obstruction permits arbitrary dependence on the frozen labels; it does
not require polynomial dependence on b or debt or any uniform degree bound.

## Scope and stop condition

The new state is sufficient to re-encode the original integer exactly. Its
availability cannot itself prove termination. The paper does not prove
lambda-recurrence or termination of the boundary map, and the direct rank
mechanism based on declining cofactor/3-adic depth fails on this universal
positive family.

No uniformly smaller coalescence target was derived by this attempt. The
witness is not a claim that such targets are impossible. Arbitrary
nonpolynomial, additional-state ranks or stronger coalescence semantics
remain outside the stated obstruction. A new attempt must identify how its
rank decreases on this exact frozen-coordinate family.

Reproduce the arithmetic with:

    python -B verification/three_adic_hard_return_check.py

The checker proves the affine branch identities by uniform coefficient
guards, checks the exact factorizations, and performs independent finite
integer replay. The universal polynomial argument is the prose proof, not a
finite test of candidate polynomials. No Lean proof or novelty claim is made.

## Connections

- **Depends on:** [frozen-debt family](AB_frozen_debt_size_rank_no_go.md).
- **Refines:** [hard return system](AB_hard_boundary_return_system.md).
- **Verified by:** [exact checker](../../verification/three_adic_hard_return_check.py).
- **Recorded in:** [research pass](../../ASTRA_RESEARCH_PASS_2026-09-05.md).
