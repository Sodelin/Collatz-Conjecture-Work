---
schema_version: 1
id: CW-SRC-GESER-HOFBAUER-WALDMANN-2020-SPARSE-TILING
type: source
title: "Sparse Tiling through Overlap Closures for Termination of String Rewriting"
status: provisional
baseline: "2e7eae2bb998b14e5443e6c440154130a0049467"
created: "2026-08-24"
updated: "2026-08-24"
tags: [source, provenance/codex-ai, review/human-required, topic/term-rewriting]
aliases: ["Sparse tiling", "Overlap-closure termination"]
---

# Sparse Tiling through Overlap Closures for Termination of String Rewriting

[Source index](INDEX.md)

## Citation and identifiers

Alfons Geser, Dieter Hofbauer, and Johannes Waldmann, FSCD 2020. [arXiv:2003.01696](https://arxiv.org/abs/2003.01696)

[Open Zotero item](zotero://select/library/items/VDGHQA74)

## Role in this project

Prior art for enriching local string-rewriting state by reachable tiles and overlap closures. It is a concrete alternative to merely increasing matrix dimension in YAH searches.

## Audit boundary

No sparse-tiling termination proof for the Collatz-equivalent system has been established here. Local termination and relative termination hypotheses must not be silently promoted to global termination.

## Review checklist

- [ ] Identify the exact closure construction applicable to the eleven-rule system.
- [ ] Separate reachable-language claims from unrestricted rewriting.
- [ ] Check whether existing tools already test the relevant instance.
