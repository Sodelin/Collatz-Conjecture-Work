---
node_id: ORIGINAL-ROOT-BRIDGE-PROGRESS-2026-09-05
node_type: archive
routes: [B, AB]
tags: [collatz, original-root, guarded-descent, finite-spell, coverage-gap]
---

# Continuing the original-root proof attempt

**Current draft extension:** [arbitrary finite chains of failed returns](#continuation-arbitrary-finite-chains-of-failed-returns) adds a cumulative original-root budget and a separately scoped Lean composition core. The earlier pass is retained below; the universal coverage gap remains.

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

## Continuation: arbitrary finite chains of failed returns

### 0. Decision brief

**New scoped result:** an arbitrary finite sequence of expanding one-halving
and two-halving returns can be followed by certified descent below the
unchanged original root. A common shifted envelope keeps all accumulated
expansion in the calculation. This extends the earlier single postspell
family, but still requires an explicit final budget. It is not an all-root
coverage theorem or a proof of Collatz.

The generic arbitrary-list composition and conditional descent core is
Lean-checked. The concrete parity-family, uniform block bound, CRT construction
and ancestor-cancellation arguments below are prose proofs with exact Python
regressions. They do not inherit end-to-end Lean status. This is a draft
continuation for review; canonical accepted claim grades and publication pins
have not been promoted by this pass.

Read the [checker](verification/multi_excursion_budget_check.py),
[deterministic results](verification/multi_excursion_budget_2026-09-05.json),
[trusted statements](lean/CollatzWork/ExcursionBudgetStatement.lean),
[formal core](lean/CollatzWork/ExcursionBudget.lean),
[formal receipt](verification/multi_excursion_formal_receipt_2026-09-05.json), and
[CI regression test](tests/test_multi_excursion_budget.py).

### 1. Abstract

For any finite list of parameters J_i>=2, h_i>=3 and tails EE or EO, we
construct infinitely many positive roots in r=22619+186624s that follow the
chosen expanding returns and then descend through a sufficiently long final
even run. A strict affine bound after adding 3 composes over the complete
list. An exact integer half-margin condition makes the final comparison with
r explicit. Two inverse-selector identities explain why a large ternary
valuation at a failed return does not by itself solve the original-root
obligation.

### 2. Definitions and delta

Use the same forward shortcut map and chronological O/E convention as above.
Write P_J=(OOEO)^J and let B_{J,h,0}=P_J O^h EE and
B_{J,h,1}=P_J O^h EO. All J>=2 and h>=3. Each B has length 4J+h+2;
the second tail contains one additional odd step. For an actual concatenation,
the following block starts odd. Thus the EE choice has exactly two halvings,
whereas EO has exactly one halving followed by an odd step.

The prior result handled one growing spell and odd run followed by repayment.
The present result allows any finite number of intervening failed returns,
with independently chosen lengths and either tail at every return. These
intervening returns really expand. This is not a renamed contracting block.

### 3. Derivation method and domain

All algebra is exact. A word is used as an orbit only when its parity is
actually realized. For a formal word W, write T_W(n)=(A_W n+C_W)/D_W.
Letter-by-letter composition gives A_W=3^(number of O), D_W=2^(length),
with a nonnegative integer C_W. A formal affine expression alone does not
establish that W is the actual itinerary.

The universal calculations below prove the parameterized assertions; finite
replays test their implementation. Roots, lengths and progression parameters
are integers. No probabilistic independence assumption about parity is used.

### 4. The multi-excursion theorem and proof

#### 4.1 A common shift for both failed-return types

Put a=(27/16)^J, b=(3/2)^h and c=23/11. If a block begins at n,
its spell exit and subsequent odd-run exit are exactly

$$
x=a(n+c)-c,\qquad z=b(x+1)-1.
$$

The EE endpoint is F_0(n)=z/4. Its slope and intercept are

$$
\lambda_0=ab/4,\qquad C_0=b(23a-12)/44-1/4.
$$

The EO endpoint is F_1(n)=(3z+2)/4=3F_0(n)+1/2, so
lambda_1=3lambda_0. For both choices,

$$
F_\delta(n)+3<\lambda_\delta(n+3). \tag{1}
$$

For EE, the difference between the left side and right side is
[121-b(10a+12)]/44. The expression b(10a+12) increases separately
with J and h. At J=2,h=3 the required strict comparison is the exact
integer inequality

$$
27(10\cdot729+12\cdot256)=279774
  >247808=121\cdot8\cdot256.
$$

This proves (1) for every permitted J,h, not just sampled values. For EO,
F_1(n)+3=3(F_0(n)+3)-11/2, so the EE bound implies (1).

Both return maps have positive intercept and slope at least
19683/8192>2. Hence both endpoints exceed n. All intermediate states do
also: during OOEO they are (3n+1)/2, (9n+5)/4, (9n+5)/8 and
(27n+23)/16, each exceeding positive n; every following odd step grows;
and the last halving intermediate is larger than the already growing return.
Induction across blocks keeps every such state above the original root.

Each block takes S20 to S20. One OOEO has residues 20,17,26,13,20.
After h>=3 odd steps, z is -1 modulo27. Both z/4 and (3z+2)/4 are
20 modulo27. These are modular consequences of actual integer steps.

#### 4.2 Cumulative budget, with no reset

Choose K>=0 failed blocks B_{J_i,h_i,delta_i}, then a terminal
P_{J_f} O^(h_f) E^e. Define

$$
J=J_f+\sum_{i=1}^{K}J_i,\quad
H=h_f+\sum_{i=1}^{K}h_i,\quad Q=\sum_{i=1}^{K}\delta_i,
$$

$$
N=4J+H+2K+e,\qquad S=3J+H+Q,\qquad A=3^S,\quad D=2^N.
$$

Assume r>=3, the complete word is actual, and

$$
2A\le D. \tag{2}
$$

Then its endpoint m=T^N(r) satisfies **0<m<r**.

Proof: multiply (1) successively. After K failed blocks, the quantity
n_K+3 is bounded by the product of their slopes times r+3. For K=0
this prefix bound is equality. The terminal block has the strict unshifted
bound m<(27/16)^(J_f)(3/2)^(h_f)(n_K+3)/2^e, obtained directly
from its displayed x,z formulas. Therefore

$$
Dm<A(r+3)\le2Ar\le Dr.
$$

Since D>0, m<r. Positivity follows from actual positive shortcut steps.
Every state through the K failed blocks and through the final growing phase
exceeds r. The comparison does not substitute the much larger n_K for r.

Taking e>=J+H is a simpler sufficient rule, although often wasteful. Indeed,

$$
A/D\le(27/32)^J(3/4)^H\,3^Q/4^K
\le(27/32)^2(3/4)^3=19683/65536<1/2,
$$

because Q<=K. The checker instead chooses the least e>=1 with e=2 mod18
satisfying (2), using integer bit lengths rather than logarithmic rounding.
This is the least value meeting this sufficient budget, not a claim about
the least value causing actual descent.

#### 4.3 Infinite families for every finite schedule

Require e=2 mod18, so the terminal endpoint is again in S20: after the odd
run z=-1 mod27 and 2^e=4 mod27. Append one O to the complete word W only
to impose oddness of m, making the final even length exact. This extra
symbol is not counted in N or in the endpoint.

For completeness, each length-L parity word has exactly one realizing class
modulo2^L. Suppose a length-j prefix is represented by
(A n+C)/2^j with A odd. The two possible lifts of a realizing residue are
n and n+2^j. Their next states differ by the odd number A, so exactly one
lift has the desired next parity. This proves the assertion inductively
and gives the algorithm in `parity_residue`.

Let c_W modulo2^(N+1) be the realizing class for WO. Its first eight
symbols are (OOEO)^2 and therefore c_W=91 mod256. Write
M=2^(N+1)/256. Since 729 is odd, choose

$$
s_0\equiv\frac{c_W-22619}{256}\,729^{-1}\pmod M,
\qquad 0\le s_0<M.
$$

Then for every integer t>=0,

$$
r=22619+186624(s_0+Mt)
$$

is positive, lies in the named cylinder, and has the entire required word.
The next symbol after each failed block is O, so EE means exact valuation2;
EO means exact valuation1. The first E after each O^h makes the odd-run
length exact. Since h>=3, its starting x is7 mod8, and v2(11x+23)=2.
The identity 11H(n)+23=27(11n+23)/16 then shows that each prescribed
spell has exactly J_i growing OOEO returns, not merely at least J_i.

This proves infinitely many roots for every independently prescribed finite
schedule. It does NOT exchange the quantifiers to produce one root realizing
an infinite schedule, nor prove that every root eventually reaches (2).

### 5. Conclusion and remaining mathematical obligation

The finite-chain extension is proved under explicit parity and budget
hypotheses. The next substantive target is forced repayment or a genuinely
smaller coalescing target for an arbitrary fixed residual root. It must also
handle exits outside q2 and other halving patterns. Constructing more selected
families, increasing a fixed search horizon, or proving that a chosen finite
schedule has positive realizations cannot replace that target.

### 6. Top-down test: the ancestor shortcut cancels its own apparent gain

At a spell exit x in S20, write x+1=3*2^h*u with 3 not dividing u.
This is possible because x+1=21 mod27 has ternary valuation exactly1.
The following odd-run exit is z=3^(h+1)*u-1.

For tail EO, y=(3z+2)/4 and 4y+1=3^(h+2)*u. The existing selector
has v=h+2 and theta=2^h*u=(x+1)/3=7 mod9. Its chosen ancestor is

$$
2^h\cdot3u-1=x.
$$

It is smaller than y but larger than the original root. It unwinds the
excursion rather than solving the original induction obligation.

For EE, y=z/4 and 4y+1=3^(h+1)*u. Now theta=2^(h-1)*u=8 mod9.
The selector's corresponding expression is

$$
16(2^{h-2}\cdot9u-1)=12x-4>r.
$$

The established smaller-than-y guarantee for that selector row requires
h>=10. Below that threshold the expression must not be advertised as a
certified smaller ancestor. At or above it, being smaller than y is still
not enough: 12x-4 remains above r. These identities exclude this particular
selector shortcut, not every mixed-coalescence construction.

### 7. Bottom-up reconstruction: an exact example

Choose two failed returns with (J,h)=(2,3): first EE, then EO. Follow them
by the terminal (J_f,h_f,e)=(2,3,20). The CRT algorithm produces:

| Shortcut time | Exact state | Meaning |
|---:|---:|---|
| 0 | 6436861099638206555 | Original root r |
| 13 | 15465910281271828571 | Growing EE return |
| 26 | 111480290063332544603 | Growing EO return |
| 57 | 1021784986051067 | Terminal endpoint m<r |

Every displayed state is20 mod27. The checker verifies each actual parity,
not only these four endpoints. Here J=6,H=9,K=2,Q=1, so A=3^28,D=2^57
and the half-margin budget holds.

### 8. Middle-out synthesis and adversarial controls

The common shift3 connects the local affine formulas to a reusable global
ledger. The original-root inequality, not local return size, is the
acceptance condition. The generic formal proof permits arbitrary segments
whose shifted inequalities are supplied, while the concrete prose theorem
proves those inequalities for these two tails.

The regression retains the old 4501595 to10816031 expansion. A second control
constructs sixteen EE failed returns followed by a locally contracting
terminal block with e=20. The final endpoint is smaller than that terminal
block's starting value but still above the original root; the cumulative
budget rejects it. An initial eight-return fixture actually descended below
the root and was rejected as an unsuitable negative test. The sixteen-return
fixture is the corrected counterexample. No theorem was changed to fit it.

Other controls reject insufficient halving, an incorrect parity realization,
malformed lengths, booleans used as integers, invalid words and nonpositive
starts. The checker never uses a removable Python `assert` for acceptance.

### 9. Glossary and evidence classes

A **failed return** is one of the two explicitly expanding blocks, not a
failure of Collatz convergence. A **shifted envelope** bounds n+3 by an
explicit slope product. The **budget** is condition (2), an assumption to
verify rather than an eventuality already proved. **CRT** is the Chinese
remainder theorem construction for compatible binary and ternary residues.

The full family theorem is supported by a self-contained prose proof and
exact diagnostics. The generic list/envelope theorem has a separate Lean
proof. Neither status is external specialist review or certified novelty.

### 10. Sources and novelty boundary

The elementary affine and parity-lifting arguments are standard machinery,
not asserted as discoveries. The project-specific contribution here is the
common shift3 for these two failed tails, its arbitrary-list original-root
specialization, and the two exact selector-cancellation diagnoses.

Monks, Monks, Monks and Monks, *Strongly sufficient sets and the distribution
of arithmetic sequences in the 3x+1 graph*,
[arXiv:1204.3904v2](https://arxiv.org/abs/1204.3904v2), provides the relevant
S20 context. Its abstract explicitly states that every nontrivial cycle and
divergent orbit meets20 mod27. This does not turn the selected cylinder above
into an exhaustive sufficient set with proved convergence.

Rozier and Terracol, *Paradoxical behavior in Collatz sequences*,
[arXiv:2502.00948v5](https://arxiv.org/abs/2502.00948v5),
*Discrete Mathematics*349,115167(2026),
[doi:10.1016/j.disc.2026.115167](https://doi.org/10.1016/j.disc.2026.115167),
is context for distinguishing coefficient contraction and actual descent.
No theorem from that paper is an input to the proof above. This pass checked
these primary-source landing pages and the existing project comparisons;
it did not conduct a new systematic novelty review or reverify their full
papers. Priority remains unassessed.

### 11. Process-integrity assessment

The main snapshot was reconstructed from the supplied source archive, with
379/379 source hashes checked and the complete tree matching recovered main
`96de442e6a157740a9d8fee8873e208e1c5ec5cb`. The continuation is isolated
in draft PR23. The previous source note remains intact above this addition.
Publication metadata, accepted claim grades and earlier proof files are not
rewritten to imply a larger result.

Local checks cover396 family replays,1022 small parity-word replays,
800 independent rational closed-form comparisons and12 rejection controls.
Normal, -O and -OO outputs agree; the longest tested word has1810 steps and
the largest tested failed-return count is64. These counts describe tests,
not the range of the unbounded prose theorem.

The generic Lean source at `306da627526eaa068285e566309660e39ef19548`
passed the official pinned4.33.1 build in
[run33987249998](https://github.com/Sodelin/Collatz-Conjecture-Work/actions/runs/33987249998).
The job checked synthetic merge `17040f805f49a13e647115a6e9a04fa31c8e8304`;
a fresh GitHub comparison returned zero changed files against the branch,
establishing identical source content. The log reports37 successful build tasks and the six new declaration
axiom inventories. Composition uses `propext` and `Quot.sound`; descent and
convergence transfer additionally use `Classical.choice`. An initial full local unit-suite invocation timed out in the older
assertion-mode regression and is not counted as passed. Focused suites have
separate logs. No local Lean compiler or independent kernel replay was available. Final-head CI acceptance
belongs in the PR receipt, not in a self-referential source hash in this note.

Process verdict: internally reproducible with explicit limitations; no
external mathematical review. Clinical GRADE, AMSTAR-2 and trial RoB scores
are not suitable measures of a deductive theorem or a software build.

### 12. Inference-robustness assessment

The robust conclusion is conditional descent for every finite schedule in
the stated class. It survives varying K, every J_i and h_i, the tail sequence,
the CRT progression parameter and Python optimization. Those diagnostics
corroborate implementation; the formulas and induction carry universality.

The weak point for a global claim is not sample size or an estimated effect:
it is the missing proof that an arbitrary fixed orbit reaches a licensed
repayment condition. No probability model, meta-analysis, heterogeneity
statistic or p-value is appropriate here. The gap changes only with an
unconditional coverage/repayment theorem, a smaller-root coalescence theorem
covering the complement, or a rigorously checked counterexample. More
successful chosen schedules do not meet that threshold.

### 13. Obsidian and Zotero integration

Keep this as a continuation of the existing original-root note, related to
the postspell, ancestor-selector and failed-halving entries rather than a new
universal-proof item. Suggested tags are `collatz/root-relative`,
`method/affine-budget`, `evidence/prose-proof`, `evidence/lean-core` and
`review/external-needed`. Keep the full family and the narrower formal core
as separate claim records when review promotes them into the canonical
registry. The source bank's existing Monks and Rozier-Terracol items already
carry identifiers; reuse them rather than creating duplicate citations.
No local Zotero library was modified.

### 14. Reproduction and formal boundary

```sh
python -B verification/multi_excursion_budget_check.py
python -O -B verification/multi_excursion_budget_check.py
python -OO -B verification/multi_excursion_budget_check.py
python -B -m unittest discover -s tests -p 'test_multi_excursion_budget.py' -v
lake build
lake env lean lean/CollatzWork/ExcursionBudget.lean
```

`excursionChainEnvelope` quantifies over arbitrary finite lists of actual
shortcut-orbit segments, with each shifted envelope an explicit premise.
`excursionChain_terminal_descent` adds a terminal bound and cumulative
half-margin premise. The convergence corollary retains convergence of smaller
positive inputs. The concrete OOEO inequalities, parity/CRT realization,
exact valuation labels, selector identities and all-root coverage are NOT
made Lean theorems by importing this module.
