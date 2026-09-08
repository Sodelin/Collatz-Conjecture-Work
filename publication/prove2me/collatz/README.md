# Collatz Prove2Me import checkpoint

Status: **locally compiled, statement-checked, and metadata-reviewed; ready for authenticated submission**. This checkpoint does not claim remote publication or verification.

Source: `https://github.com/Sodelin/Collatz-Conjecture-Work`, commit
`026aa4ad4be6453a005ab950b160a9f2204c5271`, Lean `leanprover/lean4:v4.33.1`.
No mathematical source file was modified. The original project uses Lean Std,
not Mathlib. The three historical research modules were copied byte-for-byte
under temporary archive module names for compilation and extraction.

## Verified locally

- All 38 source files compile: 35 library files and three historical research files.
- The full original environment axiom audit covers 774 theorem constants, including
  compiler-generated internal proofs. Every axiom is in
  `propext`, `Classical.choice`, `Quot.sound`; there are no extra axioms.
- The official declaration graph contains 671 retained declarations: 214
  source-ranged theorem constants, 162 retained generated theorem constants,
  and 295 other constants. The axiom audit deliberately includes internal proof
  constants the graph extractor omits, explaining the different totals.
- The generated tree contains 22 definition bundles, 113 theorem candidates,
  113 solution files, and 97 inlined helper units. Three short source simp lemmas
  are preserved in their definition context. Anonymous `example` commands remain
  source-build checks and are not exported as theorem nodes.
- `lake build` completes successfully: 255 jobs.
- All 113 theorem candidates have elaborated types exactly matching the original
  theorem types under identical pretty-printing options. No universe renaming or
  statement normalization was needed. See `type-comparison.json`.

The `Theorems` files are intentional `sorry` stubs for platform problem creation.
The `Solutions` files contain the original checked proof bodies and import child
theorem stubs. This is the platform's reduction workflow: it requires child proofs
to be accepted before parent proofs. The stubs are not evidence of proved status.
The original source axiom audit, rather than the stub tree, establishes that the
underlying proofs are complete. Platform acceptance must still check each
submitted top-level `solution` against its registered theorem.

## Publication readiness

All 113 theorem statements now have individual academic descriptions with their
actual hypotheses, displayed conclusions, mathematical roles, and separate proof
explanations. All 22 definition bundles have descriptions under the documented
`natural_language_statement` API field. Broad descriptions copied from grouped
publication claims were narrowed to the specific formal declarations. Source
links identify immutable source commits and line ranges. The YAH and Disproof
subsets received a separate review; independent spot review also checked the
main conditional orbit results and caught the zero-block natural-subtraction
convention. No novelty or universal-convergence claim is made.

The live authenticated environment check on 2026-09-08 confirms Lean 4.33.1 and
Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`; its nonsecret response is saved in
`evidence/live-environment.json`. The original project uses Std only, so its
mathematical sources do not acquire any Mathlib dependencies in this transplant.

Every theorem payload concatenates byte-for-byte to its staged theorem file.
The original metadata pass corrected a missing blank separator without changing
the checked code. A subsequent server check exposed an environment mismatch:
the server disables automatic implicit variables, while the first local build
had allowed them. The generated YAH code now explicitly declares the same
generic binders and universes inferred in the source. In particular,
`weightedCoefficient` remains polymorphic over a feature `Sort`, rather than
being restricted to a `Type`. Mathematical source and proof bodies are unchanged.

`lakefile.toml` now enforces `autoImplicit = false` for all three libraries.
The full strict build passes 255 jobs. Every theorem's elaborated type still
matches its source exactly. The repair evidence additionally checks definition
declarations and every solution against its target. Only two YAH definition
bundles and nine YAH theorem/solution contexts changed; already accepted
definition payloads retain their original bytes. The server's failed job and
the old candidate are preserved by the publication coordinator before resuming.

The remaining operations are:

1. Run the idempotent uploader, publishing
   definitions and then theorem/solution pairs in dependency order. Record and poll
   every queued publication/verification job. Confirm every final theorem is Proved.
2. Review a Collatz collaboration mission proposal after publication. These are
   auxiliary results and conditional reductions; universal Collatz termination
   remains unproved. No novelty claim is made by this import.

`manifest.json` records `validation.status = "passed"` only after all local
publication checks. The separate uploader state and final receipts establish
what was actually published and proved; a failed or queued job is not success.

## Reproduction

Use a normal working Lean 4.33.1 installation when available. From this directory:

```sh
lake build
lake env lean audit-staged-types.lean
```

From the source repository root, the official graph and sketch extractions and
full source audits are saved under `prove2me-audit/`. `prepare_extraction.py` rebuilds
the source tree and reruns both official extractors. `generate_platform.py` performs
range-based skeleton subtraction and emits these candidate files. Re-running it
resets publication readiness to pending and clears only its generated payload and
library directories. It must be followed by the full local validation again.

The local runtime launcher in `prove2me-audit/runtime/` addresses this environment's
blocked executable self-location lookup. It changes only executable path discovery
and does not modify Lean's kernel or proof checking. Set `PROBE_LEAN_ROOT` to the
installed toolchain and call the launcher with normal Lake arguments if required.
That launcher and its C source were copied from this user's `oldest-conjecture-`
repository scripts. `prepare_extraction.py` records its default runtime location;
adjust it if reproducing elsewhere.

All declaration boundaries, statement/value cuts, and identifier edits come from
the official Lean extractors. Additional parser command ranges prevent leftover
anonymous checks, and resolved-reference plus actual simp-membership facts preserve
elaboration context. Source SHA and byte hashes are recorded in the manifest and
source inventory. No authentication token or API key is included in this checkpoint.
