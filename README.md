# Collatz Conjecture Work

An AI-assisted, adversarially audited research archive about exact Collatz
arithmetic, proof-method obstructions, and reproducible verification artifacts.

> **Verdict:** the Collatz conjecture is **unresolved**. This repository contains
> no universal proof, no positive nontrivial cycle, and no rigorously divergent
> positive orbit. None of the ratings below is a probability that Collatz is
> true or false.

For versioned sharing packages, Lean source downloads, and the prepared
VibeMathed submission format, start with the [publication guide](publication/README.md)
and [research releases](https://github.com/Sodelin/Collatz-Conjecture-Work/releases).
Each release announcement identifies its exact mathematical revision and current
claim boundaries. Historical archive notes below retain their original context.

Start with the [current consolidation and focused YAH review](research-review/consolidation-2026-09-05/REPORT.md). It combines all contribution heads, issue records, verification boundaries and the publication decision. The [earlier novelty review](research-review/novelty-2026-09-05/REPORT.md) remains a dated source-comparison record.

The [consolidated checkpoint](CONSOLIDATION_2026-09-05.md) incorporates all eight open research contribution heads, including the latest guarded recovery proofs. Use it for the current scope and complete source list. The [2026-08-25 mathematician handoff](MATHEMATICIAN_HANDOFF_2026-08-25.md) is preserved as a historical snapshot.

For a visual, cross-linked map of claims, routes, evidence, historical notes,
and reopening conditions, use the [research atlas](ATLAS.md). It is portable
between GitHub and Obsidian and does not duplicate the canonical status
registries.

## Research control and shared-bank boundary

[Collatz Orchestrator V4](prompts/COLLATZ_ORCHESTRATOR_V4.md) composes the PIR
V2 harness, Evidence-Gated Discovery Control 0.1.0, Bounded-Capacity Portfolio
Control 0.1.0, and non-waivable Collatz arithmetic/formalization gates. Its
[machine-readable profile](prompts/COLLATZ_EGDC_PROFILE.json) pins imports and
keeps typed outcomes separate from termination reasons.

This repository remains authoritative for mutable Collatz mathematics, route
and claim status, Lean source, verification artifacts, and corrections. The
shared research bank may receive only immutable source-bound snapshots and
annotations under the [bank boundary](methodology/RESEARCH_OBJECT_BANK_BOUNDARY.md)
and [source-side export manifest](research-objects/BANK_EXPORT_MANIFEST.json).
The [source synthesis](methodology/AI_ASSISTED_DISCOVERY_CONTROL_SOURCE_SYNTHESIS_2026-08-30.md)
records why the new controls were added and their evidence limits.

## The two-minute map

The project contains three logically different kinds of statement. Keeping
them separate is the most important way to read the archive.

| Kind | What has actually been established | What has **not** been established | Start here |
|---|---|---|---|
| **Solved route-class obstruction** | Exact certificates rule out particular proposed mechanisms: two additive potential classes and every standard first dimension-one arctic-natural step for the original YAH system, one unrefined Mersenne inverse-word class, simple affine hard-state ranks, and cyclic-rotation-only two-pump elimination. | These results do not rule out higher-dimensional interpretations, different carriers or labels, transformed/non-coefficientwise orders, nonlinear ranks, parameter refinement, or Collatz itself. | [Claim registry](proof-search/CLAIM_REGISTRY.md#highest-value-external-review-targets) |
| **Collatz-equivalent reformulation** | Global descent, termination of the exact YAH system, and termination of the normalized hard-return map are each equivalent ways to state the remaining universal problem. | An equivalent reformulation is not progress unless it supplies a new well-founded mechanism. No such universal mechanism is known here. | [Hard return system](proof-search/routes/AB_hard_boundary_return_system.md) |
| **Still-open universal claim** | The exact acceptance gates are explicit and the main failed shortcuts are indexed. | No proof covers every positive integer; no disproof witness meets the positivity and replay gates. | [Public status](PUBLIC_STATUS_2026-08-24.md) and [approach registry](proof-search/APPROACH_REGISTRY.md) |

In plain language: the project has found several rigorous reasons why tempting
proof strategies fail, plus narrow identities that work on selected families.
It has not found the missing argument that controls every Collatz orbit.

## Current contribution families

The [consolidated checkpoint](CONSOLIDATION_2026-09-05.md#what-can-now-be-shared) separates the Lean quarter-gap chain, guarded original-root and ancestor theorems, finite additive YAH certificates, scalar-arctic certificates, finite-palette obstruction, recurrence and Thue–Morse exclusion, endpoint toolkit, and stopped divergence architectures. Each keeps its exact hypothesis and formal boundary.

The [claim registry](proof-search/CLAIM_REGISTRY.md) is the complete scoped inventory. Novelty and priority remain claim-specific review questions. The obsolete Thue–Morse candidate's positive realization is now excluded; the conjecture is still unresolved.

## Choose your path

The [research atlas](ATLAS.md) is the hand-curated knowledge map. Generated
[catalog and backlink supplements](knowledge/README.md) make every Markdown
file searchable without creating a second claim or route ledger. Both views
work in GitHub and Obsidian without a plugin.

### If you are a math enthusiast

1. Read the [plain-language public status](PUBLIC_STATUS_2026-08-24.md).
2. Browse the [research atlas](ATLAS.md) to see how the ideas connect.
3. Use the [two-minute map](#the-two-minute-map) to distinguish a method
   obstruction from an equivalent reformulation.
4. Treat every finite computation as a bounded check, never as evidence for all
   integers.

### If you are reviewing the mathematics

1. [Research atlas and dependency map](ATLAS.md)
2. [Atomic claim and evidence registry](proof-search/CLAIM_REGISTRY.md)
3. [Current route statuses](proof-search/APPROACH_REGISTRY.md)
4. [Do-not-repeat failure ledger](proof-search/FAILURE_LEDGER.md)
5. [Reproduction manifest](verification/README.md)
6. [Lean verification policy](lean/VERIFICATION_POLICY.md)
7. [Provenance and dates](PROVENANCE.md)

### If you are continuing the project

Read [CONTINUATION.md](CONTINUATION.md). The current frontier is the [consolidated checkpoint](CONSOLIDATION_2026-09-05.md); dated Round 6/7/8 files retain historical context and may contain superseded route language.

Use the V4 prompt/profile for new controlled cycles. The V4 methodology changes
research control only; it does not alter any mathematical or release status.

## What is formally checked

The [Lean scope inventory](LEAN_TARGETS.md) identifies every current proof module and the three separately preserved blind derivations. The umbrella build includes YAH's fixed-algebra additive certificates, the quarter-gap chain, guarded root-relative results, prefix collisions, affine repetition, finite-palette obstruction, and the three narrow stopped-route cores.

A clean build checks those exact declarations. It does not certify all surrounding prose, unproved global coverage, novelty, or Collatz.

## Reproduce the promoted checks

From the repository root:

For optional symbolic computation and the pinned proof checker, see the
[free math tool setup](docs/MATH_TOOL_SETUP.md).

```powershell
python -B verification\trajectory_normal_form_regression.py
python -B verification\yah_2local_edge_no_go.py
python -B verification\yah_two_state_semantic_label_no_go.py
python -S -B verification\yah_two_state_scalar_arctic_full_no_start.py
python -S -B verification\yah_scalar_arctic_top\verify_top_certificates.py
python -B verification\disproof_cycle_search.py
python -S -B verification\finite_palette_obstruction.py
lake env lean lean\CollatzWork\Disproof\TwoPumpDependency.lean
lake build
```

Expected outputs, tested versions, scope limits, and retained transcripts are
listed in [verification/README.md](verification/README.md).

Repository navigation has a separate dependency-free check:

```powershell
python -B verification\check_note_graph.py
python -B knowledge\tools\build_index.py --self-test --check
```

Mathematical notation has a separate presentation check:

```powershell
python -B verification\check_markdown_math.py --self-test
```

No Obsidian community plugin is required. Open the repository root as a vault;
ordinary relative Markdown links drive GitHub navigation and Obsidian's built-in
Graph and Backlinks views. See the
[portable note-graph standard](methodology/NOTE_GRAPH_STANDARD.md) and
[portable Markdown math style](methodology/MARKDOWN_MATH_STYLE.md).

## Prior art and novelty discipline

The mixed-base rewrite system and its Collatz equivalence are due to Yolcu,
Aaronson, and Heule. Semantic labeling is classical term-rewriting theory.
Parity-vector, cycle-equation, and Mersenne-staircase arithmetic are also
classical. In particular, the refined Mersenne easy-child coalescence is
published in substance; it must not be advertised as a new Collatz theorem.

The strongest potentially new artifacts are the exact narrow YAH cancellation
certificates, including the original-system scalar-arctic dimension-one
no-first-step theorem and its fixed-label certificate. A
bounded primary-source search found no exact match, but their priority is
**not certified**. The source-by-claim audit is recorded in the
[claim registry](proof-search/CLAIM_REGISTRY.md#primary-source-novelty-audit).

## Historical archive and integrity

- [LATEST.md](LATEST.md) is the short pointer to the accepted snapshot.
- [Round 6A review note](papers/round-6a/Theorem_6A1_Public_Review_Note.md)
  remains the cleanest statement of that earlier corrected-log branch.
- [Cycle-1 closure audit](proof-search/CODEX_CYCLE_1_CLOSURE_AUDIT_2026-08-23.md)
  records the Round-7 corrections.
- Original checksum manifests are preserved under [checksums/](checksums/).

Hashes establish content identity, not mathematical truth, peer review, or an
earlier public date. See [PROVENANCE.md](PROVENANCE.md).
