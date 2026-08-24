# L5 — Completeness bound for whole-family inverse-word coalescence search

**Cycle:** Round 7, 2026-08-23  
**Status:** `PROVED_AUX` / `FORMAL_PENDING`  
**Usefulness:** removes the arbitrary reverse-depth parameter from one Route-AB certificate class  
**Collatz relevance:** certificate-class semantics only; not a global proof

## 1. Setup

Use the accelerated Collatz map

\[
T(n)=\begin{cases}
n/2,&n\text{ even},\\
(3n+1)/2,&n\text{ odd}.
\end{cases}
\]

Fix an odd binary cylinder

\[
N(x)=2^Kx+R.
\]

After a uniform prefix of `t` accelerated steps, suppose `s` of those steps were odd branches. Then the exact affine state has the form

\[
\boxed{
Y(x)=T^t(N(x))=2^{K-t}3^s x+B.
}\tag{1}
\]

This follows because each accelerated step consumes one factor of two from the leading coefficient; an odd step also contributes one factor of three.

Now apply an admissible inverse word

\[
w\in\{E,O\}^j,
\]

where

\[
E(y)=2y,
\qquad
O(y)=\frac{2y-1}{3}
\]

and every `O` is required to be uniformly valid for the entire affine family at the point where it occurs.

Let

- `e` = number of `E` symbols in `w`;
- `r` = number of `O` symbols in `w`;
- `j=e+r`.

Because a uniform `O` requires the current leading coefficient to remain divisible by three,

\[
\boxed{r\le s.}\tag{2}
\]

## 2. Exact leading coefficient after the inverse word

Each `E` multiplies the leading coefficient by `2`; each `O` multiplies it by `2/3`. Therefore the coalescing inverse family

\[
m_w(x)
\]

has leading coefficient

\[
\boxed{
A_w=2^{K-t+e+r}3^{s-r}.
}\tag{3}
\]

A necessary condition for `m_w(x)<N(x)` for all sufficiently large `x` is

\[
A_w<2^K.\tag{4}
\]

## 3. Even-inverse budget theorem

Since `3>=2`,

\[
3^{s-r}\ge2^{s-r}.
\]

Using (3),

\[
A_w
\ge
2^{K-t+e+r}2^{s-r}
=
2^{K-t+e+s}.
\]

If (4) holds, then necessarily

\[
K-t+e+s<K,
\]

hence

\[
\boxed{e<t-s.}\tag{5}
\]

But `t-s` is exactly the number of **even forward branches** in the prefix.

### Interpretation

A successful whole-family inverse coalescence word must use strictly fewer even inverse steps than the forward prefix used even branches.

This is an exact arithmetic restriction, not a heuristic search bound.

## 4. Length bound

Combining

\[
e\le t-s-1
\]

with

\[
r\le s,
\]

we get

\[
j=e+r
\le(t-s-1)+s
=t-1.
\]

Therefore

\[
\boxed{|w|\le t-1}\tag{6}
\]

for every successful whole-family inverse-word certificate from the forward state at time `t`.

## 5. Completeness consequence

For a fixed cylinder `2^Kx+R` and a fixed uniform forward state at time `t`, the following search is **complete for this certificate class**:

1. enumerate only uniformly admissible inverse words;
2. never allow more than `t-s-1` occurrences of `E`;
3. never allow more than `s` occurrences of `O`;
4. test the exact affine coefficient/intercept inequality against `N(x)`.

No successful certificate in this class can occur at greater inverse depth, because (6) forbids it.

Taking all forward times

\[
1\le t\le K
\]

makes inverse depth at most

\[
K-1.
\]

Thus the arbitrary `max_inverse_depth` used in the first Round-7 diagnostics can be replaced by an exact finite exhaustive search for each fixed binary cylinder.

## 6. What this does and does not prove

### It proves

At fixed `K,R`, a complete finite search can decide whether the cylinder has a certificate of the following exact type:

> follow one uniform accelerated forward prefix, then take one uniformly valid whole-family inverse word to a positive affine family whose leading coefficient is smaller than `2^K` and whose exact intercept inequality gives a finite strong-induction threshold.

A search miss after applying the bound is therefore a **certificate-class miss**, not merely “we did not search deep enough.”

### It does not prove

A miss does **not** show the cylinder contains a divergent orbit. Other certificate types may exist, including:

- refinement of the parameter during the inverse macro;
- recursive graph transitions rather than one-shot coalescence;
- non-affine or vector rankings;
- mixed-radix macros whose progress is not immediate coefficient shrink;
- entirely different proof mechanisms.

Likewise, exhausting this class for every cylinder at one finite `K` would still not prove Collatz unless the resulting finite data has a sound recursive coverage theorem.

## 7. Methodological significance

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

## 8. Lean target

Formalize:

1. the exact forward leading coefficient `2^(K-t) * 3^s`;
2. inverse-word coefficient formula (3);
3. `r<=s` under uniform whole-family admissibility;
4. the inequality `A_w >= 2^(K-t+e+s)`;
5. theorem `(A_w < 2^K) -> e < t-s`;
6. corollary `|w| <= t-1`.

This theorem is small enough to formalize before any large certificate table is trusted.
