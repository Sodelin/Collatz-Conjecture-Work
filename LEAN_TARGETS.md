# Lean verification status and targets

The repository contains **four narrow Lean formalizations**. It does not
contain a Lean proof of the Collatz conjecture or of the complete prose chain.

Toolchain: Lean 4.33.1, pinned by [`lean-toolchain`](lean-toolchain).

## Existing checked modules

| Module | Exact checked scope | Not checked |
|---|---|---|
| [`lean/CollatzWork/InverseWordBoundary.lean`](lean/CollatzWork/InverseWordBoundary.lean) | Equal-slope affine comparison and the `8x+5 / 8x+4` coalescence regression. | Full L4/L5 guards, completeness, or Collatz. |
| [`lean/CollatzWork/RefinedMersenneChild.lean`](lean/CollatzWork/RefinedMersenneChild.lean) | Easy-child arithmetic, iteration identity, and coalescence for the refined Mersenne family. | Hard-child classification, successor normalization, recharge/rank obstruction, or Collatz. |
| [`lean/CollatzWork/FinitePaletteObstruction.lean`](lean/CollatzWork/FinitePaletteObstruction.lean) | Arbitrary selection among finitely many eventually nondecreasing natural-valued functions cannot guarantee a strict rank decrease within a uniform finite shortcut horizon at all sufficiently large inputs. | Real-valued or polynomial corollaries, other map conventions, unrestricted ranks, or Collatz. |
| [`lean/CollatzWork/Disproof/TwoPumpDependency.lean`](lean/CollatzWork/Disproof/TwoPumpDependency.lean) | Exact determinant-coefficient dependencies, vanishing resultant, and syzygy. | Existence or exclusion of a positive cycle. |

The umbrella [`lean/CollatzWork.lean`](lean/CollatzWork.lean) imports the first
three modules. The two-pump module must also be compiled directly.

```powershell
lake build
lake env lean lean\CollatzWork\Disproof\TwoPumpDependency.lean
```

The 2026-08-24 replay passed. The recorded theorem dependencies are summarized
in [verification/README.md](verification/README.md). Standard Lean axioms such
as `propext`, `Quot.sound`, and, for some arithmetic and finite-palette theorems,
`Classical.choice` are not `sorryAx`; they still belong in the axiom footprint.

The 2026-09-05 [finite-palette note](proof-search/lemmas/Finite_Palette_Bounded_Progress_Obstruction.md)
records the blind derivation and scope. Its trusted statement is a separate
source file; the solution ends with a type comparison and three axiom reports.
The new CI workflow replays the pinned release from a SHA-256-checked archive.

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

Formalize bounded arithmetic lemmas before importing external results. L7/L8
must expose verified-range and Rozier–Terracol statements as named hypotheses
until independently imported. L11 must retain the immutable-root limitation;
do not formalize the superseded renewal inference.

## Verification policy

Follow [`lean/VERIFICATION_POLICY.md`](lean/VERIFICATION_POLICY.md): pin the
toolchain, inspect axiom footprints, reject `sorry`/`sorryAx` and hidden global
assumptions, and keep semantic/source review separate from kernel checking.

A successful build verifies the declarations it compiles. It does not certify
novelty, public priority, omitted prose, or the Collatz conjecture.
