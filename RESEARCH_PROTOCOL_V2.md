# Research Protocol V2: adversarial, artifact-first Collatz search

**Objective:** resolve the Collatz conjecture by a complete proof **or** a complete disproof. The protocol does not assume which sign is correct.

**Current mathematical status:** unresolved. Round 6A/6B are proof-architecture results, not a resolution of Collatz.

## 1. Why this protocol exists

This project previously used independent reconstruction, counterexample search, claim ledgers, executable checks, and separate correctness/priority/usefulness/Collatz-relevance labels. Those safeguards remain mandatory.

The protocol is strengthened using two recent public examples of large-model mathematical search:

1. Anthropic's August 2026 Riemann-zeta campaign: persistent coordinator, explicit failure ledger, isolated research briefs, hostile referees, known-false control worlds, artifact handoff, and later Lean formalization.
2. OpenAI's published Cycle Double Cover prompt: diverse independent approach families, explicit route registry, theorem-strength-gap detection, BLOCKED status for equivalent-strength missing lemmas, and adversarial review throughout.

The transferable lesson is **not** “use many agents.” It is: make search branches explicit, preserve independent evidence, kill bad branches quickly, compound verified mechanisms, and leave durable artifacts.

## 2. Exact success criteria

A route succeeds only if it produces one of the following.

### PROOF certificate
A rigorous derivation of the global Collatz statement, preferably through the equivalent global-descent theorem:

> For every positive odd `n > 1`, some accelerated odd iterate is strictly smaller than `n`.

The final route must terminate at this statement or another theorem already proved equivalent to Collatz. A reduction to a new lemma of essentially the same strength is **not** progress unless the route also supplies a new mechanism for that lemma.

### DISPROOF certificate
At least one of:

- an explicit positive nontrivial periodic orbit, checked step by step;
- an explicit positive starting value together with a rigorous invariant proving its orbit never reaches `1`;
- another finite/verifiable certificate that formally implies `¬ Collatz`.

A large computation that merely fails to find descent is not a disproof.

## 3. Required branch statuses

Every approach family has exactly one primary status:

- `ACTIVE` — has a concrete next lemma/mechanism not yet killed.
- `PROVED_AUX` — produced a correct auxiliary theorem but not the resolution.
- `FORMAL_PENDING` — informal proof survives audit and is queued for Lean.
- `FORMALIZED` — trusted Lean statement compiled under the verification policy.
- `BLOCKED_EQUIVALENT` — missing lemma is essentially Collatz in disguise.
- `BLOCKED_NO_MECHANISM` — target may be useful but no concrete mechanism remains.
- `KILLED_COUNTEREXAMPLE` — a concrete counterexample refutes the route's key claim.
- `KILLED_PRIOR_ART` — route is correct but already subsumed and adds no useful new mechanism.
- `DISPROOF_CANDIDATE` — explicit candidate certificate exists, not yet independently checked.
- `PROOF_CANDIDATE` — complete candidate chain exists, not yet independently checked.

A blocked route is reopened only by a materially new invariant, construction, representation, or theorem.

## 4. Four-label claim discipline

Every substantive claim retains the Round-6A four-axis labels.

**Correctness:** `false | unresolved | plausible | high-confidence | independently-certified`

**Priority:** `prior-art | folklore-likely | exact-form-not-located | probably-new | certified-priority`

**Usefulness:** `cosmetic | expository | methodological | technically-useful | convergence-relevant`

**Collatz relevance:** `none | indirect-architecture | necessary-condition | partial-convergence | full-solution`

No label is inferred from another. In particular, correctness does not imply novelty, and Lean verification does not imply novelty.

## 5. Research brief format

Every new route or lemma gets a durable Markdown artifact containing:

1. **Target theorem**, with all quantifiers.
2. **Why it would matter**, including the exact path to global descent or disproof.
3. **Dependencies**, distinguishing proved, classical, computational, and conjectural inputs.
4. **Search object**, e.g. residue graph, rewrite interpretation, valuation inequality, cycle word.
5. **Concrete next experiment/derivation**.
6. **Kill tests** designed before accepting the result.
7. **Known-false / proves-too-much controls**.
8. **Outcome** with one primary branch status.
9. **Counterexample or repaired statement** if the original claim fails.
10. **Reopening condition** if blocked.

## 6. Independence before synthesis

For a new mathematical hinge, use at least two logically independent passes before cross-pollination when practical:

- a constructive/proof pass;
- a hostile pass whose task is to falsify it.

The hostile pass should receive the theorem statement and dependencies, not the constructive agent's narrative. It should actively search for:

- quantifier swaps;
- endpoint/floor failures;
- hidden positivity assumptions;
- valuation `>=` accidentally used as exact valuation `=`;
- asymptotic steps used as finite statements;
- circular reductions to Collatz-equivalent claims;
- computer checks being treated as universal proofs;
- accidental use of a theorem whose hypotheses already encode convergence.

## 7. Control worlds and “proves too much” tests

A convincing Collatz argument must use the special arithmetic of the positive-integer `3n+1` system somewhere. Any route that would prove convergence in obviously false neighboring systems has probably discarded the decisive structure.

Useful controls include:

- negative/signed `3x+1` dynamics with nontrivial periodic behavior;
- rational and 2-adic periodic Collatz points used in Rounds 5B/6A;
- deliberately engineered affine/rewrite systems with the same local-looking parity behavior but an explicit cycle;
- synthetic valuation words designed to maximize the proposed obstruction;
- pathological correction functions already preserved in the Round-6A counterexample ledger.

For a positive proof route, ask explicitly: **what exact line fails in the control world?**

For a disproof route, ask the dual: **what ensures the alleged invariant contains an actual positive natural orbit rather than only a 2-adic/rational ghost?**

## 8. Failure ledger is a first-class research product

Failed routes are not deleted. Record the strongest surviving statement and classify the failure:

- known theorem restated;
- equivalent to Collatz;
- finite numerical evidence only;
- nearly tautological;
- false by counterexample;
- valid but too weak;
- correct architecture, missing theorem-strength bridge;
- formalization/statement mismatch.

The failure ledger is primarily a **do-not-repeat index**. It should not become a source of consensus bias: new searches may challenge an old verdict, but must name what new mechanism justifies reopening it.

## 9. Search allocation: diversity first, then compound

Do not imitate a 60-agent count for its own sake. With a smaller tool budget:

1. keep 3–5 genuinely different mathematical families alive initially;
2. give each a precise theorem target and kill test;
3. terminate branches that hit an equivalent-strength gap without mechanism;
4. spend most subsequent effort on branches that have produced a new proved mechanism;
5. preserve one disproof lane even if the proof lanes look more promising;
6. periodically run a cold synthesis that reads the registry, not the persuasive prose of a favored branch.

The correct unit of progress is **verified theorem-strength reduction**, not number of agents or generated tokens.

## 10. GitHub is the research memory

Every substantive new method, theorem candidate, counterexample, proof sketch, checker, Lean statement, and audit verdict is committed to this repository with a descriptive commit message.

Recommended structure:

- `proof-search/` — theorem ladders, approach registry, active branches, failure ledger.
- `proof-search/lemmas/` — durable mathematical lemmas and exact proof obligations.
- `prompts/` — orchestration and hostile-audit prompts.
- `lean/` — trusted statement files, proof code, build policy, CI notes.
- `verification/` — diagnostic Python/SAT/SMT artifacts and outputs.

A file's Git commit is a public timestamp from that point forward. Mathematical status must still be written explicitly inside the artifact.

## 11. Lean policy

Lean is a verifier, not a source of truth by branding alone. Because a July 2026 AI-assisted Collatz “disproof” exposed a real Lean kernel soundness bug, this project uses a stricter pipeline; see `lean/VERIFICATION_POLICY.md`.

Core rules: current patched Lean; no `sorry`; no project axioms in a claimed unconditional resolution; no metaprogram-generated theorem declarations in the trusted path; trusted statement isolated from solution; `#print axioms`; clean rebuild; independent checker/replay where available; and human semantic comparison between the Lean theorem and the intended Collatz statement.

## 12. Stop conditions for a candidate resolution

Before calling anything a proof/disproof candidate, all must be true:

- every theorem-strength dependency is explicit;
- no dependency is merely the conjecture under a renamed definition;
- hostile counterexample search has run;
- all computational evidence is separated from deductive proof;
- a clean end-to-end proof chain exists on paper;
- the exact final theorem statement is frozen;
- Lean formalization is either complete or the result is labeled `FORMAL_PENDING`, never “verified”;
- independent specialist review is requested after internal reconstruction.

The project's default stance is neither optimism nor pessimism. It is **continue until a branch is proved, killed, or precisely blocked**.