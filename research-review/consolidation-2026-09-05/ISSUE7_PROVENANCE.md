# Issue #7 primary-source and provenance review — 2026-09-05

**Disposition: the mathematical source gate passes; independent originality is not established. Preserve an attributed corollary and end the priority lane.** The missing García–Tal primary-source check can now be closed. The mathematical result is useful for the repository's route map, but the same shell/summability/product/discrepancy combination is already publicly stated on MathOverflow. This review neither establishes the account's relationship to the project nor needs that relationship to preserve the mathematics with attribution.

## Checked primary sources

1. Manuel V. P. Garcia and Fabio A. Tal, *A note on the generalized 3n + 1 problem*, Acta Arithmetica 90(3), 245–250 (1999), [DOI](https://doi.org/10.4064/aa-90-3-245-250). Read all six pages from the [authors' university repository PDF](https://repositorio.usp.br/bitstreams/a02b7ba9-c8be-42d8-bbae-4d836520ec13); visually checked page 249. Retrieved PDF: 211308 bytes, SHA256 `dc2ab0a006bdc25430cd14f578439937b37eda3cda0701688be12e49d5c51dd8`.
2. [MathOverflow question 513539](https://mathoverflow.net/questions/513539/is-it-known-that-a-divergent-collatz-trajectory-must-have-summable-reciprocals), displayed as posted July 24, 2026 by the public account Pulowski. Read the question and displayed comments. No answer was displayed at review time. The question is primary evidence of a public mathematical statement; it is not a refereed theorem or a source of identity evidence.
3. Olivier Rozier, *The 3x + 1 Problem: A Lower Bound Hypothesis*, [author-hosted manuscript](https://www.ipgp.fr/~rozier/pub/LBHv4.pdf), Lemma 2.5, equations (11), (15)–(16). This manuscript's first page is dated November 16, 2016; it should not be described as a manuscript written in 2017 merely because a later publication date is used elsewhere. Its finite correction product and reciprocal-log bound directly cover the algebraic ingredients used here.

The ICM PDF and EuDML page returned 403 through the web reader; the USP primary PDF was successfully downloaded directly. An alphaXiv title lookup incorrectly resolved to an unrelated vegetation paper; it was excluded. A subsequent direct Semantic Scholar resolution failed. Neither result supports this review.

## Exact external input and its scope

Garcia–Tal assume fixed Hasse-map data with integers $m>d\ge2$, $\gcd(m,d)=1$, and $m<d^{d/(d-1)}$. Their Proposition 1 on page 248 supplies $\delta_1,\delta_2\in(0,1)$ and $g(k)=O(k^{\delta_2})$. For representatives $P$ of equal-time orbit coalescence, equation (6) on page 249 is

$$
\#(P\cap\{a,\ldots,a+k-1\})
\le 2(\lfloor\log_d k\rfloor+1)(k^{1-\delta_1}+g(k)),
\qquad a,k\in\mathbb N^*.
$$

The proof of Corollary 1 places every infinite individual orbit set inside such a $P$. Hence, with $\beta=\max(1-\delta_1,\delta_2)<1$, there is a constant $K$ depending on the fixed map, uniform in interval location and infinite-orbit seed, such that

$$
\#(O_H(N)\cap[a,a+X))\le K X^\beta\log(2X),\qquad a,X\ge1.
$$

Integer lengths follow directly; real endpoints follow by enlarging to an integer interval and adjusting $K$. This strengthens the stated Banach-density conclusion by retaining the quantitative inequality in its proof. Banach density zero alone would not imply reciprocal summability. The paper does not explicitly state a reciprocal-power summability theorem. Its foundational estimate invokes Heppner 1978; this review accepts that named published input and does not independently reprove Heppner.

The source's explicit Collatz specialization is $d=2$, $m=3$, with the nonzero residue represented by $-1$ (the displayed residue system is $\{0,-1\}$). Its $H$ is therefore exactly the shortcut map $T(n)=n/2$ on even inputs and $(3n+1)/2$ on odd inputs. The condition $3<4$ holds. The estimate is justified for the source's restricted Hasse family, not every arbitrary generalized Collatz map.

## Reconstructed corollary

This section is a derivation from the checked input, not a claim that the following formulation is printed in Garcia–Tal.

For $s>\beta$, the contribution of the dyadic shell $[2^r,2^{r+1})$ is at most a constant times

$$
(r+1)2^{-r(s-\beta)}.
$$

The geometric tail sums. Thus every infinite orbit set in the stated Hasse family has a finite sum of reciprocal $s$th powers, uniformly over its seed for fixed map and $s$. This is a statement about distinct orbit values. An infinite deterministic orbit has no repeated state, so it also gives time-indexed summability on every aperiodic orbit. A periodic orbit is a necessary false control: its finite orbit-set sum converges while its time-indexed reciprocal sum diverges.

For an accelerated positive odd Collatz orbit, use the notation in the repository's issue 7 packet: $a_j=\nu_2(3n_j+1)$ and $A_k=\sum_{j<k}a_j$. One accelerated edge takes exactly $a_j$ shortcut steps, including the first halving in the odd shortcut rule. Consequently,

$$
n_k=T^{A_k}(n_0).
$$

This explicit time change closes the previously unverified convention bridge. The odd orbit is a subsequence of the shortcut orbit, so the positive-term reciprocal sum also converges on every aperiodic odd orbit.

The packet's finite identities reconstruct directly by multiplying the edge equations or telescoping the affine correction:

$$
x_kn_k=n_0+S_k,\qquad
P_k=1+S_k/n_0,\qquad
q_k=1/(n_0+S_k)=1/(n_0P_k).
$$

For $0<t\le1/3$, $t/(1+t)\le\log(1+t)\le t$. Applying this to $t=1/(3n_j)$ proves the product/series equivalences. An integer orbit which revisits a bounded set infinitely often repeats a state and becomes eventually periodic. Therefore the full supported chain is

$$
\text{aperiodic}\iff\text{infinite orbit set}\iff\text{unbounded}
\iff n_k\to\infty
\iff\sum_k n_k^{-1}<\infty
\iff P_\infty,S_\infty<\infty
\iff q_\infty>0.
$$

Furthermore,

$$
k\log3-A_k\log2=\log n_k+\log q_k.
$$

In the unbounded branch the right side tends to $+\infty$. In the bounded/eventually-periodic branch, recurring factors make $P_k$ diverge, so $q_k\to0$ and the discrepancy tends to $-\infty$. This includes hypothetical nontrivial cycles and does not distinguish them from the known cycle. It does not produce a divergent seed or establish universal boundedness. The earlier issue 2 proposal of an unbounded, reciprocal-nonsummable branch is excluded by the checked published estimate.

## Attribution, overlap, and publication decision

| Item | Result of this review | Appropriate repository treatment |
|---|---|---|
| Uniform interval estimate | **Pass:** exact source, exponent, quantifiers and map checked | Attribute to Garcia–Tal equation (6), Corollary 1 and Proposition 1 |
| Shell summability and acceleration bridge | **Pass:** reconstructed mathematical consequence | Attributed prose corollary; no Lean certification claimed |
| Product/correction identities | **Pass:** elementary identities with direct finite-product prior art in Rozier | Reuse existing L1 notation and cite prior art |
| Public overlap | **Pass:** MO 513539 already states reciprocal powers, correction product and divergent discrepancy | Explicitly cite the overlapping post; do not call the core newly discovered here |
| Independent authorship or priority | **Unresolved:** no identity investigation or inference was made | Make no affiliation, independence, priority or misconduct claim |
| Standalone significance | **Not established:** no external specialist judgment obtained | Do not promote as the flagship result or a new-theorem venue submission |

The additional repository packaging—$S_k$, $q_k$, the complementary periodic branch and a unified equivalence chain—is a transparent reformulation of the cited core and classical affine algebra. This review finds no substantive new mathematical ingredient in that packaging. This is a bounded comparison, not a claim that every possible prior publication has been searched.

Issue7's own stopping rule says to end its novelty lane if provenance remains unresolved. That need not leave the mathematical source gate open indefinitely. The concrete completed disposition is: **retain an attributed, source-verified route corollary; close the audit as not promoted for independent novelty**. If the owner later supplies provenance or an external specialist assesses significance, that can be new evidence for a separate decision. Neither is required to archive the present result accurately.

No shared repository file, issue, manuscript submission or external message was modified by this review. The integration owner can update the source card's three source-check boxes, replace the packet's missing-primary-source language with this disposition, and link the resulting durable review before administratively closing issue 7. Any existing human-review label can remain because this was an independent assistant reconstruction, not external human peer review.
