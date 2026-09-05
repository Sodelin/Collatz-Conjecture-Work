# Focused YAH semantic audit

Date: 2026-09-05. Mathematical source: `33922a42e86646258d227d1e19c6cf7546a2f548`. This audit did not alter that checkout. It addresses correctness and scope; it is not an external referee report or a priority certification.

## Judgment

**No semantic or certificate defect was found in the stated, restricted obstruction.** The checks support a shareable research note about an unbounded coefficient-domain obstruction to a first standard dimension-one arctic-natural rule-removal step. They do not support a claim that the YAH method generally fails, that matrix interpretations generally fail, or that Collatz is resolved.

The important work beyond replay was checking that an interpretation satisfying the claimed hypotheses necessarily induces an assignment admitted by the reconstructed formula. I also compared the formula with independently composed max-plus functions on **288,560 assignments across all 44 labeled rule/orientation rows**, and replayed all Farkas identities and RUP steps using separate arithmetic and propagation code. These finite differential checks are diagnostics; the unrestricted conclusion comes from the soundness argument and exact contradictions below.

## Exact scope and primary identification

The original system has eleven rules. At author repository commit `8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340`, [rules/collatz-T.srs](https://github.com/emreyolcu/rewriting-collatz/blob/8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340/rules/collatz-T.srs) uses `a,b,c,d,e,f,g`. The project's renaming is respectively `f,t,^,$,0,1,2`. All eleven rows match under this bijection. The upstream file is not literally written in the project's ASCII names; this harmless notation difference should be described as a renaming.

[YAH §2.3.2](https://arxiv.org/html/2105.14697v3#S2.SS3.SSS2) specifies nonnegative finite slopes and bottom constants for its full arctic-natural mode; its weak/top mode allows finite constants. It uses coefficientwise comparisons, with bottom strictly comparable to itself. These tests are sufficient conditions for functional orientation. [Lemma 3.18](https://arxiv.org/html/2105.14697v3#S3.SS2) supplies original boundary and reversed dynamic relative-top opportunities. [The authors' implementation](https://github.com/emreyolcu/rewriting-collatz/blob/8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340/prover/arctic.py), especially `concatenate`, `weaklymonotone`, and `ArcticDecoder.checkrel`, agrees with this interpretation. The broader question about matrix-proof nonexistence occurs in §6, not as a separately named dimension-one conjecture.

The project adds a fixed two-state labeling with 22 rules and 14 tokens. For the labeled system, the top statement is a syntactic interpretation exclusion, not an asserted theorem that this labeling preserves or reflects relative top termination.

## Obligations and results

| Obligation | Result | Evidence or reason |
|---|---|---|
| Original rules and family assignments | Pass | Explicit symbol bijection; two dynamic, six auxiliary, three boundary rules |
| Fixed labeling preserves rule equations | Pass | All 22 equations checked; suffix labels use right-to-left evaluation |
| Full cancellation covers every possible strict rule | Pass | Every one of 11 original and 22 labeled row multipliers is positive; weighted deltas vanish |
| Top coefficient domain | Pass | Each token has at least one finite component; every finite value is nonnegative and unbounded |
| Word composition and support | Pass | Prefix expansion matches independent recursive max-plus composition |
| Weak comparisons | Pass | Correct support implication and maximum domination |
| Strict comparisons including bottom/bottom | Pass | Correct jointly with the target's weak comparison |
| Complete first-step target split | Pass | Six labeled boundary targets and four reversed dynamic targets; any nonempty strict subset contains one target |
| Natural-to-real relaxation | Pass | A natural satisfying assignment remains admitted by each nonnegative-real branch with the same gap constraints |
| Farkas learned clauses | Pass | Positive combinations give zero variable coefficients and positive right-hand side |
| RUP and final contradiction | Pass | All 426 clauses and ten final contradictions independently replayed |
| Equal-label transfer to original system | Pass | Giving both copies identical coefficients preserves every word's interpretation, including reversal |
| Lean theorem / verified encoding semantics | Pending | No YAH Lean theorem or kernel-verified parser/encoding/refutation bridge in the audited source |
| Broad matrix-method impossibility / Collatz outcome | Outside claim | Not implied by these certificates |
| Novelty and venue acceptance | Not decided by this audit | Correctness of this obstruction does not establish priority or a venue's previously-open-problem criterion |

## Why the encoding is sound

These are independent deductions from the project code, with source references to `verification/yah_scalar_arctic_top/top_cert_common.py` at the audited SHA.

### Domain and word coefficients

Write bottom as `⊥ = -∞`. A token acts as `x ↦ max(m+x,v)`, with `m,v` in `N ∪ {⊥}` and at least one finite. This maps nonnegative finite inputs to nonnegative finite outputs. `build_case` creates separate finite-support flags and nonnegative numeric variables (lines 250–256). A numeric value attached to a bottom component can be assigned zero: all terms involving it are inactive. Requiring nonnegativity of such unused values therefore loses no genuine interpretation.

For a word `s₁…sₖ`, its slope is the sum of the slopes if they are all finite, and bottom otherwise. Its intercept is the maximum over positions `j` of `m₁+…+mⱼ₋₁+vⱼ` whose prefix slopes and intercept are finite. `word` implements exactly these expressions and support flags (lines 275–285). Composition is in the correct direction: the leftmost symbol is the outermost function.

### Weak and strict orientation

A slope comparison `L ≥ R` is true if the right slope is bottom. Otherwise it requires a finite left slope and a nonnegative left-minus-right difference. This is exactly the clause at line 291.

For intercepts, `max Lᵢ ≥ max Rⱼ` is equivalent to every active right term being dominated by some active left term. The witnesses may differ between right terms. This is exactly the loop at lines 292–297.

For strict slopes, the target is also weakly oriented. Combining that weak condition with line 303 gives:

| Left slope | Right slope | Combined condition |
|---|---|---|
| bottom | bottom | allowed |
| finite | bottom | allowed |
| bottom | finite | forbidden |
| finite | finite | difference at least one |

For strict intercepts, if every right term is bottom the comparison is allowed, including bottom/bottom. Otherwise one active left term must exceed every active right term by at least one (lines 305–313). A maximum is attained because each word has finitely many terms, so this is precisely strict comparison of the two finite maxima over natural coefficients.

Consequently, setting arithmetic atoms to their actual inequality truth values and setting each Boolean gate to its connective value extends any genuine interpretation to a satisfying assignment of the base formula. This forward implication is the necessary encoding-to-theorem bridge. The abstract formula need not force a false arithmetic atom's complementary inequality: omitting such constraints only enlarges its possible assignments, which is safe for a nonexistence proof.

### Real relaxation and certificate logic

The base arithmetic variables satisfy `xⱼ ≥ 0`. Each arithmetic atom denotes an integer-coefficient inequality `aᵢ·x ≥ bᵢ`, with right-hand side zero or one. If positive multipliers combine selected atoms and base inequalities into `0 ≥ b`, where `b > 0`, those atoms cannot all be true, even over the reals. Thus their negated disjunction is a sound learned clause. `farkas_valid` checks exactly this identity (lines 325–343); `learned_clause` produces exactly the corresponding disjunction (lines 346–347).

RUP checks a proposed clause by temporarily assuming its negation and performing unit propagation. Deriving a contradiction proves the clause follows from the already admitted clauses. The production implementation does this at lines 350–394. A final successful RUP check of the empty clause establishes inconsistency, rather than merely that some learned clauses were valid.

The payload verifier reconstructs all cases, checks their complete target set, validates each Farkas lemma, validates each successive RUP clause, and checks a final empty-clause contradiction per target. It does not trust a stored UNSAT status or solver answer.

### Reversal and lifting

`instances(False)` reverses each already labeled word. It does not relabel the reversed original under a newly claimed algebra. This is correct for the stated syntactic exclusion.

If an original-system interpretation existed, assign both labeled copies of each original symbol its coefficients. Removing labels then preserves interpretation by induction on word length. Reversal also commutes with removing labels. All original weak comparisons, and a designated strict target, therefore lift to the corresponding certified labeled case. No top-termination semantic-labeling theorem is needed for this contradiction.

## Independent diagnostics and replay

The companion diagnostic is `research-review/consolidation-2026-09-05/yah-semantic-differential.py`. Run it from a research-repository root, or pass that root as its sole argument. It alters imported objects only in its own process to isolate each row; it never edits the mathematical source. It independently folds token functions using the pair-composition formula `(m,v) ∘ (M,V) = (m+M, max(m+V,v))`, with bottom absorbing addition.

For every one of 44 rule/orientation rows it exhaustively checks all local token assignments from the eight valid pairs in `{bottom,0,1}²`, then adds 100 deterministic wider-value cases using values up to `10^50`. It checks weak comparisons individually, strict comparisons jointly with weak orientation, and Boolean gate clauses. Total: **288,560 assignments; zero mismatches**. This includes constants, absent slopes, absent intercepts, ties, repeated tokens, and reversed composition.

A second independent implementation checks every Farkas sum and replays RUP by set-based clause simplification instead of the production checker's assignment-array scan. Results: **491 Farkas lemmas, 426 RUP clauses, ten terminal contradictions: all passed**. The original direct and top replayers also passed with `python3 -S -B` and assertions enabled. The source remained at the pinned SHA with no tracked changes.

The payload's actual LF byte hash is `dafb9bfcbe02a32905fc46d99ceb97b9b296059869d77ee42cff5c99d04592d6`; its historical documented hash corresponds to CRLF serialization, as the earlier review established. This is a provenance annotation, not a failed mathematical obligation. The comment describing a “49-row” cancellation in the top replayer should read “22-row cancellation of multiplier mass 49”; the operative code checks 22 rules correctly.

## Optional strengthening derived during this audit

The existing note is conservative about real coefficients with strict gaps below one. In this exact syntactic class, all support, weak, and max-plus composition conditions are homogeneous in the finite coefficients. Suppose nonnegative-real coefficients satisfied the same strict target conditions. Choose the finite witnesses realizing the target's intercept maximum. There are finitely many positive differences required by these witnesses and, where applicable, the finite slope comparison. Multiply every finite coefficient by a sufficiently large positive constant so each of these differences is at least one. Supports and all weak comparisons are preserved. This would satisfy the real relaxation already refuted by the certificates.

Thus the same exclusion also extends to **nonnegative-real coefficient assignments with the same coefficientwise strict relations**, by an explicit scaling argument. This is a derived feasibility corollary, not a claim that ordinary strict order on nonnegative reals is well-founded, not an exclusion of negative coefficients, and not a reason to inflate novelty. It should be introduced as a separate corollary if adopted, instead of silently changing the existing theorem's carrier.

## Publication recommendation

Share the full-plus-top obstruction as an exact-certificate research artifact, stating the carrier, dimension, first-step restriction, coefficientwise tests, original/reversed target families, and fixed-label scope in the abstract. The full cancellation alone is elementary; the value worth specialist scrutiny is the complete top case analysis and its reusable certificate chain. A bounded search cannot turn this into a priority certification.

The remaining formalization target is concrete: formalize the max-plus interpretation and composition semantics, the interpretation-to-formula implication, Farkas clause soundness, and RUP soundness. Merely checking the stored arithmetic identities inside Lean would omit the most important bridge. No additional identical replay is needed to establish the present artifact's recorded status.
