---
schema_version: 1
id: CW-FLR-F019
type: failure
title: L11 hard-exit inheritance does not automatically renew L9-L10
status: accepted
failure_ids:
  - F019
route_ids:
  - D
  - AB
baseline: b75ffec58ae20ac26271ff7d59a71d3591467994
created: 2026-08-24
updated: 2026-08-24
tags:
  - kind/failure
  - failure/f019
aliases:
  - rooted three-way split
---

# L11 hard-exit inheritance does not automatically renew L9-L10

## Canonical target

[Failure F019 and exact local-contraction witness](../../proof-search/FAILURE_LEDGER.md#f019--l11-hard-exit-inheritance-automatically-renews-l9-l10)

## Typed links

- **related-to:** [Audited negative claim](../claims/CW-CLM-F019.md)
- **blocks-route:** [Route AB without a rooted transition](../routes/CW-RTE-AB.md)

## Cheapest false control

The exact `7, 11, 10` local-contraction witness separates minimality relative
to the immutable root from minimality relative to a later endpoint.
