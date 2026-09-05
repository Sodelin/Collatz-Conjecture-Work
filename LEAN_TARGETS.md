# Lean verification status and targets

The repository contains **thirteen Lean proof modules**. It does not
contain a Lean proof of the Collatz conjecture or of the complete prose chain.

Toolchain: Lean 4.33.1, pinned by [`lean-toolchain`](lean-toolchain).

## Existing checked modules

| Module | Exact checked scope | Not checked |
|---|---|---|
| [`lean/CollatzWork/InverseWordBoundary.lean`](lean/CollatzWork/InverseWordBoundary.lean) | Equal-slope affine comparison and the `8x+5 / 8x+4` coalescence regression. | Full L4/L5 guards, completeness, or Collatz. |
| [`lean/CollatzWork/RefinedMersenneChild.lean`](lean/CollatzWork/RefinedMersenneChild.lean) | Easy-child arithmetic, iteration identity, and coalescence for the refined Mersenne family. | Hard-child classification, successor normalization, recharge/rank obstruction, or Collatz. |
| [`lean/CollatzWork/Disproof/TwoPumpDependency.lean`](lean/CollatzWork/Disproof/TwoPumpDependency.lean) | Exact determinant-coefficient dependencies, vanishing resultant, and syzygy. | Existence or exclusion of a positive cycle. |

The umbrella [`lean/CollatzWork.lean`](lean/CollatzWork.lean) directly imports twelve
proof modules and builds thirteen including the transitive `ResidueAncestorTails`
dependency. These include the two-pump module and
[`Convergence.lean`](lean/CollatzWork/Convergence.lean). The new
[`RootDescent.lean`](lean/CollatzWork/RootDescent.lean) is scoped below.

The new convergence module proves finite-prefix and coalescence invariance,
the all-positive smaller-coalescence and direct-descent equivalences, and
strong-induction applicability of the compatible child. The
[trusted statements](lean/CollatzWork/ConvergenceStatement.lean) import no
solution proofs. The universal certificate premises remain unproved.
[Official Lean 4.33.1 CI](https://github.com/Sodelin/Collatz-Conjecture-Work/actions/runs/33965738739)
passed commit `192e62b707205ae6181212eeb25ee304f6b12c71`; its nine new
axiom reports use only `propext`, `Quot.sound`, and (where inherited from the
existing arithmetic lemma) `Classical.choice`.
The universal L15 quarter-gap theorem is now fully formalized through the
integer certificate path. The general arbitrary-block real-phase theorem,
1024-block refinement and polynomial no-go proofs retain separate status.

```powershell
lake build
lake env lean lean\CollatzWork\Disproof\TwoPumpDependency.lean
```

The 2026-08-24 replay passed. The recorded theorem dependencies are summarized
in [verification/README.md](verification/README.md). Standard Lean axioms such
as `propext`, `Quot.sound`, and, for one arithmetic theorem,
`Classical.choice` are not `sorryAx`; they still belong in the axiom footprint.

## Highest-value pending targets

### 1. Exact YAH cancellation certificates

Formalize the fixed rule table, canonical/fixed-terminal context predicates,
the 13-row unlabeled adjacent-edge cancellation, and the 8-/50-row fixed
two-state labeled cancellations. Also formalize the 11-/22-row all-positive
scalar-arctic cancellations and a proof-assistant-checkable semantics for the
ten Farkas/RUP top certificates. Preserve the narrow conclusion: these kill
specific additive scalar/finite-lex classes and the standard first
dimension-one arctic-natural full/top step, not all termination orders.

The dependency-free Python replayers are exact certificate checkers, but they
are not Lean developments. Any formal port must reconstruct the YAH
full-versus-top semantics and the equal-label lifting to the original system,
not merely verify the stored integer sums.

### 2. L13 hard successor and rank obstruction

Formalize:

1. the guarded hard-child classification through `t<=L+2` in the exact
   unrefined L4 class;
2. successor-cell normalization by `v_2(Y+1)` and the odd quotient modulo 4;
3. same-label debt decrement and cross-label recharge;
4. the exact guarded affine-rank counterexample.

Do not infer that unbounded valuation depth rules out every finite symbolic
automaton.

### 3. Hard boundary normalizer and equivalence

Formalize the decreasing boundary reducer, total normalizer, hard return map,
and both directions of its Collatz equivalence. This would verify the
reformulation; it would not prove termination of the return map.

### 4. Round 6A rational-period beta-debt chain

This remains the most important older theorem reconstruction. Isolate and prove:

1. accelerated odd-map and valuation-word semantics;
2. rational periodic point and exact positive lift;
3. endpoint valuation and same-phase scaling;
4. last-global-minimum suffix/floor inequalities;
5. the asymptotic beta-debt lower bound and explicit `w_m` limit.

The current Python checker is diagnostic and cannot replace these proofs.

### 5. L0–L12 prose chain

The actual-orbit affine identity, mechanical envelope, exact first crossing
time, and universal third/quarter gap are now checked. Formalize remaining
bounded arithmetic lemmas before importing external results. L7/L8
must expose verified-range and Rozier–Terracol statements as named hypotheses
until independently imported. L11 must retain the immutable-root limitation;
do not formalize the superseded renewal inference.

## Verification policy

Follow [`lean/VERIFICATION_POLICY.md`](lean/VERIFICATION_POLICY.md): pin the
toolchain, inspect axiom footprints, reject `sorry`/`sorryAx` and hidden global
assumptions, and keep semantic/source review separate from kernel checking.

A successful build verifies the declarations it compiles. It does not certify
novelty, public priority, omitted prose, or the Collatz conjecture.


## Completed universal arithmetic chain, third pass

| Added proof module | Exact checked result |
|---|---|
| [QuarterGap](lean/CollatzWork/QuarterGap.lean) | Actual-orbit affine identity, universal mechanical upper envelope, general certificate soundness and the small finite certificate. |
| [FirstContraction](lean/CollatzWork/FirstContraction.lean) | Exact first crossing time and universal old third-gap bound. |
| [FloorPower](lean/CollatzWork/FloorPower.lean) | Exact two-bin dyadic scaling, expressed only with integers. |
| [BlockArithmetic](lean/CollatzWork/BlockArithmetic.lean) | All twelve ordered threshold regions and the exact block upper bound. |
| [QuarterGapUniversal](lean/CollatzWork/QuarterGapUniversal.lean) | Universal actual-orbit quarter gap; normalized envelope for all `s>=16`; exact failure at 15. |

[Scope and provenance](verification/Quarter_Gap_Formal_Scope_2026-09-05.md)
record the successful 17-job build and axiom audit. No first-contraction
existence theorem or global termination premise was discharged.


## Guarded root-relative progress, PR17 continuation

[RootDescentStatement](lean/CollatzWork/RootDescentStatement.lean) fixes the quantified propositions; [RootDescent](lean/CollatzWork/RootDescent.lean) proves them. The [initial exact-head CI evidence](verification/root_descent_ci_initial_2026-09-05.txt) records all19 Lake tasks passing on the unchanged pinned Lean4.33.1 release.

| Declaration | Kernel-checked scope | Axioms |
|---|---|---|
| `rootDescentBurst` | Every k≥0,u>0: T^(3k)(8^k u−5)=9^k u−5 (natural subtraction in the zero-length case). | `propext`, `Quot.sound` |
| `rootDescent` | k,u,m>0 and 2^k m+5=9^k u imply T^(4k)(8^k u−5)=m<8^k u−5. | `propext`, `Classical.choice`, `Quot.sound` |
| `rootDescent_converges_of_smaller` | Under the same guard, a stated convergence induction hypothesis for all smaller positive starts implies convergence of this start. | `propext`, `Classical.choice`, `Quot.sound` |
| `rootDescentAncestor` | q>0 and 3^(L+1)q=4r+1 imply T^(e+L+2)(2^e(2^Lq−1))=r. No size/coverage conclusion. | `propext`, `Quot.sound` |

The [infinite CRT burst specialization](proof-search/lemmas/Root_Relative_Burst_Descent.md) and [prescribed six-row valuation21 selector](proof-search/lemmas/Residue20_Valuation_Ancestor.md) retain prose proofs plus independent exact Python checks. The stronger uniform valuation13 theorem is now fully formalized as specified below. Its individually sharper lower rows are not included in that formal statement. No universal guard, stopping existence or Collatz theorem is proved.


## Complete residue20 ancestor theorem

The [trusted public statements](lean/CollatzWork/ResidueAncestorStatement.lean), [five finite tails](lean/CollatzWork/ResidueAncestorTails.lean), and [complete proof](lean/CollatzWork/ResidueAncestor.lean) establish:

    ∀ r : Nat, 3^13 ∣ (4*r+1) →
      ∃ m b : Nat, 0<m ∧ m<r ∧ m%27=20 ∧ shortcutIter b m=r.

`residueAncestor_of_divisibility` constructs the positive unit factorization; it does not assume its existence. The proof includes all selector branches, their actual forward orbit identities, target congruences, and a uniform strict size comparison. Initial acceptance is [commit eac4dad7](verification/residue_ancestor_ci_2026-09-05.txt), with22 Lake build tasks passing on unchanged Lean4.33.1. All six new aggregate/headline axiom outputs contain only `propext` and `Quot.sound`.

The formalization covers the uniform ≥13 theorem. The exact sharper lower-row thresholds, selected-table sharpness, the new [q2 exit theorem](proof-search/lemmas/Q2_Exit_Descent.md), and [second-coordinate ancestor construction](proof-search/lemmas/Complementary_Ancestor_Cylinders.md) retain separate prose/Python scope. The guarded general two-burst theorem is now checked as specified below. No global coalescence or termination premise is discharged.

## Complete guarded two-burst descent

[TwoBurstStatement](lean/CollatzWork/TwoBurstStatement.lean) and [TwoBurst](lean/CollatzWork/TwoBurst.lean) prove, for positive k,l,u,v,m with the two explicit equalities

    9^k*u+1 = 2^(3*l+1)*v,
    2^(k+l)*m+5 = 3*9^l*v,

that the actual shortcut orbit satisfies

    T^(4*(k+l)+2)(2*8^k*u-5) = m < 2*8^k*u-5.

This verifies the complete two-growing-burst excursion and strict comparison with the unchanged original root. The convergence corollary still assumes convergence of all smaller positive inputs. Oddness of v follows from the exit guard and is not a separate coverage gain.

[Acceptance evidence](verification/two_burst_ci_2026-09-05.txt) records unchanged Lean4.33.1, exact source `8ba40e7b80afd56e3c86edbb864e969bd5121226`, and all24 Lake build tasks passing in [CI33978140043](https://github.com/Sodelin/Collatz-Conjecture-Work/actions/runs/33978140043). `twoBurst_power_margin` uses `propext`, `Quot.sound`; `twoBurstDescent` and its convergence-transfer corollary use `propext`, `Classical.choice`, `Quot.sound`. There is no `sorryAx`.

The [CRT specialization, exact valuations and padding corollary](proof-search/lemmas/Two_Burst_Recharge_Escape.md) remain prose/Python results. The theorem assumes its guards; no universal recharge-or-escape premise is proved.
