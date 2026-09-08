# Collatz Round 6B
## Terminal finite-sensor approximation barriers and nonuniformity of infinite 2-adic sensor rankings

**Private research/audit continuation - 2026-08-01**  
**Branch:** 6B, terminal consolidation after Round 6A  
**Normalization:** accelerated odd-to-odd Collatz map  
**Status:** no proof or disproof of the Collatz conjecture; no certified novelty claim  
**Purpose:** attempt one final natural extension of Round 6A, then stop theorem generation and decide what is worth showing a human specialist.

Throughout, `log` is natural logarithm and `log_2` is base-2 logarithm.

---

# 0. Executive summary / decision brief

## Main answer

Round 6B attempted the most natural unresolved direction left by Rounds 5A, 5B, and 6A: allow **infinitely many 2-adic sensors** rather than one or finitely many, while imposing enough structure that the ranking is not simply an arbitrary state-by-state lookup table.

The useful result is an approximation theorem, not another fundamentally new Collatz mechanism.

Suppose

`V(n) = alpha log n + R(n)`

is claimed to satisfy a universal descent guarantee by `floor(beta log_2 n)` accelerated steps for every sufficiently large positive odd integer, with `0 < beta < 1`.

Round 6A established that on every repelling rational periodic stress orbit of length `m`, total valuation `A`, and multiplier

`lambda = 3^m / 2^A > 1`

with `beta < m/A`, the correction must acquire linearly growing same-phase debt. Writing

`eta_(beta,O) = (m - beta A) / (m + beta log_2 lambda)`,

Round 6A gives the necessary rate

`liminf Delta_r / r >= alpha log(lambda) eta_(beta,O)`.

Round 6B asks what this implies if `R` is approximated by a simpler surrogate `G` which is **phasewise frozen** on the selected periodic shadow. Let

`e_r = max_j |R(n_j) - G(n_j)|`

on an `r`-period positive shadow. Since the frozen surrogate contributes no same-phase debt,

`Delta_r <= 2 e_r`.

Therefore a universal beta-log ranking must satisfy

`liminf e_r / r >= (alpha log(lambda)/2) eta_(beta,O)`.

This is the **finite-sensor approximation-gap theorem**.

For the explicit high-period family `w_m = (2,1,...,1)`, the normalized lower bound converges to

`rho_beta / 2`,

where

`rho_beta = (1-beta)/(1 + beta log_2(3/2))`

is exactly the inverse sharp frontier independently obtained in Round 5A.

Thus a successful universal fast ranking cannot merely use infinitely many sensors in a uniformly convergent or uniformly small way. Every finite truncation must leave a residual whose magnitude becomes **Omega(log N)** on some high-period ghost shadows.

## Highest-leverage results

| Result | Correctness status | Priority status | Meaning |
|---|---|---|---|
| 6B.1 finite-sensor approximation-gap theorem | complete deduction from 6A.1 + phase freezing; executable checks | exact formulation not located | quantitative distance from every phase-frozen surrogate |
| 6B.2 finite-center + sublog residual obstruction | complete corollary | exact formulation not located; likely immediate | finitely many arbitrary sensors cannot be rescued by `o(log n)` residual structure |
| 6B.3 countable sensor-tail nonuniformity | complete corollary | exact formulation not located | every finite prefix of an infinite sensor expansion must leave log-scale stress error somewhere |
| 6B.4 uniformly convergent infinite-sensor obstruction | complete corollary | low novelty; functional-analytic closure statement | uniformly summable sensor expansions are still too weak |
| w_m normalized approximation gap tends to `rho_beta/2` | elementary limit | candidate synthesis, not major independent theorem | connects 5A sharpness to 6A distributed debt quantitatively |
| Collatz conjecture | unchanged | not applicable | none of these results proves convergence |

## Decision

**Round 6B should not replace Round 6A in a message to a specialist.**

Round 6A is closer to the mathematical core: rational periodic lifting, the quantitative beta-debt law, and the distributed critical-debt coefficient. Round 6B is a useful final corollary showing what 6A means for structured infinite-sensor rankings, but it is one abstraction farther from the original observation.

**Recommended communication:** send the **Round-6A Expert Audit Brief**, not the full 6A dossier and not the 6B dossier. If the specialist finds the 6A result interesting, 6B can be supplied later as an optional addendum.

Evidence bands:

- **Correctness:** high for the 6B deductions conditional on 6A.1; the proofs are short and transparent.
- **Usefulness:** moderate; it clarifies what “infinitely many sensors” would actually have to do.
- **Novelty:** low-to-moderate confidence; exact wording was not located, but the theorem is an elementary consequence of prior rounds rather than a new dynamical phenomenon.
- **Collatz relevance:** indirect architecture-level only.

---

# 1. Abstract

Rounds 5A and 5B expose two opposing facts about corrected-log Collatz ranking functions. Round 5A shows that unrestricted state-only corrections have enough coding capacity to realize arbitrary profiles on individual deterministic Mersenne skeletons and to attain the sharp one-sided debt/tail frontier. Round 5B shows that one or finitely many fixed 2-adic distance sensors are globally insufficient because repelling rational periodic shadows freeze those features phase-by-phase. Round 6A connects these facts quantitatively: any universal descent guarantee by `beta log_2 n` accelerated steps forces linear same-phase correction debt on every repelling rational periodic stress orbit with coefficient `m/A > beta`.

Round 6B studies the intermediate possibility of a ranking assembled from infinitely many structured 2-adic sensors. The main theorem is an approximation barrier. If `G` is any correction model which is phasewise frozen on a chosen rational periodic shadow and `R` differs from `G` by at most `e_r` on that shadow, then the same-phase debt of `R` is at most `2 e_r`. Combining this with the Round-6A debt necessity yields a linear lower bound on `e_r`. Hence a universal fast ranking must remain a logarithmic-scale distance from every finite-sensor surrogate on some sufficiently expansive periodic shadows.

For the high-period family `w_m=(2,1^{m-1})`, the normalized approximation-gap lower bound converges to one half of the Round-5A inverse sharp frontier. As consequences, no correction of the form “finite 2-adic sensor model plus globally sublogarithmic residual” can satisfy universal fixed-fraction descent, and no countable sensor expansion with uniformly convergent tails can do so. More generally, every finite truncation of a successful countable sensor expansion must leave a residual with linear-in-shadow-depth amplitude on suitable periodic stress families.

The periodic Collatz machinery is prior art. The approximation-gap packaging was not found in a targeted search but is best regarded as a terminal synthesis/corollary unless specialist review establishes independent significance.

---

# 2. Introduction

## 2.1 Why one more round

The previous branch suggested studying corrections such as

`R(n) = sum_j a_j F_j(v_2(n-z_j))`

with infinitely many centers. This is the first natural class that could plausibly evade the finite-center obstruction while remaining more structured than the arbitrary state coding permitted by 5A.

There are two possibilities:

1. an infinite sensor expansion with well-controlled tails still behaves essentially like a finite sensor model and is obstructed; or
2. successful fast descent requires the infinite tail itself to remain macroscopically important on deeper and deeper periodic stress shadows.

Round 6B proves the second alternative as a necessary condition.

## 2.2 Baseline from 6A

Fix a repelling rational periodic valuation word `O` with:

- length `m`;
- total valuation `A`;
- real multiplier `lambda = 3^m/2^A > 1`.

For a depth-`r` positive integer lift, let the last global minimizer of

`V(n)=alpha log n+R(n)`

occur at index

`j_r = i_r + k_r m`.

If universal descent is promised by `beta log_2 n`, with `beta < m/A`, Round 6A derives

`liminf k_r/r >= eta_(beta,O)`

where

`eta_(beta,O) = (m-beta A)/(m+beta log_2 lambda)`.

The same-phase growth inequality then yields

`liminf Delta_r/r >= c_(beta,O)`

with

`c_(beta,O) = alpha log(lambda) eta_(beta,O) > 0`.

This is the only nontrivial imported theorem used by the main 6B result.

---

# 3. Method

Round 6B used four tracks.

1. **Approximation reduction.** Replace the correction by a simpler phase-frozen surrogate plus an error term and determine how much debt the error can generate.
2. **Finite-center specialization.** Use the 5B freezing theorem to apply the abstract approximation result to arbitrary functions of finitely many rational 2-adic distance sensors.
3. **Infinite-series stress test.** Treat finite partial sums as finite-sensor surrogates and derive a necessary nonuniformity condition on every tail.
4. **Priority check.** Search Collatz ranking-function literature, ghost-cycle/Presburger work, program-termination periodic-orbit work, and p-adic locally constant approximation theory for an antecedent of the quantitative approximation-gap statement.

The executable checker tests the debt/error inequality, the coefficient algebra on 3,000 random repelling parameter sets, the `w_m` half-frontier limit, a finite-sensor plus sublogarithmic residual example, and a uniformly summable infinite-sensor toy expansion.

No finite computation is used to prove a universal theorem.

---

# 4. Findings

## 4.1 Lemma 6B.1 - phase-frozen approximation controls debt

Consider a finite periodic shadow

`n_0, n_1, ..., n_(rm)`

with period `m` in phase labels. Let `G` be any real-valued model satisfying

`G(n_(i+km)) = G(n_i)`

for every displayed same-phase return.

Write

`R(n_j)=G(n_j)+E(n_j)`

and define

`e_r=max_j |E(n_j)|`.

For each phase `i`,

`R(n_i)-R(n_(i+km)) = E(n_i)-E(n_(i+km))`.

Therefore

`R(n_i)-R(n_(i+km)) <= 2 e_r`.

Taking the maximum downward same-phase debt gives

`Delta_r <= 2 e_r`.

This factor `2` is sharp for the information used: one can take the residual to be `+e_r` at the first phase occurrence and `-e_r` at a later occurrence.

## 4.2 Theorem 6B.2 - quantitative finite-sensor approximation gap

Assume the universal beta-log descent hypothesis of Round 6A and fix a repelling rational periodic orbit `O` with `beta < m/A`.

Let `G_r` be any surrogate which is phasewise frozen on the displayed depth-`r` shadow, and put

`e_r=max_j |R(n_j)-G_r(n_j)|`.

Round 6A gives

`liminf Delta_r/r >= c_(beta,O)`

with

`c_(beta,O)=alpha log(lambda) (m-beta A)/(m+beta log_2 lambda)`.

Lemma 6B.1 gives `Delta_r <= 2 e_r`. Hence

`liminf e_r/r >= c_(beta,O)/2`.

Equivalently,

`liminf e_r/r >= (alpha log(lambda)/2) * (m-beta A)/(m+beta log_2 lambda)`.

### Interpretation

A successful beta-log corrected-log ranking cannot be approximated to sublinear error by any model that becomes phasewise constant on the stress orbit.

This is an approximation-separation theorem rather than a new Collatz trajectory theorem.

## 4.3 Corollary 6B.2a - finite 2-adic sensors plus residual

Fix rational 2-adic centers

`Z={z_1,...,z_s}`

and define

`D_Z(n)=(v_2(n-z_1),...,v_2(n-z_s))`.

Let

`G(n)=Phi(D_Z(n))`

for an arbitrary function `Phi`.

Choose a repelling `w_m` periodic orbit which avoids every center. A sufficiently deep positive lift freezes each component of `D_Z` phase-by-phase, hence freezes `G`.

If

`R(n)=G(n)+E(n)`,

then a universal beta-log descent theorem forces

`max_shadow |E| = Omega(r)`

on this periodic family, with the explicit coefficient of Theorem 6B.2.

In particular, if

`|E(n)|=o(log n)` globally,

then universal beta-log descent is impossible. On a fixed periodic word, all displayed positive shadow states have logarithmic size `Theta(r)`, so the global sublogarithmic assumption gives `max_shadow |E|=o(r)`, contradicting the approximation gap.

Thus finitely many completely arbitrary, even unbounded, 2-adic sensors cannot be repaired by a sublogarithmic residual.

## 4.4 Corollary 6B.2b - the high-period half-frontier

For

`w_m=(2,1,...,1)`

one has

`A=m+1`

and

`lambda_m=3^m/2^(m+1)`.

Round 6A defines the normalized debt requirement `Q_(beta,m)` and proves

`Q_(beta,m) -> rho_beta`

where

`rho_beta=(1-beta)/(1+beta log_2(3/2))`.

Because approximation error need only generate debt through the inequality `Delta_r <= 2 e_r`, the normalized 6B approximation gap tends to

`rho_beta/2`.

Concretely,

`liminf e_r / [alpha r m log(3/2)] >= Q_(beta,m)/2`,

and therefore

`lim_(m->infinity) Q_(beta,m)/2 = rho_beta/2`.

This “half frontier” is not a new dynamical constant. The factor one half comes solely from converting a symmetric sup-norm approximation error into a one-sided debt bound.

## 4.5 Theorem 6B.3 - countable sensor-tail nonuniformity

Consider a pointwise expansion

`R(n)=sum_(j>=1) H_j(n)`

where every component `H_j` depends on only finitely many rational 2-adic distance sensors.

For a fixed truncation `J`, let

`G_J(n)=sum_(j=1)^J H_j(n)`

and

`T_J(n)=R(n)-G_J(n)`.

The union of the sensor centers used by the first `J` components is finite. For every `beta<1`, choose `m` sufficiently large such that:

1. `m/(m+1)>beta`; and
2. the `w_m` periodic orbit avoids all centers used by `G_J`.

Then `G_J` freezes phasewise on sufficiently deep positive lifts. Theorem 6B.2 therefore forces

`liminf_(r->infinity) max_shadow |T_J|/r >= c_(beta,w_m)/2 > 0`.

### Meaning

For **every finite truncation**, the remaining infinite tail must regain macroscopic size on some high-period periodic stress family.

A successful infinite-sensor ranking cannot behave like a convergent refinement in which later sensors become uniformly negligible.

## 4.6 Corollary 6B.3a - uniformly convergent infinite sensor expansions fail

If the sensor series converges uniformly on the positive odd integers, then for each sufficiently large `J`,

`sup_n |T_J(n)| < infinity`

and indeed can be made arbitrarily small.

That contradicts Theorem 6B.3, which requires `max_shadow |T_J|` to grow linearly with `r` on a suitable stress family.

Therefore no uniformly convergent infinite sum of finite-sensor corrections can satisfy universal beta-log descent.

A convenient sufficient special case is

`sum_j ||H_j||_infinity < infinity`.

This gives a uniformly convergent sensor expansion and is therefore obstructed.

## 4.7 Corollary 6B.3b - no bounded-residual completion of a finite sensor model

A stronger and simpler statement is often enough.

If for some finite-sensor model `G`

`sup_n |R(n)-G(n)| < infinity`,

then universal beta-log descent is impossible for every fixed `beta<1`.

This includes uniform finite-sensor approximability as a special case.

## 4.8 What the theorem does not exclude

Round 6B does **not** rule out all infinite sensor constructions.

A surviving candidate could have sensor tails which:

- converge only pointwise, not uniformly;
- create logarithmic-scale residual amplitude on deeper stress families;
- use centers accumulating throughout the relevant 2-adic periodic structure;
- couple sensors nonadditively;
- use state information not expressible as a distance-feature expansion;
- depend on history/path rather than current state;
- use a non-real-valued well-founded ranking.

The theorem says only that the infinite tail cannot become uniformly negligible.

---

# 5. Conclusion

Round 6B does not produce a new route toward proving Collatz. It closes one architectural loophole left by Round 6A.

The progression is now:

- **5A:** unrestricted state-only coding can saturate the local debt frontier;
- **5B:** finite localized 2-adic sensing is globally insufficient;
- **6A:** universal beta-log descent requires explicit linear debt on every sufficiently expansive periodic stress orbit;
- **6B:** therefore any finite-sensor approximation to a successful correction must fail by logarithmic-scale error on some such stress orbit, and an infinite sensor expansion must have nonuniformly significant tails.

This is a coherent end point for the present exploration. Further rounds would increasingly classify artificial function classes rather than clarify the original mathematical observation.

The strongest human-facing result remains Round 6A, not Round 6B.

---

# 6. Deconstructive analysis

## 6.1 What 6B actually adds

The dynamical ingredient is inherited. The only new mathematical move is

`phase frozen surrogate + sup error e  =>  same-phase debt <= 2e`.

Everything else follows by combining this with Round 6A's quantitative debt requirement.

That makes 6B unusually easy to audit, but it also lowers its likely publication significance.

## 6.2 Why the result is still useful

The result answers a natural objection to finite-center theorems:

> “What if we just add infinitely many centers?”

The answer is not “that still fails.” The correct answer is more precise:

> It can only work if the infinite tail never becomes uniformly negligible; some tail must keep producing log-scale variation on deeper periodic stress families.

That is a genuine design constraint.

## 6.3 Where another round would go

One could now classify nonuniform expansions, weighted sensor trees, van der Put-type series, definable function classes, or complexity restrictions.

That is mathematically possible but increasingly remote from the original question of whether the initial Collatz observation was useful or prior art.

For that reason Round 6B recommends stopping.

---

# 7. Reconstructive analysis

The abstract skeleton is independent of Collatz.

Suppose a system has:

1. arbitrarily long finite trajectories shadowing a periodic orbit;
2. same-phase growth by a multiplier `lambda>1`;
3. a universal descent horizon forcing a minimum to occur a linear fraction into the shadow;
4. a resulting linear debt lower bound `Delta_r >= c r + o(r)`.

If a surrogate ranking correction is constant on same-phase returns and approximates the true correction with error `e_r`, then automatically

`Delta_r <= 2e_r`.

Therefore

`e_r >= (c/2)r + o(r)`.

The Collatz content supplies the periodic shadows and the explicit coefficient. The approximation lemma is a general finite-sequence fact.

---

# 8. Middle-out synthesis and priority

## 8.1 Prior art that clearly remains prior art

The following are not Round-6B contributions:

- rational Collatz cycles and affine valuation-word formulas;
- periodic 2-adic points;
- positive finite-word lifts;
- Mersenne blocks and `nu_2(n+1)` countdown;
- `lambda 2^a 3^b - 1` skeleton coordinates;
- ghost-cycle terminology;
- finite-state/Presburger proof-architecture obstructions;
- density of locally constant functions in standard spaces of continuous p-adic functions.

## 8.2 Closest located literature

- J. C. Lagarias (1990), *The set of rational cycles for the 3x+1 problem*, Acta Arithmetica 56, 33-53. DOI 10.4064/aa-56-1-33-53.
- D. J. Bernstein and J. C. Lagarias (1996), *The 3x+1 conjugacy map*, Canadian Journal of Mathematics 48, 1154-1169. DOI 10.4153/CJM-1996-060-x.
- T. Urata (2003), *The Collatz Problem over 2-adic Integers*, Bulletin of Aichi University of Education 52, 5-11.
- E. Yolcu, S. Aaronson, and M. J. H. Heule (2023), *An Automated Approach to the Collatz Conjecture*, Journal of Automated Reasoning 67, article 15. DOI 10.1007/s10817-022-09658-8.
- S. R. Campbell (2025), *Mersenne Block Dynamics: A Framework for the Collatz Conjecture*. Zenodo DOI 10.5281/zenodo.17971540.
- M. Dhiman and R. Pandey (2026), *2-Adic Obstructions to Presburger-Definable Characterizations of Collatz Cycles*, arXiv:2601.12772.
- K. Knight (2026), *Collatz high cycles do not exist*, Discrete Mathematics 349(3), 114812. DOI 10.1016/j.disc.2025.114812.
- J. Williams (2026), *A Coordinate System for Collatz Dynamics*, arXiv:2607.01718.
- Standard p-adic analysis: locally constant functions form a dense subspace of continuous functions on `Z_p` (van der Put basis / standard p-adic functional analysis).

## 8.3 Priority verdict

A targeted search did not locate the exact quantitative statement

`universal beta-log ranking => logarithmic-scale distance from every finite-sensor surrogate on some repelling periodic shadow`.

However, this is a short corollary of Round 6A plus finite-center freezing. Its likely scientific value is therefore as **interpretation and closure**, not as a separate major discovery.

Priority confidence should remain lower than correctness confidence.

---

# 9. Glossary

**Finite-sensor correction.** A function depending arbitrarily on finitely many features `v_2(n-z_j)` for fixed rational 2-adic centers.

**Phase-frozen surrogate.** A correction model whose value is constant on every repetition of the same phase along a selected periodic shadow.

**Approximation error `e_r`.** Maximum absolute difference between the true correction and a phase-frozen surrogate on a depth-`r` shadow.

**Same-phase debt.** Maximum drop of the correction from the first occurrence of a phase to a later same-phase occurrence.

**Approximation gap.** The necessary lower bound on `e_r` imposed by the debt requirement.

**Countable sensor-tail nonuniformity.** The requirement that no finite truncation of an infinite sensor representation can leave a uniformly negligible residual on all high-period stress families.

---

# 10. Bibliography

See Section 8.2. Round 6B does not add a large independent bibliography because its mathematics is downstream of Round 6A.

---

# 11. Metacognitive reflection I: process integrity

**Process-integrity score: 8.8/10 for a private terminal audit.**

Strengths:

- The round began with a predeclared narrow target: test an infinite-sensor extension rather than freely generate more theorem families.
- The new theorem is explicitly reduced to one elementary inequality plus the already-audited Round-6A debt theorem.
- The computational suite tests the coefficient algebra and the factor-of-two approximation conversion separately.
- The result is deliberately classified as a corollary-level synthesis despite phrase-search novelty.
- The final reporting recommendation prefers the earlier, less abstract Round-6A brief.

Limitations:

- Round 6B inherits any undiscovered error in Round 6A's rational periodic lifting or beta-debt theorem.
- No proof assistant has verified the inherited theorem.
- No specialist has yet judged whether the approximation interpretation is standard in ranking-function/termination theory.
- Search terms evolved throughout earlier rounds, so the overall research program is exploratory rather than preregistered.

**AMSTAR-2-style qualitative verdict:** strong internal audit discipline for exploratory mathematics; inadequate for certifying novelty.

---

# 12. Metacognitive reflection II: robustness

## Correctness

The new 6B implication has a very small dependency graph:

1. Round 6A gives `Delta_r >= c r + o(r)`.
2. A frozen surrogate gives `Delta_r <= 2e_r`.
3. Therefore `e_r >= (c/2)r + o(r)`.

The main mathematical uncertainty is therefore not inside 6B. It remains upstream in rational periodic lifting and the universal beta-debt coefficient.

## Novelty

Novelty confidence is modest. The approximation-gap formulation was not located, but it is short enough that specialists may regard it as immediate once the debt theorem is known.

## What would change the verdict

- A counterexample to Round 6A.1 would invalidate most of 6B.
- A prior theorem in termination/ranking theory subsuming phase-frozen approximation barriers would erase most priority significance.
- A specialist independently reconstructing 6A.1 would materially strengthen the entire chain.

## Final robustness verdict

**Keep 6B as a private terminal addendum. Do not make it the primary human-facing packet.**

---

# 13. Zotero / Obsidian integration

Suggested Obsidian note:

`[[Collatz - Finite Sensor Approximation Barrier]]`

Relations:

- `[[Round 5A Sharp Debt-Tail Frontier]]` -> local extremal constant.
- `[[Round 5B Finite-Center Ghost Stress]]` -> phase-frozen surrogates.
- `[[Round 6A Distributed Critical Debt]]` -> quantitative debt lower bound.
- `[[Round 6B Sensor-Tail Nonuniformity]]` -> approximation consequence.

Suggested tags:

`#collatz #2-adic #ranking-function #approximation-barrier #ghost-cycle #finite-sensor #infinite-sensor #termination #priority-unverified`

Status fields:

- `correctness: candidate-high`
- `priority: exact-form-not-located`
- `human_reconstruction: pending`
- `collatz_resolution: no`
- `recommended_for_initial_expert_email: no`

---

# 14. Appendix: reproducibility and final communication decision

## 14.1 Executable checks

The accompanying `collatz_round6b_checks.py` reports:

- PASS A: phase-frozen surrogate implies debt at most twice sup approximation error;
- PASS B: approximation-gap coefficient algebra on 3,000 random repelling parameter sets;
- PASS C: normalized `w_m` approximation gap converges to `rho_beta/2`;
- PASS D: finite-sensor plus representative sublog residual has sublinear same-phase debt;
- PASS E: a uniformly summable infinite-sensor series is uniformly approximable by finite-sensor prefixes.

Final line:

`ALL ROUND-6B CHECKS PASSED`

## 14.2 Independent audit order

An auditor should:

1. Verify Round 6A.1 independently first.
2. Prove `Delta_r <= 2 e_r` without trusting this dossier.
3. Check the factor `1/2` is unavoidable under symmetric sup error.
4. Re-derive the `w_m` normalized limit.
5. Verify finite-center freezing when the centers are extremely close to cycle phases but not equal.
6. Check the uniformity step for a global `o(log n)` residual.
7. Determine whether an abstract ranking-function approximation theorem already subsumes 6B.

## 14.3 Final communication recommendation

If only one follow-up is sent to the human expert who already received Round 2:

**Send Round 6A's 4-page Expert Audit Brief.**

Do not send both full dossiers. Do not send 6B instead of 6A.

A minimal message should frame the attachment as an uncertain follow-up and ask whether the result is useful or already known. The point is to reduce the recipient's burden, not to transmit the entire exploratory tree.

