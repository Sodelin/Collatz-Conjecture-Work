---
node_id: ORIGINAL-ROOT-BRIDGE-PROGRESS-2026-09-05
node_type: archive
routes: [B, AB]
tags: [collatz, original-root, guarded-descent, finite-spell, coverage-gap]
---

# Continuing the original-root proof attempt

**Verdict: universal termination is still unproved.** This pass strengthens
verification of a complete guarded descent theorem, proves an exact local
stopping rule, and identifies why bounded forward and inverse searches
cannot cover even the current named residual cylinder. A separate guarded
construction handles two independently unbounded growing stages. None of
these supplies the missing all-root coverage argument.

This continues PR17 from source
`3d706a9463b1b95ffb7bb3b9a3475771a63b3b7c`. The earlier
[recharge packet](RECHARGE_ESCAPE_PROGRESS_2026-09-05.md) records the preceding
pass. PR16 is unchanged; publication work belongs to the other thread.
The canonical claim grades remain in the
[claim registry](proof-search/CLAIM_REGISTRY.md).

## What is now proved, and in what sense

| Result | Actual advance | Evidence boundary |
|---|---|---|
| Guarded two-burst descent | The complete actual orbit and strict comparison with the original root are now Lean-checked. | The two arithmetic guards remain assumptions. CRT, exact valuation labels and extra even padding have separate prose/Python scope. |
| Finite consecutive OOEO spell | Every licensed spell has an exact finite length and a specified exit in q0, q1, q2 or q3. | Every state during the spell is larger than the original root. This is itinerary termination, not descent. |
| Bounded forward/ancestor obstruction | The same roots in the exact q5 cylinder can defeat independently prescribed finite bounds for both kinds of certificate. | General coalescence and macros with unbounded lengths remain possible. |
| Postspell growth | Even a fixed spell length and fixed q2 exit permit an independently arbitrarily long growing odd run. | This refutes discharge bounds based only on those labels; it says nothing about eventual nonconvergence. |
| Guarded spell-plus-odd-run descent | A sufficiently divisible final even run repays both growing stages, for every pair of lengths. | Infinite guarded subfamilies, not every root of the cylinder; prose proof and exact replay. |

## The verification improvement

[TwoBurstStatement](lean/CollatzWork/TwoBurstStatement.lean) quantifies positive
k,l,u,v,m and assumes exactly

    9^k*u+1 = 2^(3*l+1)*v,
    2^(k+l)*m+5 = 3*9^l*v.

[TwoBurst](lean/CollatzWork/TwoBurst.lean) proves

    T^(4*(k+l)+2)(2*8^k*u-5) = m < 2*8^k*u-5.

The source in the inequality is unchanged throughout the proof. The
convergence corollary explicitly requires convergence of all smaller
positive inputs. Oddness of v is implied by the exit equation; dropping a
redundant oddness assumption does not enlarge coverage.

The accepted source is
`8ba40e7b80afd56e3c86edbb864e969bd5121226`, checked in
[CI33978140043](https://github.com/Sodelin/Collatz-Conjecture-Work/actions/runs/33978140043).
The unchanged official Lean4.33.1 build passed all24 Lake tasks. The power
margin uses `propext`, `Quot.sound`; the descent and convergence-transfer
theorems additionally use `Classical.choice`. There is no `sorryAx`.
[The retained log](verification/two_burst_ci_2026-09-05.txt) records the exact
source and axiom outputs. An earlier candidate failed arithmetic
normalization and was not accepted; the corrected proof passed.

## The local clock and its precise limitation

Write S20={n>0:n=20 mod27}, q(n)=v2(n+5), and use the ordinary one-division
shortcut map T. For q(r)>=4 the first return is the actual four-step word
OOEO, with

    H(r)=(27r+23)/16,
    11H(r)+23=27(11r+23)/16.

The [finite-spell theorem](proof-search/lemmas/Finite_Growing_First_Return_Spells.md)
therefore gives exactly

    J=floor(v2(11r+23)/4)

consecutive growing first returns. Their endpoint has
q=v2(11r+23) mod4. Every positive-time state through time4J exceeds r.

For the current target r=22619+186624s,

    11r+23=2^8*(972+8019s),
    J=2+floor(v2(972+8019s)/4).

Every J>=2 and every exit q0..q3 occur on infinite exact CRT progressions.
The clock ends each uninterrupted OOEO spell. It does not decrease across
the subsequent excursion or establish a rank across re-entry.

## Why bounded searches cannot finish this cylinder

The [ancestor-depth proof](proof-search/lemmas/Bounded_Ancestor_Depth_Obstruction.md)
first establishes that r=20+3^(L+3)t has no smaller S20 ancestor at actual
time at most L. Any proposed inverse word transfers to the anchor20,
where its positive S20 endpoint is at least20. The nonpositive intercept
then forces its affine slope to be at least one, preventing strict
shrinkage at r as well.

On the exact q5 target, impose

    31+256s = 0 mod3^(L-3),
    v2(972+8019s) = 4*(J-2)+e,

with L>=3,J>=2 and e in0..3. The moduli are coprime, so CRT produces
infinitely many roots with no smaller S20 ancestor through L and no
smaller forward iterate through4J, while fixing exit q=e.

This rules out a finite cover choosing between these two bounded
relations, even if its membership predicates are arbitrary. It does not
extend automatically to mixed coalescence T^a(r)=T^b(m), m<r, or to
parameterized words with unbounded a or b.

The [postspell result](proof-search/lemmas/Postspell_Odd_Run_Obstruction.md)
makes the forward limitation sharper: after a fixed
J and fixed q2 exit, v2(H^J(r)+1) can independently be any H>=3. There
are then H further growing odd steps. No recovery-time or overshoot bound
depending only on J and exit q2 can hold.

## The surviving positive mechanism and the remaining bridge

The [guarded postspell theorem](proof-search/lemmas/Postspell_Guarded_Root_Descent.md)
assumes the actual word is

    (OOEO)^J O^H E^e,  J>=2, H>=3, e>=J+H.

For its endpoint m, direct composition gives

    m < (27/32)^J*(3/4)^H*(r+3)
      <= (19683/65536)*(r+3) < r.

The last inequality uses r>3, satisfied throughout the named cylinder.
Choosing e=2 mod18 with at most17 extra even steps places m back in S20.
The binary cylinder of this complete parity word intersects
r=22619+186624s in an infinite progression for every independent J,H.
This proves original-root descent across both unbounded growing stages
under an explicit final divisibility guard.

For example, J=2,H=3,e=20 gives

    r=103791333467,
    T^31(r)=951311<r,
    r mod27 = 951311 mod27 = 20.

Every state through time11, before the final even run,
exceeds r. The checker replays the entire word rather than relying only
on its affine formula.

The halving guard cannot be dropped: with J=2,H=3 and only e=2, the
same pattern gives T^13(4501595)=10816031>4501595, with both endpoints
still in S20. For every pair J,H, a separate infinite source family
even has v2(z)=1 at the end of the growing stages, below the required
e>=J+H. The unresolved complement is therefore real.

The missing statement is that every remaining root obtains a sufficient
escape or smaller coalescing target. A finite local clock, a long but
finite replay, a contracting word without its parity guard, or a decrease
measured from an intermediate larger value cannot supply that statement.
The next mathematical target must control insufficient final halving and
later re-entry while retaining the original root and both unbounded
excursion parameters. No such universal mechanism has been proved here.

## Delta against the other current mathematical work

[PR19 at49721623303d76956c88db5c9906f8c7b4a586e1](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/19)
adds a sound finite-palette bounded-horizon obstruction: arbitrary selection
among finitely many eventually nondecreasing rank pieces cannot guarantee
a strict decrease within a uniform finite shortcut horizon at every
sufficiently large start. It is a negative result, not a global escape
theorem. Its natural-valued version is Lean-checked; broader ordered-value
and polynomial extensions retain prose scope.

Its CI33976680139 checked synthetic merge
`f37c3791eab42583541344d34c89421679b9e9dd`; an exact GitHub comparison with
the submitted head returned zero changed files, establishing equal source
trees. The result supports avoiding bounded-horizon finite polynomial
palettes, while leaving the variable-length guarded excursions above
available. No external priority claim is made for this pass's elementary
affine/valuation/CRT arguments.

## Connections

- **Continues:** [the preceding recharge packet](RECHARGE_ESCAPE_PROGRESS_2026-09-05.md).
- **Strengthens verification of:** [two-burst recharge escape](proof-search/lemmas/Two_Burst_Recharge_Escape.md).
- **Uses:** [the exact finite-spell theorem](proof-search/lemmas/Finite_Growing_First_Return_Spells.md).
- **Records the scope of:** [bounded ancestor and forward obstructions](proof-search/lemmas/Bounded_Ancestor_Depth_Obstruction.md).
- **Uses:** [independent postspell growth](proof-search/lemmas/Postspell_Odd_Run_Obstruction.md) and [guarded original-root recovery](proof-search/lemmas/Postspell_Guarded_Root_Descent.md).
- **Constrained by:** [the failure ledger](proof-search/FAILURE_LEDGER.md).
- **Verified by:** [formal scope](LEAN_TARGETS.md) and [verification manifest](verification/README.md).
