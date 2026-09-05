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

It is useful to separate two quantified versions of the bounded-time
obstruction.  Let

\[
U(n)=\frac{3n+1}{2^{v_2(3n+1)}}
\]

on positive odd integers.  For `m>=2` and `0<=j<m`, direct induction gives

\[
U^j(2^m-1)=2^{m-j}3^j-1.
\]

Hence `U^j(2^m-1)>2^m-1` for every `1<=j<m`.

- **`A_cyl`:** no finite cover by power-of-two residue cylinders, each fixing
  a finite `U`-valuation prefix and carrying direct `U`-descent at a fixed
  time `k_i>=1`, can cover all odd integers greater than one (or all
  sufficiently large odd integers, with finitely many base cases handled
  separately).
- **`A_arb`:** more generally, if finitely many arbitrary sets cover all odd
  integers greater than one and the `i`-th set carries a direct-descent
  guarantee at a fixed time `k_i>=1`, the same contradiction follows.  In
  bounded-horizon form, require `K_i>=1` and, exactly,
  `forall n in C_i, exists j, 1<=j<=K_i and U^j(n)<n`.  Choosing `m` larger
  than every such time or horizon contradicts the displayed identity.  The
  same proof applies to a cover of all sufficiently large odd integers by
  taking `m` beyond the base cases.  No cylinder or topological hypothesis is
  needed for this maximum-horizon proof.

This is prior-art territory, not a new lemma.  Sinyor, *The 3x + 1 Problem as
a String Rewriting System* (2010), Section 3, explicitly records the Mersenne
forced-growth identity and arbitrarily long stopping times under its
one-division shortcut-map convention
([DOI](https://doi.org/10.1155/2010/458563)).  Applegate and Lagarias,
*The 3x+1 Semigroup* (2005/2006), Section 2, prove a stronger
architecture-specific obstruction for the class `-1 mod 2^j` under their
finite multiplier/decrease method
([arXiv](https://arxiv.org/abs/math/0411140)).

The displayed `U` identity is the odd-only translation strictly before the
Mersenne endpoint: the two maps agree through `j<m` because every removed
power of two there is exactly one.  At the endpoint their values and step
counts must not be conflated.

**Replacement architecture:** finite **recursive graph/automaton** with back-edges certified by a separate well-founded rank.

The argument above does not obstruct parameter refinement, unbounded
derivations, coalescence with a smaller start, or ranked recursion.

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

## F017 — strict leading-coefficient decrease is necessary for affine coalescence

**Class:** `FALSE`.

The exact families

`N(x)=8x+5` and `m(x)=8x+4`

satisfy `T^3(N(x))=T^3(m(x))=3x+2` and `0<m(x)<N(x)` for every
`x>=0`, although both leading coefficients are `8`. The inverse word is
`OEE`.

**Replacement:** corrected L5. A successful whole-family inverse word has
either strict slope decrease (`|w|<=t-1`) or equal slope with smaller
intercept (necessarily `|w|=t`). The complete class bound is `|w|<=t`.

## F018 — deeper unrefined inverse words will eventually close Mersenne cylinders

**Class:** `FALSE` for the stated unrefined class. The broader refinement-aware
Route AB has primary status `BLOCKED_NO_MECHANISM` in the approach registry.

For `M_K(x)=2^K(x+1)-1`, every uniformly admissible inverse word after any
uniform forward time has leading coefficient at least `2^K`. Equality forces
the exact reverse odd word and reconstructs the same family, including its
intercept. This quantifies over every inverse depth in the L4/L5 one-shot
whole-family class.

**Do not repeat:** increasing inverse depth in that same unrefined class as if
the persistent Mersenne misses were search-depth artifacts.

**Reopen only if:** the certificate refines the parameter, handles the
canonical positive boundary, and supplies a well-founded rank for the hard
transition `M_K(2y+1)=M_{K+1}(y)`, or uses a genuinely stronger semantic
class.

**Relation to F008:** call the F018 result **`B_inv`**.  Its word language
includes the empty inverse suffix (`j=e=r=0`), whose output is the selected
uniform forward iterate itself.  Direct descent is therefore literally the
empty-suffix special case of its coalescence semantics.  Within the shared
power-of-two cylinder / uniform-certificate language, `A_cyl` is strictly
weaker than `B_inv`: `B_inv` excludes that empty-suffix case and also every
nonempty uniformly admissible inverse suffix at arbitrary inverse depth.

At their full quantified scopes, `A_arb` and `B_inv` are incomparable as
architecture filters.  `A_arb` permits arbitrary covering sets but rules out
only finitely bounded direct descent.  `B_inv` handles the stronger one-shot
coalescence semantics and quantifies over every admissible inverse depth, but
only for the unrefined whole-family `E/O` certificate language on Mersenne
cylinders.  Neither result rules out parameter refinement, a refinement-aware
mixed-radix system with unbounded derivations, or an independently checked
well-founded recursion rank.

## F019 — L11 hard-exit inheritance automatically renews L9-L10

**Class:** `FALSE` inference. The associated Route-D architecture has primary
status `BLOCKED_NO_MECHANISM` in the approach registry.

If `y=n_*+d`, least-counterexample minimality proves future iterates of `y`
stay at least `n_*`. It does not prove they stay at least `y`, and it does not
prove the coefficient stopping time local to `y` is finite. A local
contraction into `[n_*,y)` is neither a contradiction nor another L10
non-descending near-return.

**Replacement:** carry the immutable root `n_*` in a total transition system.
Every local contraction, non-descending contraction, infinite coefficient-
stopping branch, band exit, and zero-gap cycle branch must be covered, and all
back-edges must decrease an independently proved well-founded rank.

## F020 — scalar adjacent-edge weights orient the exact YAH system

**Class:** `FALSE` for the stated canonical additive class.

The 13-row positive-integer cancellation in
[`routes/A_yah_2local_edge_potential_no_go.md`](routes/A_yah_2local_edge_potential_no_go.md)
forces `W_(f,f)<=-1`. Repetition on canonical strings `^f^m$` then makes the
potential unbounded below. The exact checker reconstructs the signed deltas and
prints `PASS`.

**Do not promote beyond scope:** this excludes scalar adjacent-pair additive
weights on the audited contexts. It does not exclude semantic labels, longer
windows, matrices, nonadditive orders, or termination of the rewrite system.

## F021 — the fixed two-state suffix labeling rescues additive YAH orders

**Class:** `FALSE` for additive labeled-symbol/edge scalar and finite-lex
orders in this one algebra.

For the exact two-state suffix maps recorded in
[`routes/A_yah_two_state_semantic_label_no_go.md`](routes/A_yah_two_state_semantic_label_no_go.md),
an 8-row symbol cancellation and 50-row adjacent-edge cancellation have zero
weighted delta but strictly positive dynamic mass. The same coordinatewise
identity kills every finite lexicographic tuple of those additive weights.

**Reopen only if:** a proposal changes the semantic algebra, locality/memory,
or order class and supplies an exact certificate. Do not infer that all
semantic labeling or all matrix/nonadditive interpretations fail.

## F022 — cyclic rotation supplies an independent two-pump resultant

**Class:** `FALSE` algebraic independence claim.

The exact coefficient identities `aB=cC` and `gA=dE` imply
`cgAC-adBE=0` identically. Thus rotating the same two-pump word equation does
not produce the hoped nonzero constant resultant. The derivation and a narrow
Lean proof are linked from
[`disproof/CODEX_TWO_PUMP_DEPENDENCY_AUDIT_2026-08-24.md`](disproof/CODEX_TWO_PUMP_DEPENDENCY_AUDIT_2026-08-24.md).

**Do not promote beyond scope:** this kills cyclic-rotation-only elimination,
not every multi-pump method and not any positive cycle.

## F023 — label depth, bitlength, and replay debt admit a universal affine rank

**Class:** `FALSE` for the stated lower-bounded affine class.

L13 equations (20)–(27) prove exact same-label debt decrease and arbitrary
cross-label recharge. The guarded transition
`17,184,927 -> 97,873,535` refutes every lower-bounded affine combination of
the audited label depth, parameter bitlength, and `D`/`R` replay variables.

**Reopen only if:** the rank uses genuinely richer state or nonlinear order and
is checked on every guarded successor. This result does not rule out all finite
automata or all well-founded ranks.

## F024 — boundary normalization itself supplies Route-AB descent

**Class:** `EQUIV risk`.

The decreasing boundary reducer and total normalizer in
[`routes/AB_hard_boundary_return_system.md`](routes/AB_hard_boundary_return_system.md)
produce a closed return map on the hard set. Universal termination of that map
is equivalent to Collatz. The exact `31 -> 182 -> 91` return grows and recharges
the current replay debt, so closure alone does not supply descent.

**Reopen only if:** an independently proved well-founded mechanism ranks every
hard return, or a new guarded macro coalesces with a uniformly smaller positive
target. Renaming the return obligation is not progress.


## F025 — higher-degree polynomial size/debt ranks rescue the hard return map

**Class:** `FALSE` for the exact stated class.

[AB-FROZEN-DEBT-001](routes/AB_frozen_debt_size_rank_no_go.md) gives the exact
family `65536u+47771 -> 110592u+80615 -> 279936u+204059` for every `u>=0`.
The endpoints have the same `(L,epsilon,D,R)=(2,1,2,0)`, and parameter/size
grows by more than fourfold. This excludes all lower-bounded label-dependent
polynomials in parameter, bitlength, D and R, of arbitrary finite degree,
and finite lex tuples when every coordinate is lower bounded.

**Reopen only if:** the proposed rank uses additional arithmetic information,
nonpolynomial behavior outside the proved obstruction, or a stronger smaller-target
coalescence relation. It must distinguish or validly bypass this exact family.
This strengthens F023 without excluding all nonlinear ranks or proving divergence.

---


## F026 — Adding 3-adic depth does not repair polynomial cofactor ranks

**Status:** exact obstruction within the specified augmented-state class.
[AB-3ADIC-RESET-001](routes/AB_three_adic_rank_no_go.md) proves the reset
`v3(Y+1)=1` on every raw hard return and the family
`589824t+244379 -> 995328t+412391 -> 2519424t+1043867`, `t>=0`.
Both endpoints have `(L,e,b,D,R)=(2,1,1,2,0)`, while their coprime cofactors
increase by more than fourfold. This excludes lower-bounded polynomials in
cofactor and bitlength with arbitrary dependence on those frozen measurements,
and finite lex tuples with individually lower-bounded coordinates.

**Reopen only if:** the candidate handles this exact family with further
arithmetic structure, nonpolynomial behavior, or a proved smaller target.
An exact coordinate system alone is not a well-founded order.

## F027 — Summable projected discrepancy is not a weaker mixing bridge

**Status:** exact source-quantifier obstruction. Consistent projected total
variation errors satisfy `delta_(K+1)>=delta_K>=0`; summability therefore
forces every error to vanish. Chang v6's displayed WMH supplies no weakening
of fixed-depth equidistribution. Its asserted non-atomic Haar uniqueness
also has an explicit countermeasure. See the [primary-source audit](sources/Primary_Bridge_Audit_2026-09-05.md).

**Reopen only if:** a corrected quantitative hypothesis is actually proved
for each required positive orbit, with its tail and cycle obligations intact.
Neither finite-modulus mixing nor a 2-adic almost-everywhere assertion is
that pointwise bridge. These failures are not a no-go for every ergodic method.


## F028 — Fixed residue refinement does not repair the stated polynomial ranks

The [original-F CRT construction](routes/AB_finite_residue_original_return_no_go.md)
freezes any fixed modulus across expanding true F paths. The [stronger-core
construction](routes/AB_ternary_normalized_core_residue_obstruction.md) does
the same for its specified normalized return and for first returns to20 mod27.
These are distinct transition relations. Their polynomial/finite-lex no-go
proofs do not prohibit variable moduli, unbounded valuations or different
smaller-target selection. Indeed, exact inverse macros remove the displayed
families from still-stronger minimal-root arguments.

**Reopen with:** an explicit mechanism beyond fixed-modulus polynomial size
ranks, with exact handling of the relevant family and its unbounded shadow debt.

## F029 — Decreasing coalescence normalization need not advance a return map

The exact auxiliary loop is `425 ->638 ->319 ->479 ->c425`, where the first
three arrows are actual T steps and `c(y)=(8y-7)/9` is a smaller coalescing
predecessor. The signed time advance is `+3-3=0`. Thus a decreasing normalizer
cannot inherit the original F termination-equivalence proof automatically.
See [the proof, prefix guards and clock conditions](routes/AB_ternary_normalized_core_residue_obstruction.md).

**Reopen with:** a proved global rank or sufficient accumulated progress
condition on the exact composition. Conditional stopping-time equivalence
does not itself establish unconditional termination.

# Reopening template

When reopening a ledger item, add:

- **Old blocker:**
- **New mechanism:**
- **Why it bypasses the blocker:**
- **First falsification test:**
- **Exact theorem target:**

Without these five fields, do not spend a full search cycle on the old route.


## F030 — Naming the OOE shadow depth does not prevent recharge

For the specified stronger-core return S, [the exact family](routes/AC_shadow_debt_recharge.md) with u=6807+12288t has n=1024u−5 and S^3(n)=(2187u−7)/2>n. The shadow depths are10→7→4→10; both endpoints freeze (L,epsilon,b,D,R,n mod3,q)=(2,1,0,1,0,1,10). This excludes only the stated lower-bounded per-label polynomial size/bitlength ranks and coordinatewise lower-bounded finite lex tuples.

**Reopen with:** an unfrozen arithmetic feature, a nonpolynomial mechanism, or a different smaller-target certificate. The [positive burst theorem](lemmas/Root_Relative_Burst_Descent.md) handles a separate guarded exit and supplies no general recharge bound.


## Constructive qualification of F030

[The two-burst theorem](lemmas/Two_Burst_Recharge_Escape.md) proves strict original-root descent through a different guarded recharge mechanism, including an unbounded increase in q. F030's q10→7→4→10 family remains an exact obstruction for its stated polynomial rank class. The new theorem assumes a recharged depth divisible by3 and sufficient final halving; neither follows for F030's family. This is partial positive target selection, not a retraction of the scoped negative result.


## F031 — A fixed Thue–Morse valuation code can be lifted to a positive divergent seed

**Old blocker:** the PR6 exact `1+t_i` anchor was a valid 2-adic construction,
with positive-integer membership explicitly unresolved.

**New mechanism:** [early returns of arbitrarily long initial words](disproof/TM_Prefix_Return_Exclusion_2026-09-05.md)
force the same positive seed to violate an effective finite separation bound,
unless the orbit returns exactly to that seed. Every nonerasing encoding by
two fixed finite valuation words therefore has only periodic positive
realizations. Growth excludes even those for the old anchor and the displayed
fixed hard blocks p,q≥3.

**First falsification controls:** code both symbols by `(2)` and start at1;
this cycle must remain allowed by the general statement. The block `(1,1,3)`
at55 reaches47, so the growing hard-block specialization requires p,q≥3.

**Exact outcome:** the named code-family divergence mechanism is excluded;
Collatz itself is not. Full proof is analytic, with narrow formal arithmetic.
**Reopen only with:** a code outside the specified fixed morphic family or
a different mathematical target. No universal recurrence theorem is assumed.
