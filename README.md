# Collatz Conjecture Work

Public archive of an AI-assisted mathematical research sequence on **corrected-log ranking functions, rational/2-adic periodic shadows, and necessary debt/approximation barriers for the accelerated odd-to-odd Collatz map**.

> **Status:** This repository does **not** claim a proof or disproof of the Collatz conjecture. The central results are unreviewed mathematical claims awaiting independent specialist reconstruction and proof-assistant formalization. Novelty is also not certified.

## Where to start

The cleanest public review target is:

1. [`papers/round-6a/Theorem_6A1_Public_Review_Note.md`](papers/round-6a/Theorem_6A1_Public_Review_Note.md)
2. [`verification/round-6a/collatz_round6a_checks.py`](verification/round-6a/collatz_round6a_checks.py)
3. [`verification/round-6a/Collatz_Round6A_Claim_Ledger_2026-08-01.csv`](verification/round-6a/Collatz_Round6A_Claim_Ledger_2026-08-01.csv)
4. [`verification/round-6a/round6a_check_output.txt`](verification/round-6a/round6a_check_output.txt)
5. [`LEAN_TARGETS.md`](LEAN_TARGETS.md)

The public review note isolates the central Round 6A quantitative rational-period β-debt theorem and its proof, rather than presenting the work as a solution of Collatz.

## Research sequence

| Stage | Main research state |
|---|---|
| Initial | Multi-agent research ledger |
| Round 2 | Novelty and continuation |
| Round 3 | Fixed-gap and rising-tail obstruction |
| Round 4A | Shadow deficit and priority |
| Round 4B | Shadow debt and compensation |
| Round 5A | Skeleton sharpness and critical compensation |
| Round 5B | Periodic ghost shadows and depth-tax obstructions |
| Round 6A | Verification, distributed ghost stress, and quantitative debt necessity |
| Round 6B | Terminal finite-sensor approximation barrier |

**Round 6B is chronologically the terminal consolidation, but Round 6B itself recommends Round 6A as the better first target for specialist review because 6A is closer to the mathematical core.**

## Verification status

- Internal symbolic/algebraic reconstruction: **performed**
- Executable diagnostic checks: **included for Round 6A**
- Independent human specialist reconstruction: **pending**
- Lean / proof-assistant formalization: **pending**
- Certified novelty / priority: **pending**
- Collatz convergence proof: **not claimed**

Finite computations in the included checker are diagnostic stress tests and are not presented as proofs of universal statements.

## Integrity and dates

The research artifacts are dated **2026-08-01**, with the stored packet/library records extending into **2026-08-02 UTC**. This public GitHub repository was created later, on **2026-08-23**.

The original per-round SHA-256 manifests from Rounds 4A through 6B are preserved unchanged in [`checksums/original/`](checksums/original/). A fresh byte-for-byte SHA-256 inventory of the archived source artifacts was computed at public archival time and is stored at [`checksums/PUBLICATION_SHA256SUMS_2026-08-23.txt`](checksums/PUBLICATION_SHA256SUMS_2026-08-23.txt).

Hashes establish **content identity**, not an earlier date by themselves. [`PROVENANCE.md`](PROVENANCE.md) records the distinction between the earlier artifact metadata and the later independently visible GitHub publication date.

## Current mirror scope

The repository currently publishes the central Round 6A theorem/proof, its executable checker, checker output, claim ledger, Lean formalization roadmap, provenance record, and the original checksum manifests for the broader research archive.

The historical full-size dossier/PDF/ZIP originals remain preserved in the source file library and are identified byte-for-byte by the publication manifest. They are not being represented as if GitHub had hosted them on 2026-08-01.

## Independent review requested

The most useful external question is:

> Are the rational-period positive-lift/same-phase lemmas and the Round 6A quantitative β-debt theorem correct, and is the resulting distributed critical-debt law already known in rational-cycle / 2-adic Collatz theory or termination-ranking theory?

A Lean formalization of the rational-period lift and Round 6A theorem chain would materially strengthen correctness confidence.
