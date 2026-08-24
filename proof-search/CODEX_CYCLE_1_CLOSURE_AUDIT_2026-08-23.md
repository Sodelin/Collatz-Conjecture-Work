# Codex Cycle 1 — Round-7 closure and hostile audit

**Date:** 2026-08-23
**Verdict:** the Collatz conjecture remains open in this project
**Mode:** cold reconstruction, hostile theorem/code audit, exact computation, and Route-AB certificate-class analysis

## 1. Full target

The frozen endpoint remains L0 global descent: for every positive odd `n>1`, some later odd Collatz iterate is strictly smaller than `n`.  By strong induction this is equivalent to the ordinary Collatz conjecture.

This cycle first attempted to assemble the complete argument from L8-L11 and Route AB.  It did not find a proof or disproof.  The attempt did, however, expose one concrete error in L5, one overstatement in the handoff's recursion language, one all-depth certificate-class obstruction, and one new exact valuation transition.

## 2. External-source reconstruction

The two external inputs supporting L8 were checked against their primary sources.

- Barina's 2025 paper states convergence verification through `2^71` for the same once-accelerated map used here: <https://doi.org/10.1007/s11227-025-07337-0>.
- Rozier-Terracol Corollary 4.4 gives, for a paradoxical length-`j` prefix with `j>=2`, the harmonic-mean bound
  \[
  h\le \frac{1}{2^{j/\lfloor(\log 2/\log 3)j\rfloor}-3}.
  \]
  <https://arxiv.org/abs/2502.00948> (v5, 2026-05-17; journal reference *Discrete Mathematics* 349, 115167).
- The same paper's Theorem 5.3 states that no paradoxical sequence has length `93<=j<=301,993`, matching the older L7 integration.
- Yolcu-Aaronson-Heule's mixed-radix rewrite system is an exact Collatz-equivalent representation, but their work does not terminate the full system: <https://doi.org/10.1007/s10817-022-09658-8>.

No source mismatch invalidating L8 was found.  L8 remains conditional on the external mathematical/computational inputs and on the committed exact Farey certificate.

## 3. Reconstructed dependency and branch graph

Assume Collatz is false and let `n_*` be a least positive counterexample.  Then every iterate is at least `n_*`.

```text
least counterexample n_*
        |
        +-- coefficient stopping time tau = infinity
        |       no L9-L12 first-contraction state exists
        |
        `-- tau < infinity
                |
                +-- L8 (conditional): tau >= 114,208,327,604
                +-- L9: first-crossing mechanical envelope
                +-- L10: y = n_* + d, 0 <= d < s/3, linked residues
                        |
                        +-- s >= n_*: L11 does not apply
                        |
                        `-- s < n_*: L11 gives hard exit at n_* and y
                                      |
                                      +-- d = 0: exact positive-cycle branch
                                      `-- d > 0: L12 gap-valuation transition
```

At the first L8 denominator `J`, `s<n_*` is automatic.  It is not automatic for an arbitrary later first contraction.

## 4. First fatal closure issue: L11 is not a renewal theorem

L11 proves that

\[
y=T^\tau(n_*)=n_*+d
\]

inherits the L6 hard-exit congruence when `s<n_*`.  It does not prove that L9-L10 can be restarted at `y`.

If `tau_y` denotes the coefficient stopping time measured from `y`, a restart requires both

\[
\tau_y<\infty
\]

and, to obtain another nonnegative L10 defect relative to `y`,

\[
T^{\tau_y}(y)\ge y.
\]

Minimality supplies only

\[
T^k(y)\ge n_*,
\]

not `T^k(y)>=y`, and it does not imply `tau_y<infinity`.  A local contraction landing in `[n_*,y)` decreases the excess above the immutable minimum but is not a contradiction.

Therefore the handoff phrase "recursive sequence of first-contraction / near-return states" is an architecture target, not a proved consequence of L11.  A genuine renewal theorem must carry the immutable root `n_*`, prove local coefficient-stopping finiteness or handle its failure, and provide a well-founded rank for excess-decreasing transitions.

## 5. Hostile correction: L5 omitted equal-slope reductions

The first L5 theorem claimed that eventual affine smallness requires inverse-family leading coefficient `A_w<2^K`.  This is false when `A_w=2^K` but the inverse-family intercept is smaller.

The exact witness is

\[
N(x)=8x+5,
\qquad
T^3(N(x))=3x+2,
\]

and the inverse word `OEE` gives

\[
m(x)=8x+4,
\qquad
T^3(m(x))=3x+2.
\]

Thus `0<m(x)<N(x)` for every `x>=0`, although both affine families have leading coefficient `8`.

This error did **not** make previously found strict-slope certificates unsound.  It made the claimed exhaustive certificate class incomplete and made the old depth bound `|w|<=t-1` false as a bound for all eventual affine reductions.

The corrected classification is exact:

- strict-slope winners have `e<t-s` and `|w|<=t-1`;
- equal-slope candidates occur exactly when `r=s` and `e=t-s`, hence `|w|=t`, and win exactly when their intercept is below `R`.

The corrected global class bound is therefore `|w|<=t`, and the classifier must search `e<=t-s`, not `e<t-s`.

## 6. Route-AB all-depth no-go on the persistent Mersenne family

For

\[
M_K(x)=2^K(x+1)-1,
\]

every uniform forward state is

\[
T^t(M_K(x))=2^{K-t}3^t(x+1)-1,
\qquad 0\le t\le K.
\]

An arbitrary uniformly admissible inverse word with `e` even inverses and `r` odd inverses has leading-coefficient ratio

\[
\frac{A_w}{2^K}
=2^e\left(\frac32\right)^{t-r}\ge1,
\]

because uniform admissibility forces `r<=t`.  Equality forces `e=0`, `r=t`, and hence `w=O^t`, which reconstructs `M_K` exactly with the same intercept.

Consequently no word in the full unrefined L4/L5 class can reduce any Mersenne cylinder, at any inverse depth.  This converts a persistent numerical miss into a symbolic certificate-class no-go.  The exact refinement

\[
M_K(2y+1)=M_{K+1}(y)
\]

shows why Route AB now needs parameter refinement plus an explicit positive-boundary rank; searching the same unrefined inverse-word class deeper cannot help.

See `proof-search/routes/AB_mersenne_inverse_word_no_go.md`.

## 7. New surviving theorem: hard-gap valuation transition

When `d>0` and both `n` and `n+d` are L6 hard-exit states, put

\[
q=v_2(n+1),\qquad q'=v_2(n+d+1),\qquad e=v_2(d).
\]

Elementary 2-adic subtraction proves

\[
q\ne q'\Longrightarrow e=\min(q,q'),
\]

whereas

\[
q=q'\Longrightarrow e\ge q+2.
\]

The exact odd part of `d` modulo four is also fixed in both unequal-valuation directions.  At the first Farey frontier, L10 gives `d<=24,019,143,996<2^35`.  Therefore a positive-gap survivor has

- `min(q,q')<=34` when `q!=q'`;
- `q=q'<=32` when the valuations agree.

This is stronger than L11's `4|d`, but it is still only a necessary-condition layer.  It does not provide renewal, global coverage, or a rank.  The `d=0` exact-cycle branch remains separate.

See `proof-search/lemmas/L12_Hard_Exit_Gap_Valuation_Transition.md`.

## 8. Exact remaining obstructions for the active synthesis

A proof completed through the current L8-L12 plus Route-AB synthesis would
still have to close all of the following branches.  A genuinely different
proof architecture need not pass through this decomposition.

1. **Infinite coefficient-stopping branch.** Rule out `tau(n_*)=infinity`, or absorb it into another global certificate.  This is an open coefficient-stopping/global-compatibility wall, not a finite-prefix calculation.
2. **Finite first contraction outside the L11 band.** Handle `s>=n_*`.
3. **Renewal/rank.** For `s<n_*`, turn local hard inheritance into a total transition system carrying `n_*` and a well-founded rank; L11-L12 do not do this.
4. **Cycle branch.** Exclude `d=0` at every allowed scale or cover it with an independently verified positive-cycle theorem.
5. **Route-AB finite object.** Exhibit an actual finite refinement-aware mixed-radix graph, exact guards/macros, complete coverage, and a rank.  Merely asserting that every root coalesces with a smaller integer is equivalent to global descent.

## 9. Claim-status verdict

- Full proof: **no**.
- Full disproof: **no**.
- L8-L11: algebraically reconstructed under their stated assumptions; formal and independent specialist verification still pending.
- Original L5 completeness statement: **false as written**; corrected in this cycle.
- Corrected L5: elementary proof reconstructed; its equal-slope affine
  comparison boundary and concrete witness are type-checked under pinned Lean
  4.33.1, while the full inverse-word completeness theorem remains pending.
- L12: new informal auxiliary theorem; novelty and formal verification pending.
- Mersenne no-go: exact all-depth theorem for one certificate class; broader
  Route AB is `BLOCKED_NO_MECHANISM` pending a concrete refinement-aware rank.

> The conjecture is still open in this project.  Within the active synthesis,
> the exact missing object is a total, non-circular, well-founded transition
> mechanism covering the infinite coefficient-stopping branch and every
> finite first-contraction survivor; no such mechanism or finite Route-AB
> certificate currently exists.  Other proof/disproof architectures remain
> logically possible.
