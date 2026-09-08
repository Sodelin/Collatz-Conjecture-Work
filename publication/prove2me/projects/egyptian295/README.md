# Sodelin/Egyptian-Fractions-Erdos-295 — Prove2Me preparation checkpoint

Source commit: `566f9800910aae6936d93d1a9f5c756070616f31`. Source branch: `main`.

The exact source builds with Lean4.33.1. All project declaration axiom closures are contained in `propext`, `Classical.choice`, and `Quot.sound`. Source code is preserved byte-for-byte in `source/`; hashes and compiler-derived declaration, type, axiom and source-span facts are in `audit/`.

The platform decomposition has 2 theorem nodes and 2 definition bundles, with supporting proofs inlined where appropriate. All exact generated definition bundles, theorem stubs and solution files compile. Original, staged theorem and staged solution elaborated types match exactly for all 2 nodes; see `candidate/type-checks/comparison.json`. Academic metadata and separate proof explanations have been reviewed against the exact source; see `candidate/metadata-review.json`. The live platform environment is confirmed as Lean4.33.1 with Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`; see `candidate/live-environment.json`. The payloads import only core Lean/Std. `validation.status` is `passed`, ready for authenticated upload and remote acceptance checks.

The theorem stubs deliberately contain the platform's statement holes; the separate solution files preserve the original proofs. Source verification and platform acceptance are distinct checks.

`python reproduce_source.py` rechecks the source using a normal installed Lean/Lake toolchain. The observed hosted-environment run used the repository's existing executable-path discovery launcher; no mathematical source or kernel behavior was modified. Source replay does not validate the candidate platform decomposition.

No external item had been created at this preparation checkpoint; subsequent upload receipts determine current remote status. Remaining gates are recorded in `PLAN.json`.
