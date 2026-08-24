# Methodology note — what to borrow from Anthropic's August 2026 Riemann-zeta campaign

**Purpose:** extract workflow lessons for the Collatz project without copying the scale, assuming the same mathematics, or treating agent count as a magic ingredient.

## 1. Primary-source facts

Anthropic reported on 2026-08-10 that an unreleased research version of Claude was asked to “take a real stab” at the Riemann hypothesis. It did not solve RH. During the attempt it found a related unconditional result improving a long-standing lower bound for zeta zeros on the critical line from about 41.6% to about 67.2%.

The published process description says:

- two Claude Code sessions;
- about 31 million output tokens;
- an initial session trying roughly 650 ideas, all unsuccessful;
- a second effort lasting about a day and a half with about 60 subagents;
- about 2,400 shell commands and hundreds of Python scripts;
- thousands of numerical checks;
- post-result proof review, counterexample search, independent re-derivation, and a 54-paper arXiv prior-art check;
- later human mathematical review and Lean formalization.

Anthropic's longer process appendix is more important than the headline. It shows a persistent **coordinator** working from explicit artifacts and sending narrow research briefs to isolated agents. Anything theorem-like went to hostile referees who were not allowed to read one another.

## 2. The surprising part was not “believe harder”

The human mostly sent short prompts such as “keep going.” That may have prevented premature stopping, but the coordinator itself explicitly rejected the idea that old failed routes represented a confidence problem.

A previous roughly-thousand-agent idea-mining session had left 106 candidate “survivors.” Before doing new work, the coordinator independently sorted every one into four deflating classes:

1. known theorem restated;
2. equivalent to RH;
3. finite numerical evidence consistent with RH;
4. nearly tautological.

It then used that ledger only as a **do-not-repeat list**.

For Collatz, encouragement should therefore be translated operationally as:

> continue the search after a branch dies, but do not promote a dead branch merely because the problem is hard.

Persistence is useful. Lowering evidential standards is not.

## 3. The ladder idea maps almost perfectly to our proposal

The RH coordinator explicitly answered “what would it take?” with a six-rung ladder, from mechanical barrier checking through intermediate theorem cells to RH itself, then launched all rungs at once.

The key subtlety is that the ladder was **not assumed to be a chain that must succeed**. Several rungs proved no-go/barrier statements; one high rung collapsed into RH itself; a negative result on the top rung later became the resource that generated the successful side theorem.

Our `proof-search/MISSING_LEMMA_LADDER.md` follows this pattern:

- Rung 0 freezes an exact equivalent endpoint (`GlobalDescent`).
- Rung 1 formalizes exact arithmetic and Round-6 machinery.
- Rung 2 contains genuinely different bridge architectures, not a single guessed proof.
- Rung 3 searches for finite proof/disproof certificates.
- Rung 4 proves certificate semantics in Lean.
- Rung 5 is hostile end-to-end audit.

The ladder is therefore a **search-coordinate system**, not evidence that only finitely many conceptual ideas remain.

## 4. Partition search versus open-ended search

The user's proposed partitioning strategy is valuable if the partitions are over **certificate classes or exact theorem obligations**, not over arbitrary prose ideas.

A naive partition tree has a combinatorial problem: if each node has branching factor `b` and depth `d`, the candidate count is `O(b^d)`. Worse, Collatz stopping times are unbounded, so a fixed-depth residue tree cannot be a complete proof object.

We can compress the search in two ways:

### A. Search quotient states instead of raw paths

Many residue/path prefixes induce the same affine transition behavior. Merge them into a finite symbolic state and search for a **recursive graph** rather than a tree. Back-edges are permitted only if they decrease a well-founded rank.

### B. Search certificate parameters

Instead of enumerating all mathematical statements, search finite objects such as:

- matrices/polynomials interpreting rewrite symbols;
- affine residue transitions;
- graph ranks;
- exact cycle words;
- finite invariant generators.

The general soundness theorem is proved once. Search then explores only finite data.

This is the central reason to keep Lean as a sorting/checking layer: it can reject candidate certificates quickly after a general checker theorem exists.

## 5. Briefs should constrain the target, not the mechanism

Anthropic's process appendix says the briefs were more like research memos than task tickets. They contained target, objects, inherited files, coordinator conjectures, and an outcome forecast. In both decisive runs, the successful agent found a mechanism **opposite to the coordinator's steer**.

So our briefs should specify:

- exact theorem target;
- current best reduction;
- files that contain already-proved facts;
- a sibling route not to duplicate;
- known failure modes and controls;
- what output counts as useful.

They should **not** say “use technique X and prove Y” unless testing X is itself the purpose.

## 6. Checkpoint early and externalize reasoning

The RH launch briefs required substantive work to be written to files and requested an early checkpoint. The exact infrastructure differed from ours, but the principle transfers:

- every meaningful branch gets a repo artifact before it becomes sprawling;
- code and numerical output live beside the mathematical memo;
- a dead branch leaves a concise verdict and reopening condition;
- future searches read the verdict, not 100k tokens of transcript.

GitHub gives us a durable, public, timestamped state machine for the research.

## 7. Controls are more important for Collatz than extra agents

Anthropic routinely asked an RH agent to test its claim on a world where RH is known to fail. This is a very strong anti-“proof by generic positivity” technique.

Our Collatz controls include:

- signed/negative Collatz systems with nontrivial cycles;
- rational and 2-adic periodic ghost orbits;
- affine/rewrite toy systems with identical local drift statistics but explicit cycles;
- deliberately pathological correction functions already used to kill Round-6 overgeneralizations.

A proposed Collatz proof must answer:

> Which exact line uses special arithmetic of positive integers under `3n+1`, and why does that line fail in the control system?

A proposed disproof must answer:

> Where is the genuine positive natural orbit, rather than a rational/2-adic shadow?

## 8. “Compound what works rather than scatter”

When the human later said “keep going,” the RH coordinator added only a few fronts designed to compound the mechanism that had survived, rather than returning to indiscriminate brainstorming.

Our budget rule is therefore:

1. Broad exploration until a route produces a genuinely new exact mechanism.
2. Once one does, allocate more search to local improvements, independent re-derivation, and adjacent certificate classes.
3. Preserve one or two orthogonal lanes so a seductive route does not monopolize the search.
4. Kill duplicate restatements quickly.

This is a better approximation to a 60-agent campaign than trying to simulate 60 personas sequentially.

## 9. What community discussion adds

Recent community reactions to the Anthropic result emphasize two useful points:

- the workflow, not the motivational wording, is the deeper lesson;
- synthesis of previously separate literature can matter as much as invention of a wholly new framework.

Recent Collatz community posts also reinforce the need to distinguish **classification/formalization** from **resolution**. A Lean-formalized grammar of possible minimal-counterexample failure modes is useful but explicitly does not eliminate those modes. Likewise, current 2-adic architecture projects can be valuable without being convergence proofs.

For this repository that means a new classification theorem is logged as `PROVED_AUX`, not described as “almost solved” unless its exact remaining theorem-strength gap has actually shrunk.

## 10. What we deliberately do not copy

We do not have, and do not need to fake, a 60-agent simultaneous swarm.

We also do not assume that generating hundreds of ideas is intrinsically productive. The earlier RH thousand-agent ledger is evidence that broad idea mining can produce a large graveyard whose survivors are still known/equivalent/numerical/tautological.

The substitute is:

- explicit route registry;
- nonduplicate briefs;
- finite certificate search;
- fast kill tests;
- cold audits;
- persistent artifacts;
- strategic continuation after failure.

## 11. Operational template for one Collatz search cycle

A small-budget cycle can be:

1. **Route A searcher:** exact rewrite-termination certificate.
2. **Route B/D searcher:** recursive residue/coalescence or minimal-counterexample bridge.
3. **Route E/F searcher:** explicit disproof witness/invariant lane.
4. **Hostile auditor:** cold attack on any new theorem/certificate.
5. **Coordinator:** updates registry and failure ledger; compounds only surviving mechanisms.

Repeat, using GitHub commits as checkpoints.

## 12. Bottom line

The most transferable insight from the RH campaign is not “believe the open problem is solvable.” It is:

> Turn an open-ended impossible-looking target into a persistent search over explicit intermediate theorem cells and certificate classes; record failures; use hostile controls; let successful negative information reshape the next brief; and formalize only after a mechanism survives.

That is exactly how the Collatz project should proceed from Round 7 onward.
