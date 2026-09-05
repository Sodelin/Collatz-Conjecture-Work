# Focused review of PR #19: finite-palette bounded-progress obstruction

Date: 2026-09-05. Reviewed source: `49721623303d76956c88db5c9906f8c7b4a586e1`. Comparison baseline: main `5410069`. Dedicated audit checkout: `/workspace/scratch/5d74cf805712/palette-audit`.

## Decision

**Integrate the mathematical contribution with its current scope labels.** No mathematical correctness, selector-quantifier, fixture-integrity, or documentation-boundary blocker was found. This is a formal obstruction to one ranking architecture, not a proof or disproof of Collatz and not an independently established originality claim. The statement deserves inclusion in the consolidated research release; it does not by itself establish VibeMathed eligibility.

## Exact claim suitable for publication

For the one-division shortcut map, no natural-valued rank selected arbitrarily from finitely many eventually nondecreasing functions can have a strict decrease within a single uniform finite number of shortcut steps at every sufficiently large input. The selector may be nonperiodic and noncomputable. Both the monotonicity threshold and the proposed progress threshold are arbitrary and independent. A separate trusted Lean proposition and source proof check this exact natural-valued statement.

A proposed venue description should say **“Lean-checked finite-palette bounded-progress obstruction”** and retain “uniform finite shortcut horizon” and “eventually nondecreasing pieces.” It should not say all finite-state methods, all ranking functions, all polynomial interpretations, all accelerated maps, or Collatz termination have been ruled out.

## Statement and proof review

`FinitePaletteObstructionStatement` quantifies

- `r B B' H : Nat`;
- `V : Nat → Nat`, `f : Fin r → Nat → Nat`, and `selector : Nat → Fin r`;
- eventual monotonicity of every piece from `B` onward;
- the identity `V n = f (selector n) n` only on that tail;
- the negation of universal existence of a descent time `j` with `1 ≤ j ≤ H`, from every `n ≥ B'`.

The statement permits `H = 0` (trivial impossible positive-time property) and `r = 0` (no global selector exists). Those harmless boundary cases do not weaken the intended positive-horizon, nonempty-palette theorem. Although the map domain includes zero, taking `B' ≥ 1` recovers the positive-start claim; the proof itself constructs a positive large start.

The generic `finitePalette_path_obstruction` proves that a nondecreasing path cannot carry `r` successive strict rank decreases when its ranks come from `r` nondecreasing pieces. If a piece repeats, monotonicity contradicts the strict rank drop; the finite pigeonhole argument forces a repetition among `r+1` selected states. This handles arbitrary switching: it does not accidentally assume the selector itself is monotone or periodic.

The dynamics part reuses the existing `oddRun` identity with `L = rH` and `q = B+B'+2`. The first `L` shortcut steps of `2^L q - 1` form a nondecreasing prefix (indeed strictly increasing for positive length). A chosen descent jump has positive length at most `H`. The proof bounds the total selected time after `k` jumps by `kH`, so every state in the pigeonhole argument remains within the forced-growth prefix and above both thresholds. The auxiliary use of `max a B'` in the choice function is correctly discharged at actual selected states. There is no hidden orbit-density, random-residue, convergence, or bounded-return assumption.

## Prose extensions

The arbitrary linearly ordered codomain extension is sound by the same finite proof: it uses only transitivity of strict order, monotonicity, and pigeonhole, with no well-foundedness assumption. The Lean theorem remains natural-valued, correctly disclosed.

The real-polynomial corollary is also sound as stated. If the *selected* value is eventually nonnegative, a polynomial with negative leading coefficient, or a negative constant, eventually cannot be selected. Every remaining positive-leading nonconstant polynomial is eventually increasing; the remaining constants are nondecreasing. Finitely many thresholds can be combined. The argument does not require every polynomial to be nonnegative at every input. Fixed finite lookup corrections produce finitely many polynomial pieces, but infinitely many corrections, unboundedly many pieces, and arithmetic functions not eventually monotone are outside the result.

These are prose deductions; the release must not assign them the natural-valued theorem's Lean verification label.

## Relationship to current contributions

- It extends the existing uniformly bounded direct *integer*-descent obstruction to arbitrary switching between finitely many monotone rank formulas.
- It is different from PR #16's fixed-label and finite-residue hard-return obstructions: those macro edges may require unboundedly many shortcut steps. Neither scope should be silently substituted for the other.
- It does not invalidate PR #17's guarded root-relative certificates, nor supply their missing all-orbit progress bridge.
- It is separate from YAH matrix/arctic interpretation obstructions. YAH interpretations concern encoded words and rule interpretations; they are not automatically finite palettes of eventually monotone scalar functions of the integer input. Any implication would need an explicit representation theorem and a uniform simulation-time bound.
- No conflict with the word-complexity contribution was located: finite-horizon rank impossibility and parity-prefix collision constraints address different hypotheses.

## Fresh verification performed in this review

At the exact PR #19 head:

| Check | Result |
|---|---|
| `sha256sum -c verification/finite_palette_SHA256SUMS_2026-09-05.txt` | All 25 listed files matched. |
| `python3 -S -B verification/finite_palette_obstruction.py` | PASS. |
| `python3 -S -O -B verification/finite_palette_obstruction.py` | PASS under optimized Python too. |
| Forced-growth direct/closed-form traces | 384. |
| Exhaustive small finite selector assignments | 2,438. |
| Delayed-switch fixtures | 48. |
| Malformed certificates rejected | 4. |
| Published 3-piece/4-step example | Reproduced exactly. |
| `python3 -B verification/check_note_graph.py` | 58 notes, 265 local links, all reachable, no broken links. |

The regression exhausts the specified small finite traces, not all ranks or all Collatz orbits. Its explicit `require` checks remain active under `-O`. `find_blocker` checks label range and repeated-label monotonicity; all reported windows fit within the full `rH+1` trace. The delayed-switch fixtures reach position `(r-1)H`, exercising the final complete lookahead boundary. The implementation permits integer diagnostic rank values, which is compatible with the separately proved ordered-codomain finite argument and does not alter the Lean codomain.

The existing recorded clean Lean build and axiom output are internally consistent with the reviewed source. A fresh Lean replay in this subreview was not performed because `lean` and `lake` were not on PATH. Integration must perform its existing full clean Lean gate; do not present source inspection as a fresh kernel replay.

## Required integration gate and declarations

Add these explicit publication arithmetic-checker entries:

```python
("verification/finite_palette_obstruction.py", ("-S", "-B")),
("verification/finite_palette_obstruction.py", ("-S", "-O", "-B")),
```

Compile the trusted statement and solution in the consolidated pinned source, including the final type-comparison example:

- `CollatzWork.FinitePaletteObstructionStatement`;
- `CollatzWork.FinitePaletteObstruction`.

The solution already prints these exact axiom-audit declarations, so the publisher's automatic discovery should include them:

- `CollatzWork.finitePalette_path_obstruction`;
- `CollatzWork.mersenne_prefix_nondecreasing`;
- `CollatzWork.finitePaletteObstruction`.

Expected allowed footprint: `propext`, `Classical.choice`, `Quot.sound`; the prefix theorem's recorded footprint omits choice. Reject `sorryAx` and every unexpected project axiom via the stronger existing publication gate. The PR's standalone Lean CI only greps for `sorryAx`; it should not replace that stronger gate.

`math_tool_smoke.py` and `requirements-math.txt` are optional tooling diagnostics, not proof dependencies. No new third-party numerical package is required to replay the finite-palette proof or checker.

## Fixture provenance after consolidation

The old 25-file checksum list includes shared README, atlas, claim registry, workflow, and graph-checker files. Their legitimate consolidation edits will invalidate the old *working-tree* hashes. Preserve this record as evidence for exact PR #19 source `49721623303d76956c88db5c9906f8c7b4a586e1`, or generate a distinctly named fresh consolidated manifest. Do not rewrite an old verification log to imply it checked new bytes. The consolidated release's complete source inventory and fresh verification record are the authoritative integrated evidence.

## Narrow primary-source search

A supplementary web discovery pass issued three queries:

1. `Collatz "piecewise polynomial" ranking function`
2. `Collatz "ranking" "monotone" function finite`
3. `"Collatz" "bounded" "ranking function"`

The result set surfaced [Yolcu–Aaronson–Heule, An Automated Approach to the Collatz Conjecture](https://arxiv.org/abs/2105.14697), whose interpretation framework is relevant background but is a different object and scope. The author-hosted [primary PDF](https://www.cs.cmu.edu/~mheule/publications/collatz.pdf) is also available. No exact finite-palette theorem match was located in this bounded discovery pass. That is a search result, not a priority certification. Other returned snippets proposing broad Collatz solutions were not adopted as valid prior theorems.

## Final assessment

The finite-palette contribution is internally well scoped and ready for incorporation as a formal auxiliary negative result after a fresh consolidated Lean replay. Originality remains undetermined; ordinary finite pigeonhole and forced-growth ingredients are classical. The potentially useful delta is the exact arbitrary-selector, bounded-progress formulation and its executable Lean certificate. Keep it distinct from the focused YAH submission candidate and from the unresolved universal-convergence bridges.
