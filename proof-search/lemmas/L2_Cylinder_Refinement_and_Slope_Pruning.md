# L2 — Exact one-bit cylinder refinement and slope pruning

**Cycle:** Round 7, 2026-08-23  
**Status:** `PROVED_AUX` / `FORMAL_PENDING`  
**Novelty:** likely classical parity-vector/cylinder machinery; no novelty claim  
**Usefulness:** technically useful for Route B state compression  
**Collatz relevance:** partial proof architecture only; not a convergence theorem

## 1. Setup

Let the ordinary Collatz map be

$$
U(n)=\begin{cases}
n/2,&n\equiv0\pmod2,\\
3n+1,&n\equiv1\pmod2.
\end{cases}
$$

Fix `K>=1` and an odd residue `0<R<2^K`. Write

$$
N_K(x)=2^Kx+R,\qquad x\ge0.
$$

Propagate this entire affine family under `U` for as long as parity is uniform over all integer `x>=0`. The coefficient starts at `2^K`. An even step divides that coefficient by two; an odd step multiplies it by three. Therefore the maximal uniform path stops immediately after the `K`-th division-by-two decision, when the coefficient first becomes odd.

If `s` odd steps occurred before that point, there are integers `t=K+s` and `B>0` such that

$$
\boxed{U^t(N_K(x))=3^s x+B}\tag{1}
$$

for every integer `x>=0`.

The exponent `s` is the **endpoint slope exponent** of the cylinder.

## 2. One-bit refinement lemma

Refine the cylinder by the next binary digit of `x`. For `epsilon in {0,1}` write

$$
x=2y+\epsilon,
$$

so the two children are

$$
N_{K+1,\epsilon}(y)=2^{K+1}y+R+\epsilon2^K.
$$

Substituting into (1) gives

$$
U^t(N_{K+1,\epsilon}(y))
=2\cdot3^s y+C_\epsilon,
\qquad
C_\epsilon=B+\epsilon3^s.\tag{2}
$$

Because `3^s` is odd, `C_0` and `C_1` have opposite parity.

### Case E — `C_epsilon` is even

One ordinary Collatz step is a division by two, giving

$$
\boxed{
U^{t+1}(N_{K+1,\epsilon}(y))
=3^s y+\frac{C_\epsilon}{2}.
}\tag{3}
$$

The new coefficient is odd, so this is the maximal uniform endpoint of that child. Its endpoint slope exponent remains `s`.

### Case O — `C_epsilon` is odd

The next step is `3n+1`:

$$
2\cdot3^s y+C_\epsilon
\mapsto
6\cdot3^s y+3C_\epsilon+1.
$$

Since `C_epsilon` is odd, `3C_epsilon+1` is even. The following step divides by two:

$$
\boxed{
U^{t+2}(N_{K+1,\epsilon}(y))
=3^{s+1}y+\frac{3C_\epsilon+1}{2}.
}\tag{4}
$$

Again the new coefficient is odd. This child's endpoint slope exponent is `s+1`.

### Exact conclusion

Every depth-`K` odd cylinder has exactly two depth-`K+1` children:

- one child with slope exponent `s`;
- one child with slope exponent `s+1`.

Which binary child receives which exponent is determined exactly by the parity of `B`.

No trajectory sampling or asymptotic approximation enters this statement.

## 3. Binomial cylinder-count corollary

Let `M(K,s)` be the number of odd residue cylinders modulo `2^K` whose maximal uniform endpoint has slope exponent `s`.

At `K=1`, the unique odd cylinder is `2x+1` and its endpoint slope exponent is `1`, so

$$
M(1,1)=1.
$$

The refinement lemma gives Pascal's recurrence

$$
M(K+1,s)=M(K,s)+M(K,s-1).
$$

Therefore

$$
\boxed{M(K,s)=\binom{K-1}{s-1}},
\qquad 1\le s\le K.\tag{5}
$$

This is consistent with classical parity-vector combinatorics and is not claimed as a novel result.

## 4. Slope-pruning corollary

Suppose a child cylinder has maximal uniform endpoint

$$
U^q(2^{K+1}y+R')=3^{s'}y+B'.
$$

If

$$
3^{s'}<2^{K+1},\tag{6}
$$

then the endpoint is strictly below the start for every sufficiently large `y`.

Indeed,

$$
(2^{K+1}-3^{s'})y>B'-R'
$$

holds eventually because the coefficient on the left is positive. An exact valid threshold is

$$
y_0=
\max\left(0,
\left\lfloor\frac{B'-R'}{2^{K+1}-3^{s'}}\right\rfloor+1
\right)
$$

when `B'-R'>=0`, with `y_0=0` when the inequality already holds at zero.

Thus any cylinder satisfying (6) is **asymptotically direct-descent certified**, leaving only finitely many values below `y_0` to check separately.

This is exactly the slope test implemented inside the Round-7 affine certificate search.

## 5. Deficit coordinate

Define the real slope deficit

$$
d(K,s)=K-s\log_2 3.
$$

Direct endpoint contraction corresponds to `d(K,s)>0`.

Under one-bit refinement:

- the slope-preserving child has
  $$
  d' = d+1;
  $$
- the slope-incrementing child has
  $$
  d' = d+1-\log_2 3=d-\log_2(3/2).
  $$

So each refinement makes one branch substantially easier by slope and one branch harder by the fixed amount `log_2(3/2)`.

This coordinate is diagnostic only. Following the hard branch indefinitely is still an infinite arithmetic problem; the deficit recurrence by itself does not prove Collatz.

## 6. Round-7 diagnostic consequence at K=12

At `K=12`,

$$
3^7<2^{12}<3^8.
$$

Hence the slope-hard cylinders are exactly those with `s>=8`. Equation (5) gives

$$
\binom{11}{7}+\binom{11}{8}+\binom{11}{9}+\binom{11}{10}+\binom{11}{11}
=330+165+55+11+1=562.
$$

The audited bounded coalescence search leaves only 145 of these 562 slope-hard cylinders unresolved at reverse depth 16. Thus coalescence certificates remove a substantial subset that the simple endpoint-slope test cannot remove.

This 145/562 figure is **not** evidence that Collatz is 74% solved. It measures only the additional pruning power of one bounded certificate language at this modulus.

## 7. Why this lemma matters for Route B

The refinement theorem turns the raw residue tree into an exact recursively generated state process:

$$
(K,s,B)\longrightarrow(K+1,s,B_E)
\quad\text{and}\quad
(K+1,s+1,B_O),
$$

with explicit formulas (3) and (4).

Therefore the next Route-B question can be sharpened:

> Can the intercept information needed to decide coalescence/back-edge certificates be quotiented into finitely many symbolic states, while `d(K,s)` or another well-founded quantity controls recursion?

If yes, the residue tree may admit a finite ranked graph certificate. If the required intercept information grows without bound, that would be evidence against this particular finite-state architecture and should be recorded as a no-go mechanism rather than hidden by increasing the modulus forever.

## 8. Lean target

Formalization should prove:

1. uniform affine endpoint form;
2. the two exact refinement identities;
3. opposite parity of `C_0,C_1`;
4. the `s` / `s+1` child law;
5. the binomial counting corollary separately if useful;
6. the direct slope-pruning threshold.

These are bounded supporting lemmas. They are suitable early Lean targets because they can validate the certificate generator without requiring any conjecture-strength assumption.
