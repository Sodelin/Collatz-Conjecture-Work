---
schema_version: 1
id: CW-SRC-YOLCU-AARONSON-HEULE-2023-AUTOMATED
type: source
title: "An Automated Approach to the Collatz Conjecture"
status: provisional
baseline: "2e7eae2bb998b14e5443e6c440154130a0049467"
created: "2026-08-24"
updated: "2026-08-24"
tags: [source, provenance/codex-ai, review/human-required, topic/collatz]
aliases: ["YAH 2023", "Automated Collatz rewriting"]
---

# An Automated Approach to the Collatz Conjecture

[Source index](INDEX.md)

## Citation and identifiers

Emre Yolcu, Scott Aaronson, and Marijn J. H. Heule, *Journal of Automated Reasoning* 67 (2023), article 15. [DOI](https://doi.org/10.1007/s10817-022-09658-8) · [arXiv:2105.14697](https://arxiv.org/abs/2105.14697) · [Open Zotero item](zotero://select/library/items/2CRNUQFY)

## Role in this project

Primary authority for the exact eleven-rule mixed-base string-rewriting system and the theorem that its termination is equivalent to accelerated-Collatz convergence. It defines the representation and method boundary for the YAH certificate and no-go routes.

## Audit boundary

The paper does not prove termination of the full Collatz-equivalent system. Failure of a particular interpretation search is evidence only about that certificate class, not about Collatz.

## Review checklist

- [ ] Recheck Theorem 3.17 and all rule bytes against the pinned software artifact.
- [ ] Separate published results from project-specific finite obstruction certificates.
- [ ] Record specialist review and priority findings before promotion.
