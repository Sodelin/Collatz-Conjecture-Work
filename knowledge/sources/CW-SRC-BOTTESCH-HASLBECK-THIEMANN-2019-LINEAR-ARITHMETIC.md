---
schema_version: 1
id: CW-SRC-BOTTESCH-HASLBECK-THIEMANN-2019-LINEAR-ARITHMETIC
type: source
title: "Verifying an Incremental Theory Solver for Linear Arithmetic in Isabelle/HOL"
status: provisional
baseline: "2e7eae2bb998b14e5443e6c440154130a0049467"
created: "2026-08-24"
updated: "2026-08-24"
tags: [source, provenance/codex-ai, review/human-required, topic/formalization]
aliases: ["Verified linear arithmetic solver", "Bottesch–Haslbeck–Thiemann"]
---

# Verifying an Incremental Theory Solver for Linear Arithmetic in Isabelle/HOL

[Source index](INDEX.md)

## Citation and identifiers

Ralph Bottesch, Maximilian W. Haslbeck, and René Thiemann, FroCoS 2019, LNCS 11715. [DOI](https://doi.org/10.1007/978-3-030-29007-8_13)

[Open Zotero item](zotero://select/library/items/UIWGBXCR)

## Role in this project

Formal-verification background for exact linear-arithmetic and Farkas-style certificate checking relevant to the YAH infeasibility artifacts.

## Audit boundary

This source is not Collatz-specific and does not validate the project's generated certificates. The exact checker-to-kernel translation remains its own proof obligation.

## Review checklist

- [ ] Verify the corrected first-author metadata against the publisher record.
- [ ] Identify the exact certificate semantics applicable here.
- [ ] Document which project steps remain outside the formal solver.
