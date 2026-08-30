# Shared proof-attack structure integration

**Date adopted:** 2026-08-23

**V4 control update:** 2026-08-30

The reusable proof-search methodology is maintained separately in:

`Sodelin/Proof-attack-structure`

The Collatz repository remains authoritative for Collatz mathematics,
computations, claim statuses, Lean targets, provenance, and route outcomes.

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

V4 imports the shared PIR V2 harness by a repository-qualified immutable
reference in [`COLLATZ_EGDC_PROFILE.json`](../prompts/COLLATZ_EGDC_PROFILE.json).
It also composes EGDC 0.1.0 and BCPC 0.1.0. Import namespaces are disjoint:
`pir.*` specifies the adaptive harness, `egdc.*` controls evidence eligibility
and release, `bcpc.*` allocates bounded resources, and `collatz.*` supplies
domain gates. A domain or evidence gate may be tightened but not relaxed, and
the scheduler cannot buy its way around a mandatory gate.

## Collatz-specific additions retained here

The shared framework does not replace Collatz-specific controls. In particular
this project continues to require:

- ordinary/accelerated and stopped/unstopped convention freezes;
- positive-integer versus rational/2-adic ghost distinction;
- signed/negative Collatz “proves too much” controls;
- exact valuation versus lower-bound audits;
- floor/endpoint, integrality, positivity, and lift-direction checks;
- strong-induction semantics for residue/coalescence certificates;
- general finite-to-universal soundness and exact source coverage;
- explicit proof **and** disproof lanes;
- hardened Lean trust and semantic checks before any claimed resolution;
- exact status facets, digest-bound verdicts, and human-only release.

## V4 phase and outcome contract

The Collatz adapter uses:

`PROVISIONAL_FRAME -> ORIENT -> REFREEZE -> DISCOVER -> ATTACK -> REPLICATE -> VERIFY_ASSESS -> EXPLAIN -> RELEASE`.

Primary outcomes are `POSITIVE_SUPPORTED`, `NEGATIVE_SUPPORTED`, `PARTIAL`,
`UNRESOLVED`, `MALFORMED`, or `OUT_OF_SCOPE`; termination reasons are recorded
separately. Mathematical independence is only an outcome subtype relative to
a named formal theory.

Scoped verifiers do not promote truth. They issue verdicts bound to a claim
version, artifact digest, and dependency snapshot. The claims controller may
apply an allowed transition; a named human alone owns public release. Changed
dependencies taint downstream verdicts until replayed or narrowed.

## Collaboration and bank boundary

Changes to the shared methodology repository do not silently change
mathematical statuses in this repository. Any methodology change that
materially affects a Collatz route must be applied here by an explicit commit
explaining the effect on the route or claim ledger.

Likewise, the shared research bank may receive immutable source-bound snapshots
and annotations, but it does not own mutable Collatz mathematics or Lean state.
See the [research-object bank boundary](RESEARCH_OBJECT_BANK_BOUNDARY.md).

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

The immediate mathematical question is whether the unresolved residue
cylinders collapse into a bounded collection of symbolic transition types
rather than proliferating indefinitely.

## Connections

- **Applied by:** [Collatz Orchestrator V4](../prompts/COLLATZ_ORCHESTRATOR_V4.md)
- **Prior art:** [AI-assisted discovery-control source synthesis](AI_ASSISTED_DISCOVERY_CONTROL_SOURCE_SYNTHESIS_2026-08-30.md)
- **Governed by:** [research-object bank boundary](RESEARCH_OBJECT_BANK_BOUNDARY.md)
- **Parallel to:** [portable note-graph standard](NOTE_GRAPH_STANDARD.md)
