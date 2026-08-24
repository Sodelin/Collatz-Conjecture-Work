---
schema_version: 1
id: CW-SRC-STERNAGEL-THIEMANN-2014-MONOTONE-ALGEBRAS
type: source
title: "Formalizing Monotone Algebras for Certification of Termination and Complexity Proofs"
status: provisional
baseline: "2e7eae2bb998b14e5443e6c440154130a0049467"
created: "2026-08-24"
updated: "2026-08-24"
tags: [source, provenance/codex-ai, review/human-required, topic/formalization]
aliases: ["Formalized monotone algebras", "Sternagel–Thiemann 2014"]
---

# Formalizing Monotone Algebras for Certification of Termination and Complexity Proofs

[Source index](INDEX.md)

## Citation and identifiers

Christian Sternagel and René Thiemann, ITP 2014. [DOI](https://doi.org/10.1007/978-3-319-08918-8_30)

[Open Zotero item](zotero://select/library/items/QNG8VAQL)

## Role in this project

Formal-methods reference for stating and certifying monotone-algebra termination arguments. It informs the distinction between replaying finite cancellations and proving an entire termination framework sound.

## Audit boundary

The project's Lean modules formalize narrow algebraic certificates, not a full YAH reachability or termination derivation. Citing a certification framework does not fill that semantic gap.

## Review checklist

- [ ] Identify reusable formal definitions and theorem assumptions.
- [ ] Compare Isabelle/HOL formalization scope with current Lean modules.
- [ ] Keep certificate replay and framework soundness separate.
