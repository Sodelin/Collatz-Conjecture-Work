# Legacy contribution consolidation audit — 2026-09-05

Scope: open PR6 (`215f8e6ca0afae71f9e743ea683cc7263079f24c`), PR8 (`f35cebae5065bb14b5cd4cd58868c6efb568b08a`), PR12 (`a2761eda28f2ad7701e57e64e8acb80a89898618`), and PR13 (`479ed90d32e3bd7aeffe19f6422c9f7723e4e3e0`) against main `5410069` and fetched PR16/17/20 branches. This is a source and integration audit, not a new priority review.

**Finding:** every file uniquely added by these four older PRs is absent from both main and all three newer research branches. Their age does not make their unique contributions redundant. Consolidate the additions, reconcile shared status documents, and preserve rejected/provisional material as such. No global Collatz conclusion follows.

## 1. PR6 — endpoint and renewal contributions

Integrate these exact paths from PR6:

- `proof-search/lemmas/L15_Expanded_Rewrite_and_Mixed_Inverse_Words.md`
- `proof-search/routes/AB_direct_H_return_and_renewal_filters.md`
- `proof-search/routes/AB_prime_renewal_finite_window_no_go.md`
- `proof-search/routes/F_bounded_alphabet_endpoint_residue_gate.md`
- `verification/bounded_alphabet_endpoint_residue_gate.py`
- `verification/bounded_alphabet_endpoint_residue_gate_output_2026-08-24.txt`
- `verification/direct_H_return_renewal_regression.py`
- `verification/expanded_rewrite_inverse_word_regression.py`
- `verification/prime_renewal_regression.py`

The expanded inverse-word note supplies additional decreasing predecessor rewrites, an exact nonconfluent irreducible set, inverse fibers, mixed-word congruences, a concrete `91 mod 162` family, and a fixed pure-exponent-2 depth obstruction. These are elementary affine/CRT results and a certificate-class boundary; universal coverage remains Collatz-equivalent. This old **L15** is different from the newer quarter-gap **L15**; use full names or atomic claim IDs in integration indexes.

The direct-return note gives four **partial actual-orbit** hard-state transitions and completed-switch arithmetic. Its two common-divisor renewal criteria require separate, unproved persistent-divisor hypotheses. It cannot replace PR17's rooted guarded theorem and does not define a total return relation. Its local symbol `T` is fully accelerated, unlike some other notes' shortcut `T`; preserve the explicit map convention.

The prime-renewal note proves that each finite admissible prime script has a positive realization and that finite roughness/return windows are insufficient. The seed may change with the finite script. It supplies neither a fixed positive divergent seed nor control of one infinite trajectory.

The bounded-alphabet endpoint theorem gives an exact infinite-code characterization: for bounded positive valuations, positive odd realizability is equivalent to eventual zero carry, vanishing normalized endpoint residues, and strict subcubic root growth. Failure has full cubic root limsup. The proof is prose; finite regression is evidence for the arithmetic identities, not a proof of the infinite theorem. The note itself calls this an elementary strengthening/package relative to Wang and Kramer; preserve uncertified priority and do not promote its old registry `N2/R2` ranking as a settled novelty conclusion.

Two further additions require historical treatment:

- `MATHEMATICIAN_HANDOFF_2026-08-25.md`: retain as a dated snapshot with a prominent link to the new consolidated status. Its old public baseline, strongest-target ranking, Lean-module count, and open-gate text must not become the current summary.
- `proof-search/disproof/CODEX_TM_MAHLER_ANCHOR_2026-08-24.md`: retain the exact conditional construction for provenance but add an immediate **superseded candidate / positive realization excluded by PR20** notice. The file currently says `PAUSED_AWAITING_EXACT_2_ADIC_MEMBERSHIP`; that is now stale for the exact Thue–Morse code. Preserve the 2-adic identity and conditional implication, but do not leave membership listed as a live discovery target.

## 2. PR8 — finite additive YAH certificates

Integrate:

- `lean/CollatzWork/YAHFiniteObstructionStatement.lean`
- `lean/CollatzWork/YAHFiniteObstruction.lean`
- `proof-search/routes/A_yah_finite_obstruction_formal_audit.md`
- `verification/yah_finite_obstruction_replay_2026-08-24.txt`

Add `import CollatzWork.YAHFiniteObstruction` to the current umbrella without replacing newer imports. Semantically merge PR8's updates to the two additive route notes, Lean-target boundary, and verification manifest.

The exact formal contribution covers: (i) a 13-row canonical adjacent-edge cancellation forcing a negative repeated-edge weight and, under a stated cofinality hypothesis, no common lower bound; (ii) an 8-row labeled-symbol zero cancellation; and (iii) a 50-row labeled-edge zero cancellation for one fixed two-state suffix algebra. Local legality and canonical embeddability are checked. The symbol and edge generic ordered-group no-go wrappers need no boundedness premise; the 13-row scalar contradiction has a genuine additional cofinality hypothesis.

**Do not conflate this with scalar-arctic full/top obstruction.** PR8 does not formalize the 11-/22-rule mass-49 scalar-arctic full result or Farkas/RUP top semantics. Its finite fixed-algebra scope also does not establish the proposed 70-scheme classification, global dynamic reachability from a narrower input language, arbitrary semantic labelings, matrices, longer windows, nonadditive methods, or general Collatz termination.

Principal audit targets to add to the publication manifest include `CollatzWork.YAH.twoState_rule_equations`, `unlabelledCertificate_cancellation`, `yah13_forces_ff_negative`, `ffPumpWord_canonical`, `ffPumpPotential_eq_edgePotential`, `noBoundedBelowCanonicalFFPumpWords`, `symbolCertificate_cancellation`, `edgeCertificate_cancellation`, `noTwoStateSymbolAdditiveOrder`, and `noTwoStateEdgeAdditiveOrder`.

## 3. PR12 — narrowly scoped stopped routes

Integrate the entire seven-note set under `proof-search/disproof/` with filenames beginning `CODEX_BRANCHING_CENTER_`, `CODEX_FINITE_RESIDUE_FIRST_INTEGRAL_`, `CODEX_F_POLY_RATCHET_`, and `CODEX_SMOOTH_RATIO_SEMICONJUGACY_SHOT_2026-08-24.md`, together with:

- `lean/CollatzWork/Disproof/BranchingCenter.lean`
- `lean/CollatzWork/Disproof/FiniteResidueFirstIntegral.lean`
- `lean/CollatzWork/Disproof/PolynomialRatchet.lean`
- `verification/RELEASE_AUDIT_2026-08-24.md`
- `verification/run_release_checks.ps1`

Preserve the hostile audits next to their proposed routes. These are narrow route closures, not positive divergence constructions:

| Result | Lean-checked part | Remaining prose boundary |
|---|---|---|
| Branching center | Natural-number center-consistency equation forces all three positive labels equal | Deriving the equation from rational centers and broader synchronization interpretation |
| Fixed finite-residue first integral | Generic invariance under permutations implies invariance under a transitive commutator, hence constancy | Positive lifts, removal of modulus factors 2 and 3, actual affine commutator arithmetic |
| Polynomial ratchet | Odd normal form, leading-coefficient telescope, nonresonant content-gain contradiction, vanishing nonnegative degree sum | Polynomial transport/normalization, primitive content, and macro semantics |
| Smooth-ratio generator | None in this PR | Full prose theorem: finite successive-state-ratio limit forces the positive accelerated orbit into 1 |

The resonant base `p=3` is explicitly outside the nonresonant polynomial contradiction; do not erase it. The group-action theorem alone is not a complete Lean proof of the finite-residue Collatz application.

The frozen release receipt proves only its old source `3619c756...` and listed historical checks. The PowerShell wrapper still tests only its old suite. It can remain as an historical convenience but should be updated or labeled as a subset; its `RELEASE_CHECKS = PASS` cannot certify the expanded consolidated release. Add the three modules to the current complete verification and declaration inventory, whether via umbrella imports or explicit module checks.

Excluded items named in the old receipt remain excluded unless separately supplied and reviewed: Deep Lasso failed its current hypothesis/sharpness audit; elliptic translation lacked exact height citations and its own receipt. Neither is among PR12's added files. Do not invent or silently resurrect them.

## 4. PR13 — notebook, bibliography, and issue transcriptions

Integrate all added paths under `knowledge/`, both added workflows, `methodology/MARKDOWN_MATH_STYLE.md`, `verification/check_markdown_math.py`, `proof-search/effective-flashes/`, and `publication/YAH_SCALAR_ARCTIC_CANDIDATE.md`.

The notebook is useful source/search infrastructure: deterministic catalog, backlinks, link audit, 36 provisional source cards, a frozen import manifest, and BibTeX. Keep `provenance/codex-ai` and `review/human-required` flags. Source cards do not establish their mathematical interpretation or independently verify each citation. Zotero links are optional conveniences, not the primary provenance.

The issue 7/9/10/11 transcriptions must remain conservative review aids: reciprocal summability external-input gate; provisional global carry corollary; conditional phase/summability equivalence with the fixed-point false control; and finite adelic freedom without a fixed-orbit bridge. They should not automatically enter the promoted claim list.

The scalar-arctic candidate file usefully distinguishes its own formal gap from PR8. Update it from the focused review, but keep its review and priority gates independent. User authorization already supplies owner permission for this task; stale process text asking for owner decisions must not manufacture a new approval blocker.

Do not restore PR13's historical versions of existing lemma/route/status files on top of newer mathematics. Its broad existing-file delta is principally Markdown delimiter conversion. Apply the delimiter formatter to the integrated versions instead. Regenerate `knowledge/_generated/*` against the full final corpus; copying the old generated catalogs would be stale immediately.

## 5. Collisions and canonical documents

Keep the newest truthful status as canonical and merge unique older content by claim identity. Never wholesale replace `README.md`, `ATLAS.md`, `LATEST.md`, `CONTINUATION.md`, `LEAN_TARGETS.md`, `PUBLIC_STATUS_2026-08-24.md`, `proof-search/APPROACH_REGISTRY.md`, `proof-search/CLAIM_REGISTRY.md`, `proof-search/FAILURE_LEDGER.md`, or `verification/README.md` from these branches.

The failure-ledger collision is substantive:

| Legacy ID | PR6 meaning | PR12 meaning | Newer PR16 meaning |
|---|---|---|---|
| F025 | Larger finite rewrite catalogue does not prove coverage | Two-center branching collapses | Higher-degree size/debt ranks fail |
| F026 | Finite prime windows are insufficient | Fixed-residue first integrals are constant | 3-adic depth does not repair ranks |
| F027 | Finite prefixes do not give a positive infinite seed | Normalized non-3 polynomial gain fails | Summable discrepancy reformulates the bridge |
| F028 | — | Ratio-convergent positive divergent generator excluded | Fixed residue refinement does not repair ranks |

Preserve all seven older entries under unique stable labels such as `LEGACY-PR6-F025` and `LEGACY-PR12-F025`, retain their original provenance, and repair every incoming link. PR20's F031 also conflicts with PR17's F031 and requires its own reconciliation. Do not use duplicate Markdown heading IDs.

## 6. Fresh verification performed

Independent archived checkouts were extracted from each exact Git object; the shared integration checkout was not edited.

| Check | Outcome |
|---|---|
| PR6 endpoint checker | PASS: 9,840 finite words through length 8 and positive-orbit reconstruction/boundary controls |
| PR6 direct-return checker | PASS: 50,000 typed parameters; 3,570 completed switching returns |
| PR6 expanded inverse checker | PASS: 50,000 starts; 12,500 endpoints; 510 mixed words; 10,001 family parameters |
| PR6 prime-renewal checker | PASS: 10,000 correction prefixes; 44 primes through 200; 48 rough-growth pairs |
| PR8 Lean 4.33.1 `lake build` | PASS: all eight build jobs; 13 displayed YAH axiom reports contain only the recorded standard axioms or no axioms |
| PR12 three Lean modules | PASS individually; finite-residue group-action reports axiom-free; remaining reports only standard `propext`, `Quot.sound`, and where reported `Classical.choice` |
| PR13 notebook normal and optimized `--self-test --check` | PASS in both modes on its own 95-note indexed corpus |
| PR13 Markdown `--self-test` | PASS on its own 98 Markdown files; false controls PASS |

No new axiom, `sorry`, or `native_decide` declaration was found in the PR8 modules. Direct Lean initially hit this runtime's application-location limitation; using the already configured Lean 4.33.1 compatibility launcher resolved it. No theorem source was altered to obtain a pass. Final combined-tree verification remains the integrating agent's obligation.

## 7. Integration completion conditions

1. Preserve the unique file additions and exact source SHAs in a machine-readable contribution ledger.
2. Reconcile overlapping claims, failure IDs, bibliography provenance, and current status before publication.
3. Label the Thue–Morse candidate as excluded by the newer theorem while retaining its historical calculation.
4. Include all added Lean modules and four PR6 checkers in the current release verification; maintain formal-versus-prose distinctions in every headline.
5. Regenerate notebook views after all changes and run its regular and optimized-mode self-tests, note graph, Markdown checks, full Lean build, axiom audit, and selected finite replay suite.
6. Produce a consolidated review packet whose inventory encompasses the work but whose venue-specific claims stay narrow. Packaging every contribution is compatible with submitting only a precise eligible result.
