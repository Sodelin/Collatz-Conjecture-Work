---
schema_version: 1
id: CW-ART-L14-3M1-NF-REGRESSION
type: artifact
title: L14 trajectory normal-form finite regression
status: accepted
artifact_kind: regression
claim_ids:
  - L14-3M1-NF
baseline: b75ffec58ae20ac26271ff7d59a71d3591467994
verification_level: V2
command: python -B verification/trajectory_normal_form_regression.py
expected: 500000 odd starts; counterfamily through s=10000; PASS
created: 2026-08-24
updated: 2026-08-24
tags:
  - kind/artifact
  - verification/bounded
aliases: []
---

# L14 trajectory normal-form finite regression

[Regression source](../../verification/trajectory_normal_form_regression.py)

## Reproduce

```text
python -B verification/trajectory_normal_form_regression.py
```

## Typed links

- **derived-from:** [L14 prose theorem](../claims/CW-CLM-L14-3M1-NF.md)

## Exact scope and omitted bridge

The script checks local identities and configured finite families. It does not
prove the universal prose theorem; consequently the claim remains `V1` even
though this bounded artifact is executable.
