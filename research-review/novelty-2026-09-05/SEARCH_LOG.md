# Search trail — 5 September 2026

Return to the [review report](REPORT.md). This records the bounded novelty pass, not every earlier publishing lookup. Repeated queries across independent tracks are retained. Search result totals were not consistently exposed; no total screened-literature count is fabricated.

## AlphaXiv discovery

Two requests returned 18 ranked records, 12 unique IDs. [discovery.json](discovery.json) preserves literal questions, keywords, ranking preferences, IDs, titles, and each screening depth/outcome. Three direct comparators received detailed extraction; other candidates range from full HTML to abstract-only or unresolved.

## Literal web searches

### Classical source search

1. `Collatz Terras Everett Garner coefficient stopping time paradoxical sequences`
2. `Collatz "mechanical" "stopping"`
3. `Collatz "quarter" "gap" stopping`
4. `Collatz "C" "Sturmian" Garner`
5. `Terras 1976 stopping time problem integers 3n 1 pdf`
6. `Garner 1981 Collatz algorithm stopping time pdf`
7. `"Collatz" "coefficient stopping" "bound"`
8. `"3x+1 conjugacy map over a Sturmian word" pdf`
9. `"On the Collatz 3n" "Garner" pdf -site:researchgate.net -site:semanticscholar.org -site:scispace.com`
10. `"Terras" "2.9" "1976" Collatz`
11. `"Sturmian" "López" "Stoll" pdf Collatz 2009`
12. `"Collatz" "3n" "Garner" "Theorem"`
13. `site.integers-ejcnt.org "Sturmian" "2009"`
14. `Collatz Garner theorem r k stopping 1981 bound`
15. `"Collatz" "Eliahou" "1993" pdf`
16. `"THE 3x + 1 CONJUGACY MAP OVER A STURMIAN WORD"`
17. `"A stopping time problem" "pdf" Terras -site:reddit.com -site:scirp.org`
18. `"On the Collatz" "bound condition" Garner`
19. `"Collatz" "quarter" remainder -site:reddit.com -site:facebook.com -site:medium.com`
20. `"Garner" "Collatz" "k(n)"`
21. `"Garner" "Collatz" "Theorem" "2"`
22. `"Sturmian" "Lopez" "Stoll" "math.colgate.edu"`
23. `"Collatz" "Cmax"`
24. `site:ams.org/journals/proc/1981-082-01 "bound" "k"`
25. `site:ams.org/journals/proc/1981-082-01 "3" "Theorem" "n"`
26. `site:jstor.org/stable/2044308 "Theorem"`
27. `site:math.colgate.edu/~integers/ "Sturmian" "Conjugacy"`
28. `Collatz "2349463"`
29. `Collatz "9833" "262144"`
30. `Collatz "floor" "remainder" "stopping time" sum`
31. `Collatz "sum" "fractional parts" "log" stopping`
32. `"Collatz" "3/4" "remainder"`
33. `"Collatz" "s/4" stopping`
34. `"Collatz" "n/4" "coefficient"`
35. `"Garner" "B(M)" Collatz`

### Implication search

1. `Garner "On the Collatz 3n+1 algorithm" remainder stopping time 1981 pdf`
2. `Terras 1976 stopping time problem positive integers coefficient stopping time pdf`
3. `"Garner" "Collatz" "ams.org" "1981"`
4. `"A stopping time problem" "pdf" -site:reddit.com`
5. `"Collatz" "quarter" "remainder"`
6. `"Collatz" "mechanical" "envelope"`
7. `"Garner" "Collatz" "603593" pdf`
8. `"Collatz" "sum" "floor" "remainder" "stopping"`
9. `"Collatz" "3s/4"`
10. `"Collatz" "1/(6" "log" "remainder"`
11. `"Collatz" "fractional parts" "remainder"`
12. `"Collatz" "mechanical word" stopping`
13. `"Collatz" "Weyl" "remainder"`
14. `"Collatz" "16" "quarter"`
15. `Weyl Über die Gleichverteilung von Zahlen mod Eins 1916 pdf`
16. `"Collatz" "S_s" "rotation"`
17. `"Collatz" "1/(6" "ln"`

### Formal code and secondary claims

1. `"Collatz" "Lean" "quarter"`
2. `"2603.11066"`
3. `"Collatz" "mechanical" "envelope"`
4. `"Collatz" "arctic" "YAH"`
5. `site:github.com "Collatz" "Lean" "floor"`
6. `site:github.com "formal-conjectures" "Collatz"`
7. `site:github.com/leanprover-community/mathlib4 Collatz`
8. `Collatz Lean formalization github "theorem"`
9. `"Yolcu" "Aaronson" "Heule" "arctic" "one"`
10. `"Collatz" "2349463"`
11. `"Collatz" "quarter-gap"`
12. `"A Machine-Verified Conditional Theory of the Collatz Conjecture" github`
13. `"Collatz" "mechanical" "16" "Lean"`
14. `"Collatz" "first contraction" "four"`
15. `"Collatz" "arctic" "dimension-one"`
16. `site:vibemathed.com formalization novel submission`

### Coordinator follow-up

1. `"POINTWISE SURVIVOR DISCREPANCY" Collatz`
2. `site:ccchallenge.org Rozier Terracol formalizations`

## Code searches and indexing limits

Default-branch GitHub connector queries: `Collatz` in mathlib4 (cap10, zero); `firstContractionQuarterGap` globally (cap10, zero); `Collatz` in formal-conjectures (cap10, seven); `mechanical` and `quarter` in SergioTheory/Collatz-new-math and QuixiAI/collatz (cap10 each, zero); `shadow_val_Z` in SergioTheory (cap3, zero); `arctic` in emreyolcu/rewriting-collatz (cap10, ten, capped). The missed `shadow_val_Z` exists in fetched code, demonstrating incomplete indexing. Pins are in the report and bibliography.

## Primary extraction and identity checks

- Rozier–Terracol: latest arXiv v5, selected definitions and Theorems 2.4/4.2, Lemmas 2.3/2.5, Corollary 5.4; raw PDF pages compared with official HTML.
- Chang2603.11066v6: full raw extraction, selected descent/Mersenne passages, and searches for `Lean`, `github`, `quarter`, `first coefficient`, `mechanical`, `Cmax`, `Yolcu`, `arctic`, `Mersenne`, `below-start`, and numeric fingerprints. The 630 labeled claims were not all audited.
- Niu2605.13886: raw v1 extracted; official v2 then confirmed withdrawal. V1 is historical-only evidence.
- Terras/Garner title-based alphaXiv PDF queries resolved to Crooks/Nwoke2209.05995v1. Excluded for identity mismatch.
- Lagarias1985: university-hosted scan, printed pages 8–12 visually inspected.
- HH1997: author PDF pp228–235, with Proposition2 transcribed and compared algebraically. A follow-up screenshot had a content-type error; searchable primary text remained available.
- López–Stoll2009: official journal PDF, Theorem1/Corollary2/Example8/Section4. An initially guessed path was a different graph paper and excluded after title checking.
- Cigler1969: journal archive pp151–154, linear equidistribution specialization.
- YAH: official paper relevant semantics, Lemma3.18 and future-work passage; author arctic.py at pinned8a4dfda6; actual project certificate code independently replayed.
- Kramer2607.10041v1: official full HTML §§3–4, including theorem/proof and critical-code baselines.
- De Jesus: July2026 author-uploaded ResearchGate fulltext selected §§2,3,16 and novelty boundary; related width-two model. Search for `quarter` found only unrelated cited-material context, not the target bound; `2349463` absent. No validation of all theorems claimed.
- Specialist Collatz catalog: public records and linked Terras/Rozier–Terracol formalizations followed; final details in the report.

## Access failures and unresolved coverage

- AMS Garner original:403 via ordinary web and Python reads. JSTOR stable record exposed only a shell.
- Terras ICM PDF:403; official download failed; EuDML routes failed. Catalog or secondary descriptions do not substitute for a full-text exclusion.
- Everett DOI and original Eliahou fulltext not fully audited.
- Zenodo21325038 failed in web; author-uploaded ResearchGate text was accessible.
- arXiv2608.25791 and2606.26811 official abstract reads returned DisabledError. These remain discovery-only leads.
- No full independent build of external Lean repositories, no exhaustive GitHub crawl, and no comprehensive MathSciNet/zbMATH query.
- Open Evidence Search workflow was consulted for routing; its dedicated provider was not callable and was not used. AlphaXiv, web, and GitHub were the actual search/retrieval surfaces.

## Yield and stopping rule

The final catalog follow-up used public GET panels `/htmx/paper-detail/Terras1976?tab=formalisations`, `/htmx/paper-detail/Terras1976?tab=reviews`, `/htmx/paper-detail/Garner1981?tab=reviews`, and `/htmx/paper-detail/RozierTerracol2025?tab=formalisations` on `ccchallenge.org`. Linked code was inspected at `lechmazur/terras_density_one` commit `83c436ccd727c35b7ef7b497558be9395e011b83`, `rwst/lean-code` commit `ce1619b6418dc263efb911b11ad09409c2083d80` (14 direct RT files plus theorem index), and `rwst/Collatz-Map-Basics` commit `96e063fde9f5153a492a809e9ebce3c235a73d20` (selected RozierTerracol files). No compilation was performed. The linked [Lagarias annotated bibliography](https://arxiv.org/pdf/math/0309224) entries 71 and 164 were read as secondary historical reviews; they did not close original Terras/Garner proof access. A visibly suspicious inequality in the Garner review was not silently repaired or adopted as verified.

Classical queries located direct machinery overlap; implication queries exposed a standard qualitative corollary and ruled out one concrete stronger-bound transfer; code queries corrected several assumption-free-proof impressions. Numeric/name searches located no exact quarter/16 match in returned results. This bounded pass stops with explicit remaining comparators and expert-review obligations. It does not convert absence of hits into originality.
