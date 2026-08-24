---
schema_version: 1
id: CW-CLM-L14-3M1-NF
type: claim
title: Three-n-minus-one trajectory normal form
status: accepted
proof_status: scoped-proved
global_effect: none
claim_ids:
  - L14-3M1-NF
route_ids:
  - AB
baseline: b75ffec58ae20ac26271ff7d59a71d3591467994
rating_c: C2
rating_v: V1
rating_i: I2
rating_n: N1
rating_r: R1
created: 2026-08-24
updated: 2026-08-24
tags:
  - kind/claim
  - route/ab
  - status/scoped-proved
aliases:
  - L14 normal form
---

# Three-n-minus-one trajectory normal form

> **Proof status:** `SCOPED-PROVED` · `C2/V1/I2/N1/R1`
>
> **Global effect:** `NONE — THE RESIDUAL ASSERTION IS COLLATZ-EQUIVALENT`

## Canonical target

[Exact theorem and hostile corrections](../../proof-search/lemmas/L14_ThreeNMinusOne_Trajectory_Normal_Form.md)

## Typed links

- **narrows:** [Route AB](../routes/CW-RTE-AB.md)
- **tested-by:** [Finite regression](../artifacts/CW-ART-L14-3M1-NF-REGRESSION.md)

## Scope guard

The universal normalizer is supported by a prose derivation. Its executable
artifact is a finite regression, not a proof. The remaining assertion on the
terminal families is Collatz-equivalent.
