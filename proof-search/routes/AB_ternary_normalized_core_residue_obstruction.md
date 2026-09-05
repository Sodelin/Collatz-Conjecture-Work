---
node_id: AB-CORE-RESIDUE-OBSTRUCTION-001
node_type: route
routes: [AB, B]
tags: [collatz, coalescence, root-normalization, finite-residue-rank-obstruction]
---

# Ternary predecessor normalization removes F026, but a stronger core obstruction survives

**Verdict:** exact auxiliary result; no proof or disproof of Collatz and no external novelty claim.

**Proposed new mechanism:** supplement the decreasing boundary normalizer with
smaller ternary predecessors, then seek a cross-label coalescence certificate
only on the resulting core relative to those selected rules. This is stronger certificate semantics
than demanding a rank on every old F edge. Its first falsification test is the
F026 family. That family is completely removed, but the strengthened core has
a new expanding family surviving every finite fixed-modulus residue refinement.

**Input provenance:** repository `Sodelin/Collatz-Conjecture-Work`, reviewed input
`b6eee8594714adc3b51d5005dd0b4ed8a76412e8`. This note integrates the
third-pass proposal after internal review. Dependencies are L3, L13, the exact hard boundary reducer,
and the F025/F026 polynomial argument. The elementary predecessor identity was
already implicit in L3; its use to audit F026's root admissibility is the present
application, not a newly discovered Collatz identity.

## 1. Maps and root domain

Throughout, T(n)=n/2 for even n and T(n)=(3n+1)/2 for odd n. Conv(n) means
that the positive T orbit reaches 1. The hard set H has canonical data

    n=2^L(4z+2epsilon+1)-1,
    L>=2, epsilon in {0,1}, epsilon != L mod2.

For n=2 mod3 define

    gamma(n)=(2n-1)/3.

It is a positive odd integer, T(gamma(n))=n, and 0<gamma(n)<n. Hence
Conv(gamma(n)) iff Conv(n). More generally, if

    n+1=2^a 3^b lambda, gcd(lambda,6)=1,

then b successive gamma steps are admissible and yield

    gamma^b(n)=2^(a+b)lambda-1,
    T^b(gamma^b(n))=n.

Each nonempty predecessor step strictly decreases the represented integer.
Thus a least positive nonconvergent integer, if one exists, cannot have b>0.

Let beta be the existing decreasing boundary reducer outside H: n/2 when
L=0, (3n+1)/4 when L=1, and (3n-1)/4 for the compatible labels with L>=2.
Define eta by repeatedly applying gamma when n=2 mod3, otherwise beta when
n is outside H, stopping at 1 or

    C = H intersect {n : n mod3 != 2}.

All steps strictly decrease a positive integer, so eta is total. Their orbit
identities prove Conv(n) iff Conv(eta(n)). Consequently convergence on all of C
is equivalent to convergence on all positive integers. The reduction itself
is not a well-founded transition mechanism inside C.

For compatible L>=2 labels, beta(n)=2 mod3 and

    gamma(beta(n))=(n-1)/2.

This is a useful exact composition of old identities. It does not extend to
incompatible hard labels without the required branch guard.

## 2. Exact smaller target for the entire F026 family

For every t>=0,

    A(t)=589824t+244379,
    a(t)=393216t+162919,
    T(a(t))=A(t),
    0<a(t)<A(t).

Thus the whole F026 source family has an immediate uniformly smaller target.
There is no need to refine t or continue the growing A->B->C trajectory to
obtain this certificate. It does not prove those targets converge without the
strong-induction premise, but excludes A(t) from being a least counterexample.

This does not invalidate F026: a rank required to decrease on every old F edge
must still handle its witness. It shows why an obstruction for that old rank
specification does not automatically obstruct a stronger root certificate.

## 3. A universal obstruction inside the stronger core

For EVERY integer modulus M>=1 and every v>=1, put w=Mv and define

    n=1536w-5,
    m=1728w-5.

The complete guarded shortcut path is

    n=1536w-5  --O--> 2304w-7
                --O--> 3456w-10
                --E--> m=1728w-5
                --O--> Y=2592w-7.

The slopes are even and the displayed intercepts prove each branch parity
uniformly in w. In particular,

    T^3(n)=m,
    T^4(n)=Y,
    gamma(Y)=m,
    m-n=192w>0.

The old raw hard macro at n has L=2 and is exactly T^4(n). Both n and m are
already in the new core, so the strengthened transition

    S(h)=eta(T^(L(h)+2)(h))

satisfies S(n)=m on this family. No hidden beta reductions occur after gamma.

Here is the exact endpoint data:

| Quantity | n | m |
|---|---|---|
| canonical parameter z | 96w-1 | 108w-1 |
| lambda=(x+1)/4 | 384w-1 | 432w-1 |
| L | 2 | 2 |
| epsilon | 1 | 1 |
| b=v3(x+1) | 0 | 0 |
| D=v2(11z+9) | 1 | 1 |
| R=floor(D/4) | 0 | 0 |
| x mod3 | 1 | 1 |
| x mod M | -5 mod M | -5 mod M |
| z mod M | -1 mod M | -1 mod M |
| lambda mod M | -1 mod M | -1 mod M |

Indeed, x+1=4lambda with lambda=3 mod4 and lambda=2 mod3. The debt arguments
are respectively 2(528w-1) and 2(594w-1), with odd parenthesized factors, so
D=1 exactly. Both states are positive for w>=1. The size ratio tends to 9/8.

The minimal displayed specialization M=v=1 is

    1531 -> 2297 -> 3446 -> 1723 -> 2585,
    gamma(2585)=1723.

## 4. Finite-residue polynomial-rank no-go

Fix any finite collection of fixed integer moduli. A label may contain
(L,epsilon,b,D,R,n mod3) and arbitrary functions of the residues of n, z,
and lambda modulo those moduli. On every such label independently choose a
real polynomial in n and bitlength(n). There is no function of this form that
is bounded below on C and strictly decreases on every S edge in C. Nor is
there such a finite lexicographic tuple if every coordinate is bounded below
on C. Polynomial dependence on z and bitlength(z), or on lambda and its
bitlength, gives the same obstruction.

**Proof.** Choose M to be the least common multiple of the finitely many
moduli. Section 3 freezes every label at both endpoints. For a scalar
coordinate write its polynomial on this label as

    P(x,B)=sum_j x^j q_j(B),  B=bitlength(x).

If its largest nonzero x degree k is positive, lower boundedness along the
positive family n(v) forces the leading coefficient of q_k to be positive.
Otherwise that term tends to negative infinity, dominating all smaller powers
of x. Since m/n->9/8 and B(m)-B(n) is bounded, q_k(B(m))/q_k(B(n))->1.
Consequently P(m,B(m))/P(n,B(n))->(9/8)^k>1, and the coordinate eventually
increases. If k=0, the remaining polynomial in B is constant or eventually
nondecreasing by lower boundedness; B(m)>=B(n), so its endpoint value cannot
fall. The zero polynomial is constant. Thus every coordinate is eventually
nondecreasing. A finite tuple has a common threshold beyond which none of its
coordinates decreases, contradicting strict lexicographic decrease on S(n)=m.
The z and lambda versions follow either by the same asymptotic argument or
their exact affine relation to n. This proves the stated certificate-class
obstruction for arbitrary finite moduli, not merely for tested moduli. QED.

The fixed-modulus qualifier is essential. The theorem does not concern every
possible finite additional state, variable moduli, or unbounded valuations.
It also does not forbid a different cross-label target selection.

## 5. Corollary for the exact first return to 20 modulo 27

The same positive shadow survives a frontend that reduces the problem to
residue 20 modulo 27. Let M be any positive multiple of 27 and w=Mv, v>=1.
Set

    y=2304w-7,     y'=2592w-7.

The first three shortcut steps are

    y (20 mod27) --O--> 3456w-10 (17 mod27)
                 --E--> 1728w-5  (22 mod27)
                 --O--> y'        (20 mod27).

Thus y' is exactly the FIRST positive-time return to the residue 20 modulo 27,
not simply a later chosen meeting point, and y'-y=288w>0. If a finite set of
additional moduli is specified, take M divisible by those moduli as well.
Both endpoints then equal -7 modulo each such modulus, and y'/y->9/8.
Their shared elementary valuation labels are L=1, epsilon=0 and b=1; their
canonical parameters are 288w-1 and 324w-1, and their coprime cofactors are
384w-1 and 432w-1, so those residues also freeze.

The polynomial argument in Section 4 therefore applies to any lower-bounded
polynomial-size rank, and any coordinatewise lower-bounded finite lex tuple,
whose labels contain only (L,epsilon,b) and any fixed finite residue refinement.
Do not import D,R from the hard-label theorem: an extension of those formulas
to L=1, epsilon=0 would have D=v2(z+1), which drops by three on this edge.
The first-return map may be partial on other inputs; the displayed family
proves its own returns exist exactly. A rank
that decreases only during the frontend's excursions outside residue 20 does
not by itself rank these increasing return edges. This corollary concerns the
explicit return map and does not challenge the validity of the frontend.

## 6. Stronger smaller targets peel the new shadows too

The obstruction concerns ranks required to decrease on every specified return
edge. It does not obstruct dynamically choosing a smaller coalescing target.
There are explicit positive targets even for the newly constructed witnesses.

For every t>=0,

    T^3(16t+11)=18t+13,
    0<16t+11<18t+13.

Equivalently, every positive odd n=4 mod9 admits p=(8n-5)/9<n and T^3(p)=n.
For the Section 3 family, if 3 divides M then this target is integral and
removes its source from a still-stronger least-counterexample core. Our eta
core is therefore a normal form only for its selected reductions; it is not
a claim of full coalescence irreducibility.

There is an internal smaller-target rule within residue 20 modulo27 as well:

    T^3(432t+425)=486t+479,         t>=0,
    0<432t+425<486t+479,

and both endpoints are 20 modulo27. More generally, for y=236 mod243,

    c(y)=(8y-7)/9,
    T^3(c(y))=y,
    0<c(y)<y,
    c(y)=20 mod27.

For the Section 5 family (27 divides M), the explicit target is

    p20=2048Mv-7 < y=2304Mv-7,
    T^3(p20)=y,
    p20=20 mod27.

Thus that family cannot contain the least nonconvergent residue 20 input.
The positive coefficient identities prove this for every parameter, without
numerical extrapolation.

There is a crucial compositional limit: first-return progress can be exactly
undone by a decreasing coalescence normalizer. For example,

    425 --T--> 638 --T--> 319 --T--> 479 --c--> 425.

The T path has residues20,17,22,20 modulo27, so 479 is the first return. The
starting 425 is already c-normal (v3(425+7)=3), while 479 has v3(479+7)=5 and
c(479)=425. A map defined as first return followed by exhaustive c-normalization
therefore has the positive self-loop425->425. This is a loop of the auxiliary
certificate process, not a T cycle. It proves that convergence preservation
and separately decreasing normalization do not automatically compose into a
terminating return map.

For repeated c steps, v3(y+7) drops by two each time. Consequently all residue 20
inputs can be reduced by this rule to v3(y+7) in {3,4}. But the self-loop shows
why that sharper root reduction must retain the immutable induction threshold
and exact coalescence history, or some other independent progress measure.
Normalization alone is not that measure.

## 7. The exposed escape coordinate and stop condition

The OOE macro is G(x)=(9x+5)/8 on its legitimate residue cylinder. Its affine
fixed point is -5. The positive witness shadows this negative three-step cycle,
but is not a positive cycle and is not an infinite positive divergence witness.

An unbounded arithmetic state detects this local shadow:

    v2(m+5)=v2(n+5)-3.

Thus v2(n+5) genuinely decreases across the displayed growing core edge.
Unlike a fixed residue label, it records the remaining length of the OOE run.
For q=v2(n+5), repeated legitimate OOE blocks satisfy

    G^j(n)+5=9^j(n+5)/8^j,
    v2(G^j(n)+5)=q-3j,

while the required divisibility/branch guards hold. This local debt is not
claimed to decrease on all S edges; recharge on other branches remains to be
controlled. Merely naming it does not reopen a global rank route.

Stop condition: the source F026 obstruction is eliminated by stronger
coalescence semantics, but its removal does not supply a universal core rank.
Any replacement must either handle unbounded arithmetic information such as
this shadow depth, or provide stronger uniformly smaller targets on the new
core family. Repeating fixed-modulus refinement with polynomial size ranks
cannot do so.

## 8. Signed time advance: an exact composition admission condition

The positive auxiliary self-loop suggests tracking time as well as represented
size. This is a conditional semantic check, not a Collatz proof or an
unconditionally available well-founded rank.

Suppose n,m are positive, a,b are nonnegative integers, and

    T^a(n)=T^b(m)=z.

Define this edge's signed time advance by delta=a-b. When the common orbit
converges, write tau(x)=min{k>=0 : T^k(x)=1}. The exact identity

    tau(n)-tau(m)=a-b                                      (CLOCK-EQUALITY)

requires BOTH prefix guards

    T^j(n)!=1 for every 0<=j<a,
    T^j(m)!=1 for every 0<=j<b.

Equivalently, tau(n)>=a and tau(m)>=b. These guards permit reaching 1 exactly
at the meeting time. To prove the identity, the two hitting times respectively
split as a+tau(z) and b+tau(z), since neither prefix contains an earlier 1.

A source prefix guard alone is enough for the useful inequality

    tau(n)-tau(m)>=a-b.                                    (CLOCK-BOUND)

Indeed, tau(n)=a+tau(z), while the witnessed route through z only gives
tau(m)<=b+tau(z): the target might have already visited 1 before time b.
Equality must not be claimed in that case. For example,

    T^5(3)=T^2(1)=1,
    tau(3)-tau(1)=5 != 5-2.

For a finite sequence of guarded coalescence edges n_0,...,n_q, summing
CLOCK-BOUND gives

    sum_{i<q}(a_i-b_i) <= tau(n_0)-tau(n_q) <= tau(n_0).

Convergence of n_0 implies convergence of every state on this coalescence
sequence, so all these hitting times exist. Therefore a convergent start
cannot support an infinite certificate path whose accumulated signed advance
is unbounded above. Two usable sufficient conditions are:

* every nonterminal edge has a_i-b_i>=1; or
* a finite guarded graph has an integer lower bound w_e<=a_i-b_i on each
  represented edge, and every directed cycle has strictly positive total
  lower-bound weight.

For the second condition, decompose a path in the finite graph into simple
cycles and a residual simple path. Every removed cycle has positive integer
weight, while the residual path's negative contribution has a uniform finite
bound. Any infinite path removes infinitely many cycles, so its accumulated
advance is unbounded. Merely requiring all cycles of an arbitrary infinite
graph to be positive is insufficient: an infinite acyclic path could have
zero advance throughout.

The clock values in the present example are exact:

    425 -> 479 by three T steps:       delta=+3,
    479 -> 425 by inverse coalescence: delta=-3,
    complete auxiliary cycle:         delta=0.

Thus a positive-cycle clock condition detects precisely the missing progress.
For an elementary gamma predecessor, T^0(n)=T^1(gamma(n)), so its signed
advance is -1. A run of r gamma inverses contributes -r, even though every
represented integer decreases.

By contrast, the original F construction has a positive raw-prefix advance
L+2. Its beta reductions carry advances 1, 2 and 2 in the three cases, with the
necessary source-prefix guards already justified in the hard-return note.
CLOCK-BOUND therefore supplies the original conditional stopping-time
progress, even if a target prefix enters the 1-2 cycle early. The new S
construction must separately account for its negative gamma contributions;
size decrease alone does not establish that clock condition.

Admission condition for a future composition: provide exact guarded
coalescence identities, record their signed advances, prove a suitable
accumulated-advance condition, and explicitly distinguish this conditional
semantic result from the independent well-founded mechanism still needed for
unconditional termination. If terminal states are 1 and coverage is exact,
the clock condition can restore the implication from Collatz convergence to
termination of the certificate process. It does not establish Collatz
convergence: ordinary T itself has advance +1 on every step, while its
universal termination is precisely the unsolved problem.

## 9. Verification and logical limits

Run the companion checker:

    python -B verification/core_residue_obstruction_check.py

It checks universal affine identities and coefficient divisibility, exact
valuation factorizations, 726 independent positive witness replays including
1024-bit parameters, and 101 replays of the F026 smaller-target identity.
It uses explicit checks rather than Python assert, so optimization cannot
silently remove its verification. The universal rank argument is the proof
above; sampling is not being used as a proof of that argument.

An independent agent cold-audited the branch arithmetic, frozen labels,
finite-modulus quantifiers and asymptotic polynomial argument, and separately
replayed 1,010 parameter pairs including 1024-bit parameters. There is no
Lean formalization or external priority search for this proposal.

The new map S preserves convergence on each edge. Termination of every S
orbit is a sufficient convergence certificate; the converse is deliberately
not asserted without a separate proof. The gamma normalizer can add orbit
steps to a coalescing target, so the old F stopping-time proof must not simply
be copied. The equivalence proved in Section 1 concerns convergence on the
core itself, which follows directly from the decreasing eta normalization.

## Connections

- **Depends on:** [L3 trailing-ternary coalescence](../lemmas/L3_Trailing_Ternary_Two_Coalescence.md) and [L13 refined macros](../lemmas/L13_Refined_Mersenne_Child_Macros.md).
- **Refines:** AB hard boundary return system by adding smaller predecessors.
- **Separates scope from:** F025/F026, which concern ranks on all old F edges.
- **Blocks:** finite fixed-modulus refinements with polynomial size ranks on S.
- **Leaves open:** unbounded arithmetic ranks, different target selection,
  cross-label induction mechanisms and the Collatz conjecture.

- **Compared with:** [original-F finite-residue obstruction](AB_finite_residue_original_return_no_go.md).
- **Constrains:** [residue-20 ranked normalizer](../sources/Sufficiency_Rank_Audit_2026-09-05.md).
- **Verified by:** [exact checker](../../verification/core_residue_obstruction_check.py).
- **Recorded in:** [continuation report](../../ASTRA_CONTINUATION_2026-09-05.md).


## Root-relative continuation connections

- **Strengthened by:** [explicit smaller residue20 ancestors](../lemmas/Residue20_Refined_Ancestor.md), which remove an infinite subfamily of c-normal roots, including old auxiliary-loop roots.
- **Parallel to:** [guarded forward burst descent](../lemmas/Root_Relative_Burst_Descent.md), whose later return can decrease after its first return grows.
- **Rank class further blocked by:** [exact shadow-depth recharge](AC_shadow_debt_recharge.md), for the specified stronger-core return S only.
