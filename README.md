# Collatz Conjecture Work

Public archive of an AI-assisted mathematical research sequence on **corrected-log ranking functions, rational/2-adic periodic shadows, and necessary debt/approximation barriers for the accelerated odd-to-odd Collatz map**.

> **Status:** This repository does **not** claim a proof or disproof of the Collatz conjecture. The central results are unreviewed mathematical claims awaiting independent specialist reconstruction and proof-assistant formalization. Novelty is also not certified.

## Where to start

### Recommended expert starting point
1. [`papers/round-6a/Collatz_Round6A_Expert_Audit_Brief_2026-08-01.pdf`](papers/round-6a/Collatz_Round6A_Expert_Audit_Brief_2026-08-01.pdf)
2. [`papers/round-6a/Collatz_Round6A_Verification_Distributed_Ghost_Stress_Dossier_2026-08-01.pdf`](papers/round-6a/Collatz_Round6A_Verification_Distributed_Ghost_Stress_Dossier_2026-08-01.pdf)
3. [`verification/round-6a/collatz_round6a_checks.py`](verification/round-6a/collatz_round6a_checks.py)
4. [`verification/round-6a/round6a_check_output.txt`](verification/round-6a/round6a_check_output.txt)

### Chronologically latest research state
[`papers/round-6b/Collatz_Round6B_Terminal_Approximation_Barrier_Dossier_2026-08-01.pdf`](papers/round-6b/Collatz_Round6B_Terminal_Approximation_Barrier_Dossier_2026-08-01.pdf)

Round 6B is the terminal consolidation, but its own conclusion recommends **Round 6A** as the better first document for specialist review because 6A is closer to the mathematical core.

## Research sequence

| Stage | Main artifact |
|---|---|
| Initial | Multi-agent research ledger |
| Round 2 | Novelty and continuation dossier |
| Round 3 | Fixed-gap and rising-tail dossier |
| Round 4A | Shadow deficit and priority dossier |
| Round 4B | Shadow debt and compensation dossier |
| Round 5A | Skeleton sharpness and critical compensation dossier |
| Round 5B | Periodic ghost shadows and depth-tax obstructions dossier |
| Round 6A | Verification, distributed ghost stress, and debt necessity dossier |
| Round 6B | Terminal finite-sensor approximation-barrier dossier |

## Verification status

- Internal symbolic/algebraic reconstruction: **performed**
- Executable diagnostic checks: **included**
- Independent human specialist reconstruction: **pending**
- Lean / proof-assistant formalization: **pending**
- Certified novelty / priority: **pending**
- Collatz convergence proof: **not claimed**

Finite computations in the included checkers are diagnostic stress tests and are not presented as proofs of universal statements.

## Integrity and dates

The files were generated during the research sequence dated **2026-08-01**, with packet/library records extending into **2026-08-02 UTC**. They were first published to this GitHub repository on **2026-08-23**.

The original per-round SHA-256 files are preserved in [`checksums/original/`](checksums/original/). A fresh byte-for-byte SHA-256 manifest computed at public archival upload is in [`checksums/PUBLICATION_SHA256SUMS_2026-08-23.txt`](checksums/PUBLICATION_SHA256SUMS_2026-08-23.txt).

See [`PROVENANCE.md`](PROVENANCE.md) for the important distinction between **artifact-generation metadata** and **independently verifiable public timestamping**.

## Repository layout

- `papers/` — dossiers, expert briefs, and source Markdown
- `verification/` — executable checks, outputs, and claim ledgers
- `audit-prompts/` — prompts intended for independent mathematical reconstruction
- `bibliography/` — BibTeX/reference files
- `checksums/` — original SHA-256 records plus the public-upload manifest
- `archives/` — original round packet ZIPs
- `PROVENANCE.md` — chronology and timestamp limitations
- `LATEST.md` — current-result and expert-start pointers

## Independent review requested

The most useful external review is not “Did this solve Collatz?” It is:

> Are the Round 6A rational-period lifting argument and quantitative β-debt theorem correct, and is the resulting distributed critical-debt law already known in rational-cycle / 2-adic Collatz theory or termination-ranking theory?

A Lean formalization of the rational-period lift and Round 6A theorem chain would materially strengthen correctness confidence.
