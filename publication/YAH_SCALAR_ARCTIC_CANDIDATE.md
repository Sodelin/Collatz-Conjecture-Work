# YAH scalar-arctic method-obstruction candidate

**Node ID:** `Collatz-Conjecture-Work:PUBLICATION-YAH-SCALAR-ARCTIC`

**Node type:** `publication`

> **Release decision:** `HOLD`
>
> **Intended artifact:** a narrow term-rewriting method obstruction, not a
> Collatz proof or disproof. Gate values are independent and are not scored.

## Exact candidate contribution

Package the original eleven-rule and fixed global 22-rule results showing that
no first standard dimension-one arctic-natural step can start through the
audited full/extended or relative-top opportunities.

## Gate vector

| Gate | State | Exact evidence or blocker |
|---|---|---|
| Correctness | `pending` | Internal exact checkers replay; independent term-rewriting reconstruction and formal checker-soundness audit remain. |
| Priority | `pending` | A bounded search found no exact match, but priority is uncertified. |
| Dependency closure | `pending` | Formalize the compact full cancellation, then the Farkas/RUP checker semantics and exact YAH-definition bridge. |
| Reproducibility | `pass` | Both dependency-free checkers replay from the pinned mathematical baseline with stable fingerprints/certificate hashes. |
| Source integrity | `pending` | A specialist must recheck the upstream rule extraction and Lemma-3.18 opportunity mapping. |
| Attribution | `pending` | Human authorship/contribution, AI-assistance disclosure, license, and archival metadata require an owner decision. |
| Reporting | `pass` | The theorem note and registry expose the exact excluded and surviving classes and say Collatz is unresolved. |
| Review | `pending` | No external specialist or peer review has been recorded. |

No total, average, or weighted score is permitted. A failed or pending hard
gate cannot be compensated by a stronger value elsewhere.

## Formalization boundary

Draft [PR #8](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/8)
formalizes the 13-row, 8-row, and 50-row finite additive certificates. It does
**not** formalize the scalar-arctic full/top claims in this candidate. A clean
build of that PR therefore cannot clear this candidate's dependency-closure or
correctness-review gates.

## Highest-value next artifact

Formalize the compact 11-/22-rule mass-49 full cancellation first. Separately
formalize soundness of the Farkas/RUP checker before importing the larger top
payload. Preserve exact theorem names, source hashes, axiom reports, and false
controls in the verification manifest.

## Connections

- **Depends on:** [scalar-arctic theorem note](../proof-search/routes/A_yah_two_state_scalar_arctic_full_no_start.md)
- **Verified by:** [verification manifest](../verification/README.md)
- **Formalized by / pending:** [Lean target boundary](../LEAN_TARGETS.md)
- **Prior art:** [primary-source novelty audit](../proof-search/CLAIM_REGISTRY.md#primary-source-novelty-audit)
- **Parallel to:** [draft finite-obstruction formalization PR #8](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/8)
