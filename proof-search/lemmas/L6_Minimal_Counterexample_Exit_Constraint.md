# L6 — Minimal-counterexample exit constraint from the -1/Mersenne skeleton

**Cycle:** Round 7, 2026-08-23  
**Status:** `PROVED_AUX` / `FORMAL_PENDING`  
**Novelty:** elementary Collatz coalescence identity; no novelty claim  
**Usefulness:** removes half of the first 2-adic exit states of any hypothetical least counterexample

## 1. Setup

Use the accelerated map

\[
T(n)=\begin{cases}
n/2,&n\text{ even},\\
(3n+1)/2,&n\text{ odd}.
\end{cases}
\]

For an odd positive integer `n`, define

\[
q=v_2(n+1),
\qquad
m=\frac{n+1}{2^q}.
\]

Then `m` is odd and

\[
\boxed{n=2^qm-1.}\tag{1}
\]

The first `q` accelerated steps are odd branches. Since the affine odd branch satisfies

\[
T_{m odd}(x)+1=\frac32(x+1),
\]

we have the exact identity

\[
\boxed{T^q(n)=3^qm-1.}\tag{2}
\]

This is the finite positive-integer exit from the 2-adic `-1` skeleton.

## 2. The case q=1 always descends

If `q=1`, then `n=4a+1` for some `a>=1` when `n>1`.

Then

\[
T(n)=6a+2,
\qquad
T^2(n)=3a+1<4a+1=n.
\]

Therefore every odd `n>1` with `v_2(n+1)=1` has direct descent.

Hence a hypothetical least nonconvergent odd integer must satisfy

\[
\boxed{q\ge2.}\tag{3}
\]

## 3. Good exit condition

Assume now `q>=2` and

\[
\boxed{3^qm\equiv1\pmod4.}\tag{4}
\]

By (2), `T^q(n)` is divisible by four, so

\[
T^{q+2}(n)=\frac{3^qm-1}{4}.\tag{5}
\]

There are two parity cases.

## 4. Case A: q even

If `q` is even, `3^q\equiv1 (mod 4)`. Condition (4) therefore means

\[
m\equiv1\pmod4.
\]

Define

\[
\boxed{n' = \frac{n-1}{2}=2^{q-1}m-1.}\tag{6}
\]

Clearly `0<n'<n` for `n>1`.

The first `q-1` accelerated steps from `n'` are odd, giving

\[
T^{q-1}(n')=3^{q-1}m-1.
\]

Since `q-1` is odd and `m\equiv1 (mod 4)`,

\[
3^{q-1}m-1\equiv2\pmod4.
\]

Thus one even step followed by one odd step gives

\[
T^{q+1}(n')
=
\frac{3^qm-1}{4}.
\]

Combining with (5),

\[
\boxed{T^{q+2}(n)=T^{q+1}\!\left(\frac{n-1}{2}\right).}\tag{7}
\]

So `n` coalesces exactly with the orbit of a smaller positive integer.

## 5. Case B: q odd

Now `q>=3` and `3^q\equiv3 (mod 4)`. Condition (4) means

\[
m\equiv3\pmod4.
\]

Define

\[
\boxed{n' = \frac{3n-1}{4}=3\cdot2^{q-2}m-1.}\tag{8}
\]

The congruence makes this an integer, and for `n>1`,

\[
0<n'<n
\]

because `(3n-1)/4<n`.

Also

\[
n'+1=3\cdot2^{q-2}m.
\]

Hence the first `q-2` accelerated steps from `n'` are odd and

\[
T^{q-2}(n')=3^{q-1}m-1.
\]

Since `q-1` is even and `m\equiv3 (mod4)`, this value is `2 mod 4`. Therefore one even step and one odd step yield

\[
T^q(n')=\frac{3^qm-1}{4}.
\]

Together with (5),

\[
\boxed{T^{q+2}(n)=T^q\!\left(\frac{3n-1}{4}\right).}\tag{9}
\]

Again `n` coalesces exactly with a smaller positive integer.

## 6. Strong-induction consequence

Suppose `n_*` is the least odd positive integer whose Collatz trajectory does not reach `1`.

By Section 2,

\[
q=v_2(n_*+1)\ge2.
\]

If (4) held, Sections 4–5 would give a smaller positive integer `n'<n_*` whose orbit coalesces with the orbit of `n_*`. Minimality would make `n'` convergent, forcing `n_*` to converge as well, a contradiction.

Therefore every hypothetical least counterexample must satisfy

\[
\boxed{3^qm\equiv3\pmod4.}\tag{10}
\]

Equivalently,

\[
\boxed{
\begin{array}{ll}
q\text{ even}:&m\equiv3\pmod4,\\
q\text{ odd}:&m\equiv1\pmod4.
\end{array}}
\tag{11}
\]

In residue-cylinder language, the least counterexample must leave the `-1` branch through

\[
\boxed{
n_*\equiv
\begin{cases}
3\cdot2^q-1\pmod{2^{q+2}},&q\text{ even},\\
2^q-1\pmod{2^{q+2}},&q\text{ odd}.
\end{cases}}
\tag{12}
\]

Thus the coalescence mechanism eliminates exactly one of the two possible mod-4 exit states for each `q>=2`.

## 7. Relation to the Round-7 certificate search

The fixed-cylinder exhaustive classifier shows the same pattern.

For cylinders

\[
2^{q+h}x+c2^q-1,
\qquad c\text{ odd},
\]

at small tested `h`, the whole-family inverse-word class certifies precisely the `c mod 4` half predicted by (11), while the complementary half persists as a class miss.

The theorem above is the symbolic reason for the certified half. The persistence of the complementary half is **not** itself a theorem for arbitrary future refinements and must not be extrapolated.

## 8. Why this matters

The old Rounds 4–6 identified the 2-adic point `-1` and long Mersenne shadows as an obstruction to simple local rankings. L6 uses a specifically **archimedean positive-integer fact** that the exact `-1` branch cannot continue forever for a positive integer: `q=v_2(n+1)` is finite.

When the orbit leaves that branch, half of the first exit states are now eliminated by exact smaller-orbit coalescence.

This is genuine theorem-strength narrowing of a hypothetical minimal counterexample, but it is far from a proof. The remaining hard exit class (10) still contains infinitely many positive integers and may support arbitrarily complicated subsequent behavior.

## 9. Next target

The next Route-D/AB question is:

> Starting from the hard exit condition `3^q m = 3 (mod 4)`, can one derive a second exact macro classification that either coalesces below the original `n` or maps the state into a finite ranked family of hard states?

The desired object is a recursive transition theorem, not merely a larger fixed-modulus table.

## 10. Lean targets

Formalize:

1. `q=v2(n+1)` decomposition `n=2^q m-1`;
2. exact `q`-step identity (2);
3. `q=1` direct descent;
4. even-`q` coalescence identity (7);
5. odd-`q` coalescence identity (9);
6. minimal-counterexample corollary (10)–(12).

These statements are elementary enough to make good early regression tests for the eventual Collatz certificate library.
