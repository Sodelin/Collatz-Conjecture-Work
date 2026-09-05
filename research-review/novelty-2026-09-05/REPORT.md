# Collatz novelty and submission review — 5 September 2026

## 0. Decision

**The research package is shareable now; hold the VibeMathed submission.** The publishing process has completed a real release and a saved, reopened submission draft. The remaining decision concerns mathematical novelty and venue eligibility.

The strongest candidates are (a) the explicit sharp eventual threshold **16**, its exact twelve-step certificate, and the conditional quarter-gap corollary; and (b) the original YAH system's carefully scoped dimension-one arctic full-plus-top obstruction. Neither has certified priority. Several surrounding lemmas and methods are classical or elementary.

This is a bounded evidence map with adversarial implication checks. It is not an exhaustive literature review, an independent expert endorsement, or a proof of the Collatz conjecture.

## 1. Audited objects

Mathematical source: [revision 33922a42e86646258d227d1e19c6cf7546a2f548](https://github.com/Sodelin/Collatz-Conjecture-Work/tree/33922a42e86646258d227d1e19c6cf7546a2f548). Publisher: `a3d99ab909992bf72e6e2e0907cb8d50248fa1b8`.

The [public research release](https://github.com/Sodelin/Collatz-Conjecture-Work/releases/tag/research-33922a42e866-a3d99ab90999) contains the frozen mathematical source, Lean source and build configuration, claim inventory, citations, venue exports, hashes, and fresh verification logs. All 34 verification commands passed; 41 declarations received explicit axiom audits. These checks establish only their recorded scopes.

Companion records: [mathematical comparisons](COMPARISONS.md), [search trail](SEARCH_LOG.md), [machine-readable review](review.json), [BibTeX bibliography](references.bib), and [workflow rehearsal](workflow-rehearsal.json). This review annotates the frozen source; it does not promote its canonical novelty ratings or modify the mathematical branch.

## 2. Exact question and normalization

Use the shortcut map $T(n)=n/2$ for even $n$, and $T(n)=(3n+1)/2$ for odd $n$. Let $s_j$ count odd branches in the first $j$ steps. The Lean theorem assumes a positive start, a finite first coefficient contraction $k>0$,

$$
3^{s_k}<2^k,\qquad 2^j\leq 3^{s_j}\quad(0\leq j<k),\qquad T^k(n)=n+d,
$$

with $d$ a natural number. It concludes $4d<s_k$. Existence of such a contraction for every start is not a proved premise supplied by this project.

Threshold 16 belongs to the stronger supporting envelope $4M_s\leq s3^s$, valid for every $s\geq16$ and false at 15. It is **not** a restriction $s\geq16$ on the final quarter-gap theorem, and one quarter is not the optimal asymptotic coefficient of this envelope.

## 3. Search coverage

The review combined alphaXiv discovery and raw paper extraction, official arXiv version records, publisher and author-hosted classical papers, citation follow-up, a specialist Collatz bibliography, and pinned GitHub source inspections. Parallel passes compared classical statements, mathematical implications, and formalization claims.

Two alphaXiv discovery requests returned 18 ranked records representing 12 distinct papers. Their complete identifiers and screening outcomes are retained in [review.json](review.json). The [search trail](SEARCH_LOG.md) records literal web/code queries, source locators, caps, and retrieval failures. There was no comprehensive MathSciNet or zbMATH search, no citation-network closure, and no Open Evidence Search provider call; that workflow informed routing, while the actual available scholarly connector was alphaXiv.

## 4. Claim-level verdicts

| Claim family | Assessment | Appropriate framing |
|---|---|---|
| Parity-affine identity and first coefficient stopping framework | Classical | Attribution and reusable formalization |
| Critical mechanical word and remainder ordering | Established machinery; extremizer follows with a short deadline argument | Supporting lemma, not an originality headline |
| Existence of some eventual quarter envelope | Standard equidistribution consequence once the sum is identified | Known general method applied to this sum |
| Optimal eventual cutoff 16, exact twelve-step maximum, all-count crossing certificate | No exact earlier match located; closest explicit older bound does not directly imply it | Candidate quantitative sharpening with Lean certificate |
| Actual-orbit conditional $4d<s$ | Cleanly scoped Lean result; novelty unconfirmed | Conditional restriction on hypothetical first-contraction failures |
| Descent/convergence equivalence, elementary coalescence identities | Known or elementary | Verification infrastructure |
| Original YAH dimension-one full-plus-top exclusion and fixed labeling | Plausible narrow contribution; the full scalar slope argument alone is elementary | Specialist review of exact interpretation-class obstruction |
| Restricted bounded matrix UNSAT / timeout | Bounded computational evidence | Search record, never an unbounded impossibility theorem |
| Universal Collatz convergence | Unproved | Open |

## 5. Closest classical literature

[Lagarias (1985), Theorems C and E, printed pp.8–11](https://web.williams.edu/Mathematics/sjmiller/public_html/355Sp24/addcomments/Lagarias_3x%2B1AndItsGeneralizations.pdf), gives the first-contraction admissibility/residue framework and restrictions on possible exceptional representatives. Terras (1976) and Garner (1981) are essential underlying sources; their original full texts remained inaccessible in the initial pass. Bibliographic snippets are not adequate to exclude a corollary from their exact bounds.

[Halbeisen–Hungerbühler (1997), Lemmas 4–5 and Proposition 2](https://math.ch/norbert.hungerbuehler/publications/Optimal_bounds_for_the_length_of_rational_Collatz_cycles.pdf), already uses remainder order, mechanical extrema over cyclic rotations, and finite-plus-block estimates. Its optimized cyclic quantity is larger than this project's first-crossing quantity. Our explicit comparison shows that its Proposition 2 is too loose to imply either quarter certificate by direct substitution; the derivation is in [COMPARISONS.md](COMPARISONS.md).

[López–Stoll (2009), Example 8](https://math.colgate.edu/~integers/j13/j13.pdf), explicitly studies the critical mechanical slope $\log 2/\log 3$. The word itself is prior art. The inspected results concern conjugacy series and related functions, rather than this finite endpoint inequality.

## 6. Closest modern literature and counterarguments

[Rozier–Terracol, arXiv v5 (17 May 2026)](https://arxiv.org/html/2502.00948v5), is the direct modern comparator. Lemma 2.3 supplies remainder monotonicity; Theorem 2.4 treats unrestricted extrema; Lemma 2.5 averages remainders over parity words; Theorem 4.2 constrains a harmonic mean. The average $j/4$ is not a pointwise bound using the odd count $s$. We found no exact quarter-gap/threshold-16 statement in the inspected text. The author names are Olivier Rozier and **Claude Terracol**.

The stronger challenge to novelty is our own standard-theory implication:

$$
\frac{M_s}{s3^s}\longrightarrow\frac1{6\ln2}\approx0.240449<\frac14.
$$

It follows from ordinary irrational-rotation equidistribution, for example the linear specialization in [Cigler (1969), pp.151–152](https://www.numdam.org/article/CM_1969__21_2_151_0.pdf). Thus qualitative eventual improvement to a quarter is not the strongest novelty claim. An explicit optimal cutoff and exact quantitative proof are the additional work.

[Kramer (2026), §§3–4](https://arxiv.org/html/2607.10041v1), studies exponent codes, critical mechanical baselines, and necessary residue-rate conditions. Its inspected theorem does not furnish this quarter inequality. [De Jesus's July 2026 author-uploaded preprint](https://www.researchgate.net/publication/409064728_POINTWISE_SURVIVOR_DISCREPANCY_IN_A_WIDTH-TWO_COLLATZ_SYSTEM_TERMINAL_SWAPS_DEFECT_ARITHMETIC_AND_MECHANICAL_RENEWAL) concerns a width-two survivor/counting model with a similar barrier. It is related gray literature with different quantified objects; its claims were not independently validated.

## 7. Actual proof code versus formalization claims

The [Formal Conjectures Collatz statement](https://github.com/google-deepmind/formal-conjectures/blob/8323e878b83fcd7f4a448256069352a265460d75/FormalConjectures/Wikipedia/CollatzConjecture.lean) deliberately leaves the open conjecture with `sorry`. It is a statement formalization.

At the inspected commits, [QuixiAI's Basic.lean](https://github.com/QuixiAI/collatz/blob/937e7f7ccf737151db79fa01724db3a0af040895/Collatz/Basic.lean) assumes no nontrivial cycles and no divergence as axioms, while [SergioTheory's Terras.lean](https://github.com/SergioTheory/Collatz-new-math/blob/a1119b3af1079ce4c122656753682d58b0c654ed/lean/CollatzLean/Terras.lean) declares key affine/density facts as axioms. Neither inspected interface establishes the advertised unconditional end-to-end result. No full external repository build was performed.

[Chang's 233-page v6](https://arxiv.org/abs/2603.11066v6) counts labeled prose results. The inspected extraction contained no Lean or GitHub pointer establishing a corresponding kernel-checked artifact. Its descent criterion and Mersenne discussion provide related ideas; its result count does not certify novelty or correctness.

The project's own clean axiom audit is useful evidence of its exact formal scope. It does not justify “first Lean Collatz formalization.”

Following the specialist catalog exposed closer code: [TerrasDensity's contraction module](https://github.com/lechmazur/terras_density_one/blob/83c436ccd727c35b7ef7b497558be9395e011b83/TerrasDensity/Parity/Contraction.lean) formalizes descent under a coefficient/affine-offset threshold, as a density-one prerequisite. The [rwst RT development](https://github.com/rwst/lean-code/tree/ce1619b6418dc263efb911b11ad09409c2083d80/RT) includes the mean remainder and near-cycle estimates; its [FinitePar module](https://github.com/rwst/lean-code/blob/ce1619b6418dc263efb911b11ad09409c2083d80/RT/FinitePar.lean) explicitly assumes a finite CST verification as an axiom. A smaller [Collatz-Map-Basics development](https://github.com/rwst/Collatz-Map-Basics/tree/96e063fde9f5153a492a809e9ebce3c235a73d20) also formalizes neighboring remainder results. No exact quarter-gap or threshold-16 theorem appeared in these targeted source inspections. Catalog audit status is not an assumption-free certification.

## 8. Secondary candidate: a restricted proof-method obstruction

[Yolcu–Aaronson–Heule, §6](https://arxiv.org/abs/2105.14697), identifies matrix-interpretation nonexistence for its mixed-base system as an interesting research direction. The project's original eleven-rule, dimension-one arctic-natural full-plus-top exclusion is a narrow response worth reviewing. Higher dimensions, other carriers, transformations, and other labelings remain outside it.

The full scalar slope cancellation has an elementary short proof. The more substantial candidate is the complete treatment of both top entry points, supports/intercepts, and the fixed 22-rule labeling. Exact certificate replay supports the encoded inequalities, but independent correspondence to the published interpretation semantics remains a gate. This candidate was preserved in the source archive but omitted from the release's 13-item headline claims JSON; it should receive a separate scoped claim on the next reviewed release. The [YAH review packet](YAH_REVIEW.md) records exact files, replay coverage, a resolved newline/hash discrepancy, and the semantic proof obligation.

## 9. Why discovery output alone is insufficient

AlphaXiv returned Niu's v1 as related work. The [current official arXiv v2 record](https://arxiv.org/abs/2605.13886v2) says it was withdrawn on 20 May 2026 because of duplication of Rozier–Terracol and a routine inference from their data. It is logged as a withdrawn historical lead, not independent supporting evidence.

Title-based PDF requests for Terras and Garner also resolved to an unrelated paper, `2209.05995v1`. Those outputs were excluded after identity checks. A zero-result GitHub search missed a symbol that was present in fetched code. Future novelty runs must validate document identity, latest version, actual theorem scope, and code declarations; search rank and empty results cannot certify originality.

## 10. Submission decision and concrete next gates

The [VibeMathed methodology](https://vibemathed.com/methodology) excludes pure formalizations of known results and routine rediscoveries, while allowing substantive partial answers to precise questions. Therefore a working export and a passing Lean build do not settle eligibility.

Before sending the saved draft: close the exact Terras/Garner comparison as far as legitimate access permits; secure an independent statement/novelty review of the quarter certificate or YAH obstruction; select one defensible atomic contribution; update its citations, attribution, and scope; then submit that reviewed version. There is no need to wait for an unspecified larger discovery.

The [Collatz Conjecture Challenge](https://ccchallenge.org/) also provides a specialist bibliography and formalization-review context. It merits a separate artifact-intake evaluation, without assuming listing implies novelty or verification.

## 11. Process assessment

Strong points: three independent comparison tracks, original-source follow-up, version checks, code inspection, exact implication calculations, and a real publishing rehearsal. Weak points: incomplete older full text, capped and imperfect search indexing, no comprehensive specialist-index search, and no independent human mathematical referee. This is a useful bounded review, not a systematic-review certification. No medical-style evidence score or fabricated numerical novelty probability is assigned.

## 12. Inference assessment

Confidence is high that the affine/mechanical foundations and ordinary descent reformulations should not be marketed as new. The exact quantitative certificate and full-plus-top obstruction remain plausible narrow contributions. Confidence in their historical priority is insufficient. A same-or-stronger earlier theorem, after a valid normalization, would immediately downgrade the novelty claim. Lack of a located match is not evidence of absence.

## 13. Reproducibility and publication status

The source SHA, paper versions, repository pins, exact searches, identified gaps, and mathematical translations are preserved with this report. The browser draft's 32 ordinary fields and seven supporting links matched the released JSON after reopening. **No VibeMathed submission was sent and no curator acceptance is claimed.** The research release is public; the venue draft remains a draft in the current signed-in browser.

## 14. Reuse on the next research revision

Freeze the changed source; extract atomic quantified claims; rerun its actual proof/certificate checks; search names, formulas, equivalent maps, prerequisites, and stronger theorems; verify versions and proof code; record exact/equivalent/corollary/related/unresolved comparisons; then regenerate the existing publication exports. Search can be automated, but an empty result must never automatically change `priority_status` to established.
