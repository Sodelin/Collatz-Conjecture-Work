---
schema_version: 1
id: CW-REL-YAH-SCALAR-ARCTIC
type: release
title: YAH scalar-arctic method-obstruction candidate
status: provisional
release_status: hold
baseline: b75ffec58ae20ac26271ff7d59a71d3591467994
gate_correctness: pending
gate_priority: pending
gate_dependency_closure: pending
gate_reproducibility: pass
gate_source_integrity: pending
gate_attribution: pending
gate_reporting: pass
gate_review: pending
created: 2026-08-24
updated: 2026-08-24
tags:
  - kind/release
  - candidate/method-obstruction
aliases:
  - scalar arctic publication packet
---

# YAH scalar-arctic method-obstruction candidate

> **Release decision:** `HOLD`
>
> **Intended artifact:** a narrow term-rewriting method obstruction, not a
> Collatz proof or disproof. Gate values are independent and are not scored.

## Exact candidate contribution

Package the original eleven-rule and fixed global 22-rule results showing that
no first standard dimension-one arctic-natural step can start through the
audited full/extended or relative-top opportunities.

## Typed links

- **depends-on:** [Original-system claim](../claims/CW-CLM-A-YAH-AN1-001.md)
- **depends-on:** [Fixed-label claim](../claims/CW-CLM-A-YAH-2STATE-AN1-001.md)
- **depends-on:** [Full certificate checker](../artifacts/CW-ART-A-YAH-AN1-FULL-CHECKER.md)
- **depends-on:** [Top certificate checker](../artifacts/CW-ART-A-YAH-AN1-TOP-CHECKER.md)

## Gate vector

| Gate | State | Exact evidence or blocker |
|---|---|---|
| Correctness | `pending` | Internal exact checkers replay; independent term-rewriting reconstruction and formal checker-soundness audit remain. |
| Priority | `pending` | Bounded search found no exact match, but priority is uncertified. |
| Dependency closure | `pending` | Formalize the compact full cancellation, then the Farkas/RUP checker semantics and exact YAH-definition bridge. |
| Reproducibility | `pass` | Both dependency-free checkers replay from the pinned baseline with stable fingerprints/certificate hashes. |
| Source integrity | `pending` | A specialist must recheck the upstream rule extraction and Lemma-3.18 opportunity mapping. |
| Attribution | `pending` | Human authorship/contribution, AI-assistance disclosure, license, and archival metadata require an owner decision. |
| Reporting | `pass` | Current theorem note and registry expose the exact excluded and surviving classes and say Collatz is unresolved. |
| Review | `pending` | No external specialist or peer review has been recorded. |

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
