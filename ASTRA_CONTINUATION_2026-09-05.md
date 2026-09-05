---
node_id: ASTRA-CONTINUATION-2026-09-05
node_type: research-report
routes: [A, B, AB, D]
tags: [collatz, formal-verification, quarter-gap, coalescence, ranked-normalizer]
---

# Collatz continuation: the universal quarter gap is now Lean-verified

## 0. Outcome and scope

**The universal L15 quarter-gap theorem now has a complete Lean proof for actual
Collatz orbits.** Its supporting normalized envelope holds from odd count 16
onward, and an exact countercheck at 15 establishes the sharp eventual threshold.
The unchanged pinned Lean 4.33.1 toolchain passed all 17 build jobs at revision
`b3b299e6acd5ac84fcaa640ae4158ac93adfdaad` in
[run 33970405108](https://github.com/Sodelin/Collatz-Conjecture-Work/actions/runs/33970405108).

This is a substantial internal formalization milestone. **Collatz remains
unresolved.** The theorem assumes an existing first coefficient contraction;
it does not prove that every positive start has one. Mathematical priority
for the inequalities is not established by this work.

This continuation also supplies a working, explicitly ranked stopping map to
the known target `1`, `2`, or `20 mod 27`; exact smaller coalescing targets;
stronger, carefully scoped rank obstructions; and a concrete failure of naive
composition of a return map with a decreasing coalescence normalizer.

## 1. Research objective and baseline

The user authorized a sustained attempt at full closure or a major contribution,
using the new lemmas and parallel research. This pass continued the reviewed
draft branch at `b6eee8594714adc3b51d5005dd0b4ed8a76412e8`, after the
[first two passes](ASTRA_RESEARCH_PASS_2026-09-05.md). Work remains in
[draft PR 16](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/16).

The decision hierarchy was: seek a pointwise convergence mechanism; test it
against known expanding families; independently audit the exact statements;
and complete the strongest attainable theorem with reproducible evidence.
Four parallel tasks covered formal arithmetic, smaller coalescence, rank escape,
and primary literature. Separate cold reviews checked the formal dependency
chain and the distinction between original and newly normalized return maps.

## 2. Definitions and the exact verified theorem

Use the one-division shortcut map

\[
T(n)=\begin{cases}(3n+1)/2,&n\text{ odd},\\n/2,&n\text{ even}.\end{cases}
\]

For a positive integer start, let `q_j` count odd steps in its actual first
`j` transitions. A first coefficient contraction is a finite index `k>0` with

\[
3^{q_k}<2^k,\qquad 2^j\le3^{q_j}\quad(0\le j<k).
\]

If this first contraction has not descended, write `T^k(n)=n+d`, `d>=0`, and
put `s=q_k`. The fully checked conclusion is

\[
\boxed{4d<s,\qquad d\le\left\lfloor\frac{s-1}{4}\right\rfloor.}
\]

The [trusted statement](lean/CollatzWork/QuarterGapUniversalStatement.lean)
uses the actual existing shortcut iterate. Its hypotheses contain neither an
assumed mechanical bound nor an assumed convergence conclusion. The theorem
is uniform in every positive start, every eligible first contraction, and
every natural defect. It is not restricted to a tested numerical range.

## 3. The completed formal dependency chain

The mechanical recurrence is

\[
C_0^{\max}=0,\qquad
C_{s+1}^{\max}=3C_s^{\max}+2^{\lfloor\log_2(3^s)\rfloor}.
\]

The proof establishes the actual affine identity, bounds its remainder by
this mechanical recurrence using all earlier coefficient barriers, and
proves the exact first crossing time. It then verifies the twelve possible
dyadic threshold regions with integer arithmetic, expands the recurrence
over twelve terms, and propagates the normalized envelope by twelve steps.

| Component | Formal result |
|---|---|
| Actual orbit | `2^k*T^k(n)=3^q_k*n+C_k`, with `C_k<=Cmax(q_k)` at first contraction. |
| Crossing | `k=floor(log2(3^s))+1` at an existing first contraction. |
| Twelve-term certificate | Exact integer dyadic scaling and all twelve ordered threshold cases. |
| Bases and propagation | Kernel checks at 16 through 27; induction covers every subsequent count. |
| Small remaining counts | Kernel certificate for 1 through 15, extracted from the already checked range 1 through 107. |
| Actual-orbit conclusion | Positivity gives `2^k*d<C_k`; the universal certificate yields `4d<s`. |

The proof also formalizes the old universal `3d<s` result. Nine proof modules
are now imported by the project umbrella; five were added in this continuation,
with three additional trusted-statement files. The
[scope note](verification/Quarter_Gap_Formal_Scope_2026-09-05.md) gives the
complete theorem-by-theorem chain and [retained axiom log](verification/lean_quarter_gap_ci_2026-09-05.txt).

## 4. A sharp supporting threshold

The completed proof strengthens the earlier sufficient threshold 108 to

\[
4C_s^{\max}\le s3^s\quad\text{for every }s\ge16.
\]

At the immediately preceding count,

\[
4C_{15}^{\max}=217653340>215233605=15\cdot3^{15}.
\]

Thus 16 is the smallest threshold from which this normalized inequality holds
at every later count. This does not say it fails at every smaller count.
The quarter-gap theorem itself still holds for all eligible odd counts.
The independent [integer certificate](verification/block_arithmetic_certificate.py)
checks the twelve exact regions and this threshold without feeding answers
into Lean.

The arbitrary-length real-phase theorem and the previous 1024-term conditional
frontier refinement retain their separate prose/exact-Python status. This
continuation does not present them as kernel-verified consequences.

## 5. Positive progress on smaller coalescing targets

For odd `n=2 mod 3`, the predecessor

\[
\gamma(n)=\frac{2n-1}{3}<n,\qquad T(\gamma(n))=n
\]

is an exact smaller coalescing target. If `n+1=2^a3^b lambda`, repeated
application removes the full factor `3^b`, producing `2^(a+b)lambda-1`.
Combining these decreasing moves with the repository's existing beta moves
gives a total size-decreasing normalization to a stricter hard core.

This removes every source in the previous F026 witness family from a
minimal-counterexample argument: `589824t+244379` has the smaller predecessor
`393216t+162919`. The original rank obstruction remains valid on its original
transition relation; this target selection changes the proof problem.

Further exact inverse words give additional targets. For every positive odd
`n=4 mod 9`,

\[
p=(8n-5)/9<n,\qquad T^3(p)=n.
\]

These are useful constructive reductions, not a universal target selector.
The [coalescence note](proof-search/routes/AB_ternary_normalized_core_residue_obstruction.md)
contains guards, affine identities and precise convergence-transfer statements.

## 6. Stronger obstructions and their exact limits

Two independent constructions prevent a fixed residue refinement from rescuing
the specified polynomial size ranks.

| Relation | Proved obstruction | Important boundary |
|---|---|---|
| Original hard return `F` | For every fixed modulus, expanding finite paths freeze all stated endpoint labels and residues, by an explicit CRT construction. | Applies to ranks decreasing on every original `F` edge. It does not prohibit different target choices or unbounded valuations. |
| Stronger normalized core | `1536Mv-5` maps to `1728Mv-5` with the stated core labels and all fixed-modulus refinements frozen. | This is a newly normalized relation; it is not an original `F` edge. Further smaller targets can remove these witnesses. |
| First return to `20 mod 27` | An expanding OEO family freezes fixed residues and `(L,e,b)`. | The debt labels `D,R` are not frozen here; do not import the larger label class from the preceding row. |

The original construction handles moduli 5 and 67 by repeating the return word;
a single-word argument would miss those genuine modular obstructions.
Its exact checker replayed 90 positive paths, totaling 6,330 true `F` edges,
across 18 uniform affine certificates. See the
[original-F proof](proof-search/routes/AB_finite_residue_original_return_no_go.md).

The resulting no-go applies to lower-bounded polynomials in size or bitlength
with the stated finite state dependence, and to finite lexicographic tuples
whose coordinates each meet the required lower-bound condition. It is not a
proof that every possible finite-state or coalescence certificate must fail.

## 7. A known stopping theorem becomes an explicit working rank

Monks, Monks, Monks and Monks prove that divergent or nontrivially cyclic
positive orbits hit `20 mod 27`. We reconstructed the applicable stopping
consequence directly: every positive shortcut orbit reaches `1`, `2`, or
`20 mod 27`. This is known mathematics, with no novelty claim.
[Primary preprint](https://arxiv.org/abs/1204.3904v2),
[published article](https://doi.org/10.1016/j.disc.2012.11.019).

The explicit rank uses fifteen core residues with heights in `{0,1,2}` and
weights `(16,28,49)`. All 25 internal modular edges contract `w_h*n` by a
uniform factor at most `20/21`. A finite lexicographic phase rank handles
multiples of 3, the core, residue 26, residue 13, and the stopping target.
At residue 26, arbitrarily long odd self-loops are controlled by `v2(n+1)`;
their eventual exit is proved arithmetically.

The [full rank and source audit](proof-search/sources/Sufficiency_Rank_Audit_2026-09-05.md)
prove termination at this target for every positive input. The rank is already
zero there, so it supplies no decrease across subsequent target-to-target
returns. That distinction is the exact remaining bridge for this route.

## 8. Composition can undo a valid reduction

The exact sequence

\[
425\xrightarrow{T}638\xrightarrow{T}319\xrightarrow{T}479
\xrightarrow{c}425,\qquad c(y)=(8y-7)/9
\]

is a loop in the proposed auxiliary system. The last arrow selects a smaller
coalescing predecessor. **It is not a Collatz transition or a Collatz cycle.**
It demonstrates that a first-return map followed by a decreasing normalizer
can return to its own input. Separate validity of both ingredients is
insufficient for progress of their composition.

Signed time accounting makes the problem explicit: this loop has advance
`+3-3=0`. If `T^a(n)=T^b(m)`, first-hit times differ by `a-b` when both
prefixes avoid 1; with only the source-prefix guard, the corresponding
inequality holds. Accumulated positive advance can rule out infinite
certificate paths conditional on convergence. It is not an unconditional
termination argument: ordinary forward Collatz iteration already has advance
`+1`. The [full guard and telescoping audit](proof-search/routes/AB_ternary_normalized_core_residue_obstruction.md)
states the precise admission condition.

## 9. A useful source import, and a rejected proof step

Ansari's 2025 smaller-coalescence induction theorem is a valid published
comparator for the repository's formal convergence criteria. Its hypothesis
still requires an actual smaller target; it supplies no universal construction.
[Publisher record](https://nntdm.net/volume-31-2025/number-3/471-480/).

The later sieve proof uses a false set equality already at its first induction
step: its left side contains eight of nine ternary patterns, while the claimed
right side contains four. The integer 11 distinguishes the sets. A separate
infinite-intersection display omits 3. Correcting the latter does not repair
the former. We therefore do not import the stronger sieve or verification-limit
claims. This rejects those proof steps, not the Collatz conjecture.
[Exact primary PDF](https://nntdm.net/papers/nntdm-31/NNTDM-31-3-471-480.pdf).

## 10. Verification and reproducibility

The accepted Lean build uses the official unchanged release, the checksum
pinned in the workflow, and the exact source revision recorded above. The
universal mechanical certificate uses only `propext` and `Quot.sound`; the
actual-orbit quarter-gap theorem additionally uses `Classical.choice`.
There is no theorem-strength project axiom, unfinished proof, `native_decide`,
or external arithmetic oracle in that formal chain.

Four additional exact checkers are included in CI:

```bash
python -B verification/block_arithmetic_certificate.py
python -B verification/finite_residue_hard_return_check.py
python -B verification/core_residue_obstruction_check.py
python -B verification/mod27_rank_check.py
```

The [verification index](verification/README.md) links retained outputs and
their precise scopes. Integer regression is supplementary to the universal
proofs; finite testing alone does not establish their quantifiers. The CI
workflow also repeats the existing arithmetic, normal-form, scalar-arctic
and note-graph checks. Later commits require their own successful CI run.

## 11. Process integrity assessment

**Formal chain: strong within the stated theorem.** Trusted statements,
independent semantic review, unchanged-kernel checking and axiom inventories
provide complementary checks. Intermediate failed builds were corrected and
are not counted as accepted proofs. Proof discovery and verification share
some project assumptions, so the actual map and quantifiers were inspected
explicitly rather than inferred from a green build.

**Nonformal results: checked, with a stated trust boundary.** They have prose
proofs, independent algebraic review and exact reproducible certificates;
they have not been promoted to Lean-verified status. The transition relation
and frozen labels are specified separately for each rank obstruction.

**Literature selection: targeted, not exhaustive.** Primary statements and
publication metadata were checked for the two new imports. Search relevance
and publication are not treated as proof of correctness. Clinical risk-of-bias
and meta-analysis scores do not apply to these deductive claims; no numerical
GRADE or AMSTAR rating is invented. No external priority assessment is claimed.

## 12. Robustness and sensitivity assessment

The formal quarter-gap conclusion covers every eligible odd count; it has no
untested large-input tail. Failure at 15 makes the supporting threshold claim
sharp, while the separate small certificate preserves the universal theorem.
The integer construction avoids numerical sensitivity in real logarithms.

The original-F obstruction quantifies over every fixed modulus, including
moduli where a one-word construction fails. Its limit is structural: changing
the transition relation or allowing unbounded state can evade its hypotheses.
The stronger-core witnesses themselves admit further smaller targets, an
explicit reason to continue constructive coalescence research.

The modulo-27 rank handles arbitrary sizes and arbitrarily long residue-26
loops; its failure to control target returns is a theorem boundary, not a
numerical cutoff. The 425 auxiliary loop is an exact stress test for future
composition proposals. Neither positive signed advance nor the quarter gap
discharges the missing universal convergence premise.

## 13. Open goals and reopening conditions

1. Construct a pointwise smaller-target mechanism, or a proved well-founded
   return relation, with an immutable induction root and full guard coverage.
2. For the residue-20 route, prove progress across returns or give a different
   exact coalescence selector that survives the 425 composition test.
3. For the coefficient route, discharge the missing existence/renewal/root
   hypotheses and the zero-gap branch; the newly verified inequality alone
   cannot supply these premises.
4. If useful, formalize the general phase theorem and 1024-block refinement
   separately. They are optional strengthening work, not the current global
   closure bottleneck.

Do not reopen fixed-modulus polynomial ranks without addressing the exact
families above. Do not infer impossibility of all rank or coalescence methods
from these scoped obstructions. The current continuation ends with a proved
auxiliary milestone and precise remaining mathematical work.

## 14. Evidence graph and references

- **Formalizes:** [L15](proof-search/lemmas/L15_Quarter_Gap_and_Rotation_Block_Certificate.md), with the specified parts of L9 and L10.
- **Refines:** [formal targets](LEAN_TARGETS.md) and [claim registry](proof-search/CLAIM_REGISTRY.md).
- **Constrains:** [approach registry](proof-search/APPROACH_REGISTRY.md) and [failure ledger](proof-search/FAILURE_LEDGER.md), entries F028 and F029.
- **Constructs:** [smaller targets and stronger core](proof-search/routes/AB_ternary_normalized_core_residue_obstruction.md).
- **Audits:** [primary sufficiency results](proof-search/sources/Sufficiency_Rank_Audit_2026-09-05.md).
- **Records:** [BibTeX references and source-role keywords](ASTRA_REFERENCES_2026-09-05.bib), [verification evidence](verification/README.md), and [continuation handoff](CONTINUATION.md).

The repository notes and BibTeX entries carry explicit relationship and source-role
tags for later reference-manager or note-graph import. No external Zotero or
Obsidian synchronization is claimed.
