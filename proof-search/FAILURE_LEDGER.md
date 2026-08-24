# Failure ledger — do-not-repeat index

This file records approaches that have already failed, deflated, or become precisely blocked. It is **not** a ban on revisiting them. A route may be reopened only when the new mechanism that bypasses the old blocker is stated explicitly.

## Classification codes

- `KNOWN` — substantially prior art or immediate from known machinery.
- `EQUIV` — reduction ends at a claim essentially as strong as Collatz.
- `NUMERIC` — finite experiment only.
- `TAUTOLOGY` — repackages the desired behavior without explaining it.
- `FALSE` — concrete counterexample exists.
- `TOO_WEAK` — valid theorem but insufficient for global descent/disproof.
- `ARCH_GAP` — promising architecture with a named missing theorem-strength bridge.
- `FORMAL_GAP` — informal statement/proof has not survived exact formalization yet.

## F001 — bounded corrected-log correction near the -1 shadow

**Class:** `TOO_WEAK / blocked architecture`  
**Prior status:** Rounds 2–4.

Long positive shadows of the signed fixed point force near-bitlength no-descent intervals for corrected-log potentials whose correction is bounded on the relevant congruence cylinder.

**What survives:** quantitative necessary conditions on lookahead/debt.

**Do not repeat:** “choose a bounded/local correction and prove a uniform sub-logarithmic descent horizon.”

**Reopen only if:** the correction carries qualitatively nonlocal information that is proved not to freeze on the old shadows.

## F002 — one-sided local boundedness is enough

**Class:** `FALSE`.

Round 6A produced explicit counterexamples showing that only a lower bound or only an upper bound does not control same-phase debt.

**Do not repeat:** any theorem silently replacing two-sided/local oscillation control by a one-sided bound.

**Reopen only if:** an additional monotonicity or structural assumption supplies the missing direction.

## F003 — a single depth tax `F(v_2(n+1))` repairs the ranking

**Class:** `TOO_WEAK / blocked architecture`.

Round 5B rational periodic shadows can freeze `v_2(n+1)` phase-by-phase while remaining repelling, so arbitrary `F` does not give the desired universal fast descent guarantee.

**Reopen only if:** the ranking uses information outside this single depth coordinate.

## F004 — finitely many fixed 2-adic proximity sensors suffice

**Class:** `TOO_WEAK / blocked architecture`.

Round 5B/6A periodic ghosts can be chosen to avoid finitely many centers and freeze all such sensors by phase.

**Reopen only if:** the feature map provably distinguishes arbitrarily high-period stress families.

## F005 — uniformly negligible tail of countably many sensors

**Class:** `TOO_WEAK / blocked architecture`.

Round 6B: every finite phase-frozen surrogate forces the residual approximation error to remain linearly large in shadow depth on suitable stress families. Uniformly convergent/summable tails therefore do not supply a universal fixed-fraction corrected-log ranking.

**Reopen only if:** the infinite tail remains genuinely nonuniform/log-scale and a well-founded descent theorem is provided.

## F006 — arbitrary finite valuation-prefix enumeration proves Collatz

**Class:** `EQUIV / TOO_WEAK`.

Every fixed finite valuation word can be realized by positive integer shadows under appropriate congruence precision. Hence proving that “most” or many finite words contract does not control one fixed hypothetical counterexample's infinite prefix.

**Do not repeat:** finite word statistics as though they exclude all positive orbits.

**Reopen only if:** a global compatibility constraint links successive prefixes of the same integer and forces a well-founded reduction.

## F007 — negative average log multiplier alone gives pointwise convergence

**Class:** `EQUIV / TOO_WEAK`.

Average/probabilistic drift can prove density or almost-everywhere results without ruling out an exceptional orbit. The missing step is exactly control of every orbit/minimal counterexample.

**Reopen only if:** a deterministic arithmetic mechanism converts the average estimate into an exact all-orbit certificate.

## F008 — finite-depth residue tree

**Class:** `ARCH_GAP`.

A finite tree with a bounded maximum macro-depth would imply a global bounded stopping-time depth for the represented encoding, while stopping times are known to be unbounded. The correct object cannot be a fixed-depth partition tree alone.

**Replacement architecture:** finite **recursive graph/automaton** with back-edges certified by a separate well-founded rank.

## F009 — pure computation beyond a fixed threshold

**Class:** `NUMERIC`.

Verifying all starts below any fixed bound does not prove the infinite conjecture; failing to find a counterexample below a bound does not prove none exists.

**Legitimate use:** a rigorously verified finite lower bound can serve as a base case inside an independent symbolic induction/certificate.

## F010 — rational or 2-adic periodic point is a positive counterexample

**Class:** `FALSE inference`.

Rounds 5B/6A deliberately use rational/2-adic periodic objects whose positive integer lifts shadow them for long finite times. Long positive shadows do not imply an actual positive integer periodic/divergent orbit.

**Disproof kill test:** exhibit and verify the positive natural witness/invariant explicitly.

## F011 — “Lean compiled” is sufficient verification

**Class:** `FALSE methodology`.

The July 2026 `CollatzLean` incident exposed a real Lean kernel soundness bug through malicious/metaprogrammed declarations. A sorry-free build under a vulnerable checker can still be invalid.

**Replacement:** `lean/VERIFICATION_POLICY.md`: patched/current toolchain, trusted statement, no theorem-strength project axioms, no low-level generated declarations in the trusted route, axiom audit, clean build, semantic comparison and independent replay.

## F012 — theorem with a universal structural axiom counts as Collatz proof

**Class:** `TAUTOLOGY / conditional`.

Public formalizations may prove many correct algebraic lemmas and then assume a theorem-strength universal trajectory certificate or an unverified giant base case. The final result is conditional on that assumption.

**Kill test:** `#print axioms` plus dependency graph. Any project axiom carrying the global orbit bridge remains the missing lemma.

## F013 — global descent rephrased without a mechanism

**Class:** `EQUIV`.

By L0, “every positive odd `n>1` eventually has a smaller iterate” is exactly equivalent to Collatz. It is a useful endpoint but not a progress theorem by itself.

**Do not count as progress:** giving this property a new name, potential, grammar leaf, or “eventual contraction” label without proving it from weaker, independently checkable conditions.

## F014 — six/finitely many failure classes imply resolution

**Class:** `TOO_WEAK`.

A formal classification of hypothetical minimal counterexamples is valuable only if every non-success class is eliminated. Recent community Lean work explicitly presents such grammars as structural classification, not a proof.

**Reopen as proof route only if:** a new theorem excludes all remaining leaves.

## F015 — bounded affine-coalescence search closes the residue space

**Class:** `NUMERIC / ARCH_GAP`.

Round 7's first shallow search finds many exact coalescence shortcuts but leaves residue families unresolved at every tested modulus. Enlarging the fixed search parameters is useful diagnostically, not a proof strategy.

**Replacement:** infer symbolic state transitions from the successful families and search a recursive graph with a rank.

## F016 — unresolved route described as “almost solved” because the missing lemma sounds narrow

**Class:** `EQUIV risk`.

A syntactically short missing lemma can still carry essentially all the conjecture's strength. Every bridge must be tested against L0 by asking whether its hypotheses already encode global descent.

**Policy:** use `BLOCKED_EQUIVALENT` when this occurs.

---

# Reopening template

When reopening a ledger item, add:

- **Old blocker:**
- **New mechanism:**
- **Why it bypasses the blocker:**
- **First falsification test:**
- **Exact theorem target:**

Without these five fields, do not spend a full search cycle on the old route.
