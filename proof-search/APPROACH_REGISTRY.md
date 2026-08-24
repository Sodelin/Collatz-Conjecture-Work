# Approach registry — Round 7

Last structural update: 2026-08-23, Codex Cycle 1.

This file is the canonical index of proof/disproof families. New work should update the relevant row instead of spawning unnamed duplicate routes.

| ID | Family | Exact target | Current status | Main obstacle | Reopen / next action |
|---|---|---|---|---|---|
| A | Mixed-radix string rewriting | Well-founded interpretation proving termination of the exact Collatz-equivalent rewrite system | `ACTIVE` | Existing automated matrix-interpretation classes have not terminated the full system | Reproduce exact system; synthesize richer interpretation classes; prove certificate semantics in Lean |
| B | Recursive residue certificate graph | Finite affine/congruence graph + rank implying global descent | `ACTIVE` | Naive finite-depth covers cannot handle unbounded stopping times | Search finite graph with well-founded back-edge rank, not a tree |
| AB | Mixed-radix macro coalescence | Finite mixed-radix state grammar whose exact macros coalesce with strictly smaller starts and cover all canonical inputs | `BLOCKED_NO_MECHANISM` | Unrefined whole-family inverse words provably fail on every Mersenne cylinder; no refinement-aware graph, canonical-boundary mechanism, or rank exists yet | Reopen with a concrete parameter-refining transition and explicit well-founded rank for the hard Mersenne child |
| C | Augmented-state ranking | Computable well-founded potential on integer + finite symbolic state | `ACTIVE` | State must be rich enough to evade Round-6 periodic-shadow debt barriers without encoding the answer | Derive state variables from A/B/AB; search lexicographic/vector ranks |
| D | Minimal-counterexample valuation forcing | Contradict existence of least nonterminating odd `n_*` via exact prefix bounds | `BLOCKED_NO_MECHANISM` | Infinite coefficient stopping is untouched, and L11 hard inheritance does not renew L9-L10 at the endpoint | Reopen with a concrete rooted transition and rank covering both infinite and finite coefficient-stopping branches |
| E | Positive nontrivial cycle | Explicit finite cycle under accelerated or ordinary Collatz | `ACTIVE_LOW_COST` | Enormous existing computational/cycle exclusions; no witness known | Keep exact Diophantine/SAT witness search as low-cost lane; verify any hit immediately |
| F | Positive divergent invariant set | Explicit nonempty invariant set + proof its positive orbit never reaches 1 | `ACTIVE_LOW_COST` | 2-adic/rational ghosts need not contain a divergent positive natural orbit | Require positive membership and forward invariance as first kill test |
| G | State-only corrected-log ranking with bounded/local correction | Universal descent ranking | `BLOCKED_NO_MECHANISM` | Rounds 3–6 construct long shadows and sharp debt obstructions | Reopen only with qualitatively new correction information |
| H | Finite fixed 2-adic sensor ranking | Universal descent ranking from finitely many proximity sensors | `BLOCKED_NO_MECHANISM` | Round 5B/6A finite-center freezing; Round 6B approximation barrier | Reopen only if sensor architecture is non-frozen/nonlocal in a proved way |
| I | Uniformly convergent countable sensor expansion | Universal fast corrected-log ranking | `BLOCKED_NO_MECHANISM` | Round 6B forces nonuniform/log-scale residual stress | Reopen with explicit nonuniform tail and a decrease theorem |
| J | Pure finite computation past current bound | Proof/disproof | `BLOCKED_EQUIVALENT` as proof route | Any fixed bound leaves infinitely many cases; no witness means no disproof | Use computation only to validate certificates or import a base-case theorem |

## A — Exact mixed-radix rewrite termination

### Known foundation
Yolcu–Aaronson–Heule construct a mixed binary/ternary string rewriting system whose termination is equivalent to Collatz and an automated prover using natural/arctic matrix interpretations.

### Search object
A finite interpretation certificate assigning each rewrite symbol an object in a well-founded algebra such that every rule decreases in the required orientation.

### Kill tests
- Check every rule, not just a terminating subsystem.
- Check the interpretation is genuinely well-founded on all encoded positive integers.
- Check the encoding/decoding theorem covers the exact standard or accelerated map intended.
- Reject any certificate that uses an unproved “eventual good block” assumption.

### Why high priority
The endpoint equivalence and certificate semantics already exist in the literature. This is unusually close to a SAT/SMT-searchable finite object.

## B — Recursive residue certificate graph

### Search object
A node represents a parametric family such as

`n = 2^q x + r`

with side conditions on `x`. A certified macro-edge applies an exact sequence of Collatz steps and produces either:

- direct descent below the starting `n`; or
- another node `(q',r',x')` with a proven decrease in a separate well-founded rank.

### Key distinction
A finite **tree** would impose a bounded stopping-time depth and therefore cannot be the right target. A finite **graph with ranked recursion** can represent unbounded individual stopping times while still providing a finite proof certificate.

### Candidate ranks
- lexicographic `(bitlength x, state-rank)`;
- affine rank `u_s x+v_s` attached to graph state `s`;
- vector/matrix rank in `N^d` with lexicographic or product order;
- mixed binary/ternary digit length.

### Kill tests
- Every odd positive integer must enter some node.
- Every transition must be exact for the whole family, not tested samples.
- Back-edges must decrease a proved well-founded rank.
- No unresolved strongly connected component may remain.

## AB — Mixed-radix state grammar with strong-induction coalescence

`proof-search/routes/AB_mixed_radix_coalescence_bridge.md` proves the representation bridge: the Round-7 affine cylinder refinement is the cylinder-level affine semantics of the same binary/ternary branch arithmetic encoded by the Yolcu–Aaronson–Heule rewriting system.

### Why this is not merely a duplicate of A

Standard termination interpretations seek a well-founded orientation of primitive rewrite behavior. A Route-B coalescence certificate can tolerate temporary growth and instead prove

`T^a(N(x)) = T^b(m(x))`

for an exact uniformly smaller `m(x) < N(x)`. Strong induction then closes the family.

AB therefore searches for **finite mixed-radix macro states plus coalescence reductions**, using the published finite alphabet to compress the arithmetic while preserving the more permissive induction semantics.

### Current exact supporting results

`proof-search/lemmas/L2_Cylinder_Refinement_and_Slope_Pruning.md` proves that refining one binary cylinder bit sends endpoint slope exponent `s` to exactly one child with exponent `s` and one with exponent `s+1`. The resulting cylinder counts obey the exact binomial law `C(K-1,s-1)`.

Corrected L5 proves completeness of the one-shot whole-family inverse-word
class at each fixed cylinder: strict-slope words have depth at most `t-1`, and
the equal-slope/smaller-intercept boundary has depth exactly `t`.

`proof-search/routes/AB_mersenne_inverse_word_no_go.md` then proves an
all-depth obstruction for that complete class. For
`M_K(x)=2^K(x+1)-1`, every admissible inverse word has slope at least the
original; equality only replays the same family. Refinement sends the hard
child to `M_{K+1}`, so deeper search within the same unrefined class cannot
close the route.

### Main kill test

Any proposed successor must cover the Mersenne refinement chain, including
the finite canonical left boundary, and prove a well-founded rank. If the
needed intercept/carry information cannot be quotiented into a finite or
regular symbolic state without assuming global descent, AB remains an
architecture gap rather than a proof route.

## C — Augmented-state ranking

The Round-6 lesson is treated as a design constraint: a simple `alpha log n + R(n)` with bounded/finitely sensed correction is too weak for fixed-fraction fast descent. A viable potential may need carry/radix/residue state or a nonuniform infinite-memory surrogate.

This route should be developed mostly as the abstract semantics behind A, B, or AB rather than by guessing scalar functions blindly.

## D — Minimal counterexample / exact prefix bound

From L0, a least counterexample never falls below itself. From L1, any prefix with `2^A>3^t` gives an exact upper bound on that start. L8-L10 force an enormous first-contraction barrier and a tiny near-return defect under their stated hypotheses; L11-L12 constrain hard-exit endpoints and the valuation of a positive gap.

The Cycle-1 branch audit shows that these facts do not yet recurse. Minimality
gives future values at least `n_*`, not at least the endpoint `y=n_*+d`, and
does not prove finite coefficient stopping from `y`. The target is not another
probabilistic drift estimate. It is a total arithmetic transition theorem for
one fixed positive integer, carrying the immutable root and a well-founded
rank across local excess-decreasing edges as well as non-descending edges.

Potential cross-pollination:
- B/AB may show all bad residue families recursively reduce.
- A may encode the same mechanism as termination.
- C may supply the well-founded measure.

## E — Cycle disproof lane

For a valuation word `a_0,...,a_{m-1}` with total `A`, the periodic-point equation yields an exact rational candidate. A positive nontrivial integer cycle requires the relevant denominator/divisibility and positivity conditions plus exact valuations at every phase.

Any candidate must be checked by direct integer iteration before doing anything else.

## F — Divergence disproof lane

The first kill test is archimedean reality: does the construction contain a positive integer, or only a point in `Q_2`, `Z_2`, or `Q`? Round 5B/6A show why long positive shadows of nonpositive periodic objects are not themselves counterexamples.

## Duplicate-route rule

Before starting a new route, answer:

1. Which registry row is this?
2. What is the new mathematical mechanism?
3. What exact old blocker does it bypass?

If (2) or (3) has no answer, the route is probably a wording variant of an old branch and should not consume search budget.
