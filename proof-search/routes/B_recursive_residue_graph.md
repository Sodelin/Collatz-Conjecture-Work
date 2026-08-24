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

## 2. First exact identity recovered by the search

For every integer `x>=0`, let

\[
N=32x+3,
\qquad
m=12x+1.
\]

Then `m<N` for every `x>=0`, and

\[
\begin{aligned}
32x+3
&\to96x+10\\
&\to48x+5\\
&\to144x+16\\
&\to72x+8\\
&\to36x+4,
\end{aligned}
\]

while

\[
12x+1\to36x+4.
\]

Therefore

\[
\boxed{U^5(32x+3)=U(12x+1).}
\]

So the entire residue family `3 mod 32` is reducible by strong induction to a smaller affine parameter.

This identity is not claimed novel; it is the kind of shortcut/stopping-time relation long studied in Collatz work. Its purpose here is to validate the **certificate language**.

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
3. the first `t` Collatz parity decisions for `N(x)` are fixed by the residue data;
4. the first `j` decisions for `m(x)` are fixed;
5. `U^t(N(x))=U^j(m(x))` exactly.

A direct-descent certificate is the special case `j=0` with `m(x)=U^t(N(x))<N(x)`.

## 4. Symbolic search method

For a fixed residue class `N=2^K x+R`, the first `K` parity decisions are fixed. Hence for every `t<=K`,

\[
U^t(N)=a_t x+b_t
\]

is an exact affine function.

For a proposed parity word `w` of length `j` for a smaller parameter `m`, its iterate has the exact form

\[
U^j(m)=\frac{3^s m+c_w}{2^e}.
\]

Equating this with `a_t x+b_t` solves for a unique affine candidate

\[
m(x)=Ax+B.
\]

The search then rejects the candidate unless `A,B` are integral, the parity word is actually realized, and `0<m(x)<N(x)` for the entire parametric family.

This is certificate synthesis, not trajectory sampling.

## 5. Diagnostic first sweep

A small initial program searched power-of-two residue classes with:

- `K <= 9`;
- `t <= K`;
- backward/coalescence parity words of length at most `12`;
- exact affine equality checked after candidate construction.

The fraction of odd residue families admitting either direct descent or an affine coalescence reduction increased with `K` but did **not** approach a complete finite cover in this shallow sweep. This is expected and should not be interpreted as evidence for or against Collatz.

The important observation is structural: the surviving families are exactly where a proof needs **recursive state**, not a deeper finite tree alone.

## 6. Next mathematical step

The next target is a **finite graph**, not a larger fixed modulus.

A node should encode an affine family plus a finite radix/carry state. A macro-edge either:

- reaches a strictly smaller affine parameter whose convergence follows by induction; or
- changes the symbolic state while decreasing a separate well-founded rank.

The search problem becomes:

> Can a finite state set and a finite collection of exact coalescence macros cover all parity/residue continuations, with every cycle in the abstract graph decreasing a rank?

This begins to overlap the mixed binary/ternary string-rewriting formulation. That overlap is useful: Route A can supply the right state representation, while Route B supplies the strong-induction semantics.

## 7. Kill tests

A proposed finite graph is invalid if any of the following occurs:

- a residue family is uncovered;
- an affine identity is based only on sampled `x` values;
- an abstract cycle has no well-founded decrease;
- an edge uses a parity pattern not uniform over the whole family;
- the “smaller” parameter is not uniformly positive and smaller;
- a mixed-base divisibility condition is silently dropped;
- the graph proves convergence only below a fixed modulus/depth.

## 8. Lean endpoint

Formalize a generic theorem of the form

`ValidCoalescenceGraph cert -> GlobalDescent/Collatz`.

Then Python/SAT search can remain fully untrusted. The finite graph is data; Lean checks every edge and the well-founded rank.
