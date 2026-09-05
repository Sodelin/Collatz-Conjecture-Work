---
node_id: AC-POSTSPELL-ODD-RUN-OBSTRUCTION-001
node_type: lemma
routes: [B, AB]
tags: [collatz, first-return, original-root, unbounded-overshoot]
---

# Fixed-length return spells can be followed by arbitrarily long further growth

This proves a precise obstruction to immediate compensation after the finite
OOEO spell. Even when its length is fixed and its exit depth is fixed at2,
its subsequent odd run can be independently arbitrarily long. No eventual
descent or nonconvergence conclusion is drawn.

## Exact all-parameter family

For arbitrary integers J>=2, H>=3 and t>=0, define

    d=4J-6,
    N=2^(H-1),
    V=(3+2^(H-2))*27^(-J) modN,
    M=2^(d+H-1),
    s0=(2^d V-972)*8019^(-1) modM,
    s=s0+Mt,
    r=22619+186624s.

All residues are canonical nonnegative residues. The modular inverses exist
because their bases are odd. Then the actual shortcut orbit from r has
exact word

    (OOEO)^J O^H

through time4J+H. The initial J blocks are consecutive first returns to
S20. The initial source has q(r)=5. At the end of those J blocks, the
state y has q(y)=2, and its next odd run has exactly H steps. Every
positive-time state in the displayed word exceeds the original r.

Consequently even with J fixed, no finite shortcut-time discharge bound
that depends only on J and the exit depth q=2 can force descent below r
for all roots in this residual cylinder.

## Proof

The number V is odd because H>=3. The source congruence gives

    A=972+8019s=2^d V mod2^(d+H-1).

Hence A=2^d v for a positive odd integer v with v=V mod2^(H-1).
Using11r+23=2^8 A gives

    v2(11r+23)=8+d=4J+2.

The finite-spell theorem therefore proves exactly J actual OOEO first
returns, ending at

    y=(4*27^J v-23)/11,
    q(y)=2.

The quotient is an integer because y is the actual iterate; the formula
is not applied before its parity guards are established. The congruence
on v gives

    27^J v-3=2^(H-2) mod2^(H-1).

Since

    y+1=4(27^J v-3)/11,

and11 is odd, v2(y+1)=H exactly. Put p=(y+1)/2^H. This is a positive
odd integer. The next H actual shortcut states are

    T^h(y)=3^h*2^(H-h)*p-1, 0<=h<=H.

For h<H this value is odd; at h=H it is even. Every odd step strictly
increases a positive integer. The earlier finite-spell theorem already
proved all positive-time states through time4J exceed r, so all4J+H
states exceed the same unchanged root. QED.

## Arbitrarily large overshoot after the spell

Writing z=T^(4J+H)(r), the exact formulas give

    y=(27/16)^J*(r+23/11)-23/11,
    z=(3/2)^H*(y+1)-1.

In particular,

    z/r > (27/16)^J*(3/2)^H.

For fixed J the right side is unbounded as H increases. Ending the
finite first-return spell therefore supplies no bound, in terms of its
length and q2 exit alone, on the next growing excursion's height or on
the time to recover below the original root. This does not rule out an
argument that tracks the additional parameter H or the full root.

The final even valuation can also be forced to be too short for the new
guarded descent theorem. Increasing t by one in this construction changes
r by729*2^(4J+H+1) and hence z by2*729*3^(3J+H), twice an odd integer.
Thus one of each pair of consecutive t values has z=2 mod4, i.e.
v2(z)=1. Every fixed J,H admits infinitely many such failed-exit sources.

## Exact modest example

Taking J=2,H=10,t=0 gives

    d=2, s=1632, r=304592987,
    T^8(r)=867376127,
    v2(T^8(r)+1)=10.

Thus after exactly two growing OOEO first returns there are ten more
consecutive growing odd steps. Neither ending the local valuation clock
nor reaching exit depth2 provides immediate descent.

## Optional simultaneous ancestor-depth obstruction

For any independently prescribed ancestor bound L>=3, additionally impose

    s=-31*256^(-1) mod3^(L-3).

This modulus is coprime to the binary modulus M above. CRT therefore gives
infinitely many nonnegative s satisfying both conditions. Since

    r=20+729(31+256s),

these roots obey r=20 mod3^(L+3). The separate anchor20 inverse-word
obstruction excludes every strictly smaller S20 ancestor of actual time
at most L. Thus bounded smaller ancestors can be excluded simultaneously
with this arbitrarily long postspell forward growth. This does not exclude
general forward/backward coalescence or an unbounded-depth certificate.

## Scope

The integer proof supplies all infinite quantifiers. The checker verifies
CRT reconstruction and all shortcut parities independently, including
exact odd-run termination and optional bounded inverse-tree controls.
No complete Lean formalization or external novelty claim is attached.

## Connections

- **Depends on:** [the exact finite-spell theorem](Finite_Growing_First_Return_Spells.md).
- **Combines with:** [the bounded-ancestor obstruction](Bounded_Ancestor_Depth_Obstruction.md), anchor20 theorem.
- **Verified by:** [the actual-orbit checker](../../verification/postspell_odd_run_check.py) and [verification manifest](../../verification/README.md).
- **Complemented by:** [guarded original-root descent](Postspell_Guarded_Root_Descent.md), which adds a substantive final-halving guard.
- **Formalized by / pending:** [Lean boundary](../../LEAN_TARGETS.md); this complete new theorem remains prose/Python.
- **Leaves open:** a root-relative escape/coalescence theorem with unbounded parameters.
