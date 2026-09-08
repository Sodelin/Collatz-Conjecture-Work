---
title: Supporting mathematics research catalog
date: 2026-09-08
tags: [mathematics, reproducibility, research-artifacts, public-catalog]
status: source-presence-checked
---

# Supporting mathematics research catalog

The supporting work from six mathematics repositories is already available publicly on GitHub. This index brings together exact certificates, checkers, manuscripts, prior-art reviews, unsuccessful approaches, and bibliographies at fixed commits. Prove2Me upload receipts for the separate Lean exports belong in the parent [import report](../README.md).

These entries preserve the status stated by their sources. A public research artifact can be useful without being a new theorem, a Lean formalization, or an accepted publication.

| Project | Start here | Available supporting material | Claim boundary |
|---|---|---|---|
| Erdős #128 | [Restricted certificate](https://github.com/Sodelin/Erdos-Work/tree/408f225cc4c24e897008b885b4e6b76873c7990e/research/results/erdos128) | JSON containing 32 rational triangular cells and 13 partition lines; two exact-arithmetic Python checkers; [full-target prior-art review](https://github.com/Sodelin/Erdos-Work/blob/d6ea128def74cb47c75988377d24b29ff340f5a1/research/reviews/erdos128-prior-art-2026-09-07.md) | Restricted symmetric weights on the Grötzsch graph; external theorem dependency; no Lean proof of the full conjecture |
| Phase-erasure spectrum | [Manuscript](https://github.com/Sodelin/ai-math-discovery/blob/251238baa23332faca792e584bc0939188308dd8/papers/phase-erasure-spectrum/MANUSCRIPT.md) · [PDF](https://github.com/Sodelin/ai-math-discovery/blob/251238baa23332faca792e584bc0939188308dd8/output/pdf/phase-erasure-spectrum.pdf) | Eight [claim records](https://github.com/Sodelin/ai-math-discovery/blob/251238baa23332faca792e584bc0939188308dd8/discoveries/AI-MATH-0001/CLAIMS.json), finite checkers, prior-art and internal audits, [retired candidates](https://github.com/Sodelin/ai-math-discovery/tree/251238baa23332faca792e584bc0939188308dd8/killed) | Candidate manuscript; all eight records report formal verification unavailable; specialist and priority review remain open |
| Collatz work | [Research announcement](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/026aa4ad4be6453a005ab950b160a9f2204c5271/publication/announcement.md) · [Versioned research release](https://github.com/Sodelin/Collatz-Conjecture-Work/releases/tag/research-d45362b75a8b-026aa4ad4be6) | [40 claim groups](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/026aa4ad4be6453a005ab950b160a9f2204c5271/publication/claims.json), YAH manuscript, Python/JSON certificates, proof-search routes, source notes, historical and negative results | Claim-by-claim formal/prose boundaries apply; the YAH scalar-arctic certificate theorem is not itself Lean-formalized; global Collatz unresolved |
| Erdős #302 finite transfers | [Results through 734](https://github.com/Sodelin/oldest-conjecture-/blob/48bcf1429395b980198207bf6a876994fab80789/RESULT-734.md) | Three JSON witnesses of sizes 606/607/608, integer verifiers, [general identity in prose](https://github.com/Sodelin/oldest-conjecture-/blob/48bcf1429395b980198207bf6a876994fab80789/docs/general-identity.md), novelty and submission records | Formal transfer relations accompany these files; external upper bound at 731 is not formalized; historical submissions do not imply acceptance |
| Egyptian fractions #295 | [Research record](https://github.com/Sodelin/Egyptian-Fractions-Erdos-295/blob/566f9800910aae6936d93d1a9f5c756070616f31/docs/research-record.md) | [Bounded construction probes](https://github.com/Sodelin/Egyptian-Fractions-Erdos-295/tree/566f9800910aae6936d93d1a9f5c756070616f31/probes), outputs and known-baseline explanation | Reproduces a known 35-term witness with denominators at least 18; failed searches do not prove a lower bound |
| Ranked certificates and blindness | [Blindness posting packet](https://github.com/Sodelin/new-math-discovery/blob/fc2ce68341a0556cebb4e5843a3127f0881b91db/publication/BLINDNESS_REALIZATION_POSTING_PACKET.md) | [Finite certificate and checkers](https://github.com/Sodelin/new-math-discovery/tree/fc2ce68341a0556cebb4e5843a3127f0881b91db/verification), ranked-certificate specifications, frontier memo, provenance | Selected supplemental branch includes the additional blindness Lean modules; no global Collatz certificate or novelty claim |

The Collatz research release distinguishes the mathematical source commit `d45362b75a8b48c7067e6db864e948be713f32e9` from the publisher commit `026aa4ad4be6453a005ab950b160a9f2204c5271`. Its named `research-source.zip` asset is the mathematical archive; GitHub's automatic source downloads reflect the tagged publisher commit.

## Coverage and recovery findings

- [catalog.json](catalog.json) records 10 collections and 58 concrete file/directory links with descriptions and scope limits. [source-inventory.json](source-inventory.json) records every tracked path, Git blob hash, and byte size for eight checked snapshots across six repositories.
- Both branches of `Erdos-Work` and `ai-math-discovery` were checked using complete GitHub trees. Neither contains a `.lean` file. `math-paper-denied` has no branches or source files to publish.
- The phase-erasure manuscript branch is **four commits ahead and one behind** its current main. Main's [assertion-mode safeguards](https://github.com/Sodelin/ai-math-discovery/blob/08cbb7cd2c3f2fe0625c181d9f22ac835f964ebf/tests/test_assertion_modes.py) are absent from the manuscript branch; both snapshots are catalogued. No merge was performed.
- Comparing retained remote branches of the four Lean repositories against their selected source commits found no additional Lean changes requiring another import. This is a snapshot audit, not a claim about inaccessible past conversations or future commits.
- One historical source reference remains unrecovered: [the arithmetic-orbit-geometry record](https://github.com/Sodelin/ai-math-discovery/blob/251238baa23332faca792e584bc0939188308dd8/research-programs/CROSS_PROJECT_EVIDENCE.json) names `lean/CollatzWork/AOGGhostContactCore.lean` and eight theorem exports. That file and those identifiers were not found in the inspected Lean sources. The record itself says canonical publication was pending. Its reported build cannot substitute for the missing source, so it is excluded from uploadable-proof counts. A bounded recovery check found no matching path or ghost-related commit in the local `git log --all` history of Collatz/new-math, and GitHub returned no commits for the exact Collatz path. The [record-creation commit](https://github.com/Sodelin/ai-math-discovery/commit/bedfb0e12bf2c28c2c0d33dab4e168201267a027) and [record-expansion commit](https://github.com/Sodelin/ai-math-discovery/commit/fc126ae25ab8d9039e517682d0963c80436d6304) contain metadata but no Lean source or source commit. The original isolated task identifier is retained in `catalog.json` for later recovery.
- The Erdős #128 prior-art report describes a Clebsch method-barrier replay, but the inspected branch trees contain no separately named program for that replay. Its documented result is preserved as a review record; a standalone replay artifact is not claimed.

## Reuse and verification

Use the commit-pinned links above to preserve exactly which version you read. The JSON catalog can be filtered by `evidence_class` to find executable certificates, formal-theorem context, research plans, or negative results. Every commit-pinned source link already existed publicly when checked. The additional recovered files below are included with this catalog. This catalog does not imply that it was also submitted to Prove2Me, a journal, or another archive.

This task verified file presence, pinned source identities, branch coverage, and the correspondence of the summaries with their source records. It did not rerun the non-Lean checkers or independently review the mathematical arguments. The separate Lean build and type checks are recorded in the parent import report.

For Zotero, the phase-erasure [references](https://github.com/Sodelin/ai-math-discovery/blob/251238baa23332faca792e584bc0939188308dd8/papers/phase-erasure-spectrum/REFERENCES.bib) and [existing archive notes](https://github.com/Sodelin/ai-math-discovery/tree/251238baa23332faca792e584bc0939188308dd8/archive/zotero) are directly linked. The Collatz [source bibliography](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/026aa4ad4be6453a005ab950b160a9f2204c5271/knowledge/sources/collatz_ai_assisted_research.bib) accompanies its linked source notes. Keep candidate manuscripts and computational artifacts tagged with their evidence status when importing them into a notebook.

No credentials or API keys are included in this index.


## Recovered historical files

The bounded saved-file check recovered two additional Round 6B sources absent from the eight catalogued snapshots and retained Collatz git-history blobs:

- [Terminal approximation-barrier dossier](library-archive/Collatz_Round6B_Terminal_Approximation_Barrier_Dossier_2026-08-01.md), 26,287 bytes.
- [Round 6B Python checker](library-archive/collatz_round6b_checks.py), 7,697 bytes.

Both files' SHA256 values match the independently saved [original checksum manifest](library-archive/Collatz_Round6B_SHA256_2026-08-01.txt). They are preserved as historical research, with their original caveats. The checker has not been rerun here, the dossier has not received a new mathematical audit, and neither is a Lean proof. Its historical private-research label describes the original document; the owner subsequently authorized this math archive.

The [claim-ledger read export](library-archive/Collatz_Round6B_Claim_Ledger_2026-08-01.read-export.txt) preserves parsed text, **not the original CSV bytes**. Its formatting differs from the saved CSV, and it is named accordingly. [provenance.json](library-archive/provenance.json) records file identities, hashes, exact recovery methods, and the distinction.

The broad archive remains a coverage gap. The required download route returned HTTP502 for the selected recent packets and again for the 4.2 MB full archive. No opaque or partially downloaded ZIP was published. The [bounded filename inventory](library-search-inventory.json) records 100 Collatz matches, many duplicate formats and copies; those uninspected files are not counted as archived here. No additional AOG or standalone Lean filename was located. This checkpoint must not be described as a complete recovery of every saved math file.
