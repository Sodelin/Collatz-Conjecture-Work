# Integer formalization of the universal first-contraction quarter gap

The complete universal L15 quarter-gap theorem passed the unchanged pinned
Lean 4.33.1 toolchain at revision
`b3b299e6acd5ac84fcaa640ae4158ac93adfdaad`,
[CI run 33970405108](https://github.com/Sodelin/Collatz-Conjecture-Work/actions/runs/33970405108).
All 17 build jobs succeeded. The proof uses the existing Lean standard library
and contains no theorem-strength project axiom or unfinished proof.
The [retained axiom log](lean_quarter_gap_ci_2026-09-05.txt) identifies the exact source.
This formalizes an auxiliary theorem, not the Collatz conjecture.

## Exact statement

The trusted `FirstContractionQuarterGapStatement` quantifies over positive
natural starts `n`, a finite first coefficient-contraction index `k`, and natural
defects `d`. Under `shortcutIter k n = n + d`, it concludes

\[
4d<q_k,\qquad d\le\lfloor(q_k-1)/4\rfloor.
\]

`shortcutIter` is the existing iterate of the ordinary one-division shortcut
map. `orbitOddCount n k = q_k` counts parity at the actual successive states;
`orbitRemainder n k = C_k` follows the actual affine recurrence.
`FirstCoefficientContraction` includes strict contraction at `k` and the
noncontracting coefficient barrier at every earlier index. It does not assume
that such an index exists for every start.

## Proof dependency chain

1. `orbitAffine`: `2^k*T^k(n)=3^q_k*n+C_k` for every actual finite prefix.
2. `mechanicalEnvelope`: before the first coefficient contraction, the actual
   remainder satisfies `C_k≤mechanicalMax(q_k)`. The proof uses integer
   `Nat.log2` and prefix inequalities, with no real logarithms.
3. `affine_gap_strict`: positivity and strict coefficient contraction imply
   `2^k*d<C_k`.
4. `floorPower_mul`: exact multiplication of dyadic floors has two possible
   bins, selected by an explicit integer comparison.
5. `blockNumerator12_exact_bound`: twelve ordered threshold regions certify
   the exact normalized bound `M12=2349463/262144`. Every region is discharged
   by ordinary `omega` proof terms, with endpoint equality handled explicitly.
6. `mechanical_twelve_identity`: the recurrence expands to
   `Cmax(s+12)=3^12*Cmax(s)+blockNumerator12(B,3^s)`, where
   `B=2^floor(log2(3^s))`.
7. `mechanical_twelve_propagation`: `4*Cmax(s)≤s*3^s` propagates by twelve
   steps, because the block bound gives `4*block≤12*3^12*3^s`.
8. Kernel `decide` proves the twelve bases `16≤s≤27`; strong induction
   proves `4*Cmax(s)≤s*3^s` for every `s≥16`. This sharpens the previous
   prose threshold 108. A separate kernel witness proves failure at `s=15`:
   `4*Cmax(15)=217653340 > 15*3^15=215233605`. Thus 16 is the smallest
   integer threshold from which this envelope holds at every subsequent count.
9. Kernel `decide` proves the 107 small certificates
   `4*Cmax(s)≤s*2^(floor(log2(3^s))+1)` for `1≤s≤107`; the sharpened
   universal proof now needs only its subrange `1≤s≤15`.
10. `universalMechanicalQuarterCertificate` combines both ranges, and
    `firstContractionQuarterGap` applies it to the actual orbit.

The supporting modules also prove the exact first contraction time and the
previous universal L10 bound `3d<q_k`.

## Semantic and reproducibility audit

A separate agent reconstructed the recurrence and inspected the trusted
statements before compilation. It found no altered Collatz transition,
reversed quantifier, omitted positivity case, circular inequality hypothesis,
or hidden eventual-convergence assumption. Independent Python checks cover
all finite certificate entries, all twelve exact rational threshold regions,
and arithmetic reconstruction of normalized dyadic floors. Such checks are
additional diagnostics; the accepted Lean declarations do not import their
answers or depend on an external computation axiom.

The finite kernel certificates use ordinary `decide`, not `native_decide`.
The solution supplies ordinary theorem declarations, axiom inventories, and
explicit trusted-statement type comparisons. There is no custom unchecked
declaration generation, `sorry`, or theorem-strength project axiom.

## Precise remaining boundaries

- This is a universal auxiliary inequality at an existing first contraction.
  It proves neither existence of that contraction nor universal Collatz
  convergence, universal descent, absence of other positive cycles, or a
  valid recursively renewing hard-return rank.
- L9's mechanical upper bound and crossing time are formalized. Its complete
  extremizer uniqueness and displacement-penalty formulation are separate
  statements and remain outside these modules.
- The argument formalizes the exact twelve-term integer certificate required
  for L15. The general real-phase theorem for arbitrary block length, and the
  larger 1024-block numerical refinement at the conditional L8 frontier,
  remain prose/exact-Python results.
- Mathematical novelty and external priority remain unassessed. A complete
  kernel proof of an auxiliary theorem is not a Collatz resolution.

## Connections

- **Formalizes:** [L15 quarter gap](../proof-search/lemmas/L15_Quarter_Gap_and_Rotation_Block_Certificate.md).
- **Defined by:** [trusted universal statements](../lean/CollatzWork/QuarterGapUniversalStatement.lean).
- **Proved by:** [universal proof](../lean/CollatzWork/QuarterGapUniversal.lean).
- **Cross-checked by:** [independent block certificate](block_arithmetic_certificate.py).
- **Recorded in:** [continuation report](../ASTRA_CONTINUATION_2026-09-05.md).
