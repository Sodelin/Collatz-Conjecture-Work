# Consolidated research checkpoint — 2026-09-05

**Node ID:** `Collatz-Conjecture-Work:CONSOLIDATION-2026-09-05`

**Node type:** `map`

**Global verdict: Collatz remains unresolved.** This checkpoint integrates all eight open contribution heads identified in the repository snapshot. It preserves formal auxiliary results, analytical proofs, finite diagnostics, equivalent reformulations, method obstructions, and corrected historical proposals with their distinct scopes. Integration does not confer novelty or external review.

## Source completeness

The consolidation starts from public main `541006949cd72ae77b4d4540baa1a5584bd5ef73`. Each source below is retained in Git ancestry, so its exact original text remains reviewable even where current status has been corrected. Later work beyond these pinned heads is not silently included.

| Source | Exact incorporated head | Contribution |
|---|---|---|
| [PR #6](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/6) | `215f8e6ca0afae71f9e743ea683cc7263079f24c` | Endpoint/carry, mixed inverse words, prime renewal, historical handoff |
| [PR #8](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/8) | `f35cebae5065bb14b5cd4cd58868c6efb568b08a` | Fixed-algebra additive YAH Lean certificates |
| [PR #12](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/12) | `a2761eda28f2ad7701e57e64e8acb80a89898618` | Branching-center, finite-residue and normalized-polynomial route closures |
| [PR #13](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/13) | `479ed90d32e3bd7aeffe19f6422c9f7723e4e3e0` | Linked notebook, source cards, BibTeX and issue transcriptions |
| [PR #16](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/16) | `33922a42e86646258d227d1e19c6cf7546a2f548` | Quarter gap, convergence semantics and restricted-rank audits |
| [PR #17](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/17) | `1f627c6e87f18c491cfd23dcd2c6847b13fd8364` | Latest original-root burst descent, ancestors, clocks and guarded recovery |
| [PR #20](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/20) | `991e41b12bfe38ad1f33589a4beec0678c4f9756` | Prefix collision, affine repetition and Thue–Morse candidate exclusion |
| [PR #19](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/19) | `49721623303d76956c88db5c9906f8c7b4a586e1` | Finite-palette bounded-progress obstruction and math-tool smoke checks |

## What can now be shared

| Family | Strongest integrated scope | Important limit |
|---|---|---|
| [Quarter-gap chain](proof-search/lemmas/L15_Quarter_Gap_and_Rotation_Block_Certificate.md) | Lean checks the conditional actual-orbit quarter gap and sharp eventual mechanical-envelope threshold16. | First coefficient contraction and non-descent are hypotheses; no global termination. |
| [Original-root recovery](proof-search/lemmas/Two_Burst_Recharge_Escape.md) | Latest PR17 supplies Lean-checked guarded two-burst descent and a complete residue20 ancestor theorem. | Actual guard coverage, later re-entry and a universal rank are missing; later postspell recovery is prose with exact replay. |
| [YAH additive certificates](proof-search/routes/A_yah_finite_obstruction_formal_audit.md) | Lean checks 13-row, 8-row and 50-row finite additive obstructions for specified canonical/fixed-algebra contexts. | These are separate from the still separately checked scalar-arctic full/top statements. |
| [YAH scalar-arctic obstruction](proof-search/routes/A_yah_two_state_scalar_arctic_full_no_start.md) | Exact scalar full cancellations and Farkas/RUP top certificates exclude the stated standard dimension-one first steps. | They do not exclude matrices, other algebras/carriers, transformed relations, or all termination methods. |
| [Finite-palette obstruction](lean/CollatzWork/FinitePaletteObstruction.lean) | A fixed finite palette of bounded direct positive-time descent promises cannot cover every positive start. | Unbounded macros, ranked recursion and general coalescence remain available. |
| [Word recurrence](proof-search/disproof/TM_Prefix_Return_Exclusion_2026-09-05.md) | Prefix collisions and affine repetition have Lean modules; the full analytic recurrence theorem excludes the old fixed Thue–Morse divergent anchor. | Full odd-word/substitution bridge is prose; arbitrary divergent words and unknown cycles are not excluded. |
| [Endpoint and inverse-word toolkit](proof-search/routes/F_bounded_alphabet_endpoint_residue_gate.md) | Exact prose characterizations and finite replay expose carry/positive-realization and certificate-depth gates. | Finite prefixes may require changing seeds; they do not construct one ordinary positive infinite orbit. |
| [Stopped divergence architectures](proof-search/disproof/CODEX_BRANCHING_CENTER_HOSTILE_AUDIT_2026-08-24.md) | Three narrow Lean arithmetic/group-action cores accompany complete scoped prose audits. | The formal cores do not silently formalize every surrounding rational, polynomial or residue application. |

## Current corrections

The [old Thue–Morse anchor](proof-search/disproof/CODEX_TM_MAHLER_ANCHOR_2026-08-24.md) remains available as a historical calculation, but its proposed positive realization is now excluded by the exact newer recurrence theorem. The older L15 mixed-inverse note and newer L15 quarter-gap note are distinct results; full titles and atomic claim IDs disambiguate them.

The [failure ledger](proof-search/FAILURE_LEDGER.md) keeps branch-local number collisions distinct. The [claim registry](proof-search/CLAIM_REGISTRY.md) preserves latest PR17 formal status, including TwoBurst, alongside unique older results. Frozen verification receipts retain their own source heads and do not certify this expanded tree.

## Publication and remaining work

The [publication guide](publication/README.md) controls reproducible source/Lean exports, fresh verification and venue-format preparation. The [novelty review](research-review/novelty-2026-09-05/REPORT.md) records bounded prior-art comparisons. A venue entry must identify an intelligible eligible claim; the aggregate inventory is not itself evidence of a new solution to a previously open question.

The remaining mathematical obligations are coverage of failed guards and arbitrary roots, return/re-entry compared to the immutable original root, complete coding/semantic bridges for claims not yet fully formalized, and claim-specific novelty/source review. These are research boundaries, not hidden build failures.

## Navigation

- [Latest state](LATEST.md)
- [Research atlas](ATLAS.md)
- [Claim registry](proof-search/CLAIM_REGISTRY.md)
- [Approach registry](proof-search/APPROACH_REGISTRY.md)
- [Lean scope](LEAN_TARGETS.md)
- [Reproduction manifest](verification/README.md)
- [Provisional source notebook](knowledge/README.md)
- [Historical issue review notes](proof-search/effective-flashes/README.md)
- [Continuation instructions](CONTINUATION.md)
