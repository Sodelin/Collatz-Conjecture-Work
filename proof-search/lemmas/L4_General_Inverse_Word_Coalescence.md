# L4 — General inverse-word coalescence semantics

**Cycle:** Round 7, 2026-08-23  
**Status:** `PROVED_AUX` / `FORMAL_PENDING`  
**Novelty:** elementary affine semantics; no novelty claim  
**Usefulness:** turns Route-AB macro search into finite words over two exact inverse operations

## 1. Accelerated Collatz map

Use

\[
T(n)=\begin{cases}
n/2,&n\text{ even},\\
(3n+1)/2,&n\text{ odd}.
\end{cases}
\]

Two exact one-step inverse operations are available.

### Even inverse

For every positive integer `y`,

\[
E(y)=2y,
\qquad T(E(y))=y.
\]

### Odd inverse

If

\[
y\equiv2\pmod3,
\]

then

\[
O(y)=\frac{2y-1}{3}
\]

is a positive odd integer and

\[
T(O(y))=y.
\]

Thus a finite word over `{E,O}` can be read as a finite exact inverse trajectory whenever every `O` is admissible at the stage where it is used.

## 2. Affine endpoint

Let a depth-`K` odd cylinder have the exact accelerated endpoint

\[
Y_0(x)=T^K(2^Kx+R)=3^s x+B,
\qquad x\ge0.\tag{1}
\]

Let

\[
w=w_1w_2\cdots w_j\in\{E,O\}^j
\]

be applied successively starting from `Y_0`:

\[
Y_i=w_i(Y_{i-1}).
\]

Let `r_i` be the number of `O` symbols among the first `i` letters, and let `r=r_j`.

## 3. Exact closed form

Define an integer sequence `c_i` by

\[
c_0=0,
\]

and, after `i` letters,

\[
\begin{aligned}
E:&\quad c_{i+1}=2c_i,\qquad r_{i+1}=r_i,\\
O:&\quad c_{i+1}=2c_i+3^{r_i},\qquad r_{i+1}=r_i+1.
\end{aligned}\tag{2}
\]

Then induction gives

\[
\boxed{
Y_i(x)=
\frac{2^i(3^s x+B)-c_i}{3^{r_i}}.
}\tag{3}
\]

Whenever all `O` steps are admissible, this is an integer affine family and

\[
\boxed{T^i(Y_i(x))=Y_0(x)}\tag{4}
\]

for every `x>=0`.

At the end,

\[
\boxed{
Y_j(x)=2^j3^{s-r}x+\frac{2^jB-c_w}{3^r},
}\tag{5}
\]

where `c_w=c_j`.

## 4. Uniform admissibility test

At stage `i`, before an `O` step, the leading coefficient in (3) is

\[
2^i3^{s-r_i}.
\]

If `r_i<s`, this coefficient is divisible by `3`, so the residue modulo `3` of the entire affine family is determined by its intercept. Therefore the proposed `O` step is uniformly valid for every integer `x>=0` exactly when that intercept is congruent to `2 mod 3`.

Equivalently, using (3), the condition is

\[
\frac{2^iB-c_i}{3^{r_i}}\equiv2\pmod3.\tag{6}
\]

This gives a finite exact checker for every candidate word as long as `r_i<s` before each `O`.

Once `r_i=s`, modulo-3 behavior can depend on `x`; a further whole-cylinder `O` step is not justified without refining the parameter cylinder. The macro checker must stop or explicitly introduce that refinement.

## 5. Coalescence certificate theorem

Suppose `w` passes the uniform admissibility test. Define

\[
m_w(x)=Y_j(x).
\]

Combining (1) and (4),

\[
\boxed{
T^K(2^Kx+R)=T^j(m_w(x)).
}\tag{7}
\]

Thus the original cylinder coalesces exactly with the orbit of `m_w(x)`.

The leading coefficient of the inverse family is

\[
A_w=2^j3^{s-r}.\tag{8}
\]

If

\[
\boxed{A_w<2^K,}\tag{9}
\]

then `m_w(x)<2^Kx+R` for all sufficiently large `x`. The remaining finite threshold is computed exactly from the intercept in (5).

There is one additional possibility omitted from the first version of this lemma.  If

\[
A_w=2^K
\]

and the intercept

\[
B_w=\frac{2^jB-c_w}{3^r}
\]

satisfies `B_w<R`, then `m_w(x)<2^Kx+R` for every `x` for which `m_w(x)>0`.  L5 classifies this equal-slope case exactly: for a generic forward state at time `t`, it requires `r=s`, `e=t-s`, and `|w|=t`.  In the present endpoint setup, `t=K` and `e=j-r`, so the conditions read `r=s`, `e=K-s`, and `j=K`.

Consequently, an admissible inverse word satisfying either the strict-slope condition (9) or the equal-slope/smaller-intercept condition is an eventual strong-induction certificate for the entire cylinder.

## 6. Certificate search interpretation

The search space is now explicit:

- state: the current affine pair plus the inverse-word counters `(i,r,c_i)`;
- move `E`: always legal;
- move `O`: legal only under the exact modulo-3 test (6);
- success: either coefficient inequality (9), or equal coefficient with a
  smaller intercept, plus the exact positivity/threshold check.

No trajectory sampling is necessary.

The coefficient score evolves multiplicatively:

- `E` multiplies it by `2`;
- `O` multiplies it by `2/3`.

So successful words need enough admissible `O` moves to compensate for their `E` moves and the initial slope `3^s/2^K`.

## 7. Relation to L3

L3 is the special case

\[
w=O^r.
\]

Then

\[
c_w=3^r-2^r
\]

in the equivalent expanded recurrence, and the admissibility condition reduces to a run of trailing ternary `2` digits in `B`.

L4 allows `E` moves between `O` moves and therefore captures mixed terminal binary/ternary macros that L3 misses.

## 8. New exact Round-7 certificate

For the depth-12 cylinder

\[
N(x)=4096x+1023,
\]

one computes

\[
T^{12}(N(x))=3^{10}x+14762=59049x+14762.
\]

The inverse word

\[
\boxed{w=OEOOOOOOOO}
\]

(length `10`, with `9` odd inverses and `1` even inverse) is uniformly admissible and gives

\[
\boxed{m_w(x)=3072x+767.}
\]

Therefore

\[
\boxed{
T^{12}(4096x+1023)=T^{10}(3072x+767)
}\tag{10}
\]

for every `x>=0`, and

\[
0<3072x+767<4096x+1023
\]

for every `x>=0`.

This is an exact whole-cylinder strong-induction coalescence certificate.

It was not found by the previously committed ordinary-map reverse search at depth `16` because the same accelerated inverse word expands to more ordinary-map inverse steps. The new certificate therefore closes one cylinder that the prior K=12 diagnostic had listed as unresolved.

Under the endpoint inverse-word language at macro depth `10`, the K=12 slope-hard set contains:

- `562` slope-hard cylinders;
- `418` with an endpoint inverse-word certificate;
- `144` remaining under this certificate class/search bound.

These counts are diagnostic properties of the specified search class, not a measure of percentage progress toward the conjecture.

## 9. Why this is a better search object than raw residue expansion

A raw residue search remembers thousands of integers. L4 compresses each candidate reduction into a finite word with exact affine semantics.

The next useful questions become combinatorial/arithmetic:

1. Which ternary suffix/carry states admit coefficient-winning inverse words?
2. Can successful words be generated by a finite grammar?
3. Can persistent failures be classified by a finite set of periodic/automatic word types?
4. Do the Round-5/6 rational periodic stress families correspond to periodic states in this inverse-word automaton?

Those questions are sharper than “increase K and see what happens.”

## 10. Lean target

Formalize a generic datatype of inverse words and prove:

1. the closed-form recurrence (3);
2. the exact admissibility checker for `O`;
3. `T^j(m_w(x))=Y_0(x)` for valid words;
4. the coefficient/intercept criterion implying eventual `m_w(x)<N(x)`;
5. a finite threshold theorem;
6. the concrete `4096x+1023 -> 3072x+767` certificate as a regression test.

Once this generic checker is trusted, future macro searches can be completely untrusted certificate generators.
