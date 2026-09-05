# L7 — Least-counterexample coefficient barrier through 301,993 accelerated steps

**Cycle:** Round 7, 2026-08-23  
**Status:** `PROVED_AUX` conditional on cited external theorem/computational base result; Lean pending  
**Novelty:** exact formulation not checked for priority; no novelty claim  
**Usefulness:** strong deterministic necessary condition for Route D  
**Collatz relevance:** necessary condition on a hypothetical least counterexample, not a proof

## 1. External inputs

### Input A — verified base range

Barina (2025) reports verification of Collatz convergence for all starting values through `2^71` under the same accelerated map convention

$$
T(n)=\begin{cases}
(3n+1)/2,&n\text{ odd},\\
n/2,&n\text{ even}.
\end{cases}
$$

Hence a least nonconvergent positive integer, if one exists, satisfies

$$
\boxed{n_*>2^{71}.}\tag{1}
$$

### Input B — Rozier–Terracol remainder bound

For a length-`j` accelerated prefix with `q=q_j(n)` odd terms, write

$$
T^j(n)=\frac{3^q}{2^j}n+E_j(n).
$$

Rozier–Terracol Theorem 2.4 gives

$$
\boxed{
E_j(n)\le\frac{3^q-2^q}{2^q}.
}\tag{2}
$$

### Input C — published paradoxical-length exclusion

Rozier–Terracol Theorem 5.3 proves there are no paradoxical sequences with

$$
\boxed{93\le j\le301\,993.}\tag{3}
$$

A prefix is paradoxical when

$$
\frac{3^q}{2^j}<1
\quad\text{but}\quad
T^j(n)\ge n.
$$

## 2. Minimality converts contraction into paradoxicality

Assume Collatz is false and let `n_*` be the least positive integer whose orbit does not reach `1`.

Then

$$
\boxed{T^j(n_*)\ge n_*\quad\text{for every }j\ge0.}\tag{4}
$$

Otherwise some iterate would be a smaller positive integer. By minimality that smaller integer converges to `1`, forcing `n_*` to converge as well.

Therefore every coefficient-contracting prefix of `n_*`, meaning

$$
3^{q_j(n_*)}<2^j,
$$

is automatically paradoxical.

## 3. Exact finite short-prefix bound

Suppose a prefix of length `j` is coefficient-contracting and non-descending. Then

$$
\left(1-\frac{3^q}{2^j}\right)n_*
\le E_j(n_*).
$$

Using (2),

$$
n_*
\le
\frac{(3^q-2^q)/2^q}{1-3^q/2^j}
=
\boxed{
F(j,q)=
\frac{2^{j-q}(3^q-2^q)}{2^j-3^q}.
}\tag{5}
$$

The exact integer-arithmetic checker

`verification/round7_paradoxical_prefix_barrier.py`

exhausts all integer pairs

$$
1\le j\le183,
\qquad
0\le q\le j,
\qquad
3^q<2^j,
$$

and verifies

$$
\boxed{F(j,q)<2^{71}}\tag{6}
$$

in every case.

The largest value over this range occurs at

$$
(j,q)=(176,111)
$$

and still has

$$
\log_2 F(176,111)\approx69.3479<71.
$$

The first pair by increasing `j` at which the bound can reach `2^71` is

$$
(j,q)=(184,116).
$$

Combining (1), (5), and (6), `n_*` cannot have a coefficient-contracting prefix for any

$$
1\le j\le183.
$$

## 4. Fill the remaining interval with Theorem 5.3

For every

$$
184\le j\le301\,993,
$$

a coefficient-contracting prefix of `n_*` would be paradoxical by (4).

But these lengths lie inside the Rozier–Terracol exclusion (3).

Therefore no such prefix exists.

Combining the two ranges yields the main conclusion:

$$
\boxed{
3^{q_j(n_*)}\ge2^j
\quad\text{for every }1\le j\le301\,993.
}\tag{7}
$$

## 5. Coefficient stopping-time corollary

Define, when finite,

$$
\tau(n)=
\min\left\{j\ge1:3^{q_j(n)}<2^j\right\}.
$$

Then any least Collatz counterexample must satisfy

$$
\boxed{\tau(n_*)\ge301\,994.}\tag{8}
$$

If `tau(n_*)` were infinite, (7) is of course also satisfied.

## 6. Parity-density form

Equation (7) is equivalent to

$$
q_j(n_*)
\ge
\left\lceil j\log_3 2\right\rceil
$$

for each

$$
1\le j\le301\,993,
$$

with the ceiling convention adjusted only at the impossible equality case `3^q=2^j` for positive integers `j,q`.

Thus the first 301,993 accelerated decisions of a least counterexample must remain on the noncontracting side of the exact multiplicative critical line.

This is a prefix-by-prefix constraint, stronger than merely requiring a high final odd-term density at time 301,993.

## 7. Interaction with L6

L6 independently proves that if

$$
n_*=2^qm-1,
\qquad q=v_2(n_*+1),
$$

then a least counterexample must exit the initial `-1`/Mersenne branch through the hard mod-4 state

$$
3^qm\equiv3\pmod4.
$$

So a hypothetical least counterexample must simultaneously satisfy:

1. the exact Mersenne-exit congruence from L6;
2. the prefix inequalities
   $$
   q_j(n_*)\ge\lceil j\log_3 2\rceil
   $$
   for all `j<=301,993`;
3. the published base-size lower bound `n_*>2^71`.

This creates a much narrower target for the next finite symbolic search than arbitrary parity vectors.

## 8. Why this still does not solve Collatz

There exist arbitrarily long finite parity patterns on the noncontracting side of the critical line, and congruence classes can realize long prescribed prefixes. Equation (7) by itself does not prove that the required 301,993-step prefix is impossible for a positive integer.

The new problem is concrete:

> Can the prefixwise critical-line constraint (7), together with L6's exact positive-integer exit condition and mixed-radix/coalescence constraints, be shown inconsistent before step 301,994?

A proof of that incompatibility would eliminate a least counterexample and therefore prove Collatz by strong induction. No such incompatibility theorem is currently established.

## 9. Formalization targets

A Lean development should isolate external inputs and prove locally:

1. minimality lemma (4);
2. algebra from paradoxicality + remainder upper bound to (5);
3. a reflected finite certificate for all pairs `j<=183` proving (6);
4. interval stitching with the imported statement corresponding to Theorem 5.3;
5. conclusion (7) and stopping-time corollary (8).

Until the external computational theorem and paradoxical-sequence theorem are themselves imported/formalized, the local Lean theorem should expose them as named hypotheses rather than project axioms hidden inside definitions.
