# Prove2Me publication record

Prepared 2026-09-08 for Sodelin. **Publication complete: 137 theorem entries are server-verified and marked `Proved`; all 31 definition bundles are accepted.** See [PUBLICATION_STATUS.json](PUBLICATION_STATUS.json) for the final server results and [PUBLIC_RESULTS.md](PUBLIC_RESULTS.md) for the proof and definition links derived from individual receipts. This directory contains source audits, validated imports, and a resumable publication client. A local build or queued submission is not evidence of remote acceptance.

## Source coverage

All **49 original Lean files across four projects compiled** with official Lean v4.33.1. This includes modules omitted by default build targets, three archival Collatz files, and the supplemental NewMath branch. Original source files were not changed. Source axiom audits found no dependencies outside `propext`, `Classical.choice`, and `Quot.sound`.

| Project | Original Lean files | Pinned source | Scope |
| --- | ---: | --- | --- |
| Collatz work | 38 | `026aa4ad4be6453a005ab950b160a9f2204c5271` | Auxiliary theorems, finite obstructions, and conditional convergence criteria; the universal conjecture remains unresolved. |
| Erdős #302 | 4 | `48bcf1429395b980198207bf6a876994fab80789` | Finite transfer relations at 732, 733, and 734; the external baseline upper bound is not formalized here. |
| Egyptian fractions, Erdős #295 | 3 | `566f9800910aae6936d93d1a9f5c756070616f31` | Reconstruction of a known 35-term representation with denominators at least 18. |
| NewMath | 4 | `fc2ce68341a0556cebb4e5843a3127f0881b91db` | Abstract coalescence soundness and blindness criteria, including two supplemental modules on `codex/freeze-blindness-realization`. |

See [source-projects.json](source-projects.json) for repository links, source hashes, module inventories, and package statuses. The [supporting catalog](supporting/catalog.json) records non-Lean certificates, manuscripts, checkers, prior-art reviews, and their exact public source links. The [reuse record](reuse/README.md) documents the collaboration and reuse work.

## Contents and evidence

- [collatz/](collatz/) contains Collatz candidate definition modules, theorem interfaces, solutions, coverage, validation evidence, and the upload manifest. Extraction and source audits are in [../../prove2me-audit/](../../prove2me-audit/).
- [projects/](projects/) contains the other three pinned source kits, audit evidence, reproduction scripts, plans, and candidate imports.
- [client/README.md](client/README.md) documents the upload manifest, offline checks, authenticated execution, and recovery. Its 28 offline integration and recovery tests passed, including asynchronous job handling, interrupted requests, environment mismatch, and final status verification.
- [COLLABORATION.md](COLLABORATION.md) records the existing Collatz mission and two public proved lemmas, with the definition bridges needed before reuse.
- [PUBLIC_RESULTS.md](PUBLIC_RESULTS.md) derives each project's accepted theorem and definition counts from [receipts/](receipts/), and provides direct public links. All four project receipts record completed final catalog verification.
- [supporting/README.md](supporting/README.md) presents the supporting research and historical recovery gaps; [reuse/README.md](reuse/README.md) records the separate public-proof reuse work.

Source compilation and upload compilation are separate checks. Splitting a project can change imports, helper order, namespaces, and simplification context. Each candidate's manifest and validation files record its actual state. A manifest with `pending` or `failed` validation, or an unconfirmed environment pin, must not be executed as a completed import.

All four generated trees compile: **137 theorem interfaces and their 137 solution files, with 31 definition bundles**. Elaborated type renderings match their originals for all 137 targets. Smaller supporting proofs are included with their consuming solutions; the exported-node count is not a count of every source declaration. Academic metadata and the authenticated live platform environment checks pass for all four packages. Publication is complete only when all 137 theorem entries are server-verified and show exactly `Proved`, and all 31 definition bundles are accepted. [PUBLIC_RESULTS.md](PUBLIC_RESULTS.md) and its source receipts record the observed results.

The local runtime used the source-provided executable-location launcher because this environment cannot resolve the process executable path. It uses the official Lean binaries and changes only executable-location discovery; it does not change proofs, arithmetic, or the kernel. Prove2Me independently checks submitted solutions; only completed verification and catalog receipts count toward publication completion.

## Reproduce or resume publication

1. Read each candidate manifest and its validation evidence. The current source/interface/solution type comparisons and metadata reviews pass. If any payload changes, repeat the affected checks and refresh its manifest hashes while preserving every hypothesis and the original claim scope.
2. Confirm that Prove2Me still supports the pinned environment before a later run. The authenticated check for this import confirmed Lean v4.33.1 and Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`. A future environment change requires a fresh compatibility check.
3. Supply authorized credentials through the private file described by the client. The browser and API identify the account as Sodelin. The user explicitly authorized key creation on 2026-09-08 after the earlier automatic-review block. A 30-day key was created and stored privately outside the repository. **No credential is included here.**
4. Use detached source checkouts at the pinned commits. Run offline manifest checks, then bounded client ticks. Retain the private state files and recorded job/submission IDs. Never repeat an uncertain POST blindly.
5. Resume from recorded job/submission IDs and receipts. Publish missing definitions and theorem interfaces in dependency order, then submit complete solutions. Count an entry as finished only after server verification and catalog status exactly `Proved`; do not resubmit an already completed entry. Record the actual IDs and public links in a receipt.
6. Fetch and verify any public dependencies before reuse. Propose mission integration only with checked map/iteration bridges and accurate contribution scope.

The requested publication and API-key creation are authorized. The key expires 2026-10-08 and remains outside git. The [supporting-work catalog](supporting/README.md) contains 58 pinned file/directory links in 10 collections across six public math repositories. These are supporting-artifact links, not 58 additional Lean proofs. One historically referenced AOG Lean source remains unrecovered and is excluded from verified and uploaded counts.

## Workflow provenance

The conversion follows Prove2Me workspace documentation v0.9.8, inspected at commit `6b46503a65c3a4252170ed5ca984a796b5a5b6b4`: [full-project upload](https://github.com/prove2me/prove2me_workspace/blob/6b46503a65c3a4252170ed5ca984a796b5a5b6b4/references/upload_full_project.md), [contribution API](https://github.com/prove2me/prove2me_workspace/blob/6b46503a65c3a4252170ed5ca984a796b5a5b6b4/references/contribute.md), and [verification API](https://github.com/prove2me/prove2me_workspace/blob/6b46503a65c3a4252170ed5ca984a796b5a5b6b4/references/prove.md). Lean metaprogramming supplies declaration identities, dependencies, types, and source spans; generated-code validation remains mandatory.

## Historical saved-file recovery

Two additional historical Round6B source files absent from the retained GitHub history were recovered and matched against an independently saved SHA-256 manifest. They are preserved in [supporting/library-archive/](supporting/library-archive/), with provenance and historical/unverified status. A parsed claim-ledger export is labeled separately from original bytes. Downloads of the larger saved ZIP archive repeatedly returned HTTP502. The [bounded saved-file inventory](supporting/library-search-inventory.json) records 100 filename matches, including duplicates and uninspected files. Completion of the 137-node Lean import does not mean every historical saved artifact has been recovered.
