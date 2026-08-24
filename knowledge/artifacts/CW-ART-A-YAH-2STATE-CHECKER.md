---
schema_version: 1
id: CW-ART-A-YAH-2STATE-CHECKER
type: artifact
title: Two-state semantic-label cancellation checker
status: accepted
artifact_kind: checker
claim_ids:
  - A-YAH-2STATE-001
baseline: b75ffec58ae20ac26271ff7d59a71d3591467994
verification_level: V2
command: python -B verification/yah_two_state_semantic_label_no_go.py
expected: 22 model equations; 441 contexts; 50 certificate rows; PASS
created: 2026-08-24
updated: 2026-08-24
tags:
  - kind/artifact
  - verification/executable
aliases: []
---

# Two-state semantic-label cancellation checker

[Checker source](../../verification/yah_two_state_semantic_label_no_go.py)

## Reproduce

```text
python -B verification/yah_two_state_semantic_label_no_go.py
```

## Typed links

- **derived-from:** [Scoped cancellation claim](../claims/CW-CLM-A-YAH-2STATE-001.md)

## Exact scope and omitted bridge

The checker reconstructs the fixed labeling, positive-integer cancellations,
and exact fixed-terminal support. It does not rule out other labelings,
nonadditive interpretations, or the Collatz conjecture.
