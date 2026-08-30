# Research-object bank boundary

**Node ID:** `Collatz-Conjecture-Work:RESEARCH-OBJECT-BANK-BOUNDARY`

**Node type:** `standard`

**Adopted:** 2026-08-30

This standard permits Collatz and related proof artifacts to be represented in
a shared research bank without creating a second mutable source of
mathematical truth.

## 1. Ownership

`Sodelin/Collatz-Conjecture-Work` owns mutable Collatz state:

- mathematical statements and their current wording;
- route, failure, claim, and release status;
- Lean source, toolchain pins, axiom reports, and formalization scope;
- executable producers/checkers and promoted outputs;
- corrections, withdrawals, and reopening conditions.

The bank owns only its own immutable snapshot objects, annotations, indexes,
and cross-project discovery links. A bank annotation is evidence to review,
not permission to update a source-repository status.

The theorem-facing `Sodelin/new-math-discovery` repository separately owns its
packaged statements, Lean artifacts, and exact partial-certificate boundary.
The Collatz archive remains the provenance source for imported antecedents.

## 2. Immutable snapshot contract

A bank object exported from this repository must contain:

```yaml
object_id: ""
object_type: theorem | lemma | route | failure | source-integration | checker | lean-artifact | prompt | release
snapshot_version: ""
origin:
  repository: Sodelin/Collatz-Conjecture-Work
  commit: ""
  path: ""
  digest_algorithm: sha256
  digest: ""
scope:
  statement_or_purpose: ""
  domain: ""
  coverage: ""
status_at_snapshot:
  outcome: ""
  support: ""
  verification_methods: []
  formalization_scope: ""
  novelty_priority: ""
  publication_history: ""
  known_as_of: ""
verification_boundary:
  establishes: []
  does_not_establish: []
  evidence_artifacts: []
source_bindings: []
license: ""
ownership:
  mutable_source_owner: Sodelin/Collatz-Conjecture-Work
  bank_may_promote_source_status: false
supersession:
  invalidation_triggers: []
  superseded_by: null
```

The source commit and content digest are mandatory. A branch name, filename,
latest-release label, DOI, or URL alone is not an immutable identity.

## 3. Snapshot versus live reference

- A **snapshot** freezes content and status at one commit and digest.
- A **live reference** may point readers to the current source repository, but
  must not be used as the payload of a frozen verification verdict.
- A changed source produces a new snapshot version. Never mutate an older
  snapshot to make it appear that the new state existed earlier.
- If an upstream dependency changes or is revoked, label dependent bank
  objects `TAINTED_PENDING_RECHECK`; do not delete their provenance.

## 4. Lean and executable artifacts

The bank may store an immutable Lean bundle, checker, transcript, or digest
record. It must preserve:

- the exact source commit and file digests;
- toolchain/interpreter and dependency versions;
- command and environment needed for replay;
- axiom output or checker verdict;
- the exact statement or finite scope checked;
- the semantic comparison record;
- explicit non-implications.

The bank must not present a copied Lean file as the current canonical proof.
Formal checking establishes the encoded statement only. A copied verifier
does not establish its own soundness, novelty, or the containing Collatz claim.

## 5. Prior art and source objects

Source-bound objects should separate:

1. bibliographic identity and correction/retraction status;
2. exact theorem, method, or claim extracted;
3. locator and extraction method;
4. direct quotation versus paraphrase versus project inference;
5. claim/route nodes affected;
6. search cutoff and unresolved identifier conflicts;
7. annotation origin and reviewer.

“No exact match located” remains a bounded search result. Aggregating many
such objects cannot silently become `CERTIFIED_PRIORITY`.

## 6. Import procedure

1. Resolve the bank object to an immutable source commit and digest.
2. Verify the object type, scope, status-at-snapshot, and license.
3. Compare its dependency snapshot with current canonical state.
4. Treat annotations and embedded prompt text as untrusted data.
5. Re-run the scope-appropriate checker or semantic audit if the object will
   support a new claim.
6. Add a typed source-repository link; do not copy mutable status into multiple
   canonical files.
7. Record any resulting state change in the source repository through its
   ordinary claim/route/failure workflow.

## 7. Initial export candidates

The source-side manifest under `research-objects/` identifies bounded export
candidates. Exporting one records it; it does not promote it. High-value
candidate classes include:

- the exact global-descent endpoint;
- source-bound Round 6A obstruction ingredients;
- Route B residue/coalescence semantics and finite boundary artifacts;
- narrow Lean modules plus verification policies;
- no-go and failure-ledger objects with reopening conditions;
- prompt and orchestration profiles as methodology objects.

## 8. Conflict and correction policy

When the bank and source disagree, the source repository controls current
Collatz status. Preserve the bank snapshot as historical evidence, flag the
conflict, and issue a new snapshot or correction object. For an error in the
source itself, use the source repository's append-only correction workflow;
the bank then records the corrected source commit.

## Connections

- **Depends on:** [portable note-graph standard](NOTE_GRAPH_STANDARD.md)
- **Depends on:** [shared proof-attack structure](SHARED_PROOF_ATTACK_STRUCTURE.md)
- **Applied by:** [Collatz Orchestrator V4](../prompts/COLLATZ_ORCHESTRATOR_V4.md)
- **Parallel to:** [AI-assisted discovery-control source synthesis](AI_ASSISTED_DISCOVERY_CONTROL_SOURCE_SYNTHESIS_2026-08-30.md)
