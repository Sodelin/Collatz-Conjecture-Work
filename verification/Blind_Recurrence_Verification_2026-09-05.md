---
node_id: BLIND-RECURRENCE-VERIFICATION-2026-09-05
node_type: verification
tags: [collatz, lean, exact-arithmetic, recurrence]
---

# Finite-prefix recurrence: verification and semantic scope

This record covers the [repository-informed recurrence result](../BLIND_RECONCILIATION_2026-09-05.md),
its two active proof modules, and the preserved independent derivations.
Initial mathematical base: `eac4dad7ef352b38d3db163637f6ac1f846c91b7`.
The delivered branch also incorporates the concurrent parent update
`3d706a9463b1b95ffb7bb3b9a3475771a63b3b7c`; its three added checkers are replayed.

## Formal statements

| Export | Exact statement checked | Standard logical dependencies |
|---|---|---|
| `prefixCollision` | Equal actual shortcut parity prefixes give equal residues modulo `2^k` | `propext`, `Quot.sound` |
| `prefixSeparation` | Distinct starts sharing k parities have natural absolute difference at least `2^k` | `propext`, `Quot.sound` |
| `affineRepetitionBound` | A fixed coprime affine recurrence obeys the denominator-power bound from a positive shifted initial value | `propext`, `Quot.sound` |
| `noInfiniteExpandingAffineBlocks` | Under those premises and denominator greater than one, the same recurrence cannot hold forever | `propext`, `Quot.sound` |
| `prefixReturnNumericalBound` | `2*32^d < 27^d*(n+1)` implies `10*d+27 < 27*n` and the stated floor bound | `propext`, `Classical.choice`, `Quot.sound` |

Trusted statements are separate from proofs and are compared by typed `example`
declarations. There is no added theorem-strength axiom, `sorry`, `native_decide`,
unsafe declaration fabrication, or substituted binary proof artifact.

The actual odd-word coding, odd-step height estimate, balanced substitution,
and general positive-realizability theorem have analytic proofs. The two
formal components do not constitute an end-to-end Lean proof of that theorem.
Neither the analytic theorem nor its components prove universal Collatz
termination or exclude all nontrivial cycles.

## Reproducible checks

The [machine-readable record](blind_recurrence_verification.json) gives source
hashes, exact commands, exit codes, and log filenames. The main checks are:

```bash
lake clean
lake build
lake env lean lean/CollatzWork/PrefixCollision.lean
lake env lean lean/CollatzWork/AffineRepetition.lean
lake env lean lean/CollatzWork/ResidueAncestor.lean
lake env leanchecker CollatzWork.PrefixCollision -v
lake env leanchecker CollatzWork.AffineRepetition -v
python3 -B verification/blind_word_recurrence_check.py
python3 -O -B verification/blind_word_recurrence_check.py
python3 -B verification/check_note_graph.py
```

The archive's three standalone Lean files are also compiled directly. Existing
mathematical regressions from `.github/workflows/verify.yml` are rerun alongside
the new checks. The pinned toolchain is the unchanged Lean4.33.1 release with
`Std` and no Mathlib dependency.

Local execution uses an environment-specific executable-location compatibility
preload around the unmodified installed compiler. Repository CI installs and
checksums the official pinned release and supplies the ordinary-environment
replay. The additional `leanchecker` command replays using Lean's own kernel;
it is not an independently implemented verifier.

## Exact finite evidence

The retained checker reconstructs 136,000 exact valuation-word repetition
comparisons, 120 expanding families, 40 Thue–Morse coding identities, and 24
positive seeded hard-code replays. It also checks 33 actual noncycle prefix
returns and 20 cycle controls in its stated finite range. Four deliberately
false controls must be rejected normally and under optimized Python. The
`p=2` hard-block counterexample `55 ->83 ->125 ->47` prevents weakening the
growth threshold by accident.

All tests use integers; no floating-point inequality or statistical estimate
supports a mathematical conclusion. Finite success is not used to infer the
infinite theorem.

## Independent review and remaining obligations

Separate agents reconstructed the actual-map collision argument, natural
subtraction cases, the numerical bound, the balanced code lengths, and both
growth controls. The cycle example with both codewords `(2)` at1 is retained.
The source-to-claim comparison inspected the immutable older anchor and its
endpoint theorem. These reviewers share model lineage and context; no external
specialist review or novelty certification is claimed.

The stale claim that the refined valuation13 ancestor formalization remained
pending was corrected against the already-existing source theorem
`residueAncestor_of_divisibility`, which is also replayed here. The concurrent parent update also corrected that handoff. This is an
existing result, not new mathematics from this pass.

## Connections

- **Verified by:** [exact checker](blind_word_recurrence_check.py) and [machine record](blind_recurrence_verification.json).
- **Formalized by / pending:** [formal targets](../LEAN_TARGETS.md).
- **Depends on:** [semantic proof and scope](../proof-search/disproof/TM_Prefix_Return_Exclusion_2026-09-05.md).
- **Parallel to:** [preserved independent record](../research/blind-2026-09-05/README.md).
