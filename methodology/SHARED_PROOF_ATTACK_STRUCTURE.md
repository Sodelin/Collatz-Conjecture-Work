# Shared proof-attack structure integration

**Date adopted:** 2026-08-23

The reusable proof-search methodology is now maintained separately in:

`Sodelin/Proof-attack-structure`

The Collatz repository remains authoritative for Collatz mathematics, computations, claim statuses, Lean targets, provenance, and route outcomes.

## What is imported methodologically

The Collatz project adopts the shared framework's requirements for:

- canonical endpoint freezing;
- explicit gap graphs / missing-lemma ladders;
- nonduplicate mechanism registries;
- artifact-first research passes;
- counterexample-first testing;
- conjecture-equivalence / circularity checks;
- hostile reconstruction of load-bearing hinges;
- finite-certificate semantics when available;
- durable failure/no-go ledgers;
- strict separation of mathematical, novelty, relevance, and formal-verification status;
- Git-based provenance and continuation checkpoints;
- portable note graphs with stable IDs, typed relative links, maps of content,
  and automated orphan/broken-link checks;
- candidate-resolution promotion gates.

## Collatz-specific additions retained here

The shared framework does not replace Collatz-specific controls. In particular this project continues to require:

- positive-integer versus rational/2-adic ghost distinction;
- signed/negative Collatz “proves too much” controls;
- exact valuation versus lower-bound audits;
- floor/endpoint checks in beta-log statements;
- strong-induction semantics for residue/coalescence certificates;
- explicit proof **and** disproof lanes;
- hardened Lean trust checks before any claimed resolution.

## Collaboration boundary

Changes to the shared methodology repository do not silently change mathematical statuses in this repository. Any methodology change that materially affects a Collatz route must be applied here by an explicit commit explaining the effect on the route or claim ledger.

## Current active search

Round 8 closes with exact route-class obstructions and two
Collatz-equivalent normalizers, but no universal certificate. Any later search
must begin from the [research atlas](../ATLAS.md), current registries, and exact
reopening conditions rather than the older Round-7 frontier.

The Collatz-local implementation of the shared knowledge-graph convention is
the [portable note-graph standard](NOTE_GRAPH_STANDARD.md). A generic version
may be upstreamed to `Sodelin/Proof-attack-structure`; doing so does not alter
any Collatz claim status.

The remaining broad certificate families are:

1. recursive affine residue/coalescence graphs;
2. exact mixed binary/ternary rewrite termination certificates;
3. the possibility that these are two representations of a common finite-state induction structure;
4. Lean soundness theorems for whichever certificate language survives.

The immediate mathematical question is whether the unresolved residue cylinders collapse into a bounded collection of symbolic transition types rather than proliferating indefinitely.
