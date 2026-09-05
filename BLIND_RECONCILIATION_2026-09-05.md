---
node_id: BLIND-RECONCILIATION-2026-09-05
node_type: verification
tags: [collatz, independent-derivation, recurrence, formalization]
---

# Independent attempt, repository comparison, and recurrence extension

The blind attempt did not prove Collatz. Comparing it with the repository did
identify a useful new direction: a quantitative prefix-return obstruction
settles the positive-integer membership question for the older Thue–Morse
anchor and excludes divergence for a larger class of fixed Thue–Morse codes.
This is a scoped result with an analytic proof, not a Collatz resolution or
a historical novelty claim.

## Frozen inputs and phase boundary

The initial derivations and Lean files were completed without consulting
the existing repository or external mathematical literature. The user then
explicitly requested repository comparison, integration, and expansion.
The [independent record](research/blind-2026-09-05/README.md) preserves that
earlier phase separately from the repository-informed results.

The comparison used these full Git objects:

| Surface | Revision |
|---|---|
| Current main | `a3d99ab909992bf72e6e2e0907cb8d50248fa1b8` |
| PR16 mathematical development | `33922a42e86646258d227d1e19c6cf7546a2f548` |
| PR17 at initial comparison | `eac4dad7ef352b38d3db163637f6ac1f846c91b7` |
| PR17 continuation incorporated before delivery | `3d706a9463b1b95ffb7bb3b9a3475771a63b3b7c` |
| Concurrent finite-palette branch inspected | `49721623303d76956c88db5c9906f8c7b4a586e1` |
| PR6 older membership-gate proposal | `215f8e6ca0afae71f9e743ea683cc7263079f24c` |

This branch is stacked on PR17 and incorporates its `3d706a9` continuation by a normal merge. It does not rewrite the parent branch or main. The concurrent finite-palette result is a different bounded-ranking obstruction and is not imported or claimed here.
Public publishing automation remains a separate development on main.

## What was duplicate and what changed

| Blind finding | Repository comparison | Action |
|---|---|---|
| Descent iff convergence | [Convergence](lean/CollatzWork/Convergence.lean) already proves the shortcut version | Archive the ordinary-map derivation; no new global criterion claim |
| Growing `(1,2)` family | [RootDescent](lean/CollatzWork/RootDescent.lean) already proves a more general OOE burst | Archive the independent proof; preserve the extra odd-endpoint guard |
| Inverse smaller-ancestor family | Specialization of [L4 inverse words](proof-search/lemmas/L4_General_Inverse_Word_Coalescence.md) | Retain as an example, not a new universal coverage mechanism |
| Fixed affine repetition budget | Generalizes the same-label calculation behind L13 | Add a generic, trusted-statement Lean module |
| Word collision / prefix return | No corresponding generic Lean module found in the inspected mathematical branch | Add actual-shortcut parity collision proofs and develop the analytic return bound |
| Thue–Morse positive membership | PR6 left its exact `1+t_i` anchor awaiting membership analysis | Prove no positive realization for that anchor, and extend to fixed nonempty binary encodings |

The exact endpoint distinction matters: the OOE shortcut burst can end even;
an exact odd `(1,2)` word requires an odd endpoint. For r≥1 the respective
seed congruences are `8^r | n+5` and `2·8^r | n+5`. These are not silently
identified in the formal or analytic arguments.

## Repository-informed theorem

The [complete recurrence proof](proof-search/disproof/TM_Prefix_Return_Exclusion_2026-09-05.md)
uses actual fully accelerated odd iterates, not an auxiliary normalized return
map. A length-`2d` valuation prefix repeated at odd time `3d`, with a distinct
starting state, requires

$$
2\cdot32^d<27^d(n_0+1).
$$

The [Lean arithmetic](lean/CollatzWork/AffineRepetition.lean) derives the
effective consequence `10d+27<27n_0`. Thus distinct-state returns of this
form have bounded d for a fixed positive seed.

Every nonerasing encoding of the binary Thue–Morse word by two fixed finite
positive valuation words has such prefix returns for unbounded d. A positive
realization must therefore return exactly to its starting value and lie on a
cycle. For the old `(1),(2)` encoding, and for fixed blocks `(1^p,3)` and
`(1^q,3)` with p,q≥3, explicit growth excludes that cycle exception. Those
families have no positive realization. No valuation-average assumption is used.

## Exact verification boundary

- [PrefixCollisionStatement](lean/CollatzWork/PrefixCollisionStatement.lean)
  and [PrefixCollision](lean/CollatzWork/PrefixCollision.lean) prove equal
  actual shortcut parity prefixes imply equal residues modulo `2^k`; distinct
  starts are at least `2^k` apart.
- [AffineRepetitionStatement](lean/CollatzWork/AffineRepetitionStatement.lean)
  and [AffineRepetition](lean/CollatzWork/AffineRepetition.lean) prove the
  coprime affine repetition budget and the conditional numerical return bound.
- Exact odd-word coding, the accelerated height estimate, and the
  Thue–Morse substitution/realizability argument are **analytic proofs**.
  The full exclusion theorem is not labeled Lean-formalized.
- The [checker](verification/blind_word_recurrence_check.py) uses explicit
  exceptions, passes normally and under `python -O`, and retains false controls.
  It checks finite arithmetic, not universal positive-integer exclusion.

The [verification record](verification/Blind_Recurrence_Verification_2026-09-05.md)
records source hashes, commands, axiom footprints, and replay limitations.
Independent agents shared model lineage and earlier context; this is internal
review, not external peer review.

## Existing completion discovered during reconciliation

At parent `eac4dad`, [ResidueAncestor](lean/CollatzWork/ResidueAncestor.lean)
already proves the complete guarded divisibility theorem, including the
refined tail construction. Earlier continuation text still named that
formalization as pending. The concurrently published `3d706a9` handoff corrected
that scope and was incorporated here. This pass does not claim the
already-completed theorem or the other branch's new recharge families as its own result.

## Next mathematical target

The new obstruction removes a concrete automatic-code disproof architecture.
It does not provide the root-relative recharge-or-escape mechanism sought by
PR17. Its newly specified `22619+186624s` cylinder remains the concrete
root-relative target in [the latest recharge handoff](RECHARGE_ESCAPE_PROGRESS_2026-09-05.md). A positive nonperiodic itinerary must avoid these sufficiently early
returns of arbitrarily long initial words. The next question is whether the
actual residual return system forces such recurrence or a different shrinking
quantity. No recurrence hypothesis is presently proved for all residual roots.

The simpler next formal target is to connect exact odd valuation words to the
checked shortcut parity-prefix theorem and formalize the substitution coding.
That would improve the verification level of the new exclusion, not its
mathematical coverage. The `425` auxiliary zero-clock loop remains outside the
actual-orbit collision theorem's assumptions.

## Connections

- **Depends on:** [canonical claims](proof-search/CLAIM_REGISTRY.md),
  [route decisions](proof-search/APPROACH_REGISTRY.md), and
  [failure ledger](proof-search/FAILURE_LEDGER.md).
- **Strengthens / specializes:** [Thue–Morse prefix-return exclusion](proof-search/disproof/TM_Prefix_Return_Exclusion_2026-09-05.md).
- **Verified by:** [verification record](verification/Blind_Recurrence_Verification_2026-09-05.md).
- **Parallel to:** [root-relative progress](ROOT_RELATIVE_PROGRESS_2026-09-05.md).
- **Depends on:** [frozen independent record](research/blind-2026-09-05/README.md).
