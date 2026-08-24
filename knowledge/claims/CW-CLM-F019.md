---
schema_version: 1
id: CW-CLM-F019
type: claim
title: Rooted hard-exit inheritance failure
status: accepted
proof_status: scoped-refuted
global_effect: none
claim_ids:
  - F019
route_ids:
  - D
  - AB
baseline: b75ffec58ae20ac26271ff7d59a71d3591467994
rating_c: C3
rating_v: V1
rating_i: I3
rating_n: N1
rating_r: R1
created: 2026-08-24
updated: 2026-08-24
tags:
  - kind/claim
  - failure/f019
  - status/scoped-refuted
aliases:
  - L11 inheritance no-go
---

# Rooted hard-exit inheritance failure

> **Proof status:** `SCOPED-REFUTED` · `C3/V1/I3/N1/R1`
>
> **Global effect:** `NONE`

## Canonical target

[Exact witness and corrected inference](../../proof-search/FAILURE_LEDGER.md#f019--l11-hard-exit-inheritance-automatically-renews-l9-l10)

## Typed links

- **derived-from:** [Failure record](../failures/CW-FLR-F019.md)
- **blocks-route:** [Route AB without a rooted total rank](../routes/CW-RTE-AB.md)

## Scope guard

The witness refutes automatic renewal of the named local hypotheses. It does
not refute minimal-counterexample arguments that carry the immutable root and
prove a total well-founded transition.
