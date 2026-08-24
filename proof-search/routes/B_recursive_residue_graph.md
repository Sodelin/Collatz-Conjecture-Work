# Route B — Recursive residue/coalescence certificate graph

**Status:** `ACTIVE`

**Goal:** find a finite symbolic induction certificate proving convergence of every positive integer by mapping each residue family either to a smaller value directly or into the orbit of a uniformly smaller parameter.

## 1. Why coalescence is stronger than direct descent

Global Descent (L0) is enough for Collatz, but a strong-induction proof can use an even broader reduction.

Suppose for a parametric family `N(x)` there is a uniformly smaller positive integer `m(x)<N(x)` and fixed nonnegative integers `t,j` such that

\[
U^t(N(x))=U^j(m(x)),
\]

where `U` is the ordinary Collatz map.

By strong induction, `m(x)` converges. Since the orbit of `N(x)` coalesces with the orbit of `m(x)`, `N(x)` converges too, even if the common value is temporarily larger than `N(x)`.

This is strictly more flexible than demanding that `N(x)` itself have already descended at the coalescence point.

## 2. Exact identities recovered by the search

### Warm-up

For every integer `x>=0`,

\[
U^5(32x+3)=U(12x+1)=36x+4,
\]

and `12x+1<32x+3`. This is an exact shortcut identity. A later hostile audit noticed that this example is *not* genuinely beyond direct descent: continuing the same uniform affine cylinder a little farther gives direct descent as well.

That correction exposed an implementation mistake in the first search, described below.

### Genuine coalescence example

For every integer `x>=0`, let

\[
N=64x+15,
\qquad
m=54x+13.
\]

The exact uniform forward path of `N` gives

\[
U^9(N)=162x+40,
\qquad
U^{10}(N)=81x+20.
\]

Neither endpoint is uniformly below `N` asymptotically, since `162>64` and `81>64`. At the next ordinary step the parity depends on `x`, so the residue cylinder has exhausted its uniform local information.

But

\[
U(m)=3(54x+13)+1=162x+40.
\]

Hence

\[
\boxed{U^9(64x+15)=U(54x+13),}
\]

while

\[
0<54x+13<64x+15
\]

for every `x>=0`.

Therefore the entire residue class `15 mod 64` is closed by strong induction even though its maximal uniform direct path does not itself descend.

This identity is not claimed novel. Its significance is that it demonstrates the extra proof power of **coalescence certificates** over uniform direct-descent certificates.

## 3. General certificate shape

A coalescence certificate is

\[
(K,R,A,B,t,j)
\]

meaning

\[
N(x)=2^Kx+R,
\qquad
m(x)=Ax+B,
\]

with proofs that for all integers `x>=x_0`:

1. `N(x)>0` and `m(x)>0`;
2. `m(x)<N(x)`;
3. the first `t` Collatz parity decisions for `N(x)` are uniform on the cylinder;
4. the first `j` decisions for `m(x)` are uniform;
5. `U^t(N(x))=U^j(m(x))` exactly.

A direct-descent certificate is the special case `j=0` with `m(x)=U^t(N(x))<N(x)`.

If `x_0>0`, the finitely many excluded values are explicit base cases and must be checked separately.

## 4. Correct symbolic search method

For a fixed residue class

\[
N(x)=2^Kx+R,
\]

one should **not** restrict to `t<=K` ordinary Collatz steps. That was the first implementation's error.

The correct invariant is the 2-adic valuation of the affine coefficient. As long as

\[
N_t(x)=A_t x+B_t
\]

has even `A_t`, the parity of the entire family is fixed by `B_t`, so one more ordinary Collatz step is uniform:

- if `B_t` is even, `N_{t+1}=(A_t/2)x+B_t/2`;
- if `B_t` is odd, `N_{t+1}=3A_t x+(3B_t+1)`.

Odd steps do not consume a factor of two from `A_t`. The cylinder branches exactly when `A_t` becomes odd, because parity then depends on `x`.

For coalescence, rather than enumerate all parity words blindly, start from a target affine family

\[
y(x)=Ax+B
\]

and generate exact one-step affine predecessors:

- even predecessor: `2y(x)`;
- odd predecessor: `(y(x)-1)/3`, only when the coefficients divide by 3 exactly and the resulting affine family is uniformly odd.

Every candidate is then checked for the exact inequalities

\[
0<m(x)<N(x)
\]

for the whole tail `x>=x_0`.

Concrete sample replay remains as a software guardrail, but candidate correctness comes from the symbolic divisibility/parity constraints, not from sample agreement.

## 5. Audited bounded sweep

After correcting the forward-path error and using exact reverse predecessors, the bounded search with reverse depth at most 16 gave:

| K | odd cylinders | certified | unresolved |
|---:|---:|---:|---:|
| 3 | 4 | 2 | 2 |
| 4 | 8 | 5 | 3 |
| 5 | 16 | 12 | 4 |
| 6 | 32 | 25 | 7 |
| 7 | 64 | 53 | 11 |
| 8 | 128 | 112 | 16 |
| 9 | 256 | 229 | 27 |
| 10 | 512 | 466 | 46 |
| 11 | 1024 | 944 | 80 |
| 12 | 2048 | 1903 | 145 |

At `K=12`, this bounded certificate class closes about 92.9% of odd cylinders. **That is not evidence that the remaining 7.1% vanish at some larger K.** It is simply a map of where this certificate language succeeds and where it fails.

Several unresolved patterns persist coherently through refinement, including branches related to the old `-1`/Mersenne 2-adic shadow phenomenon. That is exactly where the earlier Round-4/5 work says local finite-bit reasoning should encounter long adversarial shadows.

The full corrected output is in `verification/round7_affine_coalescence_output_2026-08-23.txt`. Git history intentionally preserves the superseded first sweep and the correction.

## 6. What the surviving cylinders tell us

The remaining search problem should not be phrased as “increase K until everything is green.” The existence of arbitrarily long stopping-time/shadow phenomena makes that a bad extrapolation.

Instead, use the successful certificates to infer a **finite symbolic state language**. A node should encode an affine family plus a finite radix/carry state. A macro-edge either:

- coalesces with a strictly smaller affine parameter, so strong induction closes it; or
- changes the symbolic state while decreasing a separate well-founded rank.

The search problem becomes:

> Can a finite state set and exact coalescence macros cover every continuation, with every abstract cycle decreasing a rank?

This now visibly overlaps the mixed binary/ternary string-rewriting formulation of Yolcu–Aaronson–Heule. Route A may provide the right quotient state representation; Route B supplies a particularly transparent strong-induction semantics for what a successful transition is buying us.

## 7. Candidate compression question

A concrete next experiment is to quotient the 145 unresolved `K=12` cylinders by features of their exact affine path, for example:

- parity-word suffix;
- exponent counts `(number of odd steps, number of halvings)`;
- affine coefficient ratio relative to `2^K`;
- terminal affine intercept modulo small powers of 2 and 3;
- relation to the `-1` shadow and to known rational-period words.

If many unresolved cylinders collapse to a small number of transition types, search for a ranked recursive grammar on those types. If the number of types continues to grow without stable transitions, record that as a no-go signal for this particular finite-state quotient.

## 8. Kill tests

A proposed finite graph is invalid if any of the following occurs:

- a residue family is uncovered;
- an affine identity is based only on sampled `x` values;
- an abstract cycle has no well-founded decrease;
- an edge uses a parity pattern not uniform over the whole family;
- the “smaller” parameter is not uniformly positive and smaller;
- a mixed-base divisibility condition is silently dropped;
- the graph proves convergence only below a fixed modulus/depth;
- a finite graph certificate is inferred from a decreasing *fraction* of survivors rather than exact closure.

## 9. Lean endpoint

Formalize a generic theorem of the form

`ValidCoalescenceGraph cert -> Collatz`.

Then Python/SAT/LLM search can remain untrusted. The finite graph is data; Lean checks every affine identity, coverage condition, and well-founded rank.
