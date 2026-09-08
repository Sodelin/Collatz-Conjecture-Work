# Sodelin/Egyptian-Fractions-Erdos-295 — Prove2Me preparation checkpoint

Source commit: `566f9800910aae6936d93d1a9f5c756070616f31`. Source branch: `main`.

The exact source builds with Lean4.33.1. All project declaration axiom closures are contained in `propext`, `Classical.choice`, and `Quot.sound`. Source code is preserved byte-for-byte in `source/`; hashes and compiler-derived declaration, type, axiom and source-span facts are in `audit/`.

The platform decomposition has 2 theorem nodes and 2 definition bundles, with supporting proofs inlined where appropriate. All exact generated definition bundles, theorem stubs and solution files compile. Original, staged theorem and staged solution elaborated types match exactly for all2 nodes; see `candidate/type-checks/comparison.json`. Academic metadata and the live platform environment pin remain pending. `validation.status` therefore remains `pending`, and upload is blocked.

The theorem stubs deliberately contain the platform's statement holes; the separate solution files preserve the original proofs. Source verification and platform acceptance are distinct checks.

`python reproduce_source.py` rechecks the source using a normal installed Lean/Lake toolchain. The observed hosted-environment run used the repository's existing executable-path discovery launcher; no mathematical source or kernel behavior was modified. Source replay does not validate the candidate platform decomposition.

No external item has been created by this checkpoint. Remaining gates are recorded in `PLAN.json`.
