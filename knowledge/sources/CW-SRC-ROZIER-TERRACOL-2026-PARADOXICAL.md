---
schema_version: 1
id: CW-SRC-ROZIER-TERRACOL-2026-PARADOXICAL
type: source
title: "Paradoxical Behavior in Collatz Sequences"
status: provisional
baseline: "2e7eae2bb998b14e5443e6c440154130a0049467"
created: "2026-08-24"
updated: "2026-08-24"
tags: [source, provenance/codex-ai, review/human-required, topic/collatz]
aliases: ["Rozier–Terracol 2026", "Paradoxical prefixes"]
---

# Paradoxical Behavior in Collatz Sequences

[Source index](INDEX.md)

## Citation and identifiers

Olivier Rozier and Claude Terracol, *Discrete Mathematics* 349 (2026), 115167. [DOI](https://doi.org/10.1016/j.disc.2026.115167) · [arXiv:2502.00948v5](https://arxiv.org/abs/2502.00948v5) · [Open Zotero item](zotero://select/library/items/DVKLL6VP)

## Role in this project

Its exact remainder bounds and exclusion of paradoxical prefix lengths are external inputs to the least-counterexample coefficient-stopping barrier.

## Audit boundary

The repository's large stopping-time barrier is conditional on this external theorem and a verified-range input. Neither input is currently proved inside Lean, and the corollary does not establish Collatz.

## Review checklist

- [ ] Verify the map convention and Theorems 2.4 and 5.3 against version 5/journal text.
- [ ] Recompute all endpoint and interval translations.
- [ ] Keep external hypotheses explicit in every derived claim.
