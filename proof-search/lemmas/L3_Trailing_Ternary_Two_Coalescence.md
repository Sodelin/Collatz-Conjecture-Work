# L3 — Trailing-ternary-2 coalescence certificate

**Cycle:** Round 7, 2026-08-23  
**Status:** `PROVED_AUX` / `FORMAL_PENDING`  
**Novelty:** elementary consequence of the accelerated Collatz affine map; no novelty claim  
**Usefulness:** gives a closed-form subfamily of Route-AB coalescence certificates and exposes the Mersenne extremal obstruction

## 1. Accelerated convention

Use

\[
T(n)=\begin{cases}
n/2,&n\text{ even},\\
(3n+1)/2,&n\text{ odd}.
\end{cases}
\]

For an odd binary cylinder

\[
N(x)=2^Kx+R,
\]

Round-7 Lemma L2 gives an exact endpoint after the `K` low binary decisions:

\[
\boxed{T^K(N(x))=3^s x+B},\tag{1}
\]

with `0<=B<3^s`. Thus `B`, padded to `s` ternary digits, is literally the fixed ternary suffix left after those `K` binary decisions have been converted.

## 2. Odd-branch iterate identity

Let

\[
F(n)=\frac{3n+1}{2}
\]

be the odd branch of `T`.

Because `-1` is the affine fixed point,

\[
F(n)+1=\frac32(n+1).
\]

Therefore, whenever the first `r` applications are legitimately odd branches,

\[
\boxed{
F^r(n)+1=\left(\frac32\right)^r(n+1)
}\tag{2}
\]

or equivalently

\[
F^r(n)=\frac{3^r(n+1)}{2^r}-1.\tag{3}
\]

## 3. Trailing-2 condition

Suppose the base-3 expansion of `B` ends in at least `r` digits equal to `2`. This is equivalent to

\[
B\equiv 3^r-1\pmod{3^r},
\]

or

\[
3^r\mid B+1.\tag{4}
\]

Write

\[
q=\frac{B+1}{3^r}\in\mathbb Z_{>0}.
\]

Define

\[
\boxed{
m_r(x)=2^r3^{s-r}x+2^rq-1.}\tag{5}
\]

Then `m_r(x)` is positive and odd for every `x>=0`.

## 4. Exact coalescence theorem

For `0<=j<r`, direct use of (5) gives

\[
F^j(m_r(x))
=
3^j2^{r-j}(3^{s-r}x+q)-1.
\tag{6}
\]

The coefficient multiplying the parenthesis is even when `j<r`, so every value in (6) is odd. Hence every one of these `r` applications really does use the odd branch of `T`.

At `j=r`,

\[
\begin{aligned}
F^r(m_r(x))
&=3^r(3^{s-r}x+q)-1\\
&=3^s x+3^rq-1\\
&=3^s x+B.
\end{aligned}
\]

Combining with (1),

\[
\boxed{T^K(N(x))=T^r(m_r(x)).}\tag{7}
\]

So the entire binary cylinder coalesces exactly with the orbit of the explicit affine family `m_r`.

## 5. When the coalescing family is smaller

The leading coefficient of `m_r` is

\[
a_r=2^r3^{s-r}.
\]

If

\[
\boxed{2^r3^{s-r}<2^K,}\tag{8}
\]

then `m_r(x)<N(x)` for every sufficiently large `x`.

An exact finite threshold follows from

\[
(2^K-a_r)x>(2^rq-1)-R.
\]

Thus (4) plus (8) gives an **eventual strong-induction coalescence certificate** for the whole cylinder; only finitely many lower parameter values remain to be checked separately.

Solving (8) for `r` gives the useful slope-excess criterion

\[
r>
\frac{s\log_2 3-K}{\log_2(3/2)}.
\tag{9}
\]

## 6. K=12 diagnostic

At `K=12`, the minimum number of trailing ternary `2` digits sufficient by (8) is:

| endpoint exponent `s` | minimum `r` |
|---:|---:|
| 8 | 2 |
| 9 | 4 |
| 10 | 7 |
| 11 | 10 |
| 12 | impossible with `r<=s` |

Among the 562 slope-hard depth-12 cylinders, 196 satisfy this simple trailing-2 sufficient condition.

All 196 are indeed certified by the current exact search:

- 103 already have an earlier direct-descent certificate;
- 93 require/also admit a coalescence mechanism;
- 0 remain unresolved.

This agreement is a diagnostic cross-check of the algebra, not an independent proof of the full search implementation.

## 7. Why the Mersenne / -1 shadow is extremal

For

\[
R=2^K-1,
\]

one has the exact all-odd accelerated shadow

\[
T^K(2^Kx+2^K-1)=3^Kx+3^K-1.
\]

Thus `s=K` and the ternary suffix is

\[
B=3^K-1=(\underbrace{22\ldots2}_{K\text{ ternary digits}})_3.
\]

It has the maximum possible trailing-2 run `r=K`, but the inverse family from (5) is

\[
m_K(x)=2^K(x+1)-1=N(x).
\]

There is **equality**, not descent.

For every partial peel `r<K`,

\[
2^r3^{K-r}>2^K
\]

because `(3/2)^{K-r}>1`.

Therefore the entire trailing-2 inversion mechanism is exactly neutral on the Mersenne family. This recovers, in the mixed-radix language, why the old `-1` shadow is a genuine stress family rather than something the simplest coalescence rule can dispose of.

## 8. Interpretation in the Yolcu-Aaronson-Heule rewriting system

A coefficient `3^s` with `0<=B<3^s` is a high variable followed by `s` ternary digits. A trailing ternary `2` is precisely the output created by the odd dynamic rule

```text
t$ -> 2$
```

in the mixed-base SRS.

Equation (5) peels a run of such dynamic odd branches backwards. Therefore this lemma is an explicit closed-form Route-AB macro rather than merely an empirical residue pattern.

## 9. Next generalization

The current reverse BFS can discover mixed binary/ternary predecessor words more general than a pure run of odd branches. The natural next target is:

> derive a closed-form certificate for an arbitrary short terminal mixed-radix word, classify when its affine leading coefficient is smaller than `2^K`, and search for a finite set of word templates covering the non-Mersenne survivors.

This is a substantially narrower search object than arbitrary coalescence prose: finite terminal mixed-radix macros with exact coefficient/intercept formulas.

## 10. Kill condition

Do not infer from the 196 certificates that long trailing-2 runs become globally inevitable. The Mersenne family proves the opposite kind of warning: even the longest possible run can be exactly neutral.

A full route still needs a mechanism for arbitrary persistent mixed-radix words, especially those corresponding to rational/2-adic stress families.
