# Source integration — Yolcu–Aaronson–Heule mixed-base rewriting

**Date:** 2026-08-23  
**Purpose:** integrate the exact prior-art claims into Round 7 and prevent Route A/AB from overstating what automated termination searches do.

## Primary source

Emre Yolcu, Scott Aaronson, Marijn J. H. Heule, **“An Automated Approach to the Collatz Conjecture,”** *Journal of Automated Reasoning* 67, article 15 (2023). DOI: `10.1007/s10817-022-09658-8`.

Reproducibility repository:

`https://github.com/emreyolcu/rewriting-collatz`

Earlier conference/preprint versions appeared in 2021; the 2023 journal article contains the expanded treatment used here.

## 1. Exact theorem imported

The paper defines

$$
T(n)=\begin{cases}
n/2,&n\equiv0\pmod2,\\
(3n+1)/2,&n\equiv1\pmod2,
\end{cases}
$$

and an 11-rule mixed binary/ternary string rewriting system `T`.

Theorem 3.17 proves:

> the rewriting system terminates if and only if the accelerated Collatz map is convergent.

Since this accelerated map has the same convergence question as the ordinary Collatz map, **termination of the exact SRS is genuinely Collatz-equivalent**.

This is prior art and must not be reported as a Round-7 discovery.

## 2. Exact representation imported

The symbols have affine semantics

```text
f(x) = 2x
 t(x) = 2x + 1
0(x) = 3x
1(x) = 3x + 1
2(x) = 3x + 2
```

with boundary symbols for the leading `1` and trailing identity.

The auxiliary rules are exact binary/ternary base swaps preserving the represented integer. The two dynamic rules apply one accelerated Collatz step.

This is the mathematical reason the Round-7 affine cylinder engine and the mixed-radix system meet exactly rather than metaphorically.

## 3. What automated matrix interpretations do and do not establish

The paper searches natural/arctic matrix interpretations and obtains automated termination proofs for several weakened/generalized Collatz systems and subsystems.

However:

- no termination proof of the full Collatz-equivalent SRS is found;
- the paper explicitly leaves open whether richer termination approaches can prove it;
- matrix/arctic interpretation search is a **sufficient proof template**, not an equivalence to Collatz.

A 2020 MathOverflow discussion involving Emre Yolcu makes the same methodological point explicitly: existence of a suitable matrix certificate is known only as a sufficient condition in this context, not an equivalent characterization of Collatz.

Therefore:

> failure to find a matrix interpretation is evidence only about that certificate class, not evidence that Collatz is false or that rewriting is impossible.

This distinction is now mandatory in the Route-A status ledger.

## 4. Existing negative result that constrains search

For the earlier unary rewriting representation, the authors prove nonexistence of natural matrix-interpretation proofs of the relevant kind, including the dependency-pair setting treated in the paper.

Their mixed-base representation was introduced specifically because the unary encoding interacts badly with that proof template.

**Transferable lesson:** representation choice changes automated proof complexity dramatically. A no-go result for one encoding/certificate class is not a no-go result for the mathematical statement.

## 5. Exact rules used by Round AB

In ASCII notation matching the public repository, the Collatz-equivalent system is:

```text
f$ -> $
t$ -> 2$

f0 -> 0f
f1 -> 0t
f2 -> 1f
t0 -> 1t
t1 -> 2f
t2 -> 2t

^0 -> ^t
^1 -> ^ff
^2 -> ^ft
```

The published repository stores the corresponding system as `rules/collatz-T.srs`.

## 6. Current literature-search result

A targeted 2026-08-23 public search located:

- the 2023 journal article;
- the 2021 mixed-base workshop/conference versions;
- the authors’ public repository and talks;
- a 2023 Dagstuhl presentation describing the same program;
- general termination literature/tools cited by the authors.

It did **not** locate a later peer-reviewed/public result claiming termination of the full 11-rule Collatz system.

This is not an exhaustive MathSciNet/zbMATH/citation-network priority certification. It only means no obvious published full-termination follow-up was located in this targeted search.

## 7. Consequence for Round 7 search allocation

Route A should not merely repeat the original bounded natural/arctic matrix search at larger dimensions without a reason.

Higher-value continuations are:

1. richer termination/certificate classes not exhausted by the original prover;
2. relative/macro termination arguments;
3. exact coalescence macros from Route B;
4. semantic labeling or state augmentation using mixed-radix carry information;
5. generic certificate checking in Lean after a finite macro language is identified.

This motivates `proof-search/routes/AB_mixed_radix_coalescence_bridge.md`.

## 8. Claim discipline

The following statements are safe:

- “termination of the published 11-rule SRS is equivalent to Collatz” — **prior-art theorem**;
- “the Round-7 cylinder refinement has the same affine semantics as the mixed-radix branch mechanics” — **project derivation, exact**;
- “a finite macro-coalescence certificate might be easier to synthesize than a primitive matrix interpretation” — **research hypothesis**;
- “no current full certificate has been found” — **current project state**.

Do not say:

- that the 11-rule representation makes Collatz a finite brute-force search;
- that failure of matrix search weakens the conjecture;
- that Route AB is a proof merely because its certificate, if found, would be finite;
- that absence of a follow-up in a targeted web search certifies novelty.

## Connections

- **Supplies semantics to:** [unlabeled adjacent-edge no-go](../proof-search/routes/A_yah_2local_edge_potential_no_go.md), [fixed two-state no-go](../proof-search/routes/A_yah_two_state_semantic_label_no_go.md), and [dimension-one scalar-arctic no-start](../proof-search/routes/A_yah_two_state_scalar_arctic_full_no_start.md).
- **Feeds the parallel macro route:** [mixed-radix coalescence bridge](../proof-search/routes/AB_mixed_radix_coalescence_bridge.md).
- **Navigated by:** [research atlas](../ATLAS.md).
