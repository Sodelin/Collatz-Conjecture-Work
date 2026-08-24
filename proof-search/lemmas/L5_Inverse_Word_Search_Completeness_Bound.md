# L5 — Corrected completeness bound for whole-family inverse-word coalescence search

**Cycle:** Round 7, 2026-08-23  
**Status:** `FORMAL_PENDING`
**Revision:** corrected after a concrete equal-slope counterexample to the original completeness claim
**Usefulness:** removes the arbitrary reverse-depth parameter from one Route-AB certificate class, including equal-slope translations
**Collatz relevance:** certificate-class semantics only; not a global proof

## 0. Codex hostile-audit correction

The first committed version asserted that a successful affine reduction must have

$$
A_w<2^K.
$$

That necessity claim was false.  If `A_w=2^K` and the inverse-family intercept is smaller than the original intercept, then the two families are parallel and the inverse family is still strictly smaller for every parameter.

The smallest concrete witness found by the hostile audit is

$$
N(x)=8x+5,
\qquad
T^3(N(x))=3x+2.
$$

The inverse word `OEE` gives

$$
m(x)=8x+4,
\qquad
T^3(m(x))=3x+2,
$$

so `0<m(x)<N(x)` for every `x>=0` even though the two leading coefficients are equal.  The old bound `|w|<=t-1` excluded this valid certificate.

The corrected theorem below proves that this is the only additional coefficient case: a successful word either has strict slope decrease and length at most `t-1`, or uses exactly the forward odd/even branch counts, has length exactly `t`, and wins by a smaller intercept.

## 1. Setup

Use the accelerated Collatz map

$$
T(n)=\begin{cases}
n/2,&n\text{ even},\\
(3n+1)/2,&n\text{ odd}.
\end{cases}
$$

Fix an odd binary cylinder

$$
N(x)=2^Kx+R.
$$

After a uniform prefix of `t` accelerated steps, suppose `s` of those steps were odd branches. Then the exact affine state has the form

$$
\boxed{
Y(x)=T^t(N(x))=2^{K-t}3^s x+B.
}\tag{1}
$$

This follows because each accelerated step consumes one factor of two from the leading coefficient; an odd step also contributes one factor of three.

Now apply an admissible inverse word

$$
w\in\{E,O\}^j,
$$

where

$$
E(y)=2y,
\qquad
O(y)=\frac{2y-1}{3}
$$

and every `O` is required to be uniformly valid for the entire affine family at the point where it occurs.

Let

- `e` = number of `E` symbols in `w`;
- `r` = number of `O` symbols in `w`;
- `j=e+r`.

Because a uniform `O` requires the current leading coefficient to remain divisible by three,

$$
\boxed{r\le s.}\tag{2}
$$

## 2. Exact leading coefficient and eventual-smaller criterion

Each `E` multiplies the leading coefficient by `2`; each `O` multiplies it by `2/3`. Therefore the coalescing inverse family

$$
m_w(x)
$$

has leading coefficient

$$
\boxed{
A_w=2^{K-t+e+r}3^{s-r}.
}\tag{3}
$$

A complete coefficient/intercept criterion for

$$
0<m_w(x)<N(x)
$$

for all sufficiently large `x` is:

$$
\boxed{
A_w<2^K
\quad\text{or}\quad
\bigl(A_w=2^K\ \text{and}\ B_w<R\bigr),
}\tag{4}
$$

where `m_w(x)=A_w x+B_w`.  Positivity supplies only the usual finite lower threshold because every inverse-family leading coefficient here is positive.

Indeed, if `A_w>2^K`, then `m_w(x)-N(x)` is eventually positive.  If the coefficients are equal, the difference is the constant `B_w-R`.  If `A_w<2^K`, the original strict-slope threshold argument applies.

## 3. Strict-slope even-inverse budget theorem

First assume the strict branch of (4):

$$
A_w<2^K.
$$

Since `3>=2`,

$$
3^{s-r}\ge2^{s-r}.
$$

Using (3),

$$
A_w
\ge
2^{K-t+e+r}2^{s-r}
=
2^{K-t+e+s}.
$$

If `A_w<2^K`, then necessarily

$$
K-t+e+s<K,
$$

hence

$$
\boxed{e<t-s.}\tag{5}
$$

But `t-s` is exactly the number of **even forward branches** in the prefix.

### Interpretation

A strict-slope whole-family inverse coalescence word must use strictly fewer even inverse steps than the forward prefix used even branches.

This is an exact arithmetic restriction, not a heuristic search bound.

## 4. Strict-slope length bound

Combining

$$
e\le t-s-1
$$

with

$$
r\le s,
$$

we get

$$
j=e+r
\le(t-s-1)+s
=t-1.
$$

Therefore every strict-slope certificate satisfies

$$
\boxed{|w|\le t-1}.\tag{6}
$$

## 5. Equal-slope classification

Now suppose

$$
A_w=2^K.
$$

Using (3) and unique factorization,

$$
2^{K-t+e+r}3^{s-r}=2^K
$$

is possible exactly when the remaining power of three disappears,

$$
r=s,
$$

and the powers of two then agree,

$$
e=t-s.
$$

Conversely these two count equalities give `A_w=2^K`.  Thus an equal-slope candidate must use exactly all `s` available odd inverses and exactly as many even inverses as the forward prefix used even branches.  In particular,

$$
\boxed{|w|=e+r=t.}\tag{7}
$$

It is a genuine reduction exactly when its intercept satisfies

$$
\boxed{B_w<R.}\tag{8}
$$

The `8x+5 -> 8x+4` witness in Section 0 is this case with `t=3`, `s=1`, `r=1`, and `e=2`.

## 6. Corrected completeness consequence

For a fixed cylinder `2^Kx+R` and a fixed uniform forward state at time `t`, the following search is **complete for this certificate class**:

1. enumerate only uniformly admissible inverse words;
2. never allow more than `t-s` occurrences of `E`;
3. never allow more than `s` occurrences of `O`;
4. test the exact affine coefficient/intercept inequality (4) against `N(x)`.

No successful certificate in this class can occur at inverse depth greater than `t`: strict-slope winners obey (6), while equal-slope winners obey (7).

Taking all forward times

$$
1\le t\le K
$$

makes inverse depth at most

$$
K.
$$

Thus the arbitrary `max_inverse_depth` used in the first Round-7 diagnostics can be replaced by an exact finite exhaustive search for each fixed binary cylinder.

## 7. What this does and does not prove

### It proves

At fixed `K,R`, a complete finite search can decide whether the cylinder has a certificate of the following exact type:

> follow one uniform accelerated forward prefix, then take one uniformly valid whole-family inverse word to a positive affine family that is eventually smaller, either by strict leading-coefficient decrease or by equal leading coefficient with strictly smaller intercept.

A search miss after applying the bound is therefore a **certificate-class miss**, not merely “we did not search deep enough.”

### It does not prove

A miss does **not** show the cylinder contains a divergent orbit. Other certificate types may exist, including:

- refinement of the parameter during the inverse macro;
- recursive graph transitions rather than one-shot coalescence;
- non-affine or vector rankings;
- mixed-radix macros whose progress is not immediate coefficient shrink;
- entirely different proof mechanisms.

Likewise, exhausting this class for every cylinder at one finite `K` would still not prove Collatz unless the resulting finite data has a sound recursive coverage theorem.

## 8. Methodological significance

This is the preferred way to use failed computation in the project:

```text
arbitrary bounded search
        ↓
prove a mathematical completeness bound for the certificate class
        ↓
rerun as an exhaustive finite classifier
        ↓
separate CLASS_MISS from SEARCH_DEPTH_MISS
```

That distinction is now part of the shared Proof-Attack methodology.

## 9. Lean target

The equal-slope affine comparison criterion and the concrete
`8x+5 -> 8x+4` once-accelerated witness are now type-checked under pinned
Lean 4.33.1 in:

- `lean/CollatzWork/InverseWordBoundaryStatement.lean` (trusted propositions);
- `lean/CollatzWork/InverseWordBoundary.lean` (proofs and axiom audit).

The clean build log and SHA-256 manifest are under `verification/`.  This is a
formalized boundary sublemma and regression, not a formalization of the full
L5 completeness theorem.

Remaining formalization targets:

Formalize:

1. the exact forward leading coefficient `2^(K-t) * 3^s`;
2. inverse-word coefficient formula (3);
3. `r<=s` under uniform whole-family admissibility;
4. the inequality `A_w >= 2^(K-t+e+s)`;
5. theorem `(A_w < 2^K) -> e < t-s`;
6. equal-slope equivalence `A_w=2^K <-> (r=s and e=t-s)`;
7. connect the now-formalized equal-intercept affine criterion to the generic
   inverse-word semantics;
8. corrected global class bound `|w|<=t`.

This theorem is small enough to formalize before any large certificate table is trusted.
