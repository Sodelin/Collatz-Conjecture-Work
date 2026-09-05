# L15: exact rotation-block certificates and a quarter-gap bound

**Status:** the universal quarter-gap theorem is Lean-verified; its exact
integer proof also sharpens the supporting envelope threshold to 16.
The general arbitrary-block phase theorem and 1024-block refinement retain
their separate prose/exact-Python status.
**Novelty:** unchecked; no priority claim. This is a project-specific tightening
of L9/L10, using their classical parity-affine machinery.  
**Scope:** auxiliary necessary condition; no proof or disproof of Collatz.

**Node ID:** `L15-QUARTER-GAP`  
**Node type:** `lemma`  
**Input commit:** `343ddb2cbfadb91af65328f2614c572dc91a2d69`  
**Date:** 2026-09-05

## Exact claim L15-QUARTER-GAP

Use the one-division shortcut map

\[
T(n)=\begin{cases}(3n+1)/2&n\text{ odd},\\n/2&n\text{ even}.\end{cases}
\]

Let `n` be positive. Suppose its first coefficient-contraction time `tau`
is finite, and let `s` be the number of odd branches before that time.
Suppose `T^tau(n)=n+d` with integer `d>=0`. Then

\[
\boxed{4d<s,\qquad d\le\left\lfloor\frac{s-1}{4}\right\rfloor.}
\]

This improves L10's `3d<s`. It does not establish finiteness of `tau`.

## 1. What L9 and L10 already supply

The non-descending hypothesis excludes `s=0`. Put

\[
L=\log_2 3,\quad \tau_s=\lfloor sL\rfloor+1,
\quad \delta_s=\tau_s-sL\in(0,1),
\]

\[
S_s=\sum_{k=0}^{s-1}2^{-\{kL\}},\qquad C_s^{\max}=3^{s-1}S_s.
\]

L9's first-crossing deadline theorem gives `tau=tau_s` and
`C<=C_s^max`, where `C` is the actual parity-affine remainder. L10's exact
near-cycle equation then gives

\[
\boxed{d<\frac{C}{2^{\tau_s}}
\le\frac{C_s^{\max}}{2^{\tau_s}}
=\frac{S_s}{3\,2^{\delta_s}}.}\tag{1}
\]

Strictness in the first inequality uses `n>0` and
`2^tau_s-3^s>0`, including the cycle case `d=0`.

## 2. Sharp finite-block theorem

For an integer `k`, define

\[
w(k)=2^{-\{kL\}}.
\]

These are exactly rational:

\[
w(0)=1,\quad
w(k)=\frac{2^{\lfloor kL\rfloor}}{3^k}\ (k>0),\quad
w(-k)=\frac{3^k}{2^{\lfloor kL\rfloor+1}}\ (k>0).
\tag{2}
\]

For `b>=1`, set

\[
\boxed{M_b=\max_{0\le i<b}\sum_{k=0}^{b-1}w(k-i),}
\qquad M_0=0.\tag{3}
\]

**Block theorem.** For every real phase `theta`,

\[
\sum_{k=0}^{b-1}2^{-\{\theta+kL\}}\le M_b,\tag{4}
\]

and the bound is attained at a phase `theta={-iL}` for some `0<=i<b`.

**Proof.** The summands have upward jumps only where
`theta={-iL}`. Between consecutive such phases their sum is a positive
constant times `2^(-theta)`, so strictly decreases. Therefore a global
maximum on the phase circle occurs immediately at one of these upward
jumps. At that phase the sum is exactly the expression in (3).
Irrationality of `L` ensures the finitely many jump phases are distinct;
the negative-index formula in (2) follows from
`{-kL}=1-{kL}`. This proves sharpness and completeness of the finite
candidate list. No sampled phase grid is used.

Consequently, for any integers `b>=1`, `s>=1`, writing `s=qb+r` with
`0<=r<b`,

\[
\boxed{S_s\le qM_b+M_r.}\tag{5}
\]

Every block has an arbitrary starting phase covered by (4), so (5)
applies to every `s`, without a finite-to-infinite extrapolation.

## 3. The twelve-term certificate

Exact evaluation of (3) gives:

| `b` | `M_b` |
|---:|---:|
| 0 | 0 |
| 1 | 1 |
| 2 | 7/4 |
| 3 | 23/9 |
| 4 | 119/36 |
| 5 | 319/81 |
| 6 | 1213/256 |
| 7 | 5581/1024 |
| 8 | 14501/2304 |
| 9 | 64565/9216 |
| 10 | 159181/20736 |
| 11 | 695773/82944 |
| 12 | 2349463/262144 |

In particular,

\[
9-M_{12}=\frac{9833}{262144},\qquad
\max_{0\le r<12}\left(M_r-\frac{3r}{4}\right)=\frac{11}{36}.
\]

For `s=12q+r`, (5) gives

\[
S_s-\frac{3s}{4}
\le-\frac{9833q}{262144}+\frac{11}{36}.
\]

The right side is strictly negative for `q>=9`, since
`9*9833/262144>11/36`. Thus

\[
\boxed{S_s<3s/4\quad(s\ge108).}\tag{6}
\]

By (1), `d<s/4` in that entire infinite range.

For the remaining `1<=s<=107`, compute integers using

\[
C_0^{\max}=0,\quad
C_s^{\max}=3C_{s-1}^{\max}+2^{\lfloor(s-1)L\rfloor},\quad
\tau_s=\lfloor sL\rfloor+1.\tag{7}
\]

The finite exact certificate checks

\[
\boxed{4C_s^{\max}\le s2^{\tau_s}\quad(1\le s\le107).}\tag{8}
\]

Equality occurs only at `s=1`. Formula (1) is strict even there, so
(8) supplies `d<s/4` throughout the remaining range. This proves the
quarter-gap theorem. The checker computes
`floor(k*log2(3))` as `bit_length(3**k)-1`, so no numerical logarithm,
floating-point rounding, or approximate Diophantine comparison enters
this certificate.

## 4. More precise reusable bound

Combining (1) and (5), every `b>=1` supplies

\[
\boxed{d<\frac{qM_b+M_r}{3\,2^{\delta_s}}
<\frac{qM_b+M_r}{3},\qquad s=qb+r.}\tag{9}
\]

The loss in the last inequality avoids computing the often tiny
Diophantine quantity `delta_s`. It remains an exact strict bound.

At the existing L8 illustrative first frontier

\[
s=72\,057\,431\,991,
\]

the quarter theorem gives

\[
d\le18\,014\,357\,997.
\]

When L11's `4 | d` also applies, the bound is

\[
\boxed{d\le18\,014\,357\,996.}\tag{10}
\]

The same exact phase theorem with `b=1024` improves (10) further:

\[
d\le17\,340\,869\,985,
\qquad
\boxed{4\mid d\ \Longrightarrow\ d\le17\,340\,869\,984.}\tag{11}
\]

For comparison, the old L10/L11 bound is `24,019,143,996`.
These are conditional arithmetic substitutions at the existing frontier,
not new claims that this frontier is attainable. The improved value in
(11) remains above `2^34` and below `2^35`, so it does **not** improve
L12's existing maximum gap valuation `e<=34`.

## 5. A modest extension of L11's sufficient hypothesis

L11's endpoint inheritance proof only needs

\[
3d+1<n_*.
\]

Its old sufficient condition `s<n_*` can therefore be replaced by the
strictly weaker, exact condition

\[
\boxed{3\left\lfloor\frac{s-1}{4}\right\rfloor+1<n_*.}\tag{12}
\]

A simpler sufficient condition is `3s+1<4n_*`, since
`4d+1<=s` implies `3d+1<=(3s+1)/4`. This extends the allowed odd-count
range to approximately `4n_*/3`. It still does not supply local
coefficient-stopping finiteness, renewal of a non-descending gap relative
to the endpoint, retained bands under indefinitely many returns, or a
well-founded rank. The immutable-root and zero-gap obligations in F019
and L12 remain unchanged.

## 6. Reproduction and adversarial boundary

Run:

```sh
python -B verification/near_return_quarter_bound.py
```

The script checks every candidate phase for each `b<=12`, compares the
sliding-window formula to direct summation, verifies all 107 small
integer inequalities by two remainder reconstructions, and evaluates the
two frontier substitutions. The 1024-term improvement uses the same
proved finite-candidate formula. It never assumes universal Collatz
convergence or searches finitely many trajectories and extrapolates.

The [completed integer formalization](../../verification/Quarter_Gap_Formal_Scope_2026-09-05.md)
now checks the actual-orbit affine identity, mechanical upper envelope, exact
crossing time, twelve-region certificate and universal quarter-gap conclusion.
It proves `4*Cmax(s)<=s*3^s` for every `s>=16`, with a checked failure at
`s=15`; thus 16 is the sharp eventual threshold for this normalized envelope.
The proof above's threshold 108 remains valid but is weaker.
The general real-phase theorem for arbitrary block length and the 1024-term
conditional frontier calculation remain prose/exact-Python results.

## Connections

- **Depends on:** [L9 mechanical envelope](L9_First_Contraction_Mechanical_Envelope.md) and [L10 near-cycle identity](L10_Near_Return_and_Dual_Residue_Certificate.md).
- **Strengthens:** [L10 near-return bound](L10_Near_Return_and_Dual_Residue_Certificate.md) and [L11 inheritance range](L11_Near_Return_Hard_Exit_Inheritance.md).
- **Feeds:** [L12 positive-gap transition](L12_Hard_Exit_Gap_Valuation_Transition.md), with unchanged valuation ceiling.
- **Verified by:** [verification manifest](../../verification/README.md).
- **Does not resolve:** F019 renewal gap, coefficient-stopping finiteness,
  zero-gap positive cycles, or any global Collatz-equivalent return map.
- **New mechanism relative to the old coarse bound:** a sharp,
  phase-uniform rotation-block certificate, covering all starting phases.
- **First falsification tests:** exact discontinuity enumeration and the
  107 integer remainder inequalities, both supplied by the checker.

The source basis is the existing L9/L10 archive. No external theorem beyond
elementary logarithm identities and irrationality of `log2(3)` is needed.
A bounded primary-source audit is recorded in the [research pass](../../ASTRA_RESEARCH_PASS_2026-09-05.md); no priority claim is made.
