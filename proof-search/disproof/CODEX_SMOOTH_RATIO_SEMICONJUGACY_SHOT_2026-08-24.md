# Smooth-ratio Collatz semiconjugacy shot

**Claim ID:** `F-SMOOTH-RATIO-SEMICONJ-001`

**Verdict:** `PASS (HOSTILE RECONSTRUCTION) / KILLED_ARCHITECTURE / STOPPED-USEFUL / NO DISPROOF`

**Date:** 2026-08-24

**Source provenance:** created untracked in an isolated detached worktree at
exact commit `b3b9f4731937a2d7c999d1b8a6417c9e96597e46`; at source time, nothing had
been committed, merged, pushed, registered, or published. This release copy is
later provenance and does not change the theorem's scope.

## Predeclared selection packet

Let the Padovan sequence be

$$
P_0=P_1=P_2=1,
\qquad
P_{m+3}=P_{m+1}+P_m.
$$

Fix `M=10^6` and declare

$$
N=2P_M+1,
\qquad
n_k=2P_{M+k}+1.
$$

- **Exact positive object:** the displayed positive odd ordinary integer `N` and its explicit positive odd Padovan tail.
- **Forward-invariance target:** `T(n_k)=n_{k+1}` for every `k>=0`, where

  $$
  T(n)=\frac{3n+1}{2^{v_2(3n+1)}}.
  $$

- **Divergence bridge:** `P_m` is unbounded, so exact termwise closure would give a fixed positive seed with a rigorously unbounded orbit.
- **Changed mechanism:** a smooth positive linear-recurrence semiconjugacy, rather than an elliptic observable, fixed valuation word, automatic inverse limit, pump, finite search, or polynomial valuation ratchet.
- **Cheapest symbolic kill:** determine whether any positive accelerated Collatz orbit can have a convergent ratio `n_{k+1}/n_k`.
- **Hard stop:** the pointwise ratio-convergent semiconjugacy class. Do not enumerate recurrences or coefficients.
- **Durable artifact:** a universal no-go theorem for this exact class.
- **Compute class:** symbolic; one constructor and one hostile reconstruction, no search.

## Theorem

Let `(n_k)_{k>=0}` be a positive odd accelerated Collatz orbit:

$$
n_{k+1}=T(n_k)
=\frac{3n_k+1}{2^{a_k}},
\qquad
a_k=v_2(3n_k+1)\ge1.
$$

If the real sequence `n_{k+1}/n_k` converges to a finite limit, then `(n_k)` is eventually the fixed orbit `1`. In particular, no unbounded positive accelerated Collatz orbit has a convergent successive-state ratio.

## Proof

Put

$$
r_k=\frac{n_{k+1}}{n_k}.
$$

### Bounded case

If `(n_k)` is bounded, determinism on a finite set makes its tail periodic. The corresponding ratio tail is periodic. A convergent periodic real sequence is constant, say `r_k=L`, on the terminal cycle. Its product around that cycle is `1`, so `L=1`; every terminal state is therefore fixed.

If `T(n)=n`, then

$$
(2^a-3)n=1,
\qquad a=v_2(3n+1).
$$

Both factors are positive integers. Hence `n=1` and `2^a-3=1`, giving `a=2`. Thus the only positive fixed point is `1`.

### Unbounded case

An unbounded deterministic positive-integer orbit has `n_k -> infinity`. Otherwise some finite set would be visited infinitely often, so one state would repeat; determinism would then give a bounded periodic tail.

Suppose `r_k -> L>=0`.

If `L=0`, then eventually `r_k<1`, producing an infinite strictly decreasing sequence of positive integers. This is impossible.

If `L>0`, exact iteration gives

$$
2^{a_k}=\frac{3+1/n_k}{r_k}\longrightarrow\frac3L.
$$

The convergent sequence `2^{a_k}` takes values in the discrete set `{2,4,8,...}`, so it is eventually constant: `a_k=a` for all sufficiently large `k`. Consequently `L=3/2^a`.

For `a>=2`, one has `L<=3/4<1`, again forcing an eventually strictly decreasing positive-integer tail. The only remaining possibility is `a=1`. On such a tail,

$$
n_{k+1}+1=\frac32(n_k+1),
$$

and hence, for every `j>=0`,

$$
n_{K+j}+1=\frac{3^j(n_K+1)}{2^j}.
$$

Integrality and `gcd(2^j,3^j)=1` force

$$
2^j\mid n_K+1
$$

for every `j`, impossible for a fixed positive integer `n_K+1`. Thus the unbounded case cannot occur, completing the proof.

## Padovan candidate verdict

The characteristic polynomial of the Padovan recurrence is

$$
x^3-x-1.
$$

Its unique dominant positive root is the plastic constant `rho>1`, and

$$
\frac{P_{m+1}}{P_m}\longrightarrow\rho.
$$

Therefore

$$
\frac{2P_{M+k+1}+1}{2P_{M+k}+1}\longrightarrow\rho,
$$

while `2P_{M+k}+1` is unbounded. The theorem proves that the declared Padovan sequence cannot satisfy exact accelerated Collatz closure. No witness survives.

## Hostile-audit verdict and collision status

The independent reconstruction returned `PASS`. It specifically verified the bounded/eventually-periodic branch, the `L=0` branch, unboundedness implying `n_k -> infinity` without using the accepted `q_infinity` classifier, eventual valuation constancy for `L>0`, and the final divisibility contradiction.

The eventual `a=1` step is the same elementary affine-lift obstruction underlying `A-AFFINE-LIFT-001`. The distinct content here is the preceding implication

$$
\text{pointwise ratio convergence}
\quad\Longrightarrow\quad
\text{eventually constant valuation branch}.
$$

No exact collision was found in the local claim, approach, or failure registries or in a bounded web search. No novelty or priority claim is made; the result is elementary route pruning rather than a Collatz advance.

## Exact scope

The theorem excludes Padovan, Lucas, Pell, and other proposed termwise positive-integer generators whenever their consecutive-state ratio has a finite real limit. It says nothing about:

- ratios with multiple accumulation points;
- Cesaro or logarithmic-average growth rates;
- changing-order or changing-coefficient recurrences without a ratio limit;
- subsequences rather than one-step images;
- finite prefixes, nonpositive values, or nonintegral shadows;
- the existence of a positive Collatz cycle or divergent orbit by another mechanism.

## Handoff fields

- **Claim ID:** `F-SMOOTH-RATIO-SEMICONJ-001`.
- **Verdict:** `PASS / KILLED_ARCHITECTURE / STOPPED-USEFUL / NO DISPROOF`.
- **Exact object/family:** the explicit Padovan tail, generalized by the theorem to every pointwise ratio-convergent positive termwise generator.
- **Positivity/integrality:** exact by construction; forward invariance is disproved.
- **Decisive equations:** `2^{a_k}=(3+1/n_k)/r_k` and the infinite `2`-divisibility forced by an eventual `a=1` tail.
- **Prior-art status:** no exact bounded-search collision; no novelty claim.
- **Remaining gap:** no positive cycle and no divergent seed.
- **Reproduction:** exact symbolic proof above; no bounded computation.
- **Files:** this packet only.
- **Single best next question:** can one specify a finite, ordinary-integer-anchored generator with deliberately nonconvergent ratios and unbounded valuation complexity, while proving exact one-step closure and `q_infinity>0`?
