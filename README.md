# Collatz Conjecture Work

An AI-assisted, adversarially audited research archive about exact Collatz
arithmetic, proof-method obstructions, and reproducible verification artifacts.

> **Verdict:** the Collatz conjecture is **unresolved**. This repository contains
> no universal proof, no positive nontrivial cycle, and no rigorously divergent
> positive orbit. None of the ratings below is a probability that Collatz is
> true or false.

Accepted mathematical baseline: full Git object
`cc33bdb470da849a5eb9d63921dcd37a8f37e94d` (2026-08-24).

For a self-contained mathematician-facing review snapshot, see
[MATHEMATICIAN_HANDOFF_2026-08-25.md](MATHEMATICIAN_HANDOFF_2026-08-25.md).

## The two-minute map

The project contains three logically different kinds of statement. Keeping
them separate is the most important way to read the archive.

| Kind | What has actually been established | What has **not** been established | Start here |
|---|---|---|---|
| **Solved route-class obstruction** | Exact certificates rule out particular proposed mechanisms: two additive potential classes for the YAH rewrite system, one unrefined Mersenne inverse-word class, simple affine hard-state ranks, and cyclic-rotation-only two-pump elimination. | These results do not rule out other labels, longer memory, matrices, nonadditive orders, nonlinear ranks, parameter refinement, or Collatz itself. | [Claim registry](proof-search/CLAIM_REGISTRY.md#highest-value-external-review-targets) |
| **Collatz-equivalent reformulation** | Global descent, termination of the exact YAH system, and termination of the normalized hard-return map are each equivalent ways to state the remaining universal problem. | An equivalent reformulation is not progress unless it supplies a new well-founded mechanism. No such universal mechanism is known here. | [Hard return system](proof-search/routes/AB_hard_boundary_return_system.md) |
| **Still-open universal claim** | The exact acceptance gates are explicit and the main failed shortcuts are indexed. | No proof covers every positive integer; no disproof witness meets the positivity and replay gates. | [Public status](PUBLIC_STATUS_2026-08-24.md) and [approach registry](proof-search/APPROACH_REGISTRY.md) |

In plain language: the project has found several rigorous reasons why tempting
proof strategies fail, plus narrow identities that work on selected families.
It has not found the missing argument that controls every Collatz orbit.

## Most important review targets

These are ordered by a combination of route importance and external-review
value, not by a claim that they solve more of Collatz.

| Claim | Scoped status | Why it matters | Novelty / publication status |
|---|---|---|---|
| Fixed two-state YAH symbol/edge cancellations | Exact standard-library checker; high confidence **within the stated algebra and locality class** | Strong finite certificate killing scalar and every finite lexicographic additive order in that model | Exact match not found in a bounded primary-source audit; priority uncertified; specialist-review packet |
| Unlabeled YAH adjacent-edge cancellation | Exact checker; high confidence within canonical adjacent-pair additive potentials | Rules out another natural termination-potential class by a 13-row certificate | Exact match not found; priority uncertified; specialist-review packet |
| Round 6A quantitative beta-debt theorem | Self-contained unreviewed derivation plus diagnostic checker | Strongest conceptual theorem candidate about corrected-log rankings and rational periodic shadows | Exact formulation not found; key lift/scaling chain lacks Lean and independent specialist reconstruction |
| L13 hard-successor normalization and rank recharge | Hostile-audited exact arithmetic; hard portion not Lean-formalized | Explains precisely why the refined Mersenne route does not close under simple replay debt or affine ranks | Classical parity arithmetic plus project-specific packaging; no priority claim |
| Refined Mersenne easy child | Narrow Lean-checked coalescence theorem | Supplies a valid strong-induction edge for one child | Published in substance in earlier Collatz work; the Lean file is a verification artifact, not a novel theorem |

The complete ordinal ratings for correctness confidence, verification,
importance, novelty, and release readiness are in the
[claim registry](proof-search/CLAIM_REGISTRY.md). “Not located” never means
“proved novel.” No repository-specific claim has external specialist or peer
review, and no claim is submission-ready as a Collatz proof or disproof.

## Choose your path

### If you are a math enthusiast

1. Read the [plain-language public status](PUBLIC_STATUS_2026-08-24.md).
2. Use the [two-minute map](#the-two-minute-map) to distinguish a method
   obstruction from an equivalent reformulation.
3. Treat every finite computation as a bounded check, never as evidence for all
   integers.

### If you are reviewing the mathematics

1. [Atomic claim and evidence registry](proof-search/CLAIM_REGISTRY.md)
2. [Current route statuses](proof-search/APPROACH_REGISTRY.md)
3. [Do-not-repeat failure ledger](proof-search/FAILURE_LEDGER.md)
4. [Reproduction manifest](verification/README.md)
5. [Lean verification policy](lean/VERIFICATION_POLICY.md)
6. [Provenance and dates](PROVENANCE.md)

### If you are continuing the project

Read [CONTINUATION.md](CONTINUATION.md). The live mathematical frontier is
Round 8; older Round 6/7 files are retained as historical branches and may
contain superseded route language.

## What is formally checked

The repository contains three narrow Lean developments:

- [equal-slope inverse-word boundary](lean/CollatzWork/InverseWordBoundary.lean);
- [refined Mersenne easy-child coalescence](lean/CollatzWork/RefinedMersenneChild.lean);
- [two-pump algebraic dependency](lean/CollatzWork/Disproof/TwoPumpDependency.lean).

The first two are included in the umbrella build. The two-pump module is
compiled directly. A clean `lake build` does **not** formalize the full prose
chain, the hard-family rank claims, Round 6A, or the Collatz conjecture.
See [LEAN_TARGETS.md](LEAN_TARGETS.md) for the exact boundary.

## Reproduce the promoted checks

From the repository root:

```powershell
python -B verification\yah_2local_edge_no_go.py
python -B verification\yah_two_state_semantic_label_no_go.py
python -B verification\disproof_cycle_search.py
lake env lean lean\CollatzWork\Disproof\TwoPumpDependency.lean
lake build
```

Expected outputs, tested versions, scope limits, and retained transcripts are
listed in [verification/README.md](verification/README.md).

## Prior art and novelty discipline

The mixed-base rewrite system and its Collatz equivalence are due to Yolcu,
Aaronson, and Heule. Semantic labeling is classical term-rewriting theory.
Parity-vector, cycle-equation, and Mersenne-staircase arithmetic are also
classical. In particular, the refined Mersenne easy-child coalescence is
published in substance; it must not be advertised as a new Collatz theorem.

The strongest potentially new artifacts are the exact narrow YAH cancellation
certificates. A bounded primary-source search found no exact match, but their
priority is **not certified**. The source-by-claim audit is recorded in the
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
