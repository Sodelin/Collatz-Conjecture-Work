---
schema_version: 1
id: CW-ART-A-YAH-AN1-FULL-CHECKER
type: artifact
title: Scalar arctic full and extended cancellation checker
status: accepted
artifact_kind: checker
claim_ids:
  - A-YAH-AN1-001
  - A-YAH-2STATE-AN1-001
baseline: b75ffec58ae20ac26271ff7d59a71d3591467994
verification_level: V2
command: python -S -B verification/yah_two_state_scalar_arctic_full_no_start.py
expected: original and labeled mass 49 with zero delta; PASS
created: 2026-08-24
updated: 2026-08-24
tags:
  - kind/artifact
  - verification/executable
aliases: []
---

# Scalar arctic full and extended cancellation checker

[Checker source](../../verification/yah_two_state_scalar_arctic_full_no_start.py)

## Reproduce

```text
python -S -B verification/yah_two_state_scalar_arctic_full_no_start.py
```

## Typed links

- **derived-from:** [Original-system scoped claim](../claims/CW-CLM-A-YAH-AN1-001.md)

## Exact scope and omitted bridge

The dependency-free checker proves the coefficient-independent cancellation
for the named dimension-one full/extended class. It is not a Lean proof and
does not cover higher-dimensional or transformed interpretations.
