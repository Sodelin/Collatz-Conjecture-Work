# Route AB — Mixed-radix rewrite states + strong-induction coalescence

**Cycle:** Round 7, 2026-08-23  
**Status:** historical architecture synthesis; current registry status
`BLOCKED_NO_MECHANISM`
**Mathematical status:** exact representation bridge proved below; global certificate not found  
**Novelty:** no claim; the mixed-base SRS is prior art and the bridge uses its published affine semantics

> **Round-8 supersession notice:** this note preserves the exact representation
> bridge, but its old active-route recommendation is no longer current. The
> hard successor/rank obstruction and exact Collatz-equivalent return system are
> recorded in [`L13_Refined_Mersenne_Child_Macros.md`](../lemmas/L13_Refined_Mersenne_Child_Macros.md)
> and [`AB_hard_boundary_return_system.md`](AB_hard_boundary_return_system.md).
> Use the [`APPROACH_REGISTRY.md`](../APPROACH_REGISTRY.md) for live status.

## 1. Why merge Routes A and B?

Route A uses the exact mixed binary/ternary string-rewriting system of Yolcu, Aaronson, and Heule (YAH), whose termination is equivalent to Collatz.

Route B uses exact affine residue cylinders and strong-induction coalescence certificates.

These are not unrelated representations. The current Round-7 affine cylinder engine is a deterministic affine projection of the same mixed-radix arithmetic used by the YAH rewriting system.

The useful distinction is **certificate semantics**:

- a conventional rewrite interpretation tries to orient primitive rewrite rules in a well-founded algebra;
- a coalescence certificate may allow temporary growth and only needs a finite macro calculation showing that the orbit joins the orbit of a strictly smaller integer.

The merged route therefore asks whether the YAH finite alphabet/state structure can compress the residue search while the strong-induction semantics supplies a more permissive macro notion of progress than rule-by-rule decrease.

## 2. Exact published substrate

YAH use the once-accelerated Collatz map

$$
T(n)=\begin{cases}
n/2,&n\equiv0\pmod2,\\
(3n+1)/2,&n\equiv1\pmod2.
\end{cases}
$$

They represent mixed binary/ternary digits by affine functions

$$
f(x)=2x,\qquad t(x)=2x+1,
$$

and

$$
0(x)=3x,\qquad1(x)=3x+1,\qquad2(x)=3x+2.
$$

Their 11-rule system consists of two dynamic rules

```text
f$ -> $
t$ -> 2$
```

plus six internal binary/ternary base-swap rules

```text
f0 -> 0f
f1 -> 0t
f2 -> 1f
t0 -> 1t
t1 -> 2f
t2 -> 2t
```

and three left-boundary rules

```text
^0 -> ^t
^1 -> ^ff
^2 -> ^ft
```

where `^` and `$` denote the boundary symbols in ASCII notation.

The auxiliary rules preserve the represented integer; the dynamic rules apply one `T` step. YAH Theorem 3.17 proves that termination of the full system is equivalent to convergence of `T`, hence to the Collatz conjecture.

Primary sources:

- Emre Yolcu, Scott Aaronson, Marijn J. H. Heule, *An Automated Approach to the Collatz Conjecture*, Journal of Automated Reasoning 67, 15 (2023), DOI `10.1007/s10817-022-09658-8`.
- Reproducibility repository: `https://github.com/emreyolcu/rewriting-collatz`.

## 3. Exact bridge to the Round-7 cylinder engine

Take an odd residue cylinder

$$
N_K(x)=2^Kx+R.
$$

The ordinary-map script previously described the maximal uniform path as

$$
U^{K+s}(N_K(x))=3^s x+B,
$$

because every odd ordinary step is immediately followed by an even division step.

Equivalently, under the YAH map `T`, this is simply

$$
\boxed{T^K(2^Kx+R)=3^s x+B.}\tag{1}
$$

Each of the `K` applications consumes exactly one factor of two from the affine leading coefficient; `s` counts how many of those `K` branches were odd.

Thus the endpoint-slope exponent of `L2_Cylinder_Refinement_and_Slope_Pruning.md` is exactly the number of `t`-type dynamic branches encountered in `K` accelerated steps.

### One-bit refinement in YAH semantics

Write `x=2y+epsilon`. At the endpoint of (1),

$$
3^s(2y+\epsilon)+B
=2\cdot3^s y+C_\epsilon,
\qquad C_\epsilon=B+\epsilon3^s.
$$

If `C_epsilon` is even, one `T` step gives

$$
3^s y+C_\epsilon/2.
$$

If `C_epsilon` is odd, one `T` step gives

$$
3^{s+1}y+(3C_\epsilon+1)/2.
$$

These are precisely the affine meanings of the two binary dynamic cases represented by the YAH `f`/`t` symbols. The published auxiliary rules are the local identities that swap adjacent binary and ternary affine digits while preserving the represented value.

**Conclusion:** the Route-B one-bit refinement transducer is not a separate Collatz model. It is the cylinder-level affine semantics of the same binary/ternary conversion process encoded finitely by the YAH SRS.

## 4. Why Route B still adds a distinct certificate idea

YAH's automated experiments search standard termination interpretations, such as natural/arctic matrix interpretations. Such methods seek a well-founded interpretation capable of orienting the rewrite system according to the termination framework.

Our affine coalescence certificate asks for something different.

For a family `N(x)`, it is sufficient to prove an exact identity

$$
T^a(N(x))=T^b(m(x))
$$

with

$$
0<m(x)<N(x).
$$

Then strong induction transfers convergence of `m(x)` to convergence of `N(x)`, even if the common trajectory value is much larger than `N(x)`.

Example already certified in ordinary-map notation:

$$
U^9(64x+15)=U(54x+13).
$$

This can be translated into the accelerated `T` convention and treated as a macro coalescence identity rather than a primitive rule orientation.

Therefore the synthesis opportunity is:

> use the finite mixed-radix grammar to represent states, but search for exact **macro coalescence/induction certificates** rather than only globally monotone primitive rewrite interpretations.

## 5. Candidate certificate language

A future finite certificate could contain:

1. a finite collection of symbolic mixed-radix state patterns;
2. exact value semantics for each state;
3. binary/ternary rewrite macros whose auxiliary portions preserve value;
4. for each terminal macro, an exact smaller affine integer `m` whose orbit coalesces;
5. recursion/back-edges only when accompanied by an explicit well-founded symbolic measure;
6. exact coverage of every canonical positive-integer representation.

The intended checker theorem is schematically

```text
ValidMixedRadixCoalescenceCertificate C -> Collatz
```

The certificate generator may be Python/SAT/SMT/LLM code. The semantic checker should eventually be Lean or an independently reconstructible mathematical proof.

## 6. What this architecture might bypass

It potentially bypasses two old limitations without claiming to solve them:

### A. Bounded residue depth

A finite macro grammar can describe arbitrarily long inputs. It need not enumerate every modulus up to a fixed `K`.

### B. Locally monotone ranking

A macro may temporarily grow and still terminate by coalescing with a strictly smaller start. This preserves the strong-induction mechanism that ordinary matrix/rule-length heuristics may miss.

## 7. Kill tests

Route AB is killed or sharply revised if any of the following becomes clear:

1. the mixed-radix state required to distinguish unresolved cylinders grows without any finite/regular quotient;
2. every proposed macro progress measure is equivalent to assuming global descent;
3. coalescence macros cannot be made compositional over a finite state grammar;
4. a claimed macro identity holds only on sampled parameters rather than symbolically;
5. coverage silently excludes a regular/infinite family of canonical strings;
6. the only surviving certificate is simply a full termination proof restated in another syntax, with no new searchable parameterization.

## 8. Immediate experiments

### AB-EXP-01 — survivor language signatures

Treat a depth-`K` unresolved residue as a binary prefix read from low to high bits. For horizon `h`, record the bitmask of its `2^h` extensions that remain unresolved under the fixed bounded coalescence search.

If the number of extension signatures stabilizes or collapses under a meaningful exact state feature, that suggests a finite quotient candidate. If it grows rapidly with `h` and `K`, finite-state compression by that feature is unlikely.

This is diagnostic only because “unresolved” depends on the bounded certificate search.

### AB-EXP-02 — translate survivor prefixes to mixed-radix rewrite states

For each persistent survivor family:

1. build its pure-binary canonical YAH string;
2. run a fixed auxiliary-normalization strategy;
3. extract short mixed-radix suffix/carry states near the dynamic end;
4. cluster survivors by these exact local states;
5. test whether successful coalescence certificates are predictable from the cluster.

### AB-EXP-03 — macro interpretation synthesis

Extend the existing termination-prover search space from primitive symbol interpretations to short certified macro rules discovered by Route B. Search for a finite set of macros whose terminal outcomes are strong-induction reductions.

## 9. Current verdict

**Historical Round-7 verdict, superseded in Round 8:** keep A and B separately
visible. Route AB is now `BLOCKED_NO_MECHANISM`, not the current highest-value
active route.

The shared mathematical core is now explicit. The next question is not whether residue arithmetic and mixed-radix rewriting are analogous; they are exact representations of the same affine branch mechanics. The open question is whether coalescence supplies a finite macro progress notion that standard local termination interpretations fail to expose.

The later hard-return analysis makes that open question exact: boundary
normalization closes the state space, but universal termination of the resulting
return map is Collatz-equivalent, and the audited simple replay-debt/affine ranks
fail. Reopen this architecture only with a genuinely richer well-founded rank
or a new guarded uniformly smaller target.
