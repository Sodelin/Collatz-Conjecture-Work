# Exact certificates excluding scalar arctic-natural first steps for the mixed-base Collatz rewrite system

**A restricted proof-method result for community review. Collatz remains unresolved.**

Maintainer: Nolan Downard. Research and preparation were AI-assisted. Original full/top certificate artifacts are recorded on August 24, 2026; focused semantic and prior-art reviews were completed on September 5, 2026. These dates describe the project record and do not certify priority. This note is not peer reviewed.

## Abstract

We give an exact-certificate obstruction to starting a particular termination proof search for the eleven-rule mixed-base Collatz string-rewriting system of Yolcu, Aaronson and Heule (YAH). Under the standard coefficientwise dimension-one arctic-natural interpretation constraints, no interpretation weakly orients every rule and strictly orients a nonempty first full rule-removal subset. The same exclusion holds for the two specified relative-top opportunities: boundary rules in the original orientation and dynamic rules in the reversed orientation. A fixed two-state twenty-two-rule labeling satisfies the corresponding syntactic exclusions. Coefficients are not bounded by a search cutoff.

The full scalar result has an elementary cancellation proof. The top result uses ten reconstructed constraint cases, 491 exact Farkas lemmas and 426 reverse-unit-propagation clauses. The supplied Python replay checks the contradictions without trusting the discovery solver. A separate internal semantic review found no defect in the interpretation-to-constraint argument and independently replayed the certificates. This is not a complete Lean formalization or an external referee endorsement. A focused prior-art audit found no exact earlier match for the combined top/labeled exclusion, while identifying the scalar weight machinery as established technique.

## 1. Research question and contribution

YAH §6 raises the possibility that suitable matrix interpretations might fail to prove termination of its mixed-base system. Its earlier impossibility theorems concern a different, unary encoding and natural matrices. Lemma 3.18 provides the two relative-top opportunities considered here. The paper does not separately name or date a dimension-one arctic-natural conjecture. Our contribution is therefore a restricted first-step subcase of its broader research direction, not a resolution of that direction. [Original paper, journal version](https://doi.org/10.1007/s10817-022-09658-8), [arXiv version 3](https://arxiv.org/abs/2105.14697v3).

The precise subquestion is whether the specified unbounded scalar interpretation class can make any first rule-removal progress. For this class and these targets, the answer is no. The original full scalar lemma is elementary; the combined affine-top case analysis and fixed-label extension are the candidate contribution offered for scrutiny.

## 2. System and interpretation class

Let `T` be the following eleven-rule system. Here `^` and `$` are boundary symbols, and `f,t,0,1,2` are internal symbols.

```text
Dynamic:  f$ -> $       t$ -> 2$

Auxiliary: f0 -> 0f     f1 -> 0t     f2 -> 1f
           t0 -> 1t     t1 -> 2f     t2 -> 2t

Boundary:  ^0 -> ^t     ^1 -> ^ff    ^2 -> ^ft
```

The author's ASCII rule file uses `a,b,c,d,e,f,g`, respectively renamed here as `f,t,^,$,0,1,2`. This is a symbol bijection, not a change of rules. The original rule file and interpretation implementation are available at a fixed author revision. [Rule source](https://github.com/emreyolcu/rewriting-collatz/blob/8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340/rules/collatz-T.srs), [arctic implementation](https://github.com/emreyolcu/rewriting-collatz/blob/8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340/prover/arctic.py).

Write bottom as `⊥ = -∞`. The coefficient domain is

$$
\mathbb A_{\mathbb N}=\mathbb N\cup\{\bot\},\qquad a\oplus b=\max(a,b),\qquad a\otimes b=a+b,
$$

where bottom absorbs multiplication. The **full/extended** class uses

$$
[\sigma](x)=m_\sigma+x,\qquad m_\sigma\in\mathbb N.
$$

The **weak/top** class permits

$$
[\sigma](x)=\max(m_\sigma+x,v_\sigma),\qquad m_\sigma,v_\sigma\in\mathbb A_{\mathbb N},
$$

with at least one finite component per symbol. Functions are composed with the leftmost word symbol outermost.

Weak orientation compares both resulting coefficients componentwise. Strict orientation also compares both coefficients componentwise, using `a ≫ b` when `a>b` or both are bottom. These are the specified coefficient tests; the result does not cover every possible functional order that could compare the same maps.

Let `T₂` be exactly the twenty-two-rule system obtained from both suffix states of the [fixed two-state algebra](../proof-search/routes/A_yah_two_state_semantic_label_no_go.md). Its fourteen labeled tokens are independent interpretation symbols. No universal claim about arbitrary two-state labelings is made.

## 3. Theorem

**Restricted first-step obstruction.** For `T` and `T₂`, there is no full/extended interpretation in the class above that weakly orients every rule and strictly orients at least one rule.

There is also no weak/top interpretation in the stated class that weakly orients every rule and strictly orients a nonempty subset of either specified target family:

1. boundary rules in the original orientation; or
2. dynamic rules after reversing every word.

For `T₂`, these are syntactic interpretation exclusions for the stored labeled rules and their reversals. They do not assert a separate semantic-labeling theorem about relative-top termination. For `T`, equal-label lifting transfers the exclusions to the original system.

The quantification is over all natural finite coefficient values and all admitted bottom-support patterns. It is not a finite coefficient search.

## 4. Proof and certificate chain

### Full/extended cancellation

For a rule `i`, let `Δᵢ` be its left-minus-right vector of symbol counts. The interpreted rule difference is `Δᵢ·m`. Weak orientation makes it nonnegative. In the displayed rule order, the eleven positive multipliers are

```text
4, 7, 5, 6, 9, 3, 4, 4, 3, 2, 2.
```

Their total is 49, and

$$
\sum_i\lambda_i\Delta_i=0.
$$

Thus a positive combination of nonnegative interpreted differences is zero, forcing every difference to be zero. None can be strict. The labeled certificate has a positive multiplier for each of its twenty-two rows and cancels all fourteen coordinates, again with total multiplier mass 49. The [direct checker](../verification/yah_two_state_scalar_arctic_full_no_start.py) verifies both identities.

One can also prove the original result directly from five inequalities. Write the internal slopes as `a,b,c,d,e`. Weak orientation gives

$$
b\ge e,\quad e\ge a+b,\quad a+d\ge c+b,\quad c\ge d,\quad e\ge d.
$$

Nonnegativity first forces `a=0` and `e=b`, then `b=0` and `c=d`, and finally `c=d=0`. Boundary coefficients cancel. This short proof illustrates why the original full scalar component alone should not be advertised as a substantial new method.

### Top constraints and soundness

For a word `s₁…sₖ`, the slope is the sum of its slopes when all are finite, and bottom otherwise. The intercept is the maximum of active terms

$$
m_{s_1}+\cdots+m_{s_{j-1}}+v_{s_j}.
$$

A term is active precisely when its prefix slopes and its intercept are finite. The [constraint code](../verification/yah_scalar_arctic_top/top_cert_common.py) reconstructs these expressions, finite-support flags, all weak rule comparisons and one strict target comparison at a time.

For finite natural values, a strict difference is at least one. Each arithmetic branch is relaxed to nonnegative real variables with the same gap constraints. Every genuine natural interpretation therefore gives an assignment admitted by the relaxed encoding. Omitting complementary arithmetic constraints for false atoms only enlarges the encoded search space, which is safe for proving nonexistence.

Each Farkas lemma combines selected inequalities with positive integer multipliers to obtain zero variable coefficients and a positive right-hand side: an impossible inequality `0 ≥ b` with `b>0`. The corresponding negated conjunction is consequently a valid learned clause. Every RUP clause is checked by assuming its negation and deriving a contradiction through unit propagation. A final empty-clause check establishes inconsistency for each target.

The [payload](../verification/yah_scalar_arctic_top/top_certificates.json) contains ten cases: six labeled boundary targets and four reversed labeled dynamic targets. It contains 491 Farkas lemmas, 426 RUP clauses and total Farkas multiplier mass 10,183. The [replayer](../verification/yah_scalar_arctic_top/verify_top_certificates.py) checks all of them and all ten terminal contradictions. Testing singleton targets is complete because every nonempty strict subset contains a strict member.

### Transfer to the original system

If an original-system interpretation existed, give both labeled copies of each symbol the same coefficients. Word interpretation is then unchanged when labels are erased. This also holds after reversal. Every original weak comparison and a designated strict target lift to the corresponding labeled case, contradicting its certificate. This argument does not require a claim that the labeling preserves relative-top termination.

## 5. Verification and reproduction

From the mathematical source checkout specified by the release manifest, with Python assertions enabled:

```bash
python3 -S -B verification/yah_two_state_scalar_arctic_full_no_start.py
python3 -S -B verification/yah_scalar_arctic_top/verify_top_certificates.py
```

Do not run with `-O` or `PYTHONOPTIMIZE`: the checkers use assertions. No third-party Python package or discovery solver is needed for replay. Expected final labels include `ORIGINAL_FULL_EXTENDED_SCALAR_ARCTIC_NO_START = PASS`, `FULL_EXTENDED_SCALAR_ARCTIC_NO_START = PASS` and `TOP_SCALAR_ARCTIC_NO_FIRST_STEP = PASS`.

The [focused semantic review](../research-review/consolidation-2026-09-05/YAH_SEMANTICS.md) checked the rule identification, support and composition semantics, weak/strict comparisons, relaxation, certificate logic and lifting argument. It also compared an independent max-plus composition implementation against the encoding on 288,560 assignments over all forty-four labeled rule/orientation rows, with zero mismatches. A separate arithmetic and propagation implementation replayed all 491 Farkas identities, 426 RUP clauses and ten terminal contradictions.

Those finite differential checks are diagnostics. The unrestricted conclusion comes from the interpretation-to-formula implication and the exact refutations. Internal AI review is not an external expert review. The complete YAH full-plus-top theorem and encoding bridge have not been formalized in Lean in this publication claim. Separate auxiliary Lean proofs in the consolidated archive retain their own scopes and do not upgrade this theorem's verification category.

The certificate payload's LF byte hash in the audited source is `dafb9bfcbe02a32905fc46d99ceb97b9b296059869d77ee42cff5c99d04592d6`. The older documented `ac7c6a...` hash is reproduced by CRLF serialization of the same data; the difference is explained in the semantic review. Release asset hashes and the pinned mathematical source are recorded in the generated manifest and `SHA256SUMS`. See [publication metadata](metadata.json) for the selected revision.

## 6. Prior art and significance

The [focused novelty review](../research-review/consolidation-2026-09-05/YAH_NOVELTY.md) records the actual queries, source versions, comparison points and limitations. It found no exact prior match for the combined unbounded top/labeled first-step exclusion in the inspected sources. That bounded observation is not a priority certification.

The scalar weight reduction and linear-feasibility perspective are already present in Gebhardt–Waldmann, §6, Lemmas 5–6. Their broader matrix hierarchy arguments cannot simply be transferred to all max-plus interpretations, a limitation discussed in the same paper. We treat the full cancellation as an elementary application of established machinery. [Primary paper](https://cyber.bibl.u-szeged.hu/index.php/actcybern/article/view/3770/3754).

Koprowski–Waldmann provide the arctic-top framework and discuss certification. Their linear-complexity result for a complete full arctic termination proof does not itself exclude every first relative step with only some strict rules. The candidate contribution here is the exact mixed-base top/labeled instance and its refutation chain, not the invention of arctic interpretation or certificate checking. [Primary paper](https://cyber.bibl.u-szeged.hu/index.php/actcybern/article/view/3772/3756).

The practical consequence is that increasing coefficient bounds cannot rescue this exact first-step class. A proof search must use a different dimension, carrier, labeling, order, transformation or already-reduced rule set to escape this obstruction. The mathematical importance of that restriction remains for the research community to assess.

## 7. Scope and remaining work

The result excludes neither dimensions two and higher nor negative finite coefficients, other carriers, arbitrary semantic labelings, non-coefficientwise orders, additional transformations or later scalar steps after other progress. It proves neither convergence nor nonconvergence of Collatz and supplies no universal descent or smaller-coalescence mechanism.

A remaining formal verification task is to encode the interpretation and composition semantics, prove that a genuine interpretation induces an admitted assignment, and verify the Farkas/RUP soundness chain in a proof assistant. Checking stored arithmetic sums alone would omit the interpretation-to-encoding bridge. A further novelty task is a specialist's exact comparison against earlier work; no such endorsement is claimed here.

The semantic audit also discusses a separately derived homogeneous-scaling feasibility corollary for nonnegative real coefficients. That corollary is not needed for the natural-coefficient theorem or the submission headline, and must not be read as a claim that ordinary strict order on the reals is well founded.

## 8. Chronology, authorship and consolidated archive

The repository records the [full certificate commit](https://github.com/Sodelin/Collatz-Conjecture-Work/commit/f8558a566b682e8dbc4465206f9c26ac9b17760c) and [top certificate commit](https://github.com/Sodelin/Collatz-Conjecture-Work/commit/b75ffec58ae20ac26271ff7d59a71d3591467994) on August 24, 2026. September 5 added the focused review and consolidation described here. Historical commit dates are evidence of the repository record, not a certified public priority timestamp.

AI assisted argument development, certificate discovery, checker code, internal review and manuscript preparation. Historical records do not establish exact model versions or a complete per-step attribution. Nolan Downard maintains the project; repository ownership is not asserted to establish sole mathematical authorship. Internal reviews share model provenance and are disclosed as internal rather than independent expert verification.

This is the narrowly selected candidate for one VibeMathed partial-result entry. The [consolidated announcement](announcement.md) presents the broader work, including Lean-checked auxiliary results, known reconstructions, bounded searches and open bridges. Their inclusion in one archive does not merge their mathematical claims or verification levels. See the [atomic claim registry](../proof-search/CLAIM_REGISTRY.md) and [original obstruction note](../proof-search/routes/A_yah_two_state_scalar_arctic_full_no_start.md).

## 11. Process integrity assessment

The theorem, original rules, fixed labeling, certificate payload, replay code, semantic review and prior-art ledger are public and inspectable. The review went beyond repeating the production checker by examining the forward encoding implication and independently replaying arithmetic and Boolean certificates. A complete kernel-verified semantics chain, external referee report and exhaustive literature coverage are absent. No numerical confidence percentage is assigned to this deductive audit.

## 12. Inference robustness assessment

The unbounded result is supported by a soundness argument and exact contradictions, not finite sampling. Its inference depends on the exact coefficient domain, orientation tests, first-step restriction and designated top targets. Changing any of those may admit interpretations without contradicting the theorem. A matching prior theorem would change the novelty assessment; a semantic defect would require correction of the result. Neither the present certificate nor the absence of a located predecessor establishes a general YAH-method impossibility or solves Collatz.
