# Route AB no-go — Mersenne cylinders defeat every unrefined whole-family inverse word

**Cycle:** Round 7, 2026-08-23
**Status:** `FORMAL_PENDING`
**Scope verdict:** exact certificate-class no-go; broader Route AB not resolved
**Scope:** the exact L4/L5 class consisting of one uniform forward prefix followed by one uniformly admissible whole-family inverse word over `{E,O}`
**Collatz relevance:** rules out a certificate class on an infinite symbolic family; it neither proves nor disproves Collatz

## 1. Purpose and logical correction

L3 proves that the pure trailing-ternary-`2` inversion is neutral on the
Mersenne cylinder at its depth-`K` endpoint. L4 permits arbitrary mixed inverse
words over

\[
E(y)=2y,
\qquad
O(y)=\frac{2y-1}{3},
\]

and L5 bounds the search for inverse words whose leading coefficient is
strictly smaller than the original cylinder coefficient.

There is a separate affine possibility that must be checked explicitly:

> an inverse family can have the **same** leading coefficient as the original
> family and still be uniformly smaller if its intercept is smaller.

Thus strict coefficient shrink is not, by itself, a necessary condition for
eventual affine inequality. The theorem below includes this equal-slope case.
For the Mersenne family, equality can occur only for the exact reverse of the
forward odd prefix, and that word reconstructs the original family with the
same intercept. Consequently the Mersenne no-go survives the equal-slope
loophole.

## 2. Mersenne cylinder and every uniform forward state

Fix `K>=1` and define

\[
\boxed{M_K(x)=2^Kx+2^K-1=2^K(x+1)-1,\qquad x\ge0.}\tag{1}
\]

Use the accelerated Collatz map

\[
T(n)=
\begin{cases}
n/2,&n\text{ even},\\
(3n+1)/2,&n\text{ odd}.
\end{cases}
\]

For the odd branch `F(n)=(3n+1)/2`, one has

\[
F(n)+1=\frac32(n+1).
\]

Therefore, for every `0<=t<=K`,

\[
\boxed{
T^t(M_K(x))
=F^t(M_K(x))
=2^{K-t}3^t(x+1)-1.
}\tag{2}
\]

The branch claim is uniform: for `0<=j<K`,

\[
F^j(M_K(x))+1=2^{K-j}3^j(x+1)
\]

is even, so `F^j(M_K(x))` is odd for every `x>=0`. At `t=K` the
leading coefficient becomes odd and the next parity decision can depend on
`x`, exactly as in the cylinder endpoint semantics of L2.

Write the forward state in (2) as

\[
Y_t(x)=A_t x+B_t,
\qquad
A_t=2^{K-t}3^t,
\qquad
B_t=2^{K-t}3^t-1.
\tag{3}
\]

## 3. Arbitrary uniformly admissible inverse word

Let

\[
w\in\{E,O\}^j
\]

be any inverse word applied to the whole family `Y_t(x)`. Let

- `e` be the number of `E` symbols in `w`;
- `r` be the number of `O` symbols in `w`;
- `j=e+r`.

Each `E` multiplies the affine leading coefficient by `2`, while each `O`
multiplies it by `2/3`. Hence, if the word is uniformly admissible, its output

\[
m_w(x)=A_wx+D_w
\]

has leading coefficient

\[
\boxed{
A_w
=2^{K-t}3^t\frac{2^{e+r}}{3^r}
=2^{K-t+e+r}3^{t-r}.
}\tag{4}
\]

Uniform admissibility forces

\[
\boxed{r\le t.}\tag{5}
\]

Indeed, after `t` odd inverses have removed all factors of `3` from the
leading coefficient, that coefficient is coprime to `3`. The residue modulo
`3` of the affine family then varies with `x`; it cannot be identically `2`
modulo `3`, which is required for another whole-family `O` step. Interspersed
`E` operations only multiply the coefficient by powers of `2` and do not
restore a factor of `3`.

Dividing (4) by the original leading coefficient `2^K` gives the exact ratio

\[
\boxed{
\frac{A_w}{2^K}
=2^e\left(\frac32\right)^{t-r}.
}\tag{6}
\]

By `e>=0` and (5),

\[
\boxed{A_w\ge2^K.}\tag{7}
\]

Thus strict leading-coefficient improvement is impossible at every forward
time and every inverse-word depth.

## 4. Classification of the equal-slope case

Suppose

\[
A_w=2^K.
\]

Equation (6) gives

\[
2^e\left(\frac32\right)^{t-r}=1.
\]

Both factors are at least one. Hence

\[
\boxed{e=0,\qquad r=t.}\tag{8}
\]

Since the word contains no `E` symbols and exactly `t` `O` symbols, necessarily

\[
\boxed{w=O^t.}\tag{9}
\]

This word is the exact inverse of the `t` legitimate odd forward branches.
More explicitly, for `0<=i<=t`,

\[
O^i(Y_t(x))
=2^{K-t+i}3^{t-i}(x+1)-1,
\tag{10}
\]

so at `i=t`,

\[
\boxed{O^t(Y_t(x))=2^K(x+1)-1=M_K(x).}\tag{11}
\]

The equal-slope word therefore has the same intercept `2^K-1`, not a smaller
one. It reconstructs the original family exactly.

## 5. No-go theorem

### Theorem — all-depth unrefined inverse-word obstruction

For every `K>=1`, every uniform forward time `0<=t<=K`, and every uniformly
admissible whole-family inverse word `w` from `T^t(M_K(x))`, the resulting
affine family `m_w(x)=A_wx+D_w` satisfies exactly one of:

1. `A_w>2^K`, in which case `m_w(x)>M_K(x)` for all sufficiently large `x`;
2. `A_w=2^K`, in which case `w=O^t` and `m_w(x)=M_K(x)` identically.

In particular, there is no threshold `x_0` for which

\[
0<m_w(x)<M_K(x)
\qquad\text{for every }x\ge x_0.
\]

### Proof

Equations (5)-(7) exclude `A_w<2^K`. If `A_w>2^K`, then

\[
m_w(x)-M_K(x)
=(A_w-2^K)x+\bigl(D_w-(2^K-1)\bigr)
\]

is positive for all sufficiently large `x`. If `A_w=2^K`, Section 4 proves
that `w=O^t` and equation (11) gives exact equality of the two affine
families. These cases exhaust all uniformly admissible words. ∎

## 6. Exact refinement identity and the boundary problem

The no-go theorem applies only while the entire parameter family is kept
unrefined. Refining the next binary digit gives

\[
M_K(2y)=2^{K+1}y+2^K-1
\tag{12}
\]

and

\[
\boxed{
M_K(2y+1)
=2^{K+1}y+2^{K+1}-1
=M_{K+1}(y).
}\tag{13}
\]

Thus one child exits the exact Mersenne form, while the high child is the next
Mersenne cylinder. This is the precise recursive obstruction that a stronger
Route-AB graph must represent.

For a fixed positive parameter `x=2y+1`, the quotient `y` is smaller than `x`,
so a rank based on the unprocessed high binary prefix can justify only the act
of reading/refining the finite input. It does not close the boundary family

\[
M_K(0)=2^K-1
\qquad(K\ge1).
\]

Those are infinitely many positive starts. They cannot be dismissed as one
finite collection of exceptional values merely because each fixed cylinder
has a finite exceptional set. A global recursive certificate must include an
exact boundary-sensitive macro or another well-founded transition that works
uniformly in the accumulated exponent `K`.

The obvious local quantities do not supply that rank:

- `K` increases under the hard-child transition (13);
- the trailing ternary-`2` count also increases;
- the slope deficit `K-K log_2(3)` moves without a lower bound in `R` and is
  not a well-founded natural-valued rank.

The 2-adic control value `x=-1` makes the positivity seam visible:
`M_K(-1)=-1` for every `K`. Any proposed local grammar that never uses the
finite canonical left boundary risks proving termination in this false
neighboring world as well.

## 7. Relation to L3, L4, L5, and Route AB

### L3

L3 treats the endpoint `t=K` and the pure word `O^r`. Its Mersenne calculation
shows that `O^K` is neutral. The present theorem extends that obstruction to:

- every uniform forward time `0<=t<=K`;
- every ordering and mixture of `E` and `O`;
- every inverse-word length allowed by uniform whole-family admissibility;
- the equal-leading-coefficient case.

### L4

L4 supplies the exact semantics used in (4)-(5). The theorem is therefore a
complete no-go result for the L4 whole-family inverse-word class on the
Mersenne cylinders, not a failed bounded search.

### L5

Corrected L5 classifies all uniformly smaller affine families and includes the
boundary

\[
A_w=2^K,
\qquad D_w<2^K-1.
\]

The present theorem specializes that corrected equal-slope boundary to the
Mersenne family and proves that it yields only exact reconstruction. Thus the
no-go conclusion includes both branches of corrected L5's complete affine
comparison criterion.

### Route AB

Increasing inverse-word depth cannot reopen this family. Route AB must add a
genuinely stronger mechanism, such as:

1. parameter refinement inside the macro;
2. a finite recursive mixed-radix graph handling (13);
3. an explicit rank depending on the remaining canonical input and a separate
   boundary mechanism for variable `K`;
4. a certificate language beyond one uniform forward prefix followed by one
   whole-family inverse word.

## 8. Failure-ledger reopening record

**Old blocker:** L3 showed that maximal trailing-`2` inversion is exactly
neutral on the Mersenne endpoint, but arbitrary mixed `E/O` words and earlier
forward times had not been excluded symbolically.

**New mechanism:** the exact leading-coefficient ratio (6), combined with the
uniform admissibility bound `r<=t` and an explicit classification of the
equal-slope case.

**Why it bypasses the blocker:** it quantifies over all inverse-word depths and
all word orders in the unrefined L4 class. It does not extrapolate from a
bounded search or assume that equal slope cannot be smaller.

**First falsification test:** for any claimed counterexample `(K,t,w)`, count
its `E` and `O` symbols. Uniform admissibility must give `r<=t`. Equation (6)
then forces `A_w>=2^K`; equality forces `w=O^t`, for which equation (11)
replays the exact original family. A valid smaller family would have to break
one of these exact checks.

**Exact theorem target now:** construct a finite refinement-aware
mixed-radix/coalescence graph whose hard transition includes (13), whose
canonical left-boundary cases are fully covered, and whose back-edges decrease
an explicit well-founded rank.

**Subroute verdict:** the unrefined whole-family inverse-word route is killed
on the Mersenne family by the exact no-go above. The broader refinement-aware
Route AB is `BLOCKED_NO_MECHANISM` until it supplies a concrete boundary-aware
rank or transition mechanism.
