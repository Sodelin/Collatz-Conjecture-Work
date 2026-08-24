# Route AB checkpoint — exact hard-boundary return system

**Status:** exact reduction and smallest rank-recharge witness; not a proof
**Map convention:** the one-division shortcut map

\[
T(n)=\begin{cases}
n/2,&n\equiv0\pmod2,\\
(3n+1)/2,&n\equiv1\pmod2.
\end{cases}
\]

This note closes a bookkeeping gap left by L13.  It gives a total exact
normalizer from every positive integer to either `1` or the recurrent hard
family.  The resulting hard-state return map is equivalent to the original
Collatz convergence obligation, and the existing replay-debt rank fails on
its smallest nontrivial boundary-skipping witness.

## 1. Canonical labels and the hard set

Every integer `x>=1` has a unique representation

\[
x=N_{r,\eta}(w)=2^r(4w+2\eta+1)-1, \tag{1}
\]

where `r=v_2(x+1)`, `eta in {0,1}`, and `w>=0`.  Define

\[
\mathcal H=
\{N_{r,\eta}(w):r\ge2,\ \eta\not\equiv r\pmod2\}. \tag{2}
\]

These are exactly the hard L13 labels.  All other labels admit one of the
following exact decreasing boundary reductions.

## 2. The total decreasing boundary reducer

For `x=N_(r,eta)(w)>1` outside `H`, put

\[
\beta(x)=
\begin{cases}
2w+\eta=x/2,&r=0,\\[1mm]
6w+3\eta+1=(3x+1)/4,&r=1,\\[1mm]
3\,2^{r-2}(4w+2\eta+1)-1=(3x-1)/4,
 &r\ge2,\ \eta\equiv r\pmod2.
\end{cases} \tag{3}
\]

The exact orbit identities are respectively

\[
T(x)=\beta(x),\qquad
T^2(x)=\beta(x),\qquad
T^{r+2}(x)=T^r(\beta(x)). \tag{4}
\]

In every stated nonterminal case,

\[
0<\beta(x)<x. \tag{5}
\]

For `r=1`, equality in the non-strict comparison occurs only at
`x=1=N_(1,0)(0)`, which is terminal and excluded from (3).  For `r>=2`,
(4)--(5) are exactly the compatible-child macro already proved in L13 and
Lean.

Natural-number recursion therefore defines

\[
\rho(x)=
\begin{cases}
x,&x=1\text{ or }x\in\mathcal H,\\
\rho(\beta(x)),&\text{otherwise}.
\end{cases} \tag{6}
\]

It terminates because every recursive call strictly decreases its positive
integer argument.  The coalescence identities in (4) give

\[
\operatorname{Conv}(x)\iff\operatorname{Conv}(\rho(x)), \tag{7}
\]

where `Conv(x)` means that the `T`-orbit of `x` reaches `1`.

## 3. The exact hard-state return map

For a hard state `h=N_(L,epsilon)(z)`, L13 gives

\[
T^{L+2}(h)
=Y_{L,\varepsilon}(z)
=3^{L+1}z+\frac{3^{L+1+\varepsilon}-1}{4}. \tag{8}
\]

Define

\[
F(h)=\rho(Y_{L,\varepsilon}(z)). \tag{9}
\]

Then `F(h)` lies in `H union {1}` and

\[
\operatorname{Conv}(h)\iff\operatorname{Conv}(F(h)). \tag{10}
\]

Consequently the following two assertions are equivalent:

1. every positive integer has a convergent `T`-orbit;
2. every `F`-orbit in `H` reaches `1`.

For the forward implication, assume every positive integer converges and let

\[
\tau(x)=\min\{k:T^k(x)=1\}.
\]

The explicit hard prefix contains no `1`, so
`tau(Y)=tau(h)-(L+2)`.  Each nonterminal `beta`-reduction also strictly
decreases `tau`: the two sides coalesce after respectively `(1,0)`, `(2,0)`,
or `(r+2,r)` steps, and `x` does not reach `1` before its stated left-hand
meeting time.  Hence `tau(F(h))<tau(h)`, so every `F`-orbit reaches `1`.
For the reverse implication, first apply (6)--(7) to enter `H union {1}`, then
iterate (9)--(10).  Thus `F` is a closed and exact compression of the
remaining problem, not an independent termination mechanism.

## 4. Smallest boundary-skipping replay-rank obstruction

The first hard state whose boundary-normalized return both grows and
recharges L13's replay debt is

\[
31=N_{5,0}(0)
\xrightarrow{\ O^5EO\ }
182=N_{0,1}(45)
\xrightarrow{\ E\ }
91=N_{2,1}(5). \tag{11}
\]

Hence

\[
F(31)=91>31. \tag{12}
\]

Using L13's exact quantities

\[
D_{L,\varepsilon}(z)
=v_2\!\left((2^{L+2}-3^{L+1})z-d_{L,\varepsilon}\right),
\qquad
R=\left\lfloor\frac{D}{L+2}\right\rfloor, \tag{13}
\]

the endpoint data are

\[
(D,R)(5,0,0)=(0,0),\qquad
(D,R)(2,1,5)=(6,1). \tag{14}
\]

Thus the exact boundary skip raises the proposed well-founded debt from zero
to one while the represented integer grows.  This is minimal among hard
sources: below `31` the only hard states are `7`, `11`, and `27`; direct
replay gives

\[
F(7)=F(11)=1,\qquad F(27)=47,
\]

and the target `47=N_(4,1)(0)` has `R=0`.

## 5. Accepted scope and stop condition

Equations (1)--(14) give an exact total boundary normalizer and a precise
failure witness for the current debt rank.  They do **not** exclude a richer
nonlinear/additional-state rank, and they do not prove or disprove Collatz.

Route AB should not be reopened merely by refining another boundary label:
that operation is already absorbed by `rho`.  A genuine continuation must
provide a well-founded measure for every `F` transition or a strictly
stronger certificate semantics.  Without such a mechanism, iterating `F`
is simply iterating a Collatz-equivalent return map.

No novelty claim is made.  The arithmetic uses the L13 specialization of
standard parity-affine identities; the contribution here is the exact route
normalization and obstruction bookkeeping.

## Connections

- **Depends on:** [L13 refined Mersenne macros](../lemmas/L13_Refined_Mersenne_Child_Macros.md).
- **Parallel to:** [L14 trajectory normal form](../lemmas/L14_ThreeNMinusOne_Trajectory_Normal_Form.md).
- **Blocked by:** the rank frontier recorded in the [failure ledger](../FAILURE_LEDGER.md).
- **Updates:** [Route AB](../APPROACH_REGISTRY.md).
- **Formalization pending:** [Lean targets](../../LEAN_TARGETS.md).
