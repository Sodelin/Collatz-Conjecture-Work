# Restricted YAH obstruction: concrete certificate review

Return to the [novelty report](REPORT.md).

This follow-up inspected both exact checkers and the complete 389-line `top_cert_common.py`, reran both checkers without third-party packages and with Python assertions enabled, and inspected the current release verification report. The mathematical source checkout remained clean at `33922a42e86646258d227d1e19c6cf7546a2f548`.

### Exact claim and file mapping

There is **no Lean theorem name for this obstruction** in the current source. The identifiers are claim-registry IDs and checker outputs, not kernel declarations.

| Item | Exact path relative to mathematical source | Role |
|---|---|---|
| Original-system claim `A-YAH-AN1-001`; labeled claim `A-YAH-2STATE-AN1-001` | `proof-search/CLAIM_REGISTRY.md` | Existing classification `C3 V2 I3 N2 R2`; R2 means specialist-review packet, and no claim is marked R3 submission-ready |
| Mathematical statement and lifting argument | `proof-search/routes/A_yah_two_state_scalar_arctic_full_no_start.md` | Full/extended plus both YAH relative-top entry points, and the fixed-label extension |
| Original 11-row and labeled 22-row full cancellation | `verification/yah_two_state_scalar_arctic_full_no_start.py` | `RULES`, `MULTIPLIER`, `UNLABELED_MULTIPLIER`, `main`; outputs `ORIGINAL_FULL_EXTENDED_SCALAR_ARCTIC_NO_START = PASS` and `FULL_EXTENDED_SCALAR_ARCTIC_NO_START = PASS` |
| Top encoding and certificate semantics | `verification/yah_scalar_arctic_top/top_cert_common.py` | `instances`, `TOP_CASES`, `build_case`, `farkas_valid`, `learned_clause`, `rup_valid`, `verify_full_compatibility` |
| Top certificate payload | `verification/yah_scalar_arctic_top/top_certificates.json` | Ten target cases; 491 integer Farkas lemmas; 426 RUP clauses; multiplier mass 10,183 |
| Top certificate replayer | `verification/yah_scalar_arctic_top/verify_top_certificates.py` | Reconstructs constraints and refutes every target; outputs `TOP_SCALAR_ARCTIC_NO_FIRST_STEP = PASS` |
| Formalization TODO | `LEAN_TARGETS.md`, highest-value pending target 1 | Explicitly requires encoding/semantics and lifting formalization, not just checking stored sums |

### Fresh replay and release evidence

Both commands below exited zero in this follow-up:

```bash
env -u PYTHONOPTIMIZE -u PYTHONPATH python3 -S -B verification/yah_two_state_scalar_arctic_full_no_start.py
env -u PYTHONOPTIMIZE -u PYTHONPATH python3 -S -B verification/yah_scalar_arctic_top/verify_top_certificates.py
```

The full replay checks all 22 semantic equations, all 14 labeled tokens, positive weights of total mass 49, and zero weighted coefficient deltas for both rule tables. The top replay checks six original-orientation labeled boundary targets and four reversed labeled dynamic targets. Every case passed; total runtime was under one second on this run. Runtime is not mathematical evidence.

`released-verification.json` records `status: passed`, exact source SHA `33922a42...`, and `verify_top_certificates` exit code 0 at `verification-logs/24-verify_top_certificates.log`. Its release gate is `publication/verify_source.py`, which explicitly executes the top checker. That checker calls `verify_full_compatibility()`, independently replaying the 22-rule full cancellation as well. The original-system full result then follows by equal-label lifting. Therefore **the existing release does cover the mathematical certificate package indirectly through the top checker**, even though it has no separate log entry for the direct original 11-row replayer.

The source's separate `.github/workflows/python-verification.yml` lists both direct full and top commands. The publication gate follows `.github/workflows/verify.yml`, which lists the top command only. Adding the direct full replayer to the publication gate would make the evidence mapping clearer and cheaply expose both original-system PASS labels; this is an audit-clarity improvement, not evidence that the current top replay omitted the full cancellation entirely.

The standalone Lean bundle contains no YAH proof. Packaging the Python source/checker in the full research archive must not promote its status to Lean-checked.

### Checksum correction: serialization, not a mathematical discrepancy

The theorem note records payload SHA-256 `ac7c6a43600d95ebdf4353b3b10e66b24267295a506ab6ea8793ca086c0c0d2a`. The actual pinned Git blob and Linux worktree contain 419,526 bytes with SHA-256 `dafb9bfcbe02a32905fc46d99ceb97b9b296059869d77ee42cff5c99d04592d6`.

Converting only LF newlines to CRLF produces 446,687 bytes and **exactly reproduces the documented `ac7c6a...` hash**. Thus the data are semantically identical; the historical hash describes Windows serialization. The semantic rule-instance fingerprint still matches `7b0dad87f3d82606686251f72e4aaf5acd8f3f4fe97d615a8f40b5d320f57d9d`. The publisher should annotate the actual release byte hash and newline explanation rather than silently modifying the frozen source.

### What is elementary and what still deserves review

The original-system **full/extended scalar** result is elementary, and its difficulty should not be exaggerated. Write the natural slope coefficients for `f,t,0,1,2` as `a,b,c,d,e`. Weak orientation includes

$$
b\ge e,\quad e\ge a+b,\quad a+d\ge c+b,\quad c\ge d,\quad e\ge d.
$$

The first two force `a=0` and `e=b`. Then the middle two force `b=0` and `c=d`; finally `e≥d` forces `d=c=0`. All five internal-symbol coefficients vanish; boundary coefficients cancel in every rule. No rule is strict. This is a short scalar additive obstruction inherent in the listed inequalities. The 11-row certificate gives a uniform checkable witness, but the full scalar part alone is a modest observation.

The broader top statement allows `sigma(x)=max(m_sigma+x,v_sigma)` with each coefficient in natural numbers plus minus infinity and at least one finite component. This requires handling slope-support cases, finite intercept maxima, the unusual bottom/bottom strict-comparison convention, all weak rule comparisons and at least one strict designated target. The current checker reconstructs those cases, turns integer strictness into a gap of at least one, verifies positive-integer Farkas contradictions for real relaxations, and checks the Boolean combination by RUP. The 22-rule fixed-label extension is also stronger than the bare original full observation.

These are reasons to review the **full-plus-top certificate package**, not evidence of novelty by themselves. A shorter direct proof or a known general theorem could still make the whole package routine. No corresponding general theorem was identified in this bounded follow-up.

### Exact relationship to YAH's published future work

The quantifier distinction is decisive. YAH §6 asks whether appropriate matrix interpretations might fail for the mixed-base system in general. It does **not** state a separately numbered dimension-one arctic-natural conjecture. The project resolves a restricted first-step subcase of that research direction. It neither answers the general matrix-interpretation question nor closes the YAH approach. The source note already correctly limits its theorem to standard coefficientwise comparisons, because YAH's coefficientwise tests are sufficient conditions for the underlying functional inequalities, not a characterization of every possible interpretation order. The author's [arctic implementation](https://github.com/emreyolcu/rewriting-collatz/blob/8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340/prover/arctic.py) uses the same full/weak distinction.

### Recommended precise publication claim

**Suggested title:** “Exact certificates excluding the first scalar arctic-natural step for the mixed-base Collatz rewrite system.”

**Suggested statement:** For the original eleven-rule mixed-base system of Yolcu, Aaronson and Heule, no standard coefficientwise dimension-one arctic-natural interpretation weakly orients every rule and strictly orients a nonempty set in a first full/extended rule-removal step. The same exclusion holds for each of the two relative-top opportunities in YAH Lemma 3.18: a nonempty boundary-rule subset in the original orientation, or a nonempty dynamic-rule subset in the reversed orientation. An exact fixed two-state 22-rule labeling satisfies the corresponding syntactic exclusions. The coefficient domain is unbounded. The proof uses elementary cancellation and replayable Farkas/RUP certificates; independent external novelty and semantic review remain pending.

**Mandatory scope sentence:** The result excludes only this first-step interpretation class; it does not exclude higher dimensions, arctic integers or other carriers, other labelings, non-coefficientwise orders, additional transformations or later scalar steps, and proves neither Collatz convergence nor nonconvergence.

### Next proof/publication gate

1. Have an independent term-rewriting reviewer verify the exact 11-rule identification, scalar coefficient domain, weak/strict composition semantics, natural-to-real relaxation and equal-label lifting. This is the highest-value remaining correctness gate; another identical replay would not answer it.
2. Produce a separate statement module and Lean proof for the elementary full result, then a small verified certificate semantics for the top cases. Formalize why genuine interpretations induce satisfying assignments and why checked Farkas/RUP certificates rule those assignments out. Checking only the 491 integer identities would leave the important encoding-to-theorem bridge open.
3. State the YAH §6 relationship as “restricted first-step subcase of a published research direction,” and perform citation/specialist prior-art review before describing it as a newly solved previously open problem. The research artifact can be shared before this gate with its present exact-certificate status.

