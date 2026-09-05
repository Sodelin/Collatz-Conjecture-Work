---
schema_version: 1
id: CW-SRC-HERCHER-2023-NO-M-CYCLES
type: source
title: "There Are No Collatz-m-Cycles with m ≤ 91"
status: provisional
baseline: "2e7eae2bb998b14e5443e6c440154130a0049467"
created: "2026-08-24"
updated: "2026-08-24"
tags: [source, provenance/codex-ai, review/human-required, topic/collatz]
aliases: ["Hercher m-cycles", "No Collatz m-cycles through 91"]
---

# There Are No Collatz-m-Cycles with m ≤ 91

[Source index](INDEX.md)

## Citation and identifiers

Christian Hercher, *Journal of Integer Sequences* 26 (2023). [arXiv:2201.00406](https://arxiv.org/abs/2201.00406) · [Journal HTML](https://cs.uwaterloo.ca/journals/JIS/VOL26/Hercher/hercher5.html) · [Open Zotero item](zotero://select/library/items/TKGZPAMU)

## Role in this project

Strong published cycle exclusion used to benchmark and properly down-rank the repository's bounded max-`C` dynamic program.

## Audit boundary

The result excludes the stated `m`-cycle range, not all nontrivial cycles. Its final computational prerequisite and map convention must remain explicit.

## Review checklist

- [ ] Verify the definition of `m`, the bound `m ≤ 91`, and journal version.
- [ ] Compare computational assumptions and verified base range.
- [ ] Keep bounded project searches classified as diagnostics.
