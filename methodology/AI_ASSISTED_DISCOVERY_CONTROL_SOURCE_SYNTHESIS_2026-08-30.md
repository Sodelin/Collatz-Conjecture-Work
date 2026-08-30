# AI-assisted discovery-control source synthesis

**Node ID:** `Collatz-Conjecture-Work:AI-DISCOVERY-CONTROL-SOURCES-2026-08-30`

**Node type:** `source`

**Cutoff:** 2026-08-30

**Purpose:** translate the supplied 2026 *Notices of the AMS* issues and two
auto-generated interview transcripts, plus directly relevant contemporary
primary artifacts, into bounded controls for Collatz research.

This is a methodology integration memo, not evidence for or against the
Collatz conjecture. Historical cases, interviews, program descriptions,
declarations, and preprints have different evidential roles. The controls below
remain engineering hypotheses until evaluated prospectively under matched
budgets and distribution shift.

## 1. Source classes and extraction limits

| Source class | What it may support here | What it cannot establish |
|---|---|---|
| Mathematical case history | A concrete failure mode, representation shift, or review pattern | That the same method will solve Collatz |
| Practitioner interview | Workflow hypotheses and failure anecdotes | Comparative effectiveness or a mathematical claim |
| Program description | Coordination and review mechanisms used in one setting | Causal value of those mechanisms without ablation |
| Governance declaration | Normative disclosure, responsibility, and review requirements | Mathematical correctness by endorsement |
| Empirical/preprint system report | Observed performance and limitations in its reported setting | Generalization to Collatz or causal contribution of each component |
| Generated transcript/commentary | Leads and time-stamped examples requiring verification | Current status, exact quotations, or primary-source authority |

Auto-generated transcript wording was treated as noisy. No mathematical or
historical status was imported from a transcript without a separate source
check, and rapidly changing formalization claims must be rechecked at use time.

## 2. Evidence-to-control matrix

| Source or case | Bounded observation | Collatz control adopted | Limitation retained |
|---|---|---|---|
| Landau/Fisher article, *Notices* Jan. 2026, [`noti3307`](https://doi.org/10.1090/noti3307) | A hard nonlinear problem may become tractable after lifting to a different representation, isolating a monotone quantity, decomposing good/bad terms, and transferring boundary information | Require mechanism-level representation changes and name the exact transfer lemma; keep decomposition and boundary audit explicit | Analogy supplies a search pattern, not a Collatz theorem |
| Abel/quintic history, *Notices* Jan. 2026, [`noti3264`](https://doi.org/10.1090/noti3264) | Failed proof efforts can expose a disproof route; gaps and exhaustive cases matter; short and full presentations serve different review roles | Preserve proof and disproof lanes, convert failures into explicit route objects, and require short certificate plus full record | Historical narration does not validate current agent performance |
| Four-color case, *Notices* Mar. 2026, [`noti3305`](https://doi.org/10.1090/noti3305) | An accepted-looking proof failed under counterexample; later solutions separated conceptual reduction from finite checking and ultimately supported formal replay | Separate candidate search from checker, general soundness from finite enumeration, and mathematical scope from formal scope | A famous computer-assisted proof is not evidence that a Collatz finite search has universal coverage |
| Hamkins's darts, *Notices* Mar. 2026, [`noti3315`](https://doi.org/10.1090/noti3315) | Hidden measurability/foundational assumptions and quantifier choices can change a theorem's truth | Add domain, quantifier-order, hidden-hypothesis, and countermodel audits before route promotion | The particular examples are not Collatz-specific |
| Kashiwara profile, *Notices* Mar. 2026, [`noti3306`](https://doi.org/10.1090/noti3306) | Productive work can arise from changing representation and solving a degenerate or limiting case before lifting back | Reward nonduplicate representation shifts and require an explicit lift back to the positive-natural endpoint | Degeneration-and-lift is a candidate strategy, not a completeness claim |
| PRIMES/STEP program, *Notices* Jul. 2026, [`noti3352`](https://doi.org/10.1090/noti3352) | Bounded landscapes, typed problem statements/gaps, shared artifacts, and two or three independent reviewers can make distributed work reviewable | Use route and claim registries, typed artifacts, small reviewable targets, and scoped independent reviews | Program organization is descriptive; agent-count imitation is not justified |
| Tsimerman interview, *Notices* Jul. 2026, [`noti3372`](https://doi.org/10.1090/noti3372), and supplied auto-generated transcript | Orientation, one-project contexts, clean restarts after error cascades, explicit role/background/time/output contracts, independent redoing, and Lean can shorten the path to useful work | Add provisional frame -> orient -> refreeze, dependency-and-hazard context, contamination restarts, independent reconstruction, and semantic Lean audit | Interview experience is not a controlled trial; transcript details require confirmation |
| Sarnak/AlphaZero test, *Notices* Jul. 2026, [`noti3373`](https://doi.org/10.1090/noti3373) | Precommit what would change belief; distinguish proof, disproof, unknown, and independence; distinguish formal correctness from understanding | Freeze belief-update tests and typed outcomes; treat mathematical independence only relative to a named theory; require explanation beside verification | A challenge design does not itself validate a particular orchestration stack |
| Leiden Declaration on AI in Research, *Notices* Aug. 2026, [`noti3386`](https://doi.org/10.1090/noti3386), official declaration DOI [`10.5281/zenodo.20302944`](https://doi.org/10.5281/zenodo.20302944) | Human responsibility, disclosure, independent verification, semantic translation review, and concern about AI-amenable questions are governance requirements | Human-only release, AI/tool disclosure, independent mathematical and semantic review, and an amenability-bias check | Endorsement is normative authority, not verification of a theorem or workflow efficacy |
| Efron article, *Notices* Aug. 2026, [`noti3387`](https://doi.org/10.1090/noti3387) | Random and chronological validation can diverge sharply under distribution shift | Evaluate prompts on hidden holdouts, later chronological sources, neighboring systems, and mutation cases; report degradation | One empirical example does not set a universal expected error rate |
| FAIR computational resources, *Notices* May 2026, [`noti3332`](https://doi.org/10.1090/noti3332) | Findable/accessibile/interoperable/reusable presentation is distinct from executable reproducibility; environments, dependencies, ownership, and decisions matter | Require short presentation, full technical record, executable bundle, versions, dependency DAG, ownership, and decision log | FAIR metadata alone does not reproduce or verify a result |
| Max Bill mathematical modeling case, *Notices* May 2026, [`noti3334`](https://doi.org/10.1090/noti3334) | A productive sequence can move from anomaly to definition, obstruction, restricted theorem, computation, independent check, and certificate; search failure is not impossibility | Preserve `PARTIAL`, no-go objects, bounded checks, independent replay, and exact termination reasons | Methodological analogy does not imply which Collatz route is promising |
| Markoff case, *Notices* May 2026, [`noti3336`](https://doi.org/10.1090/noti3336) | Graph/invariant views, exactness squeezes, theory/computation boundaries, and failed transfers can expose the real hinge | Require graph semantics, exact transfer direction, and explicit finite/theoretical boundary | The specific invariant is unrelated to Collatz unless proved otherwise |
| Supplied auto-generated commentary on an AI-assisted `S^6` claim and its linked artifact | Claims can inflate before formal and independent review; reputation, length, and publication venue are weak proxies; a short review path must bind to the full artifact | Keep origin, scope, verification, publication, and responsibility separate; freeze a digest; provide short/full/provenance layers; recheck time-sensitive formalization status | The transcript is commentary, not the current authoritative status of the `S^6` work |
| Formalizing Actionable Research, arXiv [`2608.16977`](https://arxiv.org/abs/2608.16977) | The reported cascade uses label, extract, check, solve, judge, grade, and human-review stages; the pilot reports selective human review and explicit limitations | Use an outer evidence cascade, typed outcomes, same-artifact gates, selective high-value escalation, and a final human gate | Observational/pilot evidence, selected review, same-model judge correlation, and reported AUC do not prove causal superiority or transfer to Collatz |
| Station, arXiv [`2608.23691`](https://arxiv.org/abs/2608.23691) | The reported open-world system uses heterogeneous agents, isolated initial work, artifact/archive memory, context summaries, supervisors, and stagnation controls | Use durable artifact memory, isolated proposals, compact handoffs, multistart only when warranted, and stagnation/low-value stop rules | Retrospective mechanism attribution without ablation does not identify which component caused results |

## 3. Collatz-specific synthesis

The sources support a two-level control architecture:

1. **Outer evidence cascade:** provisional frame, orientation, refreeze,
   discovery, attack, replication, scoped verification/assessment, explanation,
   and human release.
2. **Inner proof ecosystem:** several nonduplicate proof mechanisms plus a
   persistent disproof lane, hostile audits, separately expressed finite
   checkers, Lean on frozen hinges, and durable route/failure memory.

The bridge between them is artifact-bound status control. Agents do not vote a
claim into trusted state. A scoped verifier records what one digest establishes
and does not establish; a claims controller applies an allowed transition; a
human owns release.

For Collatz, the highest-risk recurring errors remain concrete:

- switching ordinary, accelerated, stopped, or unstopped conventions;
- replacing exact valuations with lower bounds;
- losing floors, endpoints, positivity, or integrality in lifts;
- treating rational/2-adic/signed objects as positive-natural witnesses;
- promoting finite residue coverage without a soundness/closure theorem;
- hiding the conjecture in an equivalent-strength bridge;
- treating a Lean component or a large computation as the entire result;
- treating absence of prior art or failed search as proof of novelty or
  impossibility.

V4 therefore keeps these as non-waivable domain gates rather than costs that a
portfolio scheduler may trade away.

## 4. What is new in V4

Relative to V3, the evidence supports the following bounded changes:

- provisional formalization followed by orientation and an explicit refreeze;
- typed primary outcomes plus separate termination reasons;
- a clean-context contamination/taint/replay protocol;
- risk-based eligibility separated from budget scheduling;
- digest-bound verifier verdicts and dependency snapshots;
- explicit correction, withdrawal, recall, and dependency-revocation paths;
- exact wording predicates instead of a single weakest-axis score;
- untrusted-source/prompt-injection and data-access controls;
- immutable research-bank snapshots with source-repository ownership;
- short certificate, complete record, and reproduction/provenance bundle.

## 5. Evaluation obligation

Do not call V4 “best practice” merely because the source list is broad. Compare
it with V3 under matched budgets on frozen known-true, known-false, circular,
finite-only, map-confusion, valuation, endpoint, semantic-mismatch, and
prior-art cases. Hold back route variants, use chronological sources and
neighboring affine systems as shifts, and measure false promotion, calibrated
abstention, falsification yield, scope fidelity, semantic mismatch, reviewer
time, and context per verified gain.

Adopt a control only if it catches a relevant failure or improves verified
decision quality without unacceptable overhead or worst-stream degradation.

## 6. Supplied source containers

The review used the supplied optimized full issues
`202601FullIssue-optimized.pdf` through `202608FullIssue-optimized.pdf` and the
two supplied auto-generated `.srt` transcripts. Article identifiers above are
the stable theorem-level locators used for rechecking; the attached issue or
transcript filename is only the local container identity.

## Connections

- **Applied by:** [Collatz Orchestrator V4](../prompts/COLLATZ_ORCHESTRATOR_V4.md)
- **Parallel to:** [research-object bank boundary](RESEARCH_OBJECT_BANK_BOUNDARY.md)
- **Depends on:** [research protocol](../RESEARCH_PROTOCOL_V2.md)
- **Strengthens:** [shared proof-attack integration](SHARED_PROOF_ATTACK_STRUCTURE.md)
