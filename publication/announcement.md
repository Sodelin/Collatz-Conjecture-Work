# A Lean-checked quarter-gap theorem at the first Collatz coefficient contraction

**Research preview and partial-result proposal. Collatz remains unresolved.** The main result is an auxiliary inequality on actual Collatz orbits, with a complete Lean proof. It applies whenever a first coefficient contraction exists and its endpoint has not descended below the positive start. Mathematical novelty and priority have not been externally certified.

This preview describes [source revision `33922a42e86646258d227d1e19c6cf7546a2f548`](https://github.com/Sodelin/Collatz-Conjecture-Work/tree/33922a42e86646258d227d1e19c6cf7546a2f548) of `Sodelin/Collatz-Conjecture-Work`. It is suitable for community review and as a proposed VibeMathed partial-result contribution; it makes no claim of acceptance, peer review, a DOI, or a platform-assigned identifier.

## Exact theorem

Use the one-division shortcut map

\[
T(n)=\begin{cases}(3n+1)/2,&n\text{ odd},\\n/2,&n\text{ even}.\end{cases}
\]

For a positive integer start \(n\), let \(q_j\) count odd branches in its actual first \(j\) transitions. Assume that \(k>0\) is a first coefficient contraction:

\[
3^{q_k}<2^k,\qquad 2^j\leq3^{q_j}\quad\text{for every }0\leq j<k.
\]

If \(T^k(n)=n+d\), with \(d\) a nonnegative integer, then, writing \(s=q_k\),

\[
\boxed{4d<s,\qquad d\leq\left\lfloor\frac{s-1}{4}\right\rfloor.}
\]

The exported declaration is `CollatzWork.firstContractionQuarterGap`, with type `CollatzWork.FirstContractionQuarterGapStatement`. The [trusted statement](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/33922a42e86646258d227d1e19c6cf7546a2f548/lean/CollatzWork/QuarterGapUniversalStatement.lean) and [proof](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/33922a42e86646258d227d1e19c6cf7546a2f548/lean/CollatzWork/QuarterGapUniversal.lean) are separate files. The [orbit definitions](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/33922a42e86646258d227d1e19c6cf7546a2f548/lean/CollatzWork/QuarterGapStatement.lean) use the existing shortcut iterate. This statement is universal over eligible inputs, without a finite numerical cutoff.

The existence of \(k\) is a hypothesis. The result does not prove first-contraction existence for every start, eventual descent, or exclusion of nontrivial cycles. In particular, the permitted case \(d=0\) is not eliminated.

## What supports it

The proof bounds the actual affine remainder using the mechanical recurrence

\[
C^{\max}_0=0,\qquad C^{\max}_{s+1}=3C^{\max}_s+2^{\lfloor\log_2(3^s)\rfloor}.
\]

The supporting inequality \(4C^{\max}_s\leq s3^s\) holds for every \(s\geq16\), proved by twelve-step propagation and kernel-checked bases. At \(s=15\), \(4C^{\max}_{15}=217653340>215233605=15\cdot3^{15}\). Thus 16 is the smallest eventual threshold for this supporting inequality. A separate small-count certificate completes the quarter-gap proof for every eligible odd count.

The [formal scope audit](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/33922a42e86646258d227d1e19c6cf7546a2f548/verification/Quarter_Gap_Formal_Scope_2026-09-05.md) records the dependency chain. The universal mechanical certificate uses `propext` and `Quot.sound`; the actual-orbit theorem also uses `Classical.choice`. The stated chain uses ordinary kernel checking, with no `sorry`, theorem-strength project axiom, `native_decide`, or external arithmetic oracle. These are scoped verification claims, not an assertion that formalization certifies originality.

## Other material in the research snapshot

| Material | Evidence and boundary |
|---|---|
| Smaller-coalescence and descent criteria | Lean proves equivalence with all-positive convergence and supplies one guarded refined-Mersenne family. The universal smaller-target premise remains open. |
| Equal-slope inverse-word boundary and two-pump dependency | Lean verifies auxiliary arithmetic and an obstruction to a particular cyclic-elimination method. The `Disproof` module name does not signify a disproof of Collatz. |
| General rotation-block theorem and 1024-block refinement | Prose proofs and exact Python certificates. Only the required twelve-term integer specialization is covered by the headline Lean chain. |
| Fixed-residue rank obstructions | Prose arguments with exact checkers for specified polynomial/bitlength rank classes. Original hard returns and newly normalized returns are different relations with separately stated guards. |
| Stopping at 1, 2, or 20 modulo 27 | A ranked reconstruction of a known consequence attributed to Monks, Monks, Monks and Monks. It provides no progress across subsequent target returns and carries no novelty claim. |
| Failed composition and bounded searches | An auxiliary return-plus-normalizer loop at 425 blocks a proposed composition, without being a Collatz cycle. A dimension-two matrix search reports bounded UNSAT and a larger-bound timeout, without a general impossibility theorem. |

The [continuation report](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/33922a42e86646258d227d1e19c6cf7546a2f548/ASTRA_CONTINUATION_2026-09-05.md), [claim registry](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/33922a42e86646258d227d1e19c6cf7546a2f548/proof-search/CLAIM_REGISTRY.md), and [verification index](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/33922a42e86646258d227d1e19c6cf7546a2f548/verification/README.md) distinguish these statuses. The publication package's `claims.json` maps selected claims to their source paths and exact Lean declarations. The full source snapshot retains the surrounding work; inclusion in the archive does not promote every historical claim to formal status.

## Reproduction and provenance

Check out the immutable source revision above, install its pinned `leanprover/lean4:v4.33.1` toolchain, and run `lake build` from the repository root. The exact-checker commands and retained outputs are indexed in the verification note. A publication build should rerun the pinned snapshot and record its own source SHA, toolchain, results, and checksums.

Historical evidence in the snapshot includes [CI run 33970405108](https://github.com/Sodelin/Collatz-Conjecture-Work/actions/runs/33970405108), recorded for source revision `b3b299e6acd5ac84fcaa640ae4158ac93adfdaad`. That older successful run must not be relabeled as a fresh check of the publication revision.

**AI disclosure:** this is AI-assisted work. The repository records an Astra research pass and continuation using parallel discovery and internal review roles. Those records explicitly acknowledge shared model provenance; this is internal review, not independent external peer review. The audited documents do not establish exact model version identifiers or a complete per-file model attribution, so none is supplied here. Repository ownership is not asserted to establish sole mathematical authorship. See the [research-method record](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/33922a42e86646258d227d1e19c6cf7546a2f548/ASTRA_RESEARCH_PASS_2026-09-05.md) and [provenance note](https://github.com/Sodelin/Collatz-Conjecture-Work/blob/33922a42e86646258d227d1e19c6cf7546a2f548/PROVENANCE.md). Earlier artifact dates are metadata claims, separate from public availability and any later archival deposit.

## Requested mathematical review

The most useful review would check the ordinary-map interpretation and quantifiers, search for prior instances of the quarter bound and sharp supporting threshold, and inspect the exact boundaries of the nonformal claims. Further constructive work needs a universal descent or smaller-coalescence mechanism, or a well-founded return relation with full guard coverage. The quarter bound alone supplies none of these missing premises.

## 11. Process integrity assessment

The formal statements, proof declarations, source revision, historical verification evidence, and trust boundaries are inspectable. This preview audits those records; its text is not a fresh Lean execution report. Prior-art coverage is targeted and incomplete. External mathematical review and a current build of the precise publication snapshot remain distinct verification tasks. Empirical-review scoring instruments do not yield a meaningful numerical score for this deductive audit.

## 12. Inference robustness assessment

The formal theorem has universal eligible-input coverage; finite orbit sampling is not its justification. Positivity, first-contraction barriers, the actual map, and nonnegative defect are essential assumptions. A mismatch between those definitions and the prose, or failure to check the exported theorem at the declared source revision, would require correcting this preview. Extra-state ranks can evade the stated obstruction classes without refuting them. No conclusion about global Collatz termination or external priority follows from the verified auxiliary inequality.
