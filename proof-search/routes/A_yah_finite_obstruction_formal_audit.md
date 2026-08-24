# YAH finite obstruction certificates — formal audit packet

**Candidate status:** independently replayed specialist-review artifact; not
published from this worktree

**Global status:** the Collatz conjecture remains unresolved.  Nothing here
proves termination of the YAH rewriting system, proves Collatz, or supplies a
counterexample.

## What is formally checked

The trusted statement module fixes the exact seven-symbol, eleven-rule string
rewriting system, the canonical language `^w$`, the fixed two-state suffix
algebra, local labeled-context legality, canonical labeled embeddability, and
integer feature-count arithmetic.  The proof module contains the complete
13-, 8-, and 50-row positive-integer certificates.

### 1. Canonical adjacent-edge scalar obstruction

For the thirteen displayed canonical rewrite instances in
[`A_yah_2local_edge_potential_no_go.md`](A_yah_2local_edge_potential_no_go.md),
Lean checks:

- every displayed source and target is syntactically canonical;
- the `t$ -> 2$` row realizes `11 -> 17` under the one-division shortcut map;
- the twelve auxiliary rows preserve the represented integer;
- row 9 has multiplicity two, every other row multiplicity one;
- the weighted adjacent-edge coefficient vector is exactly `-W_(f,f)`;
- weak auxiliary orientation plus strict orientation of the displayed dynamic
  row forces `W_(f,f) < 0` in the stated compatible ordered additive target.

The formal pump word with parameter `m` is exactly `^ f^(m+1) $`; `m` counts
its internal `(f,f)` edges.  Lean proves that it is canonical and that its
whole-word adjacent-edge potential is

\[
W_{\wedge f}+mW_{ff}+W_{f\$}.
\]

Under the explicit hypothesis that negative natural multiples are cofinal
below, Lean derives that these actual canonical-word potentials have no common
lower bound.  This hypothesis holds for the intended real-valued scalar
potentials.  It is deliberately not asserted for arbitrary lexicographic
ordered groups.

### 2. Fixed two-state labeled-symbol obstruction

For the algebra

\[
f,0,\wedge,\$=\operatorname{const}(0),\qquad
t,2=\operatorname{const}(1),\qquad 1=\operatorname{id},
\]

Lean checks all 22 rule equations, local legality and canonical embeddability
of all eight selected labeled rows, positive multipliers, dynamic mass five,
and exact zero cancellation of every labeled-symbol coefficient.  It then
proves that no additive labeled-symbol weight in the stated compatible ordered
additive group can orient every locally valid auxiliary instance weakly and
every locally valid dynamic instance strictly.

### 3. Fixed two-state labeled-edge obstruction

Lean contains all fifty rows and checks local legality, canonical
embeddability, positive multipliers, dynamic mass `144057`, and exact zero
cancellation of every labeled adjacent-edge coefficient.  The analogous
generic no-orientation theorem follows.

The two exact-zero identities need no boundedness assumption.  Their
finite-lexicographic additive corollary is mathematically immediate from the
generic ordered-group result, but this packet does not introduce a separately
named Lean finite-lex datatype or instance.

### Lean theorem index

| Checked boundary | Principal theorem |
|---|---|
| exact rule-instance legality and integer semantics | `unlabelledRows_legal`, `unlabelledRows_semantic` |
| 13-row coefficient identity | `unlabelledCertificate_cancellation` |
| forced negative repeated-edge weight | `yah13_forces_ff_negative` |
| canonical pump word and exact whole-word potential | `ffPumpWord_canonical`, `ffPumpPotential_eq_edgePotential` |
| scalar/cofinal boundedness contradiction | `noBoundedBelowCanonicalFFPumpWords` |
| 22 two-state algebra equations | `twoState_rule_equations` |
| 8-row legality, embedding, shape, and zero identity | `symbolCertificate_legal`, `symbolCertificate_canonically_embeddable`, `symbolCertificate_shape`, `symbolCertificate_cancellation` |
| 50-row legality, embedding, shape, and zero identity | `edgeCertificate_legal`, `edgeCertificate_canonically_embeddable`, `edgeCertificate_shape`, `edgeCertificate_cancellation` |
| global local-instance no-go wrappers | `noTwoStateSymbolAdditiveOrder`, `noTwoStateEdgeAdditiveOrder` |

## Formal boundary

The labeled theorems quantify over locally valid instances and separately
prove that each certificate row embeds in a fixed-terminal canonical labeled
word.  They do **not** define a global derivation relation or prove that a row
is dynamically reachable from a narrower positive-input language.  They also
do not cover different semantic algebras, longer windows, matrices,
nonadditive orders, or strategy-specific termination arguments.

In particular, this packet contains no enumerator, equivalence transport,
representative certificates, or Lean theorem for the separate proposed
70-scheme/four-orientation-type generalization.  That claim is unaudited here
and must not be inferred from the fixed two-state algebra proved below.

The formal modules replay certificates that were found earlier; they do not
formally verify or archive a certificate-generation algorithm.  The Python
programs provide an independent executable reconstruction of the same finite
data and checks.

## Source provenance

The YAH system and its Collatz simulation theorem are from Yolcu, Aaronson,
and Heule, *An Automated Approach to the Collatz Conjecture*, Journal of
Automated Reasoning 67 (2023), Theorem 3.17:
<https://doi.org/10.1007/s10817-022-09658-8>.

The upstream artifact is pinned at commit
`8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340`.  Its exact rule file is
<https://github.com/emreyolcu/rewriting-collatz/blob/8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340/rules/collatz-T.srs>
with SHA-256
`e4777832e5cf8148a54299dffa48cf10254629680961006f2c15bcb6c55aa9d2`.

## Accepted Draft PR #8 artifacts

- `lean/CollatzWork/YAHFiniteObstructionStatement.lean` — trusted exact data
  and executable predicates;
- `lean/CollatzWork/YAHFiniteObstruction.lean` — complete finite certificates
  and no-go consequences;
- `lean/CollatzWork.lean` — umbrella import;
- `verification/yah_2local_edge_no_go.py` — independent 13-row replay;
- `verification/yah_two_state_semantic_label_no_go.py` — independent
  two-state 8-/50-row replay;
- `verification/yah_finite_obstruction_replay_2026-08-24.txt` — frozen
  command, output, toolchain, and sandbox-diagnostic transcript;
- the two route notes linked above and
  [`A_yah_two_state_semantic_label_no_go.md`](A_yah_two_state_semantic_label_no_go.md).

## Bounded reproduction

Tested with Python 3.14.5, Lean 4.33.1, and Lake 5.0.0:

```powershell
python -B verification/yah_2local_edge_no_go.py
python -B verification/yah_two_state_semantic_label_no_go.py
lake build
lake env lean lean/CollatzWork/YAHFiniteObstruction.lean
```

Run `lake build` before the direct module command in a fresh clone. The build
creates imported `.olean` files; reversing these two commands can fail before
Lean reaches the target theorem. If `lake` is not on `PATH`, invoke the local
`elan` installation without hard-coding another contributor's home directory.

Expected decisive output:

```text
13-row: weighted strict lower bound = 1; cancellation = -W_(f,f); PASS
two-state: 22 equations; 441 legal contexts; symbol mass = 5;
           edge mass = 144057; 20 supported labeled instances;
           both cancellations empty; PASS
Lean: build completed successfully; no sorryAx
```

The exact cancellation identities are axiom-free except that the 13-row
finite-map equality reports `propext`.  The derived no-go wrappers report only
Lean's standard `propext` and `Quot.sound`.  No theorem depends on `sorryAx`.

## Importance, novelty, and review status

These certificates close three sharply specified additive interpretation
classes for one published Collatz-equivalent rewrite system.  They are useful
route obstructions and a plausible short term-rewriting/formal-methods note.
They are not a Collatz advance in the sense of proving convergence or finding
a counterexample.

The exact finite certificates are project-specific.  A bounded prior-art
search found no exact published match, but priority and novelty are **not
certified**.  Before submission, an external term-rewriting specialist should
reconstruct the theorem scopes and perform a broader literature/priority
check.  Until then the correct label is **candidate specialist-review
artifact**, not a publishable theorem claim.
