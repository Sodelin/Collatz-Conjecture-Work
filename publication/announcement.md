# Collatz research consolidation: formal auxiliary results and proof-method obstructions

**Collatz remains unresolved.** This release brings the separate research branches and issue contributions into one reproducible, shareable archive. The VibeMathed proposal concerns a restricted YAH proof-method obstruction. It does not present the whole archive as a collection of independently novel solves.

The mathematical source is [33922a42e86646258d227d1e19c6cf7546a2f548](https://github.com/Sodelin/Collatz-Conjecture-Work/tree/33922a42e86646258d227d1e19c6cf7546a2f548). Every committed source file is preserved in research-source.zip. All tracked Lean sources, including three archived standalone derivations, are included in lean-source.zip with the pinned Lean4.33.1 configuration. The claim manifest and exact verification logs distinguish formal results, prose arguments, bounded searches, known reconstructions and open questions.

## The focused YAH contribution

The original Yolcu–Aaronson–Heule rewriting system provides a termination formulation of Collatz. Within its standard dimension-one arctic-natural first-step interpretation class, the project excludes full rule removal and both relative-top entry modes: original boundary targets and reversed dynamic targets. The affine-top coefficient domain is nonnegative and unbounded, with bottom values and the authors' coefficientwise tests. The fixed two-state22-rule labeling is certified explicitly, and equal-label lifting transfers the obstruction to the original eleven rules.

The full cancellation is elementary. The affine-top proof uses ten reconstructed target cases,491exact Farkas lemmas and426RUP steps ending in contradictions. A separate review reconstructed the semantic encoding and compared it with direct max-plus composition on288,560 assignments. The [focused review](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/33922a42e86646258d227d1e19c6cf7546a2f548/research-review/consolidation-2026-09-05/REPORT.md) explains why finite diagnostics are supplemental to the unrestricted soundness argument.

The scalar-arctic full/top claim is **not Lean-formalized**. It does not exclude higher dimensions, other carriers or labelings, transformed systems, or non-coefficientwise methods. The literature review located no exact predecessor for the complete top exclusion, but priority is not certified. The dedicated manuscript is publication/yah-obstruction.md; the venue entry uses Unreviewed, Partial result and Announcement.

## Everything consolidated

| Research component | Established contribution | Remaining boundary |
|---|---|---|
| First-contraction quarter gap | For a positive start with an existing first coefficient contraction and endpoint n+d, d>=0, Lean proves4d<s where s counts odd shortcut steps. The supporting envelope has sharp eventual threshold16. | Existence of a contraction for every start and global descent remain open. |
| Guarded root-relative families | Lean proves actual burst descent, smaller residue20 ancestors under3^13 dividing4r+1, and a guarded two-burst theorem. Prose extends the analysis to complementary ancestors and postspell compensation. | Parity/divisibility and final-halving guards are essential; no arbitrary-root coverage is claimed. |
| Finite search and rank obstructions | Exact arguments rule out specified bounded ancestor/forward covers, fixed debt/residue ranks and finite-palette uniformly bounded progress. | Unbounded return mechanisms and larger rank classes remain possible. |
| Fixed Thue–Morse valuation codes | Analytic recurrence argument forces a positive realization of any fixed nonerasing binary Thue–Morse valuation morphism onto a cycle; strict growth excludes the specified candidate subclasses. | Full coding/height/substitution proof is prose; only finite prefix/affine components are Lean. General positive cycles are not excluded. |
| Additive YAH certificates | Lean verifies the13-row unlabelled and fixed two-state symbol/edge algebraic certificates, with their exact hypotheses. | Different theorem from scalar-arctic full/top; no arbitrary-label or all-algebra classification. |
| Inverse words, endpoint carry and prime renewal | Exact affine/CRT arithmetic, partial hard returns, finite prime-script realization and an infinite-code endpoint characterization with finite diagnostics. | A finite script may use a different seed; persistent renewal and positive realization of arbitrary infinite codes remain unproved. |
| Stopped disproof routes | Narrow Lean cores for branching-center rigidity, invariant constancy and polynomial-ratchet arithmetic; paired hostile audits and a prose ratio-generator obstruction. | Broader semantic applications are not automatically formalized. A file named Disproof is not a Collatz disproof. |
| Earlier corrected-log, coalescence and methodology work | Original arguments, failure records, formal coalescence criteria, orchestrator controls and provenance manifests retained. | Historical claims retain their original qualifications and later corrections. |
| Issues and bibliography | All eight open issues and eleven comments preserved, including unique transfer/coboundary and correction-prime arguments;36provisional source cards and linked notebook retained. | The Garcia–Tal source gate now passes; the overlapping corollary is attributed without independent novelty. Other source cards retain their review flags. |

The [38-entry claim manifest](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/33922a42e86646258d227d1e19c6cf7546a2f548/publication/claims.json), [claim registry](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/33922a42e86646258d227d1e19c6cf7546a2f548/proof-search/CLAIM_REGISTRY.md), [verification index](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/33922a42e86646258d227d1e19c6cf7546a2f548/verification/README.md), and [consolidation review](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/33922a42e86646258d227d1e19c6cf7546a2f548/research-review/consolidation-2026-09-05/REPORT.md) supply exact paths, hypotheses and source identities. The two historical lemmas called L15 have different full titles. Conflicting failure IDs are reconciled without dropping either result. The old Thue–Morse membership target is preserved as a superseded derivation.

## Formal verification and reproduction

Install the unchanged pinned leanprover/lean4:v4.33.1 release and run lake build. The publication workflow additionally compiles each tracked Lean module and each allowlisted archived derivation, audits exported declarations for unexpected axioms or sorryAx, and replays the explicit mathematical and documentation checkers. Complete commands and output are retained in verification.json and verification-logs.zip.

The field headline_declaration in publication metadata remains CollatzWork.firstContractionQuarterGap as an established formal audit anchor. It does not label the selected YAH venue theorem as Lean-checked. Formal proof checks establish only their actual types and assumptions; internal statement and novelty reviews are not external expert endorsement.

The source inventory and SHA256SUMS bind every distributed byte. Historical manifests authenticate their original revisions, including historical line-ending conventions; the current manifest authenticates this consolidation. The release tag identifies the publisher revision, while research-source.zip identifies the selected mathematical source.

## Attribution and sharing

Nolan Downard directed the research. AI systems materially assisted mathematical exploration, exact certificates, Lean developments, counterexample searches, literature comparisons and internal adversarial review. Recorded model labels include Astra and Codex; exact historical versions and a complete per-step attribution log are not available. The conservative AI-assisted contribution tier is used.

Classical Collatz parity arithmetic, semantic labeling and arctic interpretations retain their original attribution. Known reconstructions are not novelty claims. No external specialist endorsement, journal acceptance, DOI or solution of Collatz is claimed. The repository is the primary announcement; VibeMathed independently decides whether the restricted partial result meets its catalog criteria.
