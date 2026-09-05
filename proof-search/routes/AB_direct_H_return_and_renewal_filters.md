# Direct hard-boundary returns and renewal filters

**Primary claim:** `F-DIRECT-H-RETURN-ARITHMETIC-001`

**Secondary claim:** `F-RENEWAL-GCD-FILTER-001`

**Status:** `STOPPED-USEFUL` / `FORMAL_PENDING` / `NO PROOF OR DISPROOF`

**Novelty:** elementary affine and valuation packaging; no novelty claim

**Global verdict:** Collatz remains unresolved

## 1. Convention and hard states

For a positive odd integer `x`, define the fully accelerated map

$$
T(x)=\frac{3x+1}{2^{v_2(3x+1)}}.
$$

For positive odd parameters `u`, put

$$
H_1(u)=4u+3,
\qquad
H_2(u)=16u+11.
$$

These are the two terminal families in the L14 normalizer. The transition
system below records only **direct actual-orbit returns** that remain in their
union. It is partial: a parameter outside a displayed domain exits the hard
set and must be handled by a separate normalization step.

## 2. Exact partial typed transition system

The four direct typed edges are:

$$
\begin{array}{lll}
AA:&u\equiv3\pmod4,
&H_1(u)\xrightarrow{T}H_1\!\left(\frac{3u+1}{2}\right),\\[1ex]
AB:&u\equiv9\pmod{16},
&H_1(u)\xrightarrow{T}H_2\!\left(\frac{3(u-1)}8\right),\\[1ex]
BA:&u\equiv1\pmod4,
&H_2(u)\xrightarrow{T^2}H_1\!\left(\frac{9u+5}{2}\right),\\[1ex]
BB:&u\equiv15\pmod{16},
&H_2(u)\xrightarrow{T^2}H_2\!\left(\frac{9u+1}{8}\right).
\end{array}
$$

The `A`-source edges consume one accelerated valuation, exactly `1`. The
`B`-source edges consume two valuations, exactly `(1,2)`. These claims follow
from

$$
\begin{aligned}
T(H_1(u))&=6u+5,\\
T(H_2(u))&=24u+17,\\
T^2(H_2(u))&=18u+13,
\end{aligned}
$$

and matching those outputs against the two parameterizations. The displayed
residue domains are exactly the conditions that the target parameter be a
positive odd integer of the stated type.

This partial system is denoted `D` below. It is not a total normalizer and is
not the full Collatz return map.

## 3. Completed direct `A`-returns

An `AA` edge is a one-edge completed `A`-return. Every completed switching
excursion has the typed form

$$
AB\,BB^{k-1}BA
\qquad(k\ge1).
$$

For every positive odd `u` and every `k >= 1`, starting at `H_1(u)` the
displayed switching path exists exactly when

$$
\boxed{v_2(3u+5)=3k+1.}
$$

Consequently, a switching return exists exactly when
`t=v_2(3u+5) >= 4` and `t` is congruent to `1` modulo `3`; its length is then
unique, with `k=(t-1)/3`.

If its terminal `H_1`-parameter is `v`, then

$$
\boxed{2\cdot8^k(v+2)=9^k(3u+5).}
$$

Equivalently, write

$$
3u+5=2\cdot8^kq
$$

with `q` positive odd. Then

$$
\boxed{
u=\frac{2\cdot8^kq-5}{3},
\qquad
v=9^kq-2,
}
$$

where `q \equiv (-1)^k \pmod 3`. Conversely, for `k >= 1` and every positive
odd `q` with this congruence, the displayed formulas define positive odd
parameters `u,v` and the stated path. (The inequality `2*8^k*q>5` is then
automatic.)

The identity is an exact two-place description. Large 2-adic divisibility of
`3u+5` forces a large real parameter; it does not create a contradiction.
Real growth and 2-adic closeness are limits in different completions and must
not be identified.

## 4. Conditional consequences of an infinite positive `D`-ray

Every defined direct edge strictly increases the underlying hard state:

$$
T(h)=\frac{3h+1}{2}>h
$$

on an `A`-source edge, while

$$
T^2(h)=\frac{9h+5}{8}>h
$$

on a `B`-source edge. Thus an infinite positive `D`-ray would be unbounded
along its typed endpoints.

It would also switch types infinitely often. An eventual all-`A` tail would
force arbitrarily large powers of `2` to divide one fixed `u+1`, because an
`AA` edge sends

$$
u+1\longmapsto\frac32(u+1).
$$

An eventual all-`B` tail would force the same impossibility in powers of `8`,
because a `BB` edge sends

$$
u+1\longmapsto\frac98(u+1).
$$

Finally, the typed code could not be eventually periodic. A typed period gives
an eventually periodic expanded exact valuation word
`a_0,...,a_(r-1)`, where `r` counts accelerated `T`-steps (a typed `B` edge
contributes two). Put `B=sum_j a_j`, and let `C` be its affine correction.
The period return map is

$$
F(z)=\frac{3^r z+C}{2^B}.
$$

For every `k`, integrality of `F^k(z)` implies

$$
2^{Bk}\mid (2^B-3^r)z-C.
$$

Indeed, after writing the numerator of `F^k(z)` over `2^(Bk)`, multiply it by
the odd integer `3^r-2^B` and subtract the corresponding geometric sum. The
remaining numerator is exactly a power of `3^r` times the displayed fixed
integer, so the odd factor is invertible modulo `2^(Bk)`. Divisibility for all
`k` forces that integer to vanish. Hence `F(z)=z`, contradicting strict growth
at every completed typed edge.

These are conditional consequences only. This note neither constructs nor
excludes an infinite positive `D`-ray. Even excluding every direct ray would
leave trajectories with infinitely many exits followed by non-direct
normalization.

## 5. One-way long-run ghost filter

Let `x_0=N` be a positive odd seed and `x_(n+1)=T(x_n)`. Suppose a proposed
typed itinerary contains runs of `m_j >= 1` consecutive exact valuation-`1`
steps beginning at accelerated times `s_j >= 0`. If

$$
\sup_j\left(m_j+1-s_j\log_2(3/2)\right)=\infty,
$$

then no single positive ordinary seed realizes that itinerary.

Indeed, the run identity gives

$$
2^{m_j+1}\mid x_{s_j}+1,
$$

while every preceding accelerated step obeys

$$
x_{s_j}+1\le(3/2)^{s_j}(N+1)
$$

for a fixed initial seed `N`. The two inequalities contradict the displayed
unboundedness.

Finite typed prefixes may still lie in nonempty positive residue cylinders.
If these cylinders are nested and coherent, their limit is a no-positive-seed
2-adic realization; it may still be an ordinary negative integer (the all-`1`
word realizes `-1`). Without that compatibility hypothesis, the inequality
proves only that no positive odd seed realizes the proposed code. The filter
is one-way: bounded or subthreshold runs do not prove that a positive realizing
seed exists.

## 6. Renewal-block identity

Let `x` be positive odd and write

$$
x+1=2^Rq,
\qquad R=v_2(x+1)\ge1,
$$

with `q` positive odd. Put

$$
b=v_2(3^Rq-1)\ge1,
\qquad
y=\frac{3^Rq-1}{2^b}.
$$

Then the first `R-1` accelerated valuations from `x` are `1`, the `R`th is
`b+1`, and

$$
y=T^R(x).
$$

The exact affine identity is

$$
\boxed{2^{R+b}y=3^Rx+(3^R-2^R).}
$$

## 7. Two separate common-divisor filters

Consider a nonempty, possibly infinite tail of renewal states `x_i`, with
renewal lengths `R_i`, next states `x_(i+1)`, and exponents `b_i` as in
Section 6.

If one positive odd integer `d` divides **every state** `x_i`, then

$$
d\mid3^{R_i}-2^{R_i}
$$

for every `i`. With

$$
g=\gcd_iR_i,
$$

the claim is immediate for `d=1`. For `d>1`, the displayed divisibilities also
give `gcd(d,6)=1`, so the order of `3*2^(-1)` modulo `d` divides every `R_i`
and hence divides `g`. Therefore

$$
\boxed{d\mid3^g-2^g.}
$$

Separately, if one positive odd integer `d` divides **every shifted state** `x_i+1`,
then the renewal equation modulo `d` gives

$$
d\mid2^{b_i}-1
$$

for every `i`. With

$$
h=\gcd_i b_i,
$$

the claim is immediate for `d=1`. For `d>1`, the order of `2` modulo `d`
divides every `b_i` and hence divides `h`, giving

$$
\boxed{d\mid2^h-1.}
$$

The two hypotheses are different and must not be merged. Neither theorem
produces such a persistent divisor, forces `d=1`, or constrains generic affine
coefficients.

## 8. Route value and exclusions

The direct-return formulas give cheap exact filters for proposed hard-boundary
itineraries. The renewal identity gives cheap necessary conditions for a
separately hypothesized persistent state divisor. Together they close several
incorrect local arguments, but they do not provide the missing global rank or
positive counterexample.

In particular, this note does not assert:

- that `D` is total, canonical, or identical to the original return map;
- that an infinite positive `D`-ray exists or is impossible;
- that the long-run ghost condition is an equivalence;
- that either common-divisor hypothesis holds on every Collatz orbit;
- that real and 2-adic limiting identities may be equated;
- or that Collatz has been proved or disproved.

The companion
[`direct_H_return_renewal_regression.py`](../../verification/direct_H_return_renewal_regression.py)
checks 50,000 odd parameters through `100000`, classifies every switching
return or exit in that range, and checks 50,000 renewal identities through odd
state `100000`. It also includes the nontrivial witnesses `15 -> 5` for the
state-divisor filter and `23 -> 5` for the shifted-state filter, alongside
finite-chain regressions. The universal statements above remain prose proofs
and are not Lean-formalized.
