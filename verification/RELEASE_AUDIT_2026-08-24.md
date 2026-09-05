# Audited-route release replay — 2026-08-24

**Node ID:** `Collatz-Conjecture-Work:RELEASE-AUDIT-2026-08-24`  
**Node type:** `verification`  
**Mathematical source commit:** `3619c756e136318520153ced00ce30eaf37ed33d`  
**Source parent:** `2e7eae2bb998b14e5443e6c440154130a0049467`  
**Verdict:** `RELEASE_CHECKS = PASS / COLLATZ UNRESOLVED`

This receipt records a clean replay against the exact integration commit
above. It certifies the listed executable and formal scopes only. It does not
certify novelty, omitted prose bridges, a Collatz proof, or a Collatz disproof.

## Environment

```text
Python 3.14.5
Lake 5.0.0-src+819816b
Lean 4.33.1, commit 819816b2e0a3bf405af45ae5c7af2491d8f5bee6
Host: x86_64-w64-windows-gnu
```

The repository toolchain is pinned by `lean-toolchain`. The replay used the
portable wrapper rather than contributor-specific paths:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File verification\run_release_checks.ps1
```

## Replay result

All eleven mathematical commands and the separate documentation-graph check
completed with exit code `0`:

| Check | Decisive result | Scope boundary |
|---|---|---|
| L14 finite regression | 500,000 odd starts; maximum 19 normalizer edges; counterfamily through `s=10000`; `PASS` | Finite regression, not the universal prose theorem. |
| YAH adjacent-edge cancellation | Weighted strict lower bound `1`; `W_(f,f)<=-1`; `PASS` | Canonical adjacent-edge additive class only. |
| YAH two-state cancellation | 22 model equations, 441 fixed-terminal contexts, 8-row and 50-row certificates; `PASS` | One fixed semantic algebra and additive locality class. |
| YAH scalar full certificates | Original 11-row and labeled 22-row cancellations, mass `49`; both `PASS` | Standard first dimension-one full/extended step only. |
| YAH scalar top certificates | 10 cases, 491 Farkas lemmas, 426 RUP clauses; `PASS` | The six original and four labeled top targets only. |
| Bounded max-`C` cycle diagnostic | 91 pairs, peak 47,517 states, 9 trivial encodings, 0 nontrivial candidates | Exact bounded negative result, not evidence for all cycles. |
| Lean umbrella | `Build completed successfully` | Imports the two nondisproof modules only. |
| Lean two-pump module | Five reports containing only `propext`, `Quot.sound` | Cyclic-rotation algebraic dependency only. |
| Lean branching-center core | Three reports containing only standard `propext`, `Quot.sound`, and where shown `Classical.choice` | The eliminated natural-number rigidity equation only. |
| Lean finite-residue core | Five exported theorem reports, all axiom-free | Abstract permutation/commutator/transitivity core only. |
| Lean polynomial-ratchet core | Four reports containing only `propext`, `Quot.sound` | Normalized arithmetic implications only. |
| Repository note graph | 57 Markdown notes, 237 local Markdown links, 0 broken, 57 reachable; `NOTE_GRAPH = PASS` | Navigation and reachability only. |

The wrapper's final line was:

```text
RELEASE_CHECKS = PASS
```

## New artifact identities

SHA-256 values below identify the release copies at the source commit:

| Artifact | SHA-256 |
|---|---|
| `lean/CollatzWork/Disproof/BranchingCenter.lean` | `CEACBACE8C08F0302BDE35FDAC19E3660BE95DC50C65352DD4D8AEA722D40C26` |
| `lean/CollatzWork/Disproof/FiniteResidueFirstIntegral.lean` | `EF19D5151CBE2C8C22824BAD1CE380063027136AA5924DC21FE2AC5E287A21FF` |
| `lean/CollatzWork/Disproof/PolynomialRatchet.lean` | `E3F38DB03605171CB094728EBB8089037D9A0F77A773047852666F26BA188C6A` |
| `CODEX_BRANCHING_CENTER_SHOT_2026-08-24.md` | `4A08251D93676A502D25FB1C9CA8AFE18D6BC45CB57B5C4C11502DB85CC56349` |
| `CODEX_BRANCHING_CENTER_HOSTILE_AUDIT_2026-08-24.md` | `704F209E0E5705945DBF6E94EE0225E6E3F9F087073D7B1ED815CC87CBEE12D8` |
| `CODEX_FINITE_RESIDUE_FIRST_INTEGRAL_SHOT_2026-08-24.md` | `737224441621F0466A517E38E5CCDA1B745956640A76A6C715A8C1130A7F092D` |
| `CODEX_FINITE_RESIDUE_FIRST_INTEGRAL_HOSTILE_AUDIT_2026-08-24.md` | `F69FD82B43D9B5CC34857E0134091A216181B4D02A21798102D9B393C53ED0EA` |
| `CODEX_F_POLY_RATCHET_SHOT_2026-08-24.md` | `AABC4413DDAD02CA106FAF192950A7841A071384B78110929B8355986D9456FB` |
| `CODEX_F_POLY_RATCHET_HOSTILE_AUDIT_2026-08-24.md` | `E76C2B5AE67E9AF1DDC4F070CF618893691CC1171033547F0BDC8C7998A53DA7` |
| `CODEX_SMOOTH_RATIO_SEMICONJUGACY_SHOT_2026-08-24.md` | `01589B369625A9B788F35DB2B0E5148925D464DFB3052769B336A74BD98EFE4B` |
| `verification/run_release_checks.ps1` | `8F4916FCB7F163DE9C6C47654CA87E40BDE5B8CF95AA8B2364DB658CB19C5E4B` |

The BranchingCenter release copies differ from their isolated source packets
only by removal of one trailing blank line; their mathematical text is
unchanged. The polynomial hostile audit and smooth-ratio packet contain
release-provenance wording patches recorded in the integration commit.

## Publication boundary

The accepted additions are four exact route closures:

- the two-rational-center/three-single-edge BranchingCenter architecture;
- memoryless first integrals on one fixed finite residue ring;
- the canonically normalized fixed-cycle polynomial divisibility/eigenform
  subclass; and
- positive accelerated generators with a finite successive-state-ratio limit.

They are `STOPPED-USEFUL` or killed-architecture results. None is a positive
cycle, a divergent positive seed, or evidence that no such witness exists.

The generalized Thue–Morse/Mahler package remains outside this integration
pending a specialist literature/priority review. The Deep Lasso draft remains
excluded because its current two-rate sharpness and hypothesis formulation do
not pass audit. The elliptic-translation note is deferred, not rejected: it
requires proposition-level height citations and a separate immutable
specialist receipt before public integration.

## Connections

- **Verifies:** [verification and reproduction manifest](README.md).
- **Verifies:** [Lean target boundary](../LEAN_TARGETS.md).
- **Supports:** [atomic claim registry](../proof-search/CLAIM_REGISTRY.md).
- **Mapped by:** [research atlas](../ATLAS.md).
- **Governed by:** [portable proof-note graph standard](../methodology/NOTE_GRAPH_STANDARD.md).
