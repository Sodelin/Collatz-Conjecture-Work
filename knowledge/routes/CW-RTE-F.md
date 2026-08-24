---
schema_version: 1
id: CW-RTE-F
type: route
title: Positive divergent invariant set
status: accepted
route_status: ACTIVE_LOW_COST
route_ids:
  - F
baseline: b75ffec58ae20ac26271ff7d59a71d3591467994
created: 2026-08-24
updated: 2026-08-24
tags:
  - kind/route
  - route/f
aliases:
  - divergence disproof lane
---

# Positive divergent invariant set

> **Route status:** `ACTIVE_LOW_COST`; no positive divergent witness exists in
> the repository.

## Canonical target

[Route F positivity and invariance gates](../../proof-search/APPROACH_REGISTRY.md#f--divergence-disproof-lane)

## Typed links

- **depends-on:** [Accelerated odd map convention](../concepts/CW-CON-ACCELERATED-ODD-MAP.md)

## Reopening condition

An alleged disproof must identify an explicit positive integer, prove forward
invariance, and prove that its orbit never reaches `1`. A rational, 2-adic, or
symbolic itinerary without positive membership fails the first gate.
