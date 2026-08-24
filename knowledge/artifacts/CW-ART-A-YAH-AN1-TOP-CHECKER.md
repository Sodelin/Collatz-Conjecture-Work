---
schema_version: 1
id: CW-ART-A-YAH-AN1-TOP-CHECKER
type: artifact
title: Scalar arctic relative-top certificate checker
status: accepted
artifact_kind: checker
claim_ids:
  - A-YAH-AN1-001
  - A-YAH-2STATE-AN1-001
baseline: b75ffec58ae20ac26271ff7d59a71d3591467994
verification_level: V2
command: python -S -B verification/yah_scalar_arctic_top/verify_top_certificates.py
expected: 491 Farkas lemmas; 426 RUP clauses; TOP_SCALAR_ARCTIC_NO_FIRST_STEP = PASS
created: 2026-08-24
updated: 2026-08-24
tags:
  - kind/artifact
  - verification/executable
aliases: []
---

# Scalar arctic relative-top certificate checker

[Checker and certificate payload](../../verification/yah_scalar_arctic_top/verify_top_certificates.py)

## Reproduce

```text
python -S -B verification/yah_scalar_arctic_top/verify_top_certificates.py
```

## Typed links

- **derived-from:** [Original-system scoped claim](../claims/CW-CLM-A-YAH-AN1-001.md)

## Exact scope and omitted bridge

The checker reconstructs the named finite Farkas/RUP certificates over the
unbounded coefficient domain. It is not a formal proof of checker soundness,
and it closes only the enumerated first-step top opportunities.
