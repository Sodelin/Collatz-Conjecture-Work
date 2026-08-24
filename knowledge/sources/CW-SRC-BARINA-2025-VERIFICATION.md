---
schema_version: 1
id: CW-SRC-BARINA-2025-VERIFICATION
type: source
title: "Improved Verification Limit for the Convergence of the Collatz Conjecture"
status: provisional
baseline: "2e7eae2bb998b14e5443e6c440154130a0049467"
created: "2026-08-24"
updated: "2026-08-24"
tags: [source, provenance/codex-ai, review/human-required, topic/collatz]
aliases: ["Bařina verified range", "Collatz 2^71 verification"]
---

# Improved Verification Limit for the Convergence of the Collatz Conjecture

[Source index](INDEX.md)

## Citation and identifiers

David Bařina, *The Journal of Supercomputing* 81 (2025), article 810. [DOI](https://doi.org/10.1007/s11227-025-07337-0)

[Open Zotero item](zotero://select/library/items/5SMQHT9E)

## Role in this project

Provides the conservative published convergence verification through `2^71`, used to lower-bound any hypothetical least counterexample and to combine with paradoxical-prefix exclusions.

## Audit boundary

This is a finite computational verification, not a proof for all positive integers. Repository corollaries remain conditional until the external computation and map convention are independently accepted.

## Review checklist

- [ ] Verify the exact published bound and inclusive/exclusive endpoint.
- [ ] Confirm the map convention used when importing the result.
- [ ] Record software and reproducibility provenance separately.
