# Primary-source screen of three new discovery candidates

Date: 2026-09-05. This is a bounded relevance and implication screen, not a full novelty certification or peer review. Three alphaXiv discovery hits supplied by the coordinating agent were checked against current arXiv records before reading their PDF text. No additional alphaXiv discovery calls were used.

## Identity and version verification

| Identifier | Verified title and authors | Current primary record |
|---|---|---|
| [2607.10041](https://arxiv.org/abs/2607.10041) | *Adaptive Search in Collatz Exponent-Code Space via 2-adic and 3-adic Constraints* — Oliver Kramer | v1, 10 July 2026; six pages; no withdrawal displayed |
| [2603.25753](https://arxiv.org/abs/2603.25753) | *A Structural Reduction of the Collatz Conjecture to One-Bit Orbit Mixing* — Edward Y. Chang | v1, 24 March 2026; thirteen pages; no withdrawal displayed; PDF internally dated March 30 |
| [2602.21895](https://arxiv.org/abs/2602.21895) | *Symbols frequencies in the Thue–Morse word in base 3/2 and related conjectures* — Julien Cassaigne, Bastiàn Espinoza, Michel Rigo, Manon Stipulanti | v1, 25 February 2026; thirty-nine pages; no withdrawal displayed |

The PDF-tool results explicitly identified these same three arXiv IDs with version `v1`; no title-to-paper substitution occurred. An arXiv listing does not itself establish peer review. The previously encountered withdrawn Niu paper `2605.13886` was not promoted or used as an independent accepted result.

## Claim comparison

**Kramer: close antecedent already correctly cited; no direct subsumption found.** Sections 3.2–3.4 define the same finite affine start and endpoint representatives. Theorem 1 proves that a fixed positive odd seed forces the two diagnostic rates to vanish; Corollary 2 excludes a code if either rate has positive lower limit. Its six-page paper does not state the bounded-alphabet carry converse or the exact nonrealizability rate alternative. No source-code URL appeared in the inspected paper. [Primary PDF](https://arxiv.org/pdf/2607.10041v1).

The repository's `F_bounded_alphabet_endpoint_residue_gate.md` correctly distinguishes this necessary direction from its bounded-alphabet equivalence: eventual zero carry, normalized endpoint vanishing, strict subcubic root growth, and positive realization. The claimed added converse remains an elementary strengthening requiring wider comparison, particularly against Wang's E-sequence results. Kramer neither settles arbitrary-code realizability nor supplies PR17's guarded original-root descent. This screen supports the existing modest characterization, not a novelty promotion.

**Chang: related research direction, with concrete defects requiring caution.** The paper leaves deterministic orbit-level balance open. Its Theorem 4.2 states an alternating signed residue-count difference, whereas its Table 1 has the opposite sign. Section 6.1 reports eighteen burst steps before the orbit of 27 reaches 1; direct calculation gives seventeen under its own definition. Its residue-class notation also needs a representative or lift convention: compressed division does not generally descend to the stated fixed modulus. [Primary PDF, pp. 4–5 and 9–10](https://arxiv.org/pdf/2603.25753v1).

Independent controls below establish these narrowly identified problems. They do not refute every lemma in the paper. None of the read material establishes PR17's exact divisibility-guarded family or resolves its recharge/escape complement. Do not import the headline reduction or its numerical assertions as a trusted bridge without separate reconstruction.

**Cassaigne et al.: different Thue–Morse object; no direct subsumption found.** Its sequence is digit-sum parity in rational base `3/2`, beginning `001110…`, rather than ordinary binary Thue–Morse `011010…`. Theorem 18 establishes half-frequency in each dyadic residue class; Theorem 14 addresses uniform recurrence, and Propositions 15 and 17 address symmetries of factors. These concern a different numeration sequence, not positive Collatz realization of a fixed valuation-word morphism of ordinary Thue–Morse. [Primary PDF, pp. 2–3, 19–22](https://arxiv.org/pdf/2602.21895v1).

PR20's theorem uses long repeated prefixes and a fixed-seed size/congruence contradiction. The rational-base frequency theorem does not directly imply its cycle-return conclusion or exclusion of `a_i=1+t_i`. Related combinatorics may suggest tools, but should not be merged as if the sequences or conclusions were identical.

## Reproducible Chang controls

The following standard-library calculation was executed. These are independent arithmetic computations, not copied source claims.

```python
from itertools import groupby

def U(n):
    m, a = 3*n + 1, 0
    while m % 2 == 0:
        m //= 2
        a += 1
    return m, a

for K in range(5, 10):
    S = [r for r in range(1, 2**K, 4) if U(r)[0] % 4 == 3]
    c3 = sum(U(r)[0] % 8 == 3 for r in S)
    c7 = sum(U(r)[0] % 8 == 7 for r in S)
    print(K, len(S), c3, c7, c3-c7)

print(U(5), U(37), 5 % 32, 37 % 32)
n, valuations = 27, []
while n != 1:
    n, a = U(n)
    valuations.append(a)
print(len(valuations), sum(a >= 2 for a in valuations))
```

Output:

```text
5 3 2 1 1
6 7 3 4 -1
7 15 8 7 1
8 31 15 16 -1
9 63 32 31 1
(1, 4) (7, 4) 5 5
41 17
```

Thus representative enumeration gives sign `(-1)^(K+1)` in these controls; the absolute difference of one agrees with the displayed table. Also `5` and `37` belong to the same class modulo 32 but have opposite burst-to-gap behavior. A theorem explicitly about least representatives may still count them, but cannot automatically be interpreted as a well-defined quotient dynamics or as uniform information about all integer lifts. The 27 control counts the forty-one source states preceding the first arrival at 1.

## Exact retrieval log and read depth

Primary metadata query: one `web.open` batch on the three arXiv abstract URLs in the identity table. All returned the stated identities and versions. One direct `web.open` of Chang's versioned PDF independently confirmed the extracted text. A requested PDF screenshot failed because the screenshot service was unavailable; no visual verification is claimed.

One parallel `alphaxiv_answer_pdf_queries` call per paper used the following exact queries:

### Kramer

1. “Identify the title, author, date/version of this PDF and list its numbered propositions/theorems about finite exponent-code realization, exact terminal valuation, 2-adic start representatives and 3-adic endpoint representatives.”
2. “What are the precise formulas and quantifiers in its residue-rate theorem, and does it imply a bounded-alphabet endpoint obstruction, an exact depth-two admissibility sieve, or a root-relative guarded descent theorem?”
3. “What explicit source-code links and antecedent references accompany the mathematical results, and what is explicitly left unproved?”

Read depth: complete returned PDF, pages 1–6, including theorem proof and references.

### Chang

1. “Identify the title, author and date/version; give the exact one-bit orbit-mixing assumption and theorem that claims to reduce Collatz to it.”
2. “Give the exact Map Balance theorem and low-depth run formulas and distinguish finite-residue counts from properties of every individual orbit.”
3. “Does this paper prove unconditional root-relative guarded descent for an infinite family, exclude a residue class such as 19 modulo 96, or leave recurrence/escape, recharge, or orbit mixing as an unproved assumption?”

Read depth: returned pages 1–5 and 7–13, focusing on definitions, Theorem 4.2, the open mixing condition, worked example, tables and discussion. Page 6 was not returned by the filtered PDF tool. No claim of full companion-paper proof reconstruction is made.

### Cassaigne et al.

1. “Identify the title, authors and version; define the rational-base 3/2 Thue-Morse sequence precisely and distinguish it from the ordinary binary Thue-Morse sequence.”
2. “State its main numbered theorems and any Collatz, Mahler, transcendence, rationality or automatic sequence results.”
3. “Does it study the Collatz 2-adic inverse of the ordinary Thue-Morse parity sequence and prove that inverse is nonintegral, or a dyadic complement/prefix sum recurrence relevant to that claim?”

Read depth: filtered pages 1, 2, 3, 6, 8, 10, 11, 12, 13, 19, 20, 21, 22, 34, 38, 39; close reading of sequence definition and relevant theorem statements, with frequency-proof context and references screened. The third query used “parity sequence” broadly; the precise repository target is an accelerated **valuation** code/morphism. That distinction was retained in the comparison.

## Integration recommendation

Keep Kramer as a direct antecedent and preserve the bounded-alphabet restriction. Keep Chang as a screened, untrusted comparison with explicit defects and an unresolved orbit-level bridge. Keep the rational-base Thue–Morse paper in related literature with a clear different-sequence tag. None supplies a reason to promote the consolidated work to universal Collatz convergence, nor did this bounded screen locate a theorem directly subsuming the three project targets.

One independent consolidation issue also requires updating the current claim ledger: PR20's new prefix-return exclusion negatively resolves the earlier Thue–Morse anchor's positive-realization gate, if PR20 passes the coordinating proof audit. The old conditional anchor can remain historically intact, but current status should point to that new exclusion rather than continue calling membership wholly open.
