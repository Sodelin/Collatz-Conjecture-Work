# Focused prior-art audit: restricted YAH scalar-arctic obstruction

Audit date: 2026-09-05. This is a bounded, claim-specific literature and author-code review. It supplements `research-review/novelty-2026-09-05/YAH_REVIEW.md`; it does not independently certify the project's encoding semantics or establish priority.

## Decision

No earlier theorem proving the exact **original eleven-rule mixed-base, standard coefficientwise, dimension-one arctic-natural, full-plus-relative-top first-step exclusion** was located in the inspected sources. The fixed two-state twenty-two-rule extension was likewise not located. This supports keeping the combined package as a **candidate narrow contribution**, subject to semantic and external novelty review.

The **original full scalar part alone should not be the novelty headline**. Its reduction to additive letter weights and linear feasibility is old machinery, and its particular contradiction is elementary. The useful candidate is the precisely delimited, unbounded-coefficient **top plus fixed-label certificate package**, with the full scalar result presented as its introductory lemma.

The defensible unresolved-question framing is: **a restricted first-step subcase of a published research direction**. The audit did not establish that anyone had separately posed the exact scalar subproblem or that the broader research direction has been answered.

## Exact object under comparison

The candidate excludes an interpretation that weakly orients all rules and strictly orients at least one allowed target before any rules have been removed. The full case uses finite scalar arctic slopes. The relative-top cases allow unary affine max-plus maps

$$
[\sigma](x)=\max(m_\sigma+x,v_\sigma),\qquad m_\sigma,v_\sigma\in\mathbb N\cup\{-\infty\},
$$

with at least one finite component and the project's standard coefficientwise comparison convention. The designated top targets are boundary rules in the original orientation and dynamic rules in the reversed orientation. The labeled theorem concerns exactly the stored two-state labeling, with original-system results obtained by assigning both labels the same interpretation.

This is a theorem about a specified proof-search class. It does not imply termination, nontermination, undecidability, failure of all matrix interpretations, failure of all labelings, or failure of later scalar steps after another method removes rules. In particular, the twenty-two-rule labeling is not a theorem about every possible two-state semantic labeling.

## Primary comparison matrix

| Comparator | What was inspected | Relationship and consequence |
|---|---|---|
| Yolcu–Aaronson–Heule, *An Automated Approach to the Collatz Conjecture*, JAR 67, article 15 (2023), DOI `10.1007/s10817-022-09658-8`; arXiv `2105.14697v3` | §§2.3, 3.1.1, Lemma 3.18, §§4.3–4.4, §6 in the 44-page journal PDF | The unary natural-matrix impossibility is a different theorem. Lemma 3.18 supplies the two top opportunities. The mixed-base general impossibility direction remains prospective in §6. |
| Gebhardt–Waldmann, *Weighted Automata Define a Hierarchy of Terminating String Rewriting Systems*, Acta Cybernetica 19(2), 295–312 (2009) | §6, Lemmas 5–6; discussion of decidability and non-strict semirings | Scalar additive letter-weight feasibility is established machinery. The paper explicitly limits transfer of its general hierarchy arguments to max-plus. It supplies neither the specific YAH instance nor the affine-top certificate theorem. |
| Koprowski–Waldmann, *Max/Plus Tree Automata for Termination of Term Rewriting*, Acta Cybernetica 19(2), 357–392 (2009) | §§6–8, Theorem 7.1, certification §10, discussion §12 and Lemma 12.1 | Foundational arctic-natural/top framework and certification predate the project. Linear complexity for a full arctic termination proof does not itself exclude a first relative step with only some strict rules. |
| Neurauter–Middeldorp, *Revisiting Matrix Interpretations for Proving Termination of Term Rewriting*, RTA 2011, 251–266 | Publisher abstract and PDF terminology scan | Studies alternative vector orders for ordinary nonnegative matrix interpretations. No matching arctic scalar obstruction located; reinforces that a restricted order must not be called all matrix interpretations. |
| `emreyolcu/rewriting-collatz`, commit `8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340` | Fresh clone; 84 tracked/worktree files listed; README, eleven-rule table, complete `prover/arctic.py`, `subsystems.py`, proof scripts and targeted text searches | Author implementation is a bounded search and proof-decoding reference, not an unbounded impossibility certificate. No matching no-first-step theorem or certificate payload located in that snapshot. |
| Yolcu, June 2023 Dagstuhl talk and resulting seminar report | Public 78-page slide deck, relevant impossibility slides; report §3.21 | Reiterates unary natural-matrix obstruction and encoding changes, with no located scalar-arctic mixed-base exclusion. |

### Why the original paper does not already settle this

YAH's Theorems 3.8 and 3.10 exclude natural-matrix approaches for the **unary** encoding, including a dependency-pair form. The paper explains that its rational-sequence argument loses its direct basis when numbers use mixed-base representations. Section 6 then proposes possible absence of suitable interpretations for the mixed-base system as an interesting direction. The exact scalar question is not separately numbered. Consequently, describing the project as a restricted response to that direction is justified; claiming it answers the general question is not. The coefficients/order must also be qualified because §2.3's arctic coefficient tests are sufficient conditions for functional comparisons. [Journal version](https://link.springer.com/content/pdf/10.1007/s10817-022-09658-8.pdf).

### Why the full scalar lemma is modest

Gebhardt–Waldmann §6 explicitly turns one-state multiplicative weights into additive letter weights through logarithms and expresses weak/strict orientation as linear inequalities. Its Lemma 6 combines successive scalar weight proofs. The discussion also notes scalar feasibility is decidable. Those are strong prior-art reasons to treat additive cancellation as established technique. Crucially, the same discussion says the broader hierarchy arguments require different methods for non-strict semirings such as max-plus; it is not a ready-made theorem about affine arctic-top interpretations. [Primary PDF](https://cyber.bibl.u-szeged.hu/index.php/actcybern/article/view/3770/3754).

Independent instance analysis: write the five internal finite slopes as `a,b,c,d,e`. The weak rule inequalities include

$$
b\ge e,\quad e\ge a+b,\quad a+d\ge c+b,\quad c\ge d,\quad e\ge d.
$$

Nonnegativity forces `a=0`, `e=b`, then `b=0`, `c=d`, and finally `d=c=0`. Boundary symbols cancel. Thus all rule slope comparisons are equal and no rule can be strict. This is a short application of elementary linear reasoning. A replayable certificate is useful provenance and implementation work, but is not evidence of a newly invented method.

### Why two tempting general shortcuts do not settle the top claim

Koprowski–Waldmann Theorem 7.1 uses somewhere-finite arctic-natural interpretations for relative-top termination. Its §10 already discusses formal certification, so the general idea of certifying arctic interpretations is not new. Lemma 12.1 bounds derivation length linearly when a full arctic interpretation proves the complete system terminating. That is weaker than an exclusion of **every first relative step**: some rules can remain weak, and their occurrences need not be bounded by the strict decrease count. The paper also distinguishes arctic-natural and below-zero prerequisites. [Primary PDF](https://cyber.bibl.u-szeged.hu/index.php/actcybern/article/view/3772/3756).

Our comparison inference: neither a known all-strict complexity barrier nor a scalar multiplicative hierarchy theorem supplies the missing finite-support/intercept argument for the project's top cases. A new direct proof could still simplify those cases; this audit has not shown their difficulty or significance is high merely because a certificate has many clauses.

Neurauter–Middeldorp study alternative orders based on vector norms, including a stronger variant of ordinary matrix interpretation. These are scope counterexamples to an overbroad phrase such as “matrix interpretations cannot work,” rather than an identified proof of the current obstruction. [Publisher record and PDF](https://drops.dagstuhl.de/entities/document/10.4230/LIPIcs.RTA.2011.251).

## Author-code and follow-up checks

The fresh author clone still ended at the October 7, 2023 README commit `8a4dfda6`. Its ASCII system maps `a,b,c,d,e,f,g` to the project's `f,t,^,$,0,1,2`; the eleven rule strings agree under that renaming. In `ArcticEncoder`, `full` omits constant vectors; the other mode composes them by max-plus. `relate` applies coefficientwise comparisons and `ArcticDecoder.checkrel` uses the bottom/bottom strict-comparison convention. These observations support comparison with the actual implemented class, not universal functional-order equivalence. [Rule file](https://github.com/emreyolcu/rewriting-collatz/blob/8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340/rules/collatz-T.srs), [arctic code](https://github.com/emreyolcu/rewriting-collatz/blob/8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340/prover/arctic.py).

`subsystems.py` searches dimensions 1–7, bounded result widths, and timed runs of proper subsystems. Its timeout/unsuccessful return path is not a quantified no-solution theorem over unbounded coefficients. No Farkas/RUP impossibility artifact or scalar no-first-step statement was located by the clone-wide targeted search. This is a snapshot observation, not an assertion about every branch, fork, private computation or unpublished author knowledge. [Subsystem search](https://github.com/emreyolcu/rewriting-collatz/blob/8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340/subsystems.py).

Yolcu's current public publication list links the original 2021/2023 work and the June 2023 encoding talk. The talk's nonexistence slides concern unary natural matrices; the Dagstuhl report §3.21 says the same. No new focused obstruction was found there. [Author bibliography](https://emreyolcu.com/), [talk](https://emreyolcu.com/talks/encoding-collatz.pdf), [seminar report](https://drops.dagstuhl.de/storage/04dagstuhl-reports/volume13/issue06/23261/html/DagRep.13.6.106/DagRep.13.6.106.html).

## Publication recommendation

Proposed title: **Exact certificates excluding scalar arctic-natural first steps for the mixed-base Collatz rewrite system**.

Proposed question: **Can an unbounded-coefficient dimension-one arctic-natural interpretation, under the standard coefficientwise constraints, remove any rule at the start of the specified full or relative-top proof searches for the eleven-rule mixed-base system?**

Proposed answer: **The supplied exact certificates exclude the specified first steps, including their fixed two-state labeled versions.**

Keep the combined artifact public and give a curator the specific theorem statement, source SHA, semantic review, direct checker commands, and this comparison. Use the actual verification category: exact independently replayable Python certificates are not Lean-checked mathematics. Any newly added Lean result must list precisely which portion it covers. Treat the full scalar lemma as an elementary component, not a standalone “previously open problem solved.”

VibeMathed's methodology permits genuine partial results but excludes routine rediscovery or formalization alone. The combined top/labeled obstruction is a defensible **candidate partial result for curator assessment**, provided the semantic review succeeds. This prior-art audit finds no specific matching theorem that blocks such a carefully qualified submission. It does not establish venue acceptance, independent mathematical endorsement, or novelty certification. [Venue methodology](https://vibemathed.com/methodology).

The most useful remaining loose end is a specialist's exact statement comparison or a verified interpretation-to-constraint bridge. Repeating a broad Collatz search or an identical certificate replay would add substantially less evidence. No reviewer was contacted in this audit.

## Reproducible search ledger

All searches were performed on 2026-09-05 with the web search tool. Ranked results were screened for actual proof-method relevance, and primary papers/code were inspected. Search results often ignored multiple quoted terms or produced geographic “Arctic” noise; these are recorded as low-precision searches, not negative mathematical evidence. No alphaXiv discovery call was made by this subtask because the parent reserved that route.

Literal queries, in order:

1. `Yolcu Aaronson Heule 2023 automated techniques Collatz arctic interpretation conjecture`
2. `"Collatz" "arctic" "dimension" nonexistence`
3. `"Collatz" "matrix interpretations" impossible`
4. `"Max/plus tree automata for termination of term rewriting" pdf`
5. `"Collatz" "arctic" -site:facebook.com -site:researchgate.net -site:alphaxiv.org -site:scribd.com`
6. `"An Automated Approach to the Collatz Conjecture" "nonexistence" -site:researchgate.net -site:alphaxiv.org`
7. `Koprowski Waldmann Max plus tree automata termination 2009 pdf`
8. `Collatz arctic scalar interpretations nonexistence Yolcu 2025 2026`
9. `Collatz scalar arctic nonexistence`
10. `Yolcu mixed base arctic impossibility 2024 2025 2026`
11. `Collatz rewriting first step obstruction matrix interpretations`
12. `Yolcu Aaronson Heule citations rewriting arctic`
13. `site:arxiv.org Collatz "rewriting" "arctic"`
14. `site:github.com "collatz" "arctic" "unsat"`
15. `site:imn.htwk-leipzig.de Collatz arctic`
16. `site:cs.cmu.edu Collatz arctic obstruction`
17. `Collatz arctic interpretations`, with domains `arxiv.org`, `github.com`, `drops.dagstuhl.de`, `cs.cmu.edu`, `imn.htwk-leipzig.de`
18. `Yolcu rewriting Collatz obstruction scalar arctic natural`
19. `mixed-base Collatz arctic-naturals first rule`
20. `Collatz arctic Farkas RUP certificate`
21. `An Automated Approach to the Collatz Conjecture Yolcu 2023 citations`, with domains `emreyolcu.com`, `cs.cmu.edu`, `drops.dagstuhl.de`

Searches 1–3 located YAH primary versions and author material. Query 7 located the primary Acta Cybernetica issue; reference chaining from that issue found both 2009 articles. Queries 9–20 mostly returned existing YAH records, unrelated results, or citation snippets without a matching theorem. Query 21 located the author publication page and primary Dagstuhl report. These searches do not provide reliable total corpus counts or complete citation-graph coverage.

Local primary-code scan: `rg --files` produced 84 files. `rg -n -i 'nonexist|no.?go|impossib|unsat|dimension.?one|dimension.?1|scalar|farkas|certificate' . --glob '!*.pdf' --glob '!*.log' --glob '!*.dimacs'` found bounded solver statuses, decoder formatting and Farkas-variant proof script references, not an impossibility theorem. An initial named-directory scan mentioned a nonexistent `scripts` directory and exited 2; the subsequent repository-wide scan exited 0. This error was corrected, not treated as a completed search.

Downloaded journal PDFs were extracted with `pdftotext -layout`. YAH extraction was inspected around §§2.3, 3.1.1, 3.18, 4.3–4.4 and 6; the two Acta papers were searched and inspected at the sections cited above. The Neurauter–Middeldorp PDF yielded no `arctic` hit. Keyword absence is used only to describe this inspection, never as a priority certificate.

## Assessment and limits

**Process integrity:** strong primary version and code identification; moderate coverage of the narrow historical method family. The important improvement over the previous pass is an actual comparison with scalar weight hierarchies and arctic complexity theorems. General web search performed poorly on exact terminology, and no complete forward-citation index or all-forks crawl was completed.

**Inference robustness:** high confidence that the unary theorem, ordinary scalar weight machinery, full-arctic complexity bound, and affine-top exclusion must be kept separate. Moderate confidence that the combined top/labeled artifact warrants a targeted research submission or specialist review. Insufficient evidence to certify first occurrence or to label the result a resolution of the full YAH direction. An exact earlier exclusion, a general theorem immediately implying all top cases, or a semantic counterexample would change this verdict.
