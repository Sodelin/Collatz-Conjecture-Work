# Missing-lemma ladder: from current work to an actual Collatz resolution

This is the target-first map for Round 7. It separates **formalizing what we already have** from **inventing the theorem that would actually cross the remaining gap**.

## Rung 0 — Freeze the exact endpoint

### L0.1 Accelerated/ordinary equivalence
Prove that convergence of every positive odd integer under the accelerated odd-to-odd map is equivalent to the ordinary Collatz conjecture.

### L0.2 Global descent equivalence
Prove

\[
\forall n>1\text{ odd},\;\exists k\ge1:S^k(n)<n
\iff
\text{Collatz}.
\]

**Current status:** elementary informal proof complete in `lemmas/L0_Global_Descent_Equivalence.md`; Lean pending.

This is the project's endpoint interface. Any proof route that does not terminate here must state exactly what remains.

---

## Rung 1 — Formalize the exact arithmetic substrate

### L1.1 Exact valuation-prefix affine formula

For a realized valuation word `a_0,...,a_{t-1}` prove

\[
S^t(n)=\frac{3^t n+C_t}{2^{A_t}}.
\]

### L1.2 Exact prefix-descent bound

If `2^{A_t}>3^t` and the endpoint has not descended, prove

\[
n\le C_t/(2^{A_t}-3^t).
\]

**Current status:** direct algebra recorded in `lemmas/L1_Exact_Prefix_Descent_Bound.md`; Lean pending.

### L1.3 Round-6 rational periodic lifting

Formalize exactly, including endpoint valuation, the positive-integer lift of a repeated rational periodic valuation word.

### L1.4 Same-phase scaling

Formalize exact affine scaling around the rational periodic point.

### L1.5 Round 6A β-debt theorem

Formalize the last-minimum argument with the full `k_r log_2(lambda)` bit-length contribution and floor endpoint.

**Meaning of Rung 1:** this certifies the existing obstruction technology. It does **not** by itself prove Collatz.

---

## Rung 2 — Choose a bridge architecture that can imply global descent

At least one of the following theorem families must be completed. They are intentionally different search spaces.

### Route A — Exact rewrite termination

Known literature gives an exact mixed binary/ternary string-rewriting system whose termination is equivalent to Collatz.

**Needed new object:** a well-founded interpretation/order proving termination of the full exact system.

Candidate certificate classes, in increasing flexibility:

1. natural matrix interpretations;
2. arctic/tropical interpretations;
3. polynomial or piecewise-linear interpretations;
4. lexicographic/product orders;
5. weighted automata / finite-state potentials;
6. custom interpretation carrying both binary and ternary state.

**Theorem-strength gap:** construct an interpretation that decreases on **all** required rewrite rules and is well-founded.

A failed bounded search is useful only if it produces a formal no-go theorem for that certificate class.

### Route B — Recursive residue-certificate graph

Partition positive odd integers into exact affine/congruence families. For each family, either:

- certify a finite Collatz prefix that descends below its start; or
- map the family exactly into another certified family while decreasing a separate well-founded rank.

**Needed new object:** a finite directed certificate graph plus a rank proving no unresolved infinite path.

This is not a finite-depth residue tree. Stopping times are unbounded, so a finite tree with bounded maximum depth cannot prove the conjecture. The sought object is a **finite recursive graph with back-edges controlled by a rank**.

### Route C — Augmented-state global ranking

Construct a well-founded potential on a richer state than the integer alone, for example

\[
\Phi(n,q,\text{radix state},\text{carry state},\ldots),
\]

such that an exact macro-step always decreases `Phi`.

Round 5A–6B make simple corrected-log state-only/small-sensor potentials unattractive: a successful ranking must carry enough global/nonuniform information to survive periodic-shadow stress.

**Needed new object:** a non-circular computable state augmentation and a strict well-founded decrease theorem.

### Route D — Minimal-counterexample valuation forcing

Assume a least nonterminating odd `n_*`. L0 forces every iterate to remain at least `n_*`. L1 then gives an exact upper bound from every multiplicatively contracting valuation prefix.

**Needed bridge lemma:** prove that the single positive-integer orbit of `n_*` must eventually realize a prefix whose L1 upper bound contradicts the certified lower bound on `n_*`.

This must use more than arbitrary finite 2-adic word realizability, because periodic-shadow constructions show that extremely bad finite prefixes exist at arbitrarily large depths.

A candidate bridge that merely says “eventually the average valuation exceeds log_2 3” is essentially the unresolved problem unless supplied with a new arithmetic mechanism.

### Route E — Disproof: finite cycle certificate

Search a valuation word whose rational cycle point is an actual positive integer and whose orbit avoids `1`.

**Needed certificate:** explicit integer cycle values or equivalent exact divisibility conditions, then Lean checks every transition.

Large finite search without a witness has no bearing on truth.

### Route F — Disproof: invariant divergent set

Find an explicitly defined set `A` of positive integers and a rank/size function such that

- `A` is nonempty;
- `S(A) subset A`;
- every orbit in `A` avoids `1`;
- a rigorous monotone/unbounded property rules out periodic return to `1`.

**Needed certificate:** actual positive-integer membership and invariance, not merely a rational or 2-adic ghost orbit.

---

## Rung 3 — Search-space compression

The new strategy is to search for **small proof certificates**, not arbitrary prose proofs.

### Certificate class 1: finite rewrite interpretation
A finite table/matrix/polynomial object satisfying finitely many inequalities.

### Certificate class 2: recursive residue graph
A finite graph of residue/affine states plus finitely many exact transition proofs and a rank.

### Certificate class 3: minimal-counterexample exclusion engine
A finite collection of symbolic transforms showing that every unresolved residue family eventually maps to a family with a smaller certified parameter or an L1 contradiction.

### Certificate class 4: disproof witness
A finite cycle or finite invariant-generator description.

Each class can be enumerated/synthesized with code. The mathematics then consists of (i) proving the certificate semantics once and (ii) checking a finite certificate.

---

## Rung 4 — Formal certificate semantics in Lean

Before trusting a machine-discovered certificate, Lean should prove general soundness theorems:

### Rewrite route
`InterpretationCertificate -> Termination exactRewriteSystem -> GlobalDescent -> Collatz`.

### Residue-graph route
`ValidResidueGraphCertificate C -> GlobalDescent -> Collatz`.

### Cycle route
`ValidPositiveCycleCertificate C -> not Collatz`.

### Divergence route
`ValidInvariantDivergenceCertificate C -> not Collatz`.

Once these checker theorems exist, SAT/Python/LLM search becomes untrusted certificate generation. Lean checks only the finite result.

---

## Rung 5 — Candidate resolution audit

A complete candidate chain then receives three independent checks:

1. **Mathematical hostile audit:** derive from scratch and try to falsify each joint.
2. **Semantic Lean audit:** verify the formal theorem is exactly Collatz or its exact negation, not a weakened/altered statement.
3. **Kernel/toolchain audit:** patched Lean, clean rebuild, axiom audit, independent replay/checker.

Only after all three should the repository status move to `PROOF_CANDIDATE` or `DISPROOF_CANDIDATE`.

---

# Current best search allocation

| Priority | Route | Why |
|---|---|---|
| 1 | B — recursive residue-certificate graph | Directly operationalizes the partition idea while avoiding the bounded-depth trap; finite certificate may be synthesizable. |
| 1 | A — exact rewrite termination | Exact equivalence already exists in peer-reviewed work and converts the problem into finite certificate synthesis. |
| 2 | D — minimal-counterexample valuation forcing | L0/L1 make the missing arithmetic bridge explicit and testable. |
| 2 | C — augmented-state ranking | May unify A/B and can absorb the distributed-debt lessons of Round 6. |
| 3 | E/F — disproof lanes | Cheap to keep alive; any explicit witness ends the problem immediately. |
| blocked unless new mechanism | simple state-only corrected-log / finite-sensor ranking | Rounds 5A–6B already expose sharp/periodic obstructions; do not repeat without a qualitatively new information source. |

The purpose of the ladder is not to claim that the remaining search is small in an absolute sense. It is to make every search branch terminate in a **finite, auditable mathematical object** rather than an unbounded cloud of arguments.
