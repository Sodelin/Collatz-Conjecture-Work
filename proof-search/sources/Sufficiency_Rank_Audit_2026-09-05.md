---
node_id: THIRD-PASS-SUFFICIENCY-AUDIT-2026-09-05
node_type: source
routes: [B, AB]
tags: [collatz, primary-source-audit, modular-rank, sufficiency, prior-art]
---

# Two exact theorem imports and a ranked reconstruction

**Outcome:** a proved residue-hitting theorem has an explicit finite lexicographic
rank certificate. It terminates at `1`, `2`, or `20 mod 27`; it does not control
subsequent returns from `20 mod 27`. A second published paper supplies a valid
induction wrapper already represented in the repository, but its stronger sieve
construction contains exact algebraic errors and must not be imported.

Input: reviewed repository revision `b6eee8594714adc3b51d5005dd0b4ed8a76412e8`.
The modular rank was independently reconstructed and checked during this continuation.

## 1. Accepted imports, with exact scope

Both use the positive-integer shortcut map

$$
T(n)=\begin{cases}(3n+1)/2&n\text{ odd},\\n/2&n\text{ even}.\end{cases}
$$

### Import A: actual orbit hitting, rather than mere merging

Monks, Monks, Monks and Monks, *Strongly sufficient sets and the distribution
of arithmetic sequences in the 3x+1 graph*, published in **Discrete Mathematics
313(4), 468–489 (2013)**; DOI
[10.1016/j.disc.2012.11.019](https://doi.org/10.1016/j.disc.2012.11.019).
Read the authors' [arXiv:1204.3904v2](https://arxiv.org/abs/1204.3904v2),
PDF pp.22–24, Theorem 6.4: every divergent positive T-orbit and every nontrivial
positive T-cycle contains an integer congruent to20 modulo27.

Their Proposition6.5(a) gives a reusable finite-graph criterion: after removing
target residues and edges lying on no cycle from the pruned modular graph,
if every remaining simple cycle has odd-edge proportion below
`log(2)/log(3)`, the target is hit by every divergent orbit.

Theorem4.1's uniform inverse-path bound counts odd inverse branches, not total
iteration count or target magnitude. It supplies no smaller coalescing target.
Thus it cannot replace the repository's missing strict order condition.

**Applicable conclusion:**

$$
\forall n>0\;\exists k\ge0:
T^k(n)\in\{1,2\}\ \lor\ T^k(n)\equiv20\pmod{27}.
$$

The concrete certificate below reconstructs this consequence directly. It
does not rely on cycle-length bounds, computation of large Collatz ranges,
or any probability law for actual orbits.

### Import B: finite verification transfer through smaller coalescence

Mohammad Ansari, *Recursive sufficiency for the Collatz conjecture and
computational verification*, published **Notes on Number Theory and Discrete
Mathematics31(3), 471–480 (2025)**, DOI
[10.7546/nntdm.2025.31.3.471-480](https://doi.org/10.7546/nntdm.2025.31.3.471-480).
The [primary PDF](https://nntdm.net/papers/nntdm-31/NNTDM-31-3-471-480.pdf),
Definition1.3 and Theorem2.1, defines a set F by the requirement that each
`n>1` outside F merges with some `0<m<n`. It proves that convergence on
`F∩[1,N]` implies convergence on `[1,N]`, for every N. The proof is strong
induction; the definition itself is the required arithmetic hypothesis.

**Role:** existing convergence criteria gain an explicit published comparator,
not a new universal smaller-target mechanism. The paper's later sieve claims
are not covered by this accepted import; see the exact failed identities below.

## 2. Independent reconstruction: an explicit rank for the modulo27 target

Let A consist of `1`, `2`, and all positive integers congruent to20 modulo27.
Stop the shortcut iteration on entering A.

Use the following exact modular table; even/odd columns describe the parity of
the actual integer, not its representative modulo the odd modulus27. Since
`2^{-1}=14 mod27`, these are exhaustive modular images of the true branches.

| Residue r | h(r) | Even image | Odd image |
|---:|---:|---:|---:|
|1|2|14|2|
|2|1|1|17|
|4|0|2|20|
|5|1|16|8|
|7|2|17|11|
|8|0|4|26|
|10|2|5|2|
|11|1|19|17|
|14|1|7|8|
|16|2|8|11|
|17|0|22|26|
|19|2|23|2|
|22|0|11|20|
|23|1|25|8|
|25|2|26|11|

Call these fifteen residues the core. For all25 edges remaining inside the
core, the table verifies

$$
2p-1\le h(r)-h(r'),
$$

where p is1 on an odd branch and0 on an even branch. Let

$$
(w_0,w_1,w_2)=(16,28,49),\qquad Q(n)=w_{h(n\bmod27)}n.
$$

For non-target n in the core, n≥3. On odd steps,
`T(n)/n≤5/3` and h decreases by at least1; adjacent weights have ratio7/4.
Thus `Q(Tn)/Q(n)≤(5/3)(4/7)=20/21`.
On even steps h increases by at most1, so the ratio is at most7/8.
Therefore every core-to-core step contracts Q by at least the uniform
factor20/21. These are integer weights and exact rational comparisons.

Now define a pair of natural numbers, ordered lexicographically:

$$
\mathcal R(n)=
\begin{cases}
(0,0),&n\in A,\\
(3,n),&3\mid n,\\
(1,v_2(n+1)+2),&n\equiv26\pmod{27},\\
(1,1),&n\equiv13\pmod{27},\\
(2,Q(n)),&\text{otherwise}.
\end{cases}
$$

Every non-target actual step strictly decreases this pair:

1. If3 divides n, an even step halves n within phase3. An odd step produces
   a number coprime to3 and leaves phase3.
2. A core step stays in the core and contracts Q, or enters a lower phase.
   Coprimality to3 is preserved by both branches.
3. At residue26, an odd step stays in residue26 and satisfies
   `T(n)+1=3(n+1)/2`, reducing `v2(n+1)` by exactly1. An even step enters
   residue13, dropping the score from at least2 to1.
4. At residue13, both parity branches enter residue20 and phase0.

The lexicographic order on `N×N` is well-founded. Hence the stopped map
terminates for every positive input. This is a complete proof of the stated
normalization theorem, including all modular loops and arbitrary input size.
The weighted rank was first reconstructed quadratically in this subtask;
the parent simplified it to the linear weights above.

### Why residue26 needs its own arithmetic argument

When reconstructing the source's transient-residue argument near PDF
pp.22–23, the residue26 self-loop requires explicit arithmetic treatment: `53→80` repeats residue26.
More generally, `27*2^e−1` follows that loop for e odd steps. The valuation
argument above proves that no positive input follows it forever. Deleting the
loop based solely on a finite-graph picture would be invalid; its arithmetic
exit debt supplies the missing justification. This supplies a complete arithmetic treatment consistent with the published
hitting conclusion.

### Exact remaining bridge

The rank restarts only if one imposes a new stopping problem. It makes no claim
that an input in20 modulo27 reaches a *smaller* member of20 modulo27, a smaller
integer, or1. At such an input, the present rank is already0. Global convergence
still requires a well-founded return mechanism on this target or another
pointwise theorem controlling its positive orbits. A partial normalizer cannot
be silently reused as a rank on target-to-target edges.

## 3. Rejected stronger claims in the second paper

The following are independent set computations against the exact displayed
definitions on printed pp.477–479. They establish errors in those proof steps;
they are not counterexamples to the Collatz conjecture.

### The induction in Lemma3.1 uses a false set equality

Write m=4k+3. At the displayed induction step n=1, the set F'_1 permits all
two-digit ternary patterns of k. Its removed subset A' consists only of
pattern22. Therefore, within `0≤k<9`, F'_1 minus A' has eight elements:

$$
\{3,7,11,15,19,23,27,31\}.
$$

But F_2 requires both ternary digits to belong to{0,1}, giving just

$$
\{3,7,15,19\}.
$$

In particular,11 belongs to the claimed left side and not the right side.
Consequently the equality `F_{n+1}=F'_n\setminus A'` used to conclude the
induction is false already for n=1. This leaves the universal recursive
sufficiency of these later sieves unestablished by the displayed argument.

### The infinite intersection identity omits3

Setting every ternary digit and the leading free parameter to0 shows that3
belongs to every F_n. Hence3 belongs to their intersection. The displayed
right side of Lemma3.2 insists on a leading nonzero ternary digit and starts
at7, so it omits3. Adding3 repairs this set identity but does not repair the
previous induction error. We therefore do not use the advertised sieve or
claimed increase of a verification limit.

## 4. Reproduction and provenance

Run `python -B verification/mod27_rank_check.py` from the repository root. The standard-library
checker verifies the exhaustive modular table and linear coefficient
inequalities for all n≥3, then replays200,000 starting states and deliberately
long residue26 loops through1024 steps. It also checks the finite n=1 failed
set equality. The universal proof is the rank argument above; finite replay
alone is not its justification. This artifact is not yet Lean-verified.

Search budget: two discovery rounds, each followed by exact primary reading.
The first combined alphaXiv discovery with targeted web lookup; the second
looked up publication metadata and surfaced Ansari. No Chang/Williams/Dhiman
scan was repeated. Newer unsupported proof papers returned by broad discovery
were not imported. Source discovery is selective, not exhaustive.

Source roles for Zotero/Obsidian: Monks2013=`proved-hitting-theorem` and
`finite-graph-prior-art`; Ansari2025=`accepted-induction-wrapper` plus
`rejected-sieve-proof-step`. Relate this note to the convergence statement,
RouteB, RouteAB, and the primary bridge audit. The explicit certificate is
an internal reconstruction of known sufficiency, with no novelty claim.

Process-integrity assessment: exact statements and map conventions were
checked in primary text; both promising imports received algebraic scrutiny.
The paper pair was selected for specific utility rather than comprehensiveness.
Robustness assessment: the rank survives arbitrary positive sizes and arbitrarily
long self-loop prefixes; closure fails precisely at the stopping target, not at
an untested numerical threshold. The sieve rejection survives correction of
the separate omitted3 typo because its eight-versus-four set mismatch remains.

## Connections

- **Refines:** [Route B](../APPROACH_REGISTRY.md) with a proved ranked stopping map.
- **Compared with:** [formal coalescence criteria](../../lean/CollatzWork/Convergence.lean).
- **Constrained by:** [residue-20 return obstruction and composition loop](../routes/AB_ternary_normalized_core_residue_obstruction.md).
- **Verified by:** [exact modular certificate](../../verification/mod27_rank_check.py).
- **Recorded in:** [continuation report](../../ASTRA_CONTINUATION_2026-09-05.md).
