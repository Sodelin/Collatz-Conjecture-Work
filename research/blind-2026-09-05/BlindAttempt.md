---
title: "Independent Collatz attempt: partial results and checked Lean proofs"
date: 2026-09-05
tags:
  - mathematics/collatz
  - formalization/lean
  - research/independent-attempt
  - claim-status/partial
---

**Phase boundary:** this is the independent-phase report. The later [repository reconciliation](../../BLIND_RECONCILIATION_2026-09-05.md) identifies rediscoveries and strengthens the recurrence argument.

**0. Executive decision brief**

This attempt did **not** obtain a complete proof of the Collatz conjecture. It produced several exact partial results, three independently compilable Lean files, and a precise diagnosis of the failed global argument. No existing Collatz project files or outside mathematical sources were consulted. This means an independent derivation in this session; it does not establish historical novelty or erase the model's prior mathematical knowledge.

The most useful result is a finite bound on repetitions of a fixed expanding affine block. The attempted extension to changing patterns fails because its proposed decreasing quantity changes with the pattern. A further analytic argument restricts the complexity of some hypothetical divergent valuation sequences, but gives no universal contradiction.

| Finding | What it establishes | Verification |
|---|---|---|
| Arbitrarily long expanding `(1,2)` blocks | Bounded ascent runs do not guarantee descent | Lean kernel checked |
| Fixed-block repetition bound | A positive seed cannot repeat one expanding affine block forever | Lean kernel checked; sharper valuation criterion proved analytically |
| Descent iff convergence | The exact remaining universal descent obligation would imply Collatz | Lean kernel checked, both global propositions unproved |
| Square-prefix bound | Even changing repeated words have a length bound at a fixed noncyclic seed | Analytic proof; not Lean checked |
| Conditional complexity bound | Low-complexity aperiodic candidates with an existing low mean valuation can be excluded | Analytic proof; not Lean checked |

These are proof-status categories, not clinical GRADE assessments. Numerical tests check formulas; they provide no proof of universal termination. The next mathematical target is a common well-founded quantity for changing valuation blocks. The current work does not establish that such a quantity exists.

**1. Abstract**

Starting from the ordinary and accelerated Collatz definitions, independent lines of attack examined forward descent, affine valuation words, inverse ancestors, and proof formalization. The resulting finite arithmetic identities and obstruction lemmas survive checking. The global inference does not: excluding periodically expanding words and selected aperiodic words leaves general aperiodic trajectories and nontrivial positive cycles unresolved.

**2. Problem and conventions**

The ordinary map is `C(n)=n/2` for even n and `C(n)=3n+1` for odd n. The target is: every positive integer has a finite iterate equal to 1.

For positive odd n, use the accelerated odd map

$$
U(n)=\frac{3n+1}{2^{a(n)}},\qquad a(n)=v_2(3n+1).
$$

The shortcut map divides by two once on either branch. One `(1,2)` valuation block is **two accelerated odd steps, three shortcut steps, or five ordinary steps**. The Lean growth file checks the shortcut/ordinary connection explicitly for this block.

**3. Method**

The initial approaches were developed independently, then exchanged for criticism. Exact algebra was tested against integer computation. Lean 4.33.1 with `Std` checked the three formal source files. Their principal theorem axiom reports contain only `propext` and `Quot.sound`; no added axioms, `sorry` placeholders, or `native_decide` were used.

The restriction against consulting earlier work was maintained. No literature search, novelty search, or repository comparison was performed. One inverse-tree proof attempt was rejected after its integrality assumption failed; its correction is recorded in `InverseNotes.md`.

**4. Findings and proofs**

For any q≥0,

$$
16q+11\xrightarrow{a=1}24q+17
\xrightarrow{a=2}18q+13>16q+11.
$$

The exact valuations follow from `3(16q+11)+1 ≡ 2 mod 4` and `3(24q+17)+1 ≡ 4 mod 8`. Repeating the block, for m,t≥1, gives the checked family

$$
n_0=16\,8^m t-5,
\qquad U^{2m}(n_0)=16\,9^m t-5>n_0.
$$

Every intervening block endpoint increases. This is an arbitrarily long **finite** expansion theorem. The starting value changes with m. Interchanging “for every length there is a seed” with “there is a seed for every length” would be invalid.

The complementary repetition theorem applies to any affine block

$$
b x_{j+1}=(b+d)x_j+c,
\quad \gcd(b,b+d)=1,
\quad b>1,
\quad d x_0+c>0.
$$

Put y_j=d x_j+c. Direct expansion gives `b y_(j+1)=(b+d)y_j`. After k repetitions,

$$
b^k y_k=(b+d)^k y_0.
$$

Coprimality gives `b^k | y_0`; positivity therefore gives

$$
\boxed{b^k\le d x_0+c.}
$$

This proves a fixed block cannot recur indefinitely under these hypotheses. For an expanding Collatz word, set `b=2^s`, `b+d=3^ℓ`, and use its positive affine constant c. For `(1,2)`, this is simply `8^k≤x_0+5`.

The sharper exact-word result in `SymbolicNotes.md` states that a word with map `(A n+c)/2^s` repeats r times exactly when

$$
v_2((A-2^s)n+c)\ge rs+1.
$$

It is proved analytically and checked in 136,000 finite comparisons. The generic Lean bound proves a consequence; the entire exact-word equivalence is **not** formalized in the accompanying Lean files.

The analytic extension to repeated words of changing shapes gives: if a word of length ℓ occurs twice consecutively from n, and its first copy does not return to n, then

$$
(4/3)^\ell<(n+1)/2.
$$

The two block starts share a residue class modulo `2^(s+1)`, so distinct starts differ by at least that amount; the accelerated growth bound controls their possible separation. The full proof is in `SymbolicNotes.md`.

A further analytic theorem assumes the odd orbit has distinct entries and a limiting mean valuation α. Writing p(L) for the number of distinct length-L valuation blocks, it gives

$$
1\le\alpha\le\log_2 3,
\qquad
\liminf_{L\to\infty}\frac{p(L)}L
\ge\frac{\alpha}{\log_2 3-\alpha}
\quad(\alpha<\log_2 3).
$$

At equality `α=log₂3`, the complexity ratio tends to infinity. The notes prove the needed uniform bounds and explicitly retain the mean-existence hypothesis. This excludes the concrete substitution candidate `1→12, 2→21`: its mean is 1.5 and its complexity is below `8L`, whereas the required asymptotic slope is about 17.6548. This result has an analytic proof, not a Lean formalization.

**5. Conclusion**

There is no complete Collatz proof in this packet. The formal results are exact restrictions and a reduction. They do not supply the missing universal premise.

**6. Deconstructive analysis: where closure would enter**

`Descent.lean` proves

```lean
theorem descent_iff_convergence : UniversalDescent ↔ CollatzConjecture
```

`UniversalDescent` means every n>1 eventually has a positive-time iterate below n. The forward implication uses strong induction and positivity. The converse uses reaching 1. Both properties are declared only as propositions; neither has a proof term in this work.

This equivalence is a precise specification of the gap, not a solution to it. A complete proof must also rule out nontrivial cycles; excluding expanding periodic words alone does not do that.

**7. Reconstructive analysis: why the local argument does not accumulate**

For one fixed word, the same positive integer `(A−2^s)n+c` is repeatedly forced to contain more powers of two. A fixed positive integer cannot do this forever.

When the word changes, A, s, and c change. For an arbitrary prefix ending at n_k, the relevant identity becomes

$$
(A-2^s)n+c=2^s(n_k-n).
$$

Its one-copy divisibility condition merely records that both endpoints are odd. No common quantity has been shown to decrease across all choices of the next block. Treating these different quantities as one finite budget would be the invalid step.

**8. Middle-out synthesis and next target**

The growing family and the repetition bound are compatible: longer prescribed expansion requires larger seeds, while every fixed seed exhausts any fixed pattern's repetition budget. The complexity theorem advances beyond periodic patterns but still permits high-complexity valuation sequences, and says nothing universal when the valuation average fails to exist.

The highest-value next target from this attempt is an invariant or an arithmetic constraint controlling **changes between blocks**. Any proposed theorem must survive the explicit growing family, handle patterns with no limiting average, and account for positive cycles. No such theorem is asserted here.

**9. Glossary**

| Term | Meaning |
|---|---|
| Valuation `v₂(x)` | Number of factors of two dividing nonzero integer x; `v₂(0)=∞` in the exact-word note |
| Valuation word | The successive exact division counts in the odd map |
| Affine block | A finite composition written `(A n+c)/B` |
| Square prefix | Two consecutive copies `ww` starting at the specified seed |
| Subword complexity | Number of distinct contiguous words of a given length |
| Kernel checked | Lean accepted the proof term for the statement actually declared |

**10. Bibliography and provenance**

No external mathematical bibliography was consulted or fabricated. Sources for this packet are the derivations, Lean files, and reproducible arithmetic checks included here. A blind derivation does not establish priority; literature comparison would be a separate task.

**11. Process-integrity reflection**

Process verdict: appropriate for an exploratory derivation, not a systematic review. Independent development, counterexample checking, exact claim labels, and compiler verification were used. An error in an inverse-tree argument was exposed and its faulty generalization withdrawn. The main remaining process limitation is that the later analytic complexity result has not undergone Lean checking or external specialist review.

Search completeness, PRISMA screening, AMSTAR-2, and trial risk-of-bias scores do not apply to this mathematical task. Assigning a numerical review score would create false precision. Reproduction instructions and compiler outputs are included instead.

**12. Inference-robustness reflection**

Robustness verdict: strong for the stated kernel-checked lemmas; analytic support for the additional derivations; insufficient for universal termination. Finite experiments cannot exclude an exceptional infinite orbit. No statistical effect size, heterogeneity statistic, or publication-bias test is applicable.

What would change the overall verdict: a proof of `UniversalDescent` with no unproved assumptions, or an equivalent independently checked theorem covering every positive integer. What would weaken an analytic result: a failure of its exact-word congruence, uniform error estimate, or stated average hypothesis. The finite checks test algebra and indexing, not the infinite quantifiers.

**13. Zotero and Obsidian integration**

Use this Markdown file as an Obsidian note and retain the linked source files together. For Zotero, create a **Document** item titled as above, dated 2026-09-05, and attach this note and the packet. Tag it `collatz`, `lean`, `independent-derivation`, `partial-result`, and `novelty-unverified`. It is a generated working document, not a published research article. Relate it to existing project notes only after a separate comparison; no earlier work was inspected here.

**14. Reproduction appendix**

The three `.lean` files each import only `Std`. With Lean 4.33.1 on the path, run:

```bash
lean Descent.lean
lean AlternatingGrowth.lean
lean RepetitionBound.lean
python3 ../../verification/blind_word_recurrence_check.py
```

The [verification record](../../verification/Blind_Recurrence_Verification_2026-09-05.md) records compiler results, exact arithmetic test counts, source hashes, and retained logs. The expanded arguments are in `SymbolicNotes.md` and `InverseNotes.md`; those files are analytic notes, not additional formal proof modules.
