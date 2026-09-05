---
node_id: AC-GROWING-FIRST-RETURN-SPELL-001
node_type: lemma
routes: [B, AB]
tags: [collatz, first-return, recharge, valuation-clock, obstruction]
---

# Exact termination of every consecutive OOEO first-return spell

Use the shortcut map T(n)=n/2 for even n and (3n+1)/2 for odd n,
S20={n>0:n=20 mod27}, and q(n)=v2(n+5). This note proves a finite
escape from one specified growing itinerary, together with an obstruction
to uniformly bounded forward descent on the named residual cylinder.
Its endpoint remains larger than its original root. No universal Collatz
termination, eventual descent, or coverage theorem follows.

## 1. Uniform exact spell theorem

For r in S20 with q(r)>=4, put

    a=v2(11r+23), L=floor(a/4), b=a-4L.

Then L>=1 and 0<=b<=3. Exactly L consecutive first returns follow the
word OOEO. If r_j=T^(4j)(r), for 0<=j<=L, then

    16^j(11r_j+23)=27^j(11r+23),
    v2(11r_j+23)=a-4j,
    r_j in S20.

For every 0<=j<L, q(r_j)>=4 and

    r_(j+1)=H(r_j)=(27r_j+23)/16>r_j.

The spell terminates with the exact low-depth state

    q(r_L)=b in {0,1,2,3}.

Every positive-time shortcut state through time4L is larger than the
unchanged starting value r. In particular, ending this itinerary is not
descent below r.

### Proof

For a positive integer x,

    11x+23=11(x+5)-32.

Because11 is odd, q(x)>=4 if and only if16 divides11x+23. On this
guard, x=11 mod16, and the actual four states are

    x -> (3x+1)/2 -> (9x+5)/4 -> (9x+5)/8 -> (27x+23)/16.

Their parities before the respective steps are OOEO. If x is in S20,
the residues are20,17,26,13,20, so the fourth step is the first positive
return to S20. Every one of the four new values exceeds x.

The affine map satisfies

    11H(x)+23=27(11x+23)/16.

Therefore each licensed step lowers the finite positive integer's binary
valuation by exactly4. Applying the guard equivalence inductively proves
all L steps, the displayed identity, and that no next OOEO step is licensed.
At the endpoint, v2(11r_L+23)=b<4. Adding32 preserves that valuation,
so 11(r_L+5)=(11r_L+23)+32 has valuation b. Thus q(r_L)=b.
Strict increase inside every four-step block proves the root-relative
non-descent assertion. All formulas concern actual shortcut paths. QED.

Equivalently, the rational fixed point -23/11 centers the exact formula

    r_L=(27/16)^L*(r+23/11)-23/11.

This fixed point is used only as an algebraic identity. Its nonintegrality
is consistent with, but is not substituted for, the valuation proof.

## 2. Every exit class and every spell length in the residual cylinder

For the previous packet's concrete source cylinder

    r=22619+186624s, s>=0,

one has exactly

    r+5=32(707+5832s), q(r)=5,
    11r+23=2^8(972+8019s).

Consequently

    L=2+floor(v2(972+8019s)/4),
    q(r_L)=v2(972+8019s) mod4.

For arbitrary integers L0>=2 and b0 in {0,1,2,3}, put

    d=4(L0-2)+b0,
    M=2^(d+1),
    s0=(2^d-972)*8019^(-1) mod M,
    s=s0+Mt, t>=0.

The inverse exists because8019 is odd. Taking canonical s0 in[0,M)
gives nonnegative s. The congruence

    972+8019s=2^d mod2^(d+1)

proves its valuation is exactly d. Thus this infinite subcylinder has
exactly L0 growing OOEO first returns, followed by the prescribed exit
q=b0. All four exit depths occur with arbitrarily long spells.

For example, s0=0 gives r=22619, a=10, L=2 and exit q=2. Its actual
successive returns are22619 ->38171 ->64415. Both exceed the original
root; the terminal value has v2(64415+5)=2.

## 3. Scoped obstruction to a uniform forward stopping bound

For every finite shortcut-time bound B, choose L0>=2 with4L0>=B and
any b0. Every root in the corresponding infinite subcylinder satisfies

    T^j(r)>r for all 1<=j<=B.

Hence no single finite time bound proves strict forward descent for every
root of r=22619+186624s. In particular a finite collection of forward
parity words with bounded length, each certifying T^j(r)<r, cannot cover
that entire cylinder.

This does not exclude an unbounded parameterized escape theorem, a smaller
ancestor certificate, a coalescence certificate, a bound depending on r,
or eventual descent after the spell. It does not assert nonconvergence
of any root. The obstruction is to uniformly bounded actual forward
descent on this specific source family.

## 4. What remains open

The valuation a gives a well-founded clock only during consecutive OOEO
first returns. It is not claimed to decrease across the subsequent q0,
q1, q2 or q3 excursion, nor across a later re-entry to the high-q region.
The terminal overshoot grows without bound as L increases. A root-relative
progress theorem still has to repay that accumulated growth or provide a
smaller coalescing ancestor compared with the unchanged original r.

The strongest useful next bridge must therefore accommodate unbounded L
and all four exit classes; merely proving that this local itinerary ends
is insufficient. The identities above isolate its input and exit data
without concealing an eventual-escape assumption.

## 5. Subsequent progress and its exact guard

The [postspell odd-run obstruction](Postspell_Odd_Run_Obstruction.md) shows that even a fixed spell length J and fixed q2 exit allow independently unbounded subsequent growth. A discharge bound based only on J and that exit depth is therefore insufficient.

The [guarded root-descent theorem](Postspell_Guarded_Root_Descent.md) handles a positive subfamily at every J≥2 and H≥3: the actual word (OOEO)^J O^H E^e descends below the original root when the final even run has e≥J+H steps. Its CRT construction gives infinite sources in the exact q5 cylinder with e=2 mod18 and fewer than eighteen padding steps. Failed final-halving guards and arbitrary-source coverage remain open.

## 6. Evidence boundary

The all-parameter statements follow from the integer proof and CRT
construction. The companion checker independently executes every shortcut
step, tests first-return residues and the end-of-spell guard, verifies all
four terminal depths through large L, and retains positive-time growth
controls. It uses explicit failures, so Python -O does not remove checks.
There is no Lean certificate for this new aggregate statement in this note.
The retained test output is232 general roots and396 CRT replays, with all
four exit depths, spell lengths through511, and four rejected invalid guards;
the same output is obtained in normal and optimized Python execution.
No external priority or exhaustive novelty claim is made.

## Connections

- **Depends on:** [complementary ancestor and first-return analysis](Complementary_Ancestor_Cylinders.md).
- **Strengthens / specializes:** [recharge progress packet](../../RECHARGE_ESCAPE_PROGRESS_2026-09-05.md), Section7.
- **Extended by:** [independently long postspell growth](Postspell_Odd_Run_Obstruction.md) and [guarded descent after both growing phases](Postspell_Guarded_Root_Descent.md).
- **Parallel to:** [two-burst guarded escape](Two_Burst_Recharge_Escape.md).
- **Verified by:** [independent actual-orbit checker](../../verification/finite_first_return_spell_check.py) and [verification manifest](../../verification/README.md).
- **Combined with:** [the bounded-ancestor obstruction](Bounded_Ancestor_Depth_Obstruction.md) to exclude simultaneous bounded forward/ancestor covers on the same q5 roots.
- **Formalized by / pending:** [Lean boundary](../../LEAN_TARGETS.md); the aggregate spell theorem is not yet formalized.
- **Leaves open:** uniform root-relative progress after the q0..q3 exit.
