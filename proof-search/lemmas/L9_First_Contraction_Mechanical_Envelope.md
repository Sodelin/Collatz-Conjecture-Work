# L9 — Mechanical-envelope theorem for the first coefficient contraction

**Cycle:** Round 7, 2026-08-23  
**Status:** `PROVED_AUX` / `FORMAL_PENDING`  
**Novelty:** exact formulation not priority-certified; no novelty claim  
**Usefulness:** replaces an exponential family of first-contraction parity prefixes by one extremal mechanical word plus explicit displacement penalties  
**Collatz relevance:** necessary-condition sharpening only; not a resolution

## 1. Setup

Use the accelerated Collatz map

\[
T(n)=\begin{cases}
(3n+1)/2,&n\text{ odd},\\
n/2,&n\text{ even}.
\end{cases}
\]

Let `eps_i in {0,1}` be the parity branch at accelerated step `i`, with `eps_i=1` for an odd branch. Define

\[
q_j=\sum_{i=1}^j\varepsilon_i.
\]

For every finite prefix there is an exact affine formula

\[
\boxed{
T^j(n)=\frac{3^{q_j}n+C_j}{2^j}
}\tag{1}
\]

with `C_0=0` and recurrence

\[
C_j=\begin{cases}
C_{j-1},&\varepsilon_j=0,\\
3C_{j-1}+2^{j-1},&\varepsilon_j=1.
\end{cases}
\tag{2}
\]

If the odd steps occur at positions

\[
1\le p_1<p_2<\cdots<p_s\le j,
\]

then

\[
\boxed{
C_j=\sum_{r=1}^s 2^{p_r-1}3^{s-r}.
}\tag{3}
\]

## 2. First coefficient contraction

Suppose `tau` is the first accelerated time at which the multiplicative coefficient becomes contracting:

\[
3^{q_\tau}<2^\tau,
\qquad
3^{q_j}\ge2^j\quad(1\le j<\tau).
\tag{4}
\]

Write

\[
s=q_\tau.
\]

The nontrivial branch considered below has `s>=1`.  The edge case `s=0`
forces `tau=1`; it occurs only when the first branch is even, in which case
`T(n)=n/2<n` immediately.  In particular, `s=0` cannot occur for a
non-descending first contraction or for the odd least-counterexample state
used in L8-L12.

The step at `tau` must be even. Indeed, if step `tau` were odd then

\[
3^{q_\tau}=3\cdot3^{q_{\tau-1}}
\ge3\cdot2^{\tau-1}>2^\tau,
\]

contradicting (4).

Hence

\[
q_{\tau-1}=q_\tau=s
\]

and

\[
2^{\tau-1}\le3^s<2^\tau.
\]

With

\[
L=\log_2 3,
\]

this gives the exact first-crossing time

\[
\boxed{
\tau=\lfloor sL\rfloor+1.
}\tag{5}
\]

## 3. Deadline theorem for the odd steps

For each `r=1,...,s`, define

\[
\boxed{
d_r=\lfloor(r-1)L\rfloor+1.}\tag{6}
\]

Then the `r`-th odd step must satisfy

\[
\boxed{p_r\le d_r.}\tag{7}
\]

Proof: if `p_r>d_r`, then by time `d_r` at most `r-1` odd steps have occurred. But

\[
d_r>(r-1)L,
\]

so

\[
2^{d_r}>3^{r-1}\ge3^{q_{d_r}},
\]

which would produce a coefficient contraction before `tau`, contradicting first-crossing minimality.

Thus every odd step has a latest admissible deadline.

## 4. Unique extremal mechanical prefix

Because every summand in (3) is strictly increasing in `p_r`, the additive remainder is maximized by taking every odd step as late as allowed:

\[
\boxed{p_r=d_r\quad(1\le r\le s).}\tag{8}
\]

The deadlines are strictly increasing because `L>1`, so (8) defines a valid parity word.

Moreover its prefix odd-count is exactly

\[
q_j=\left\lceil\frac{j}{L}\right\rceil
=\lceil j\log_3 2\rceil
\quad(j<\tau),
\]

so it rides the multiplicative critical line as closely as an integer parity word can from above.

Therefore this is the unique first-contraction prefix maximizing `C_\tau`.

## 5. Exact extremal remainder

Let

\[
\theta_r=\{(r-1)L\}
\]

be the fractional part. Since

\[
2^{d_r-1}
=2^{\lfloor(r-1)L\rfloor}
=3^{r-1}2^{-\theta_r},
\]

substitution into (3) gives

\[
\boxed{
C_\tau^{\max}
=3^{s-1}\sum_{r=1}^s2^{-\theta_r}.
}\tag{9}
\]

Define

\[
S_s=\sum_{r=1}^s2^{-\{(r-1)L\}}.
\tag{10}
\]

Then

\[
C_\tau^{\max}=3^{s-1}S_s.
\]

Also define

\[
\delta_s=\tau-sL
=1-\{sL\}\in(0,1).
\tag{11}
\]

Since

\[
2^\tau=3^s2^{\delta_s},
\]

we obtain

\[
\boxed{
2^\tau-3^s
=3^s(2^{\delta_s}-1).
}\tag{12}
\]

## 6. First-contraction size envelope

Suppose in addition that the prefix is non-descending:

\[
T^\tau(n)\ge n.
\]

From (1),

\[
(2^\tau-3^s)n\le C_\tau\le C_\tau^{\max}.
\]

Using (9) and (12),

\[
\boxed{
n\le
G(s):=
\frac{S_s}{3(2^{\delta_s}-1)}.
}\tag{13}
\]

This is strictly sharper than maximizing the remainder over all length-`tau` parity words with `s` odd steps, because it uses the full first-contraction prefix constraints.

The elementary bounds

\[
\frac{s}{2}\le S_s\le s
\]

give

\[
\boxed{
\frac{s}{6(2^{\delta_s}-1)}
\le G(s)\le
\frac{s}{3(2^{\delta_s}-1)}.
}\tag{14}
\]

The upper expression is the same Diophantine scale that appears in harmonic-mean/Farey coefficient barriers; (13) identifies the exact mechanical correction factor.

## 7. Displacement-penalty form

For an arbitrary first-contraction prefix define the nonnegative deadline deficits

\[
\Delta_r=d_r-p_r\ge0.
\]

Then (3) becomes exactly

\[
\boxed{
C_\tau
=3^{s-1}\sum_{r=1}^s
2^{-\{(r-1)L\}}2^{-\Delta_r}.
}\tag{15}
\]

Thus every time an odd step is moved one slot earlier than its latest critical-line deadline, its contribution is halved; a displacement by `k` slots multiplies that contribution by `2^{-k}`.

This converts the first-contraction search from an exponential collection of parity words into:

1. one deterministic extremal mechanical word;
2. a nonnegative integer displacement profile `(Delta_r)`;
3. an exact weighted penalty functional.

For any lower bound `B<n`, a necessary condition becomes

\[
\boxed{
\sum_{r=1}^s
2^{-\{(r-1)L\}}2^{-\Delta_r}
>
3B(2^{\delta_s}-1).
}\tag{16}
\]

So a large least counterexample can only realize first contraction at a Diophantine near-return `delta_s` **and** with an odd-step schedule sufficiently close, in this weighted sense, to the mechanical extremizer.

## 8. Interaction with L8

L8 proves, conditional on its two external inputs, that a hypothetical least counterexample has no coefficient contraction before

\[
J=114\,208\,327\,604.
\]

At the first L8-allowed denominator the corresponding odd count is

\[
s=72\,057\,431\,991,
\]

with

\[
J=\lfloor s\log_2 3\rfloor+1.
\]

L9 does **not** eliminate this candidate by itself. Instead it gives the exact next object to study: the displacement profile of any first contraction at or beyond the Farey frontier.

The route should therefore stop treating all critical parity prefixes equally. The only prefixes capable of supporting a very large non-descending start are those close to the mechanical deadline word under the weighted penalty (16).

## 9. Why this is not a proof

There are arbitrarily long finite parity words satisfying the critical-line prefix inequalities, and the exact mechanical word itself is realizable by a positive residue class at every finite depth.

L9 proves an extremal theorem and a sharp compression of the search space. It does not prove that a positive integer cannot follow an admissible near-mechanical prefix indefinitely.

The remaining theorem-strength bridge is:

> show that a fixed positive integer cannot maintain both the required near-mechanical displacement budget and all 2-adic / mixed-radix compatibility constraints for arbitrarily large first-contraction scales, unless it already admits a smaller-orbit coalescence certificate.

## 10. Lean targets

Formalize:

1. recurrence (2) and odd-position sum (3);
2. first-contraction last-step-even lemma;
3. exact time formula (5);
4. deadline theorem (7);
5. extremal mechanical word and uniqueness;
6. remainder formula (9);
7. size envelope (13);
8. displacement identity (15).

No external analytic theorem is needed for L9 itself beyond standard real-log facts and irrationality of `log_2 3` at the equality-avoidance point.
