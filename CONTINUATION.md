# Continuation checkpoint

This file is the restart point if the project is resumed.

## Current mathematical state

### Core result to verify first

**Round 6A, Theorem 6A.1:** under a universal corrected-log descent guarantee within `β log_2 n` accelerated odd Collatz steps, every sufficiently expansive repelling rational periodic shadow forces linearly growing same-phase correction debt, with an explicit coefficient.

Public review version: [`papers/round-6a/Theorem_6A1_Public_Review_Note.md`](papers/round-6a/Theorem_6A1_Public_Review_Note.md).

### Terminal extension

**Round 6B:** if a simpler surrogate is phasewise frozen on a periodic shadow and approximates the correction with error `e_r`, then the Round 6A debt lower bound forces `e_r = Ω(r)`. For the high-period `w_m` family, the normalized approximation-gap lower bound tends to one half of the Round 5A inverse frontier.

Round 6B is useful as a closure/corollary statement, but its own audit recommends returning to Round 6A for external verification.

## Do not restart theorem generation before these checks

1. **Formalize the rational-period positive-lift lemma.** Exact valuation preservation, including the endpoint, is the most fragile technical step.
2. **Formalize exact same-phase scaling.** This should be clean once the rational periodic point is in place.
3. **Formalize Theorem 6A.1.** Preserve the `k_r log_2 λ` term and the floor endpoint.
4. **Run an independent priority search.** Search rational cycles, 2-adic dynamics, amortized/ranking functions, and program termination for an equivalent β-debt statement.
5. **Only then decide whether a new theorem branch is warranted.**

## Existing executable record

- `verification/round-6a/collatz_round6a_checks.py`
- `verification/round-6a/round6a_check_output.txt`
- `verification/round-6a/Collatz_Round6A_Claim_Ledger_2026-08-01.csv`

These are diagnostic checks, not substitutes for proof.

## Formalization plan

See [`LEAN_TARGETS.md`](LEAN_TARGETS.md).

## Provenance and integrity

The earlier research artifacts are indexed by both the original per-round checksum manifests and the fresh public-archive-time SHA-256 manifest. See [`PROVENANCE.md`](PROVENANCE.md) and `checksums/`.

## Claim discipline

Until independent verification changes the status, use:

- **Correctness:** high internal confidence / unreviewed
- **Priority:** exact formulation not located / unverified
- **Usefulness:** proof-architecture necessary condition
- **Collatz relevance:** indirect architecture / necessary condition
- **Full Collatz solution:** no
