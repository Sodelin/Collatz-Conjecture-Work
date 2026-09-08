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
- `runtime/`: optional executable-location compatibility launcher; no kernel changes.

Original upstream extraction script comments are preserved. Historical source copies
under `archive/` are byte-identical to the original files and exist only to assign
importable temporary module names. The source manifest points back to original paths.

After rebuilding with `python prove2me-audit/prepare_extraction.py`, run the saved
audit scripts with `lake env lean`, then generate candidates with:

```sh
python prove2me-audit/generate_platform.py . publication/prove2me/collatz
```

Run this only while candidate compilation is stopped. Re-generation invalidates
the prior staging hashes and checks, which must be refreshed. For current results,
remaining metadata/server gates, and caveats about intentional theorem stubs, read
the candidate tree's README. No remote theorem was submitted by these scripts.
