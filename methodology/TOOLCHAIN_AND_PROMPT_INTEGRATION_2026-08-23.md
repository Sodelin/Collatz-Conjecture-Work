# Collatz Toolchain and Prompt-Programming Integration

**Date:** 2026-08-23

## 1. Status

This file records a methodology change, not a mathematical result.

The Collatz project's mathematical status remains unresolved. Adding tools increases search, falsification, verification, literature, and provenance capability; it does not itself increase the correctness status of any theorem claim.

## 2. Connected/available research stack

The current relevant tool stack includes:

- GitHub;
- Wolfram;
- Precise Special Functions (mpmath-backed arbitrary-precision special functions);
- Python/Codex execution when available;
- Elicit;
- Consensus;
- Scholar Sidekick;
- Firecrawl;
- Zotero;
- Chat / Work modes;
- Lean through the repository/local Codex workflow when available;
- Zenodo/GitHub archival integration as an external provenance layer.

The reusable policies for these tools live in:

- `Sodelin/Proof-attack-structure/framework/PROMPT_PROGRAMMING.md`
- `Sodelin/Proof-attack-structure/framework/TOOL_AND_MODE_ROUTING.md`
- `Sodelin/Proof-attack-structure/framework/PRIOR_ART_AND_NOVELTY_PROTOCOL.md`

## 3. New verification architecture

A load-bearing mathematical claim should now be routed through progressively stronger layers when the claim warrants them.

### 3.1 Hypothesis layer

Use Chat or Work to produce an exact statement, implication path, and kill tests.

Status ceiling: `plausible`.

### 3.2 Numerical/symbolic falsification layer

Use Python, Wolfram, and/or Precise Special Functions depending on the object.

Preferred pattern for numerical or symbolic claims:

`candidate derivation -> Python/mpmath -> Wolfram -> compare -> hostile interpretation audit`

The tools should be fed the same mathematical claim through independently expressed calculations where possible. Literal duplication of one algebraic mistake across tools is not meaningful independence.

Status ceiling for a universal theorem: still not `proved` merely because all finite/symbolic checks agree.

### 3.3 Literature/prior-art layer

Use:

- Consensus for rapid scholarly mapping;
- Elicit for structured discovery/screening/extraction;
- Firecrawl for broad web, developer, grey-literature, repository, and hard-to-index searches;
- Scholar Sidekick to verify identifiers, citation metadata, corrections, and retractions;
- Zotero as the canonical source library.

Every theorem-strength novelty claim should receive a theorem fingerprint and diversified prior-art search under the shared novelty protocol.

### 3.4 Formal layer

Once an informal lemma survives hostile audit and matters to the global proof chain:

1. freeze its intended mathematical statement;
2. create the Lean statement independent of proof-internal definitions where practical;
3. use Codex/local environment to implement the proof;
4. prohibit `sorry` and theorem-strength axioms under `lean/VERIFICATION_POLICY.md`;
5. run `#print axioms` or equivalent dependency inspection;
6. clean-build from a pinned toolchain;
7. compare the Lean theorem semantically against the intended theorem;
8. preserve build/audit logs.

Formal verification raises correctness confidence. It does not establish novelty or Collatz relevance automatically.

## 4. Tool jurisdictions for this project

### Wolfram

Use for:

- exact symbolic simplification;
- recurrence/algebra checks;
- integer/divisibility identities;
- solving or reducing finite symbolic systems;
- independent evaluation of expressions derived in the proof search.

Do not use the phrase 'Wolfram proved this' unless the output is itself a complete deductive object and the claim is independently reconstructed. Wolfram is primarily an exact computational/symbolic oracle here, not the formal trusted kernel.

### Precise Special Functions

Use for arbitrary-precision numerical evaluation of supported special functions. This is more central to the Riemann project than to ordinary Collatz dynamics, but it remains a useful independent numerical service for any route that introduces gamma/zeta/special-function objects.

Do not promote high-precision agreement to a universal Collatz theorem.

### Python

Use for:

- exhaustive finite search;
- residue graph generation;
- cycle divisibility experiments;
- rank/certificate synthesis;
- adversarial counterexample search;
- independent replay of finite certificates;
- property-based testing of candidate lemmas.

Every meaningful script/output belongs under `verification/`.

### Elicit / Consensus / Firecrawl / Scholar Sidekick / Zotero

These jointly form the prior-art pipeline. No one tool certifies novelty.

For important claims, record:

- direct searches;
- structural searches;
- equivalent-form searches;
- historical terminology searches;
- adversarial 'this is probably already known' searches;
- closest prior results and logical comparison.

## 5. Chat vs Work vs Codex for Collatz

### Chat

Use as the **research steering layer**:

- choose the next theorem cell;
- design a falsification attack;
- compare route families;
- interpret a single result;
- create a compact handoff packet.

Do not use Chat history as the canonical proof state.

### Work

Use as the **research campaign layer**:

- execute multi-source prior-art sweeps;
- compare several independent routes;
- create/update research memos;
- orchestrate Wolfram/Elicit/Firecrawl/Scholar Sidekick checks;
- produce durable artifacts and continuation checkpoints.

### Codex

Use as the **executable laboratory**:

- inspect the repository directly;
- write/run Python;
- generate finite certificates;
- run Lean;
- test builds;
- write reproducible logs;
- update files only after executable evidence exists.

When Codex becomes available again, the first high-value task is not 'try to prove Collatz in Lean.' It is to formalize the smallest trusted bridge lemmas and certificate-soundness statements already named by the missing-lemma ladder.

## 6. Prompt-programming change

The project no longer treats the orchestrator prompt as a single handcrafted block of prose.

It should be regarded as a compiled rendering of a Prompt Intermediate Representation (PIR):

`P = <G, S, C, R, D, T, V, O, M, F, X>`

where:

- `G`: exact Collatz target;
- `S`: current trusted project state;
- `C`: invariants/forbidden shortcuts;
- `R`: repositories, papers, tools, data;
- `D`: missing-lemma ladder and route graph;
- `T`: tool jurisdictions;
- `V`: verification gates;
- `O`: required artifacts;
- `M`: Chat/Work/Codex routing;
- `F`: evaluation metrics for prompt/research-pass quality;
- `X`: stop/kill/block/formalize/archive transitions.

Future orchestrator prompts should be versioned against explicit eval failures rather than edited because a wording change 'feels better.'

## 7. Prompt evaluation suite for Collatz

A useful prompt benchmark should include known control tasks where the desired behavior is known in advance.

Suggested cases:

1. a true elementary Collatz identity that should be derived correctly;
2. a false valuation statement with a small counterexample;
3. a statement equivalent to Collatz disguised as a 'last lemma' that should be labeled `BLOCKED_EQUIVALENT`;
4. a large finite computation presented as if it proved the universal conjecture, which should be rejected;
5. a known prior-art theorem under altered notation, which should trigger literature search;
6. a candidate finite certificate with a checker bug, which should fail adversarial replay;
7. a correct new auxiliary lemma too weak to imply descent, which should be labeled correctly;
8. a Lean theorem whose statement is weaker than the intended English theorem, which should trigger a semantic mismatch warning;
9. a neighboring false Collatz-like system that exposes a 'proves too much' mechanism;
10. a genuinely unresolved micro-obligation where the correct output is an exact blocker, not fabricated closure.

Prompt versions should be scored on:

- mathematical correctness;
- counterexample/falsification rate;
- equivalent-gap detection;
- tool-routing accuracy;
- calibration;
- artifact quality;
- novelty overclaim rate;
- cost/latency where relevant.

## 8. Zenodo and release semantics

Zenodo is useful for **archiving a milestone release and assigning it a DOI**.

For this project, a release/DOI means:

> this exact repository snapshot was publicly deposited and made citable by this date.

It does **not** mean:

- peer reviewed;
- journal accepted;
- mathematically verified;
- novel;
- a solved Collatz conjecture.

Therefore public descriptions should say `archived`, `deposited`, `released`, or `DOI-assigned snapshot` unless there is a separate publication/review event.

The GitHub -> Zenodo workflow should be used only for meaningful milestones, not every speculative branch. Git commits already preserve fine-grained development history; Zenodo should freeze important versions.

## 9. Candidate-resolution mode switch

If any route appears to close Global Descent or produce a valid disproof certificate, immediately stop prompt optimization aimed at generating more ideas.

Switch almost all resources to:

1. independent reconstruction;
2. Python/Wolfram exact checks where applicable;
3. hostile proof audit;
4. prior-art search;
5. Lean formalization;
6. clean independent replay;
7. specialist review;
8. GitHub release only after statuses are explicit;
9. Zenodo archival after the release metadata does not overstate the claim.

The closer the project appears to a solution, the more the system should behave like an adversarial verification lab rather than a creative brainstorming engine.

## 10. Governing rule

The expanded toolchain changes the project's **ceiling of verification and search**, not the theorem's truth value.

The objective is to make every new attractive idea face more independent ways to die before it can be promoted.
