# Lean source audit and import extraction

This directory is a reproducible audit checkpoint for the Prove2Me candidate tree
at `publication/prove2me/collatz`. The mathematical source files are unchanged.

- `source-inventory.json`: all 38 source paths, extraction module names and SHA-256.
- `build.log`, `Archive*.build.log`: successful source builds.
- `extract_decl_graph.lean`, `decl_graph.jsonl`: official declaration/dependency facts.
- `extract_sketch_info.lean`, `sketch.*.jsonl`: official declaration/value/reference
  positions, plus parser command positions and binding ranges for mechanical edits.
- `axiom_type_audit.lean`, `axiom-type-audit.jsonl`: exhaustive original theorem axiom
  audit and fully qualified, explicit elaborated types. All 774 theorem constants
  use only standard accepted axioms; 214 have original source spans.
- `extract_simp_membership.lean`, `simp-membership.jsonl`: actual original simp-set
  membership needed to preserve proof elaboration after splitting modules.
- `generate_platform.py`: dependency planning and source-range skeleton subtraction.
- `repair_collatz_autoimplicit.py`: source/oracle-hash-guarded declaration of the
  generic YAH binders required by the server's `autoImplicit = false` setting.
- `runtime/`: optional executable-location compatibility launcher; no kernel changes.

Original upstream extraction script comments are preserved. Historical source copies
under `archive/` are byte-identical to the original files and exist only to assign
importable temporary module names. The source manifest points back to original paths.

After rebuilding with `python prove2me-audit/prepare_extraction.py`, run the saved
audit scripts with `lake env lean`. Generate into a fresh staging directory so
an active upload's recorded manifest and payload bytes remain available:

```sh
python prove2me-audit/generate_platform.py . publication/prove2me/rebuild-collatz
python prove2me-audit/repair_collatz_autoimplicit.py . publication/prove2me/rebuild-collatz
cd publication/prove2me/rebuild-collatz
lake build
```

The generated Lake package enforces `autoImplicit = false`. The source project
uses automatic implicit variables in generic YAH declarations, so this setting
correctly exposes missing explicit binders instead of silently passing a build
that differs from the server. The repair inserts the source's originally inferred
implicit binders at declaration-name ranges reported by the Lean sketch oracle.
The feature parameter of `weightedCoefficient` remains `Sort`-polymorphic; other
list-constrained parameters use `Type`. Universe `u` is declared outside solution
helper namespaces so it is still in scope for the top-level solution.

The repair refuses changed source or oracle hashes and refuses to insert the
same binders twice. Changed source requires a fresh Lean extraction and a new
binder review. It refreshes affected file hashes while leaving validation pending;
it performs no authentication or publication and never edits upload state.

The generator also emits the documented definition description field and makes
each theorem's `preamble + formal_statement` exactly equal its staged theorem
file, including the separator newline. It deliberately resets semantic metadata
and publication readiness to pending. After any regeneration or compatibility
repair, perform the full strict build, compare the original and staged theorem
and definition types, and check each top-level solution against its target.
Then restore or review individual academic metadata, confirm the live environment,
and refresh all manifest evidence hashes before setting validation to passed.

The frozen validated Collatz candidate records this completed repair in
`publication/prove2me/collatz/evidence/strict-validation.json`: 255 strict build
jobs, 113 original/staged theorem type matches, 243 retained definition-constant
type matches, and 113 exact solution/target comparisons using rigid universes.
Its README distinguishes source verification from actual remote receipts.
No remote theorem is submitted by these extraction and repair scripts.
