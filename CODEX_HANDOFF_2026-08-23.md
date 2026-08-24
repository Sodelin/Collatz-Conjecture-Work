# Codex handoff — Collatz project

**Date:** 2026-08-23  
**Purpose:** freeze the current ChatGPT research state before transferring active work to Codex.  
**Status:** no proof or disproof of the Collatz conjecture; active research frontier only.

## 1. Handoff rule

This repository is the authoritative mathematical ledger.

After this handoff, do **not** assume any uncommitted ChatGPT reasoning exists. Codex should begin from the committed files listed below and should commit every material theorem, correction, counterexample, script, output, and status change.

The current ChatGPT-side research session is intentionally **stopped here** to avoid two agents independently extending the same branch.

## 2. Current mathematical frontier

The active frontier is Round 7, not Round 6.

### L8 — Farey-certified coefficient barrier

`proof-search/lemmas/L8_Farey_Certified_Coefficient_Barrier.md`

Conditional on:

1. Barina's published verification through `2^71`; and
2. Rozier–Terracol Corollary 4.4,

a hypothetical least Collatz counterexample `n_*` cannot have a coefficient-contracting accelerated prefix before

`J = 114,208,327,604`.

This is a necessary-condition theorem, not a resolution.

### L9 — first-contraction mechanical envelope

`proof-search/lemmas/L9_First_Contraction_Mechanical_Envelope.md`

If `tau` is the first accelerated coefficient-contraction time and `s=q_tau`, then

`tau = floor(s log_2 3) + 1`.

If the odd steps are at positions `p_r`, then

`p_r <= floor((r-1) log_2 3) + 1`.

The unique first-contraction prefix maximizing the additive remainder places every odd step at its latest admissible deadline. Arbitrary first-contraction words are represented by a nonnegative displacement profile from this mechanical extremizer.

### L10 — near-return and dual-residue certificate

`proof-search/lemmas/L10_Near_Return_and_Dual_Residue_Certificate.md`

If the first coefficient contraction is non-descending and

`T^tau(n)=n+d`, then

`0 <= d < s/3`.

The same first-contraction word determines:

- the canonical start residue modulo `2^tau`;
- the canonical endpoint residue modulo `3^s`;
- the near-return defect residue modulo `D=2^tau-3^s`.

A paradoxical first contraction therefore requires simultaneous small-residue behavior in these linked arithmetic coordinates.

Important blocker: proving every first coefficient contraction descends is essentially the classical Coefficient Stopping Time problem. Do not relabel that open wall as a routine lemma.

### L11 — hard-exit inheritance

`proof-search/lemmas/L11_Near_Return_Hard_Exit_Inheritance.md`

Let `n_*` be a least counterexample and let its first coefficient contraction satisfy

`T^tau(n_*) = n_* + d`.

When `s<n_*`, L10's bound is strong enough to show that the endpoint itself must inherit the L6 hard `-1`-exit state. In particular:

- the endpoint is odd;
- `v_2(endpoint+1)>=2`;
- the endpoint cannot take the L6 good coalescing exit;
- `d ≡ 0 (mod 4)`.

At the first L8 Farey frontier, `s<n_*` is automatic because `s < 2^71 < n_*`.

This is currently the most important recursive structural result in the active branch.

## 3. Main live research question

Do **not** optimize for “the next lemma.” Optimize for a full contradiction / proof architecture.

The current synthesis target is:

> Can a least counterexample indefinitely sustain a sequence of near-critical first-contraction / near-return states that simultaneously satisfy:
>
> 1. the mechanical-envelope constraints from L9;
> 2. the tiny linked residue conditions from L10;
> 3. the L6/L11 hard-exit inheritance condition;
> 4. exact mixed-radix / coalescence compatibility;
> 5. global minimality `T^j(n_*) >= n_*`?

A complete proof would need a theorem showing that these recursive states either:

- force an iterate below `n_*`; or
- enter a finite/regular state graph with a well-founded rank; or
- become arithmetically incompatible with any positive integer; or
- otherwise contradict the exact Collatz dynamics.

Do not assume such a theorem exists merely because the surviving state description is narrow.

## 4. High-value synthesis route

The strongest current architecture is Route `AB` in:

`proof-search/routes/AB_mixed_radix_coalescence_bridge.md`

It identifies the Round-7 affine cylinder machinery with the exact mixed binary/ternary arithmetic used by the Yolcu–Aaronson–Heule Collatz-equivalent rewriting system.

The preferred search object is a **finite mixed-radix macro/coalescence certificate**, not a fixed-depth residue tree.

A useful certificate may allow temporary growth and prove instead that an exact macro coalesces with the orbit of a strictly smaller positive integer.

## 5. Existing exact certificate machinery

Read before generating another search program:

- `proof-search/lemmas/L2_Cylinder_Refinement_and_Slope_Pruning.md`
- `proof-search/lemmas/L3_Trailing_Ternary_Two_Coalescence.md`
- `proof-search/lemmas/L4_General_Inverse_Word_Coalescence.md`
- `proof-search/lemmas/L5_Inverse_Word_Search_Completeness_Bound.md`
- `verification/round7_exhaustive_inverse_word_classifier.py`
- `verification/round7_exhaustive_inverse_word_classifier_output_2026-08-23.txt`

L5 removes the arbitrary inverse-depth parameter for the whole-family inverse-word certificate class. A miss from the exhaustive classifier is therefore a **class miss**, not merely a shallow-search miss.

## 6. External/prior-art integration already done

Read:

- `methodology/YAH_REWRITE_SOURCE_INTEGRATION_2026-08-23.md`
- `methodology/ANTHROPIC_RH_WORKFLOW_NOTES.md`
- `methodology/SHARED_PROOF_ATTACK_STRUCTURE.md`

Do not rediscover or overclaim:

- the 11-rule mixed binary/ternary rewriting representation is prior art;
- termination of the exact published system is Collatz-equivalent;
- standard matrix/arctic interpretation search is a sufficient certificate class, not an equivalent characterization of Collatz;
- failure to find one such interpretation says only that the searched class failed.

## 7. Failure ledger is mandatory

Before reopening an old idea, read:

`proof-search/FAILURE_LEDGER.md`

Especially avoid:

- finite parity-prefix statistics treated as global proof;
- average drift promoted to pointwise convergence;
- fixed-depth residue trees;
- simple bounded/local corrected-log rankings;
- rational/2-adic ghosts treated as positive counterexamples;
- “global descent” renamed without an independent mechanism;
- assuming a narrow-looking missing lemma is weak.

If an old route is reopened, record:

- old blocker;
- new mechanism;
- why it bypasses the blocker;
- first falsification test;
- exact theorem target.

## 8. Formal verification priorities

Do not attempt to formalize the entire conjecture immediately.

Best bounded Lean targets, roughly in order:

1. L0 global-descent equivalence;
2. L2 exact cylinder refinement;
3. L4 inverse-word semantics;
4. L5 completeness bound for the certificate class;
5. L6 hard-exit coalescence identities;
6. L9 first-contraction deadline/extremizer theorem;
7. L10 near-return and residue identities;
8. L11 hard-exit inheritance;
9. L8 only after its external inputs are represented explicitly as hypotheses or independently formalized.

Use `lean/VERIFICATION_POLICY.md`. A compiled theorem is not enough unless the theorem statement, assumptions, imported trust, axioms, and toolchain are audited.

## 9. Mathematical claim discipline

As of this handoff:

- **Full Collatz proof:** NO.
- **Full Collatz disproof:** NO.
- **Lean-verified full chain:** NO.
- **Independent specialist reconstruction:** NO.
- **Novelty certification for Round-7 lemmas:** NO.
- **Strong internal auxiliary theorem chain:** YES, but still pending independent/formal verification.

The correct public phrasing is “AI-assisted exploratory research with unreviewed auxiliary results and explicit verification targets.”

## 10. Provenance / publication

The repository itself is now the provenance record from its public commits onward.

Earlier August 1–2 artifacts and original checksum manifests are preserved under the repository provenance/checksum structure.

Do not backdate commits.

No Zenodo deposit was created in this handoff. If Codex later prepares a stable archival release, prefer doing so only after:

1. the exact artifact set is frozen;
2. the README/status language is current;
3. checksums are regenerated for that release;
4. the repository is tagged/released;
5. the deposit is clearly labeled as research archive / unreviewed work rather than a Collatz proof.

## 11. Shared methodology repository

Reusable proof-search governance lives in:

`Sodelin/Proof-attack-structure`

Problem-specific mathematics stays here.

Codex may improve the shared methodology, but a shared-methodology change does not silently alter the mathematical status of this repository.

## 12. Recommended first Codex cycle

1. Cold-read L8–L11 and independently reconstruct every proof.
2. Try to break L9–L11 before extending them.
3. Reproduce the existing exact scripts.
4. Compare the first-near-return state with the mixed-radix Route-AB state representation.
5. Search for a recursive macro theorem that propagates **more than mod 4** across the near-return.
6. Prefer a theorem that closes the whole recursive state space over another larger finite bound.
7. Commit every correction before attempting synthesis.

The research goal remains the actual conjecture, not merely producing an indefinitely long sequence of auxiliary lemmas.
