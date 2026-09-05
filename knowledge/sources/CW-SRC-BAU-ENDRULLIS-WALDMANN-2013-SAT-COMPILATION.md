---
schema_version: 1
id: CW-SRC-BAU-ENDRULLIS-WALDMANN-2013-SAT-COMPILATION
type: source
title: "SAT Compilation for Termination Proofs via Semantic Labelling"
status: provisional
baseline: "2e7eae2bb998b14e5443e6c440154130a0049467"
created: "2026-08-24"
updated: "2026-08-24"
tags: [source, provenance/codex-ai, review/human-required, topic/term-rewriting]
aliases: ["SAT semantic labelling", "WST 2013 SAT compilation"]
---

# SAT Compilation for Termination Proofs via Semantic Labelling

[Source index](INDEX.md)

## Citation and identifiers

Alexander Bau, Jörg Endrullis, and Johannes Waldmann, WST 2013, 8–12. [Official PDF](https://www.imn.htwk-leipzig.de/~waldmann/WST2013/papers/paper_6.pdf)

[Open Zotero item](zotero://select/library/items/XCHB4X98)

## Role in this project

Prior art for compiling semantic-labelling and interpretation search into SAT, relevant to reproducible synthesis of finite YAH certificates.

## Audit boundary

A SAT encoding is only as strong as its formalized method class and translation. Unsatisfiability of one encoding does not imply absence of all termination proofs.

## Review checklist

- [ ] Verify proceedings metadata and page range.
- [ ] Compare its constraint language with the project's checkers.
- [ ] Require independently checkable proof output for any new search.
