---
node_id: PRIMARY-BRIDGE-AUDIT-2026-09-05
node_type: source
routes: [B, C, F]
tags: [collatz, primary-source-audit, quantifiers, invariant-measures]
---

# Primary-paper closure audit: two 2026 Collatz papers

**Verdict:** Neither paper supplies the missing universal Collatz bridge. One
provides a valid restriction on how full reachability can be encoded. The other
retains unproved orbitwise assumptions and contains two exact, independently
diagnosable errors in statements advertised as central progress. These findings
do not prove or disprove Collatz.

**Primary access:** alphaXiv raw PDF page retrieval, followed by raw full-text
retrieval for Chang. AI intermediate reports were not used. Source links, versions and page locations below identify the audited text;
full copyrighted extracts are not redistributed with this note. This is a selective load-bearing
audit, not a review of every claim in the 230-page Chang document.

## 1. Dhiman–Pandey: a valid reachability obstruction with limited transfer

Source: Madhav Dhiman and Rohan Pandey, *Non-Definability of Reachability in
Büchi Arithmetic for a Family of Generalized Collatz Maps*,
[arXiv:2602.06066v2](https://arxiv.org/abs/2602.06066v2), June 26, 2026.
Theorem 2 and proof: PDF pages 6–7; definitions and supporting lemmas: pages 3–6.

The exact map is the shortcut map

$$
T_{q,d}(n)=\begin{cases}n/2&n\text{ even},\\(qn+d)/2&n\text{ odd},\end{cases}
$$

for odd `q>=3,d>=1` satisfying `q+d=2^s`. The theorem says that the full
unparameterized relation

$$
R(x,z)\iff\exists k\ge0:T_{q,d}^k(x)=z
$$

is not first-order definable in `BA_q=<N,+,V_q>`, equivalently not recognized
by a synchronous automaton on base-q representations. **It includes `q=3,d=1`
unconditionally.** It does not assume classical Collatz convergence.

The proof is sound on inspection: the orbit of 1 is a cycle consisting only
of powers of 2. If R were definable, a first-order extraction using its
reachable-floor relation would define exactly the powers of 2. Cobham's theorem
rules out recognizing that set in any base multiplicatively independent of 2.
The argument correctly conditions the reverse inclusion on `R(x,1)` and never
assumes that every positive input reaches 1.

### What it does not rule out

It does not rule out a finite guarded transition graph equipped with an
unbounded natural rank, auxiliary integer parameters, or a separately proved
well-founded order. A finite presentation of individual transitions is not an
automaton recognizing their entire transitive closure.

The following exact countermodel makes the distinction decisive. Define

$$
H(n)=\begin{cases}n/2&n\text{ even},\\1&n\text{ odd}.\end{cases}
$$

There is a two-rule termination certificate with rank `n`: for every `n>1`,
`H(n)<n`. Both guards and updates are Presburger-definable. Nevertheless,
the full reachability relation of H is not base-3 Büchi-definable. If it were,
the formula

$$
x>0\quad\land\quad\forall z\,[R_H(x,z)\Rightarrow(\operatorname{Even}(z)\lor z=1)]
$$

would define precisely the powers of 2: powers of 2 only visit powers of 2,
whereas any other positive integer visits its odd part greater than 1.
Cobham supplies the same contradiction. Therefore transferring the paper's
result into a ban on ranked finite certificates is mathematically false.

**Correct transfer to repository Route B:** reject proposals requiring an exact
base-3 synchronous automaton for full R. Keep finite guarded graphs with
unbounded parameters and independently proved ranks available. Adding a rank
escapes the representational prohibition; it still has to be constructed and
proved for Collatz.

There is also a false explanatory aside on PDF pages 3 and 7: multiplication
by a fixed q is claimed unrecognizable in base 2. In fact `y=qx` is definable
with q-fold addition in Presburger arithmetic, hence recognizable in every
integer base. The one-step Collatz relation is likewise Presburger-definable.
This aside does not invalidate the main full-reachability proof.

## 2. Chang: the strongest stated route remains conditional

Source: Edward Y. Chang, *Exploring Collatz Dynamics with Human-LLM
Collaboration*, [arXiv:2603.11066v6](https://arxiv.org/abs/2603.11066v6),
April 22, 2026. The relevant source sections are Hypothesis 8.3,
Theorems 8.14/8.16, Remarks 8.15/9.11/9.16, Proposition 9.9,
Conjecture 10.14, Appendix F.2, and the spectral discussion near PDF page 179.

Theorem 8.16 requires both a Weak Mixing Hypothesis and orbitwise tail
vanishing. Remark 8.15 expressly leaves that tail step unproved. In addition,
the footnote to Theorem 8.1 states that the claimed Cesàro mean limit does not
yet imply its required uniformly bounded additive discrepancy. Thus even
granting the proposed mixing input would not license silently dropping these
other conditions.

The alternate Carry Independence Conjecture, Conjecture 10.14, requires every
individual positive integer to leave an infinite compatibility tower. The
paper itself identifies this as the remaining Collatz-strength pointwise
question. Cylinder thinning and finite word searches do not establish it.

### 2a. Exact collapse of the advertised weaker mixing condition

Hypothesis 8.3 defines, for every depth K,

$$
\delta_K(n)=\limsup_{N\to\infty}
\operatorname{TV}(\mu_{K,N},u_K),
\qquad \sum_{K\ge3}\delta_K(n)<0.557.
$$

Here `mu_{K,N}` is the orbit's empirical distribution modulo `2^K`, and `u_K`
is the uniform law on the odd residues. Projection between depths sends both
laws to their lower-depth counterparts. Total variation contracts under
projection, so

$$
\delta_{K+1}\ge\delta_K\ge0.
$$

The paper itself proves this monotonicity in Proposition 9.9. Consequently,

$$
\boxed{\sum_{K\ge3}\delta_K<\infty
\iff\delta_K=0\text{ for every }K\ge3.}
$$

Indeed, any positive value at depth J lower-bounds every subsequent summand
by that same positive value. This makes the sum diverge.

Therefore the stated WMH is exact equidistribution at every fixed depth. Its
numeric tolerance of 0.557 does not permit any nonzero asymptotic discrepancy.
It is not the claimed strictly weaker tolerance hypothesis.

Moreover, as Conjecture 8.2 is written, fixed-depth convergence is equivalent
to the existence of some depth `M(N)->infinity` at which TV tends to zero.
For the nontrivial direction, choose strictly increasing thresholds `N_j` such that
for every `N>=N_j`, the depth-j error is at most `1/j`, then set `M(N)` to the
largest j whose threshold has passed. The reverse direction is projection.
Thus the displayed OEC and WMH are equivalent under their definitions; an
extra prescribed quantitative growth rate for M could change that comparison,
but none is present in the stated existential formulation.

There is a second scope issue the paper later acknowledges: for any known
convergent Syracuse orbit, the empirical limit is the point mass at 1, so

$$
\delta_K=1-2^{1-K},
$$

and the sum diverges. This immediately refutes the literal universal
all-odd-start formulation. Remarks 9.11 and 9.16 instead apply the intended
condition only to hypothetical nonconvergent orbits. That repair avoids the
trivial counterexample but leaves an unproved pointwise assumption and the
OEC/WMH equivalence above.

### 2b. A non-Haar, non-atomic invariant measure exists explicitly

The discussion around PDF page 179 and the v13 summary on page 228 retains a
claim that Haar measure is the unique non-atomic Syracuse-invariant Borel
probability measure on the odd 2-adic integers. The summary labels uniqueness
as proved. That asserted uniqueness conclusion is false. Proposition C.48
itself is conditional on a uniform spectral gap: the counterexample below
refutes the asserted conclusion as a property of the map, without separately
establishing or refuting that conditional statement's antecedent.

Here is a constructive counterexample, requiring no numerical experiment.
Take independent fair random variables `v_0,v_1,...` in `{1,2}`, put `S_0=0`
and `S_j=v_0+...+v_{j-1}`, and define in the 2-adic integers

$$
x(v)=-\sum_{j\ge0}\frac{2^{S_j}}{3^{j+1}}.
$$

The series converges because `S_j>=j`. Its first term is odd and all later
terms are even, so x is odd. Direct reindexing gives

$$
3x(v)+1=2^{v_0}x(\operatorname{shift}v).
$$

The right-hand successor is odd, so its valuation is exactly `v_0`, and hence

$$
U(x(v))=x(\operatorname{shift}v).
$$

Agreement of the first j exponents fixes x modulo `2^j`, so the coding
is continuous and Borel measurable. Its invariant support avoids `-1/3`,
where U is undefined, and every orbit that hits that singular point: all
its successive valuations are exactly 1 or 2. Equivalently, extend U
arbitrarily on the exceptional points, which have measure zero here.

Push forward the Bernoulli probability measure through x. Shift invariance
gives a Syracuse-invariant measure. The map is injective because the entire
valuation sequence can be recovered from its iterates, so the measure is
non-atomic. Yet it assigns probability zero to valuations at least 3, whereas
normalized Haar measure on odd 2-adics assigns that event probability 1/4.
The two invariant measures are different.

This does not produce a positive divergent orbit: it is an invariant-measure
counterexample on the 2-adic domain. It blocks importing the asserted
non-atomic uniqueness as a proved ingredient in a positive-integer convergence
argument. The proposed projection step also needs justification: an
invariant measure for U need not give the higher-bit conditional lift law
used to define a Haar-averaged finite transition matrix.

### 2c. The modular operator requires more careful semantics

Remark C.34 on PDF page 170 describes a finite matrix by having the accelerated
map send one odd residue modulo `2^M` to another. U does not descend to such a
deterministic quotient. At M=4,

$$
1\equiv17\pmod{16},\qquad U(1)=1,\quad U(17)=13.
$$

A transfer matrix defined by averaging all higher-bit lifts is a meaningful
different object, but its transition probabilities do not supply the missing
actual-orbit lift law. A spectral gap for that averaged matrix therefore does
not by itself prove equidistribution of each integer orbit. The document
discusses several distinct operators and sometimes acknowledges this problem;
the semantics must be pinned before accepting any spectral transfer theorem.

## 3. What a complete hierarchy must still contain

The valid deliverable chain is:

1. Exact guarded transition/macro semantics for every positive input.
2. A well-founded mechanism, or a separately proved pointwise arithmetic
   theorem, covering all unbounded returns and all recurrent labels.
3. Explicit treatment of nontrivial positive cycles and divergent trajectories.
4. A global induction/termination theorem using those already proved inputs.

Dhiman–Pandey restricts one possible encoding of step 2's full reachability
relation. It does not remove the ranked finite-graph route. Chang supplies no
proved step 2 that can be inserted into the existing repository: its relevant
pointwise assumptions remain open, its advertised WMH weakening collapses,
and its non-atomic uniqueness claim has the explicit counterexample above.

**No new universal closure is certified by this audit.** The existing L9/L15
gap tightening and the hard-return polynomial-rank obstruction remain valid
auxiliary contributions, but neither repairs these source-level bridges.

## Reproduction scope

[The exact checker](../../verification/primary_bridge_counterexamples.py) checks the small integer witnesses,
projection-consistent discrepancy example, and finite inverse-branch identities.
The infinite-measure and logical nondefinability arguments are the proofs
above, not extrapolations from that checker. Neither paper nor this audit is
represented as Lean-verified.

## Connections

- **Constrains:** [approach registry](../APPROACH_REGISTRY.md), Routes B/C/F.
- **Verified by:** [finite counterexample regressions](../../verification/primary_bridge_counterexamples.py).
- **Recorded in:** [research pass](../../ASTRA_RESEARCH_PASS_2026-09-05.md).

The measure and quantifier arguments passed a separate cold reconstruction;
neither is a novelty claim, a Lean theorem, or a positive-integer disproof.
