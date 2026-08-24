# Hardened Lean verification policy

This policy applies to any future claim in this repository labeled `FORMALIZED`, `PROOF_CANDIDATE`, or `DISPROOF_CANDIDATE`.

## Why the policy is unusually strict

In July 2026 an AI-assisted repository named `CollatzLean` produced a `sorry`-free apparent Lean disproof of Collatz. Review exposed Lean kernel soundness bug #14576: a malicious/metaprogrammed declaration involving nested inductive projections could be accepted and used to prove `False`. Lean 4.32.2 was released specifically to fix the soundness bug.

Therefore “Lean accepted it,” `sorry`-free, and even a single checker pass are not sufficient audit descriptions for a high-stakes open-problem claim.

## 1. Toolchain floor

- Do not use Lean versions affected by #14576.
- Minimum acceptable release: **Lean 4.32.2**.
- Prefer the latest stable Lean/Mathlib available when formalization begins.
- Pin the exact Lean toolchain and Mathlib commit in the repository.
- Record both versions in every formalization release/checksum manifest.

## 2. Trusted-statement architecture

Follow the strongest feature of modern formalization challenge workflows:

1. Put the mathematical statement to be checked in a small **trusted statement file**.
2. Define the standard Collatz map / accelerated odd map there using ordinary Lean definitions.
3. State the headline theorem there with no access to solution-internal alternate definitions.
4. Keep the solution proof in separate modules.
5. Mechanically compare the exported solution theorem's type with the trusted statement when possible.

For a claimed proof, the trusted theorem must be semantically equivalent to the ordinary Collatz conjecture, preferably via the separately formalized L0 equivalence.

For a claimed disproof, the trusted theorem must imply the negation of that exact statement and expose a mathematically meaningful witness/certificate whenever feasible.

## 3. Prohibited shortcuts in the trusted proof path

A claimed unconditional Collatz resolution must contain:

- no `sorry`;
- no project-defined `axiom` or `postulate` carrying theorem-strength mathematical content;
- no `unsafeCast` or equivalent escape hatch;
- no `debug.skipKernelTC`;
- no unchecked declaration API;
- no binary `.olean` artifact substituted for auditable source;
- no generated theorem whose correctness depends on a custom meta-program fabricating low-level `Expr` declarations.

Ordinary tactics and metaprograms may be used to *search/build proof terms*, but the final trusted route should reduce to ordinary checked theorem declarations. For this project, avoid `addDecl`-style theorem generation in the critical chain entirely unless independently justified and replayed through multiple current checkers.

## 4. Axiom audit

For every headline theorem run `#print axioms` and store the output.

Expected standard logical dependencies may include Mathlib/Lean foundations such as `propext`, `Classical.choice`, and `Quot.sound`. Any project-specific mathematical axiom automatically downgrades the result to `conditional`, not `FORMALIZED` as an unconditional Collatz resolution.

A finite base computation may be imported only through a clearly labeled verified certificate/interface, never as an unexplained axiom such as “all n below 2^109 converge.”

## 5. Clean build and replay

Required checks:

1. clean clone into an empty directory;
2. exact pinned toolchain installation;
3. full `lake build` from source/configuration;
4. compile trusted statement and solution modules;
5. run axiom audit;
6. run statement/type comparator;
7. run an independent checker/replay implementation when available;
8. preserve logs and SHA-256 hashes in `verification/`.

No validation result should depend on an editor cache or pre-existing local environment.

## 6. Semantic audit

A human-readable audit must answer all of the following independently of the green build:

- Is the function in Lean exactly the intended Collatz map?
- Are domains exactly positive naturals / positive odds as claimed?
- Is accelerated iteration proven equivalent to standard iteration?
- Are existential/universal quantifiers in the same order as the mathematical conjecture?
- Does “diverges” mean genuinely never reaches `1`, not merely “no descent found within k steps”?
- Does a cycle exclude the trivial `1` cycle?
- Are imported computational bounds exactly what the external computation proves?
- Does the final theorem have any hidden hypotheses?

## 7. Certificate-first design

Prefer formalizing **general certificate soundness** once, then letting untrusted tools generate finite certificates.

Examples:

- `ValidRewriteInterpretation cert -> Collatz`;
- `ValidResidueGraph cert -> Collatz`;
- `ValidPositiveCycle cert -> not Collatz`;
- `ValidDivergenceInvariant cert -> not Collatz`.

Python, SAT, SMT, LLMs, and search code may produce the `cert`. Lean should need only to check finite data plus a general soundness theorem.

This sharply separates creative search failure modes from deductive verification failure modes.

## 8. Formalization order

### Foundation
1. ordinary Collatz map;
2. accelerated odd map;
3. map equivalence;
4. L0 global-descent equivalence.

### Existing Round-6 chain
5. exact valuation-prefix affine identity;
6. rational periodic point;
7. exact positive lift including endpoint valuation;
8. same-phase scaling;
9. Round 6A β-debt theorem;
10. `w_m` limit.

### Resolution architectures
11. certificate semantics for whichever Route A–F survives search;
12. concrete generated certificate;
13. exact top-level proof/disproof theorem.

## 9. Counterexample-driven development

Before formalizing a broad theorem, first encode the smallest known counterexamples to nearby stronger statements. In particular preserve the Round-6A failures of one-sided boundedness and test any new ranking lemma against periodic-shadow constructions.

A theorem that becomes difficult to state because its informal version was ambiguous has already benefited from formalization; repair the statement before trying to force the proof.

## 10. Release gate

A public claim of “Lean-verified proof/disproof” requires all of:

- current patched toolchain;
- frozen trusted statement;
- zero `sorry` in the solution path;
- zero project theorem-strength axioms;
- stored `#print axioms` output;
- clean CI build;
- comparator/type check;
- independent replay/check where practical;
- readable proof dependency graph;
- independent mathematical audit of semantics.

Until then use `Lean formalization in progress` or `Lean candidate`, never `Lean verified`.
