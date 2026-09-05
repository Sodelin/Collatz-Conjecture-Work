# L11 — Hard-exit inheritance across a sufficiently small first near-return

**Cycle:** Round 7, 2026-08-23  
**Status:** `PROVED_AUX` / `FORMAL_PENDING`  
**Novelty:** exact formulation not priority-certified; no novelty claim  
**Usefulness:** propagates the L6 hard-exit constraint from a least counterexample to its first coefficient-contraction endpoint when the L10 near-return is sufficiently small  
**Collatz relevance:** one-step inherited necessary condition; not a resolution

## 1. Setup

Let `n_*` be the least positive integer whose accelerated Collatz orbit does not reach `1`, assuming such an integer exists.

Use

\[
T(n)=\begin{cases}
(3n+1)/2,&n\text{ odd},\\
n/2,&n\text{ even}.
\end{cases}
\]

The least counterexample is odd.  If it were even, its first iterate would be
the smaller positive integer `n_*/2`; minimality would make that iterate's
orbit reach `1`, and hence the orbit of `n_*` would reach `1` as well.

Suppose the coefficient stopping time of `n_*` is finite, and let `tau` be its first coefficient contraction. Let

\[
s=q_\tau
\]

be the number of odd accelerated branches before time `tau`.

By minimality,

\[
T^j(n_*)\ge n_*
\quad\text{for every }j\ge0.
\tag{1}
\]

L10 writes the first contraction as

\[
\boxed{y:=T^\tau(n_*)=n_*+d}\tag{2}
\]

with

\[
\boxed{0\le d\le\left\lfloor\frac{s-1}{3}\right\rfloor.}\tag{3}
\]

Assume in this lemma that

\[
\boxed{s<n_*.}\tag{4}
\]

Then (3) gives the two exact inequalities

\[
3d+1\le s<n_*,
\tag{5}
\]

and

\[
y=n_*+d<\frac43n_*.
\tag{6}
\]

## 2. The endpoint cannot be even

If `y` were even, then

\[
T(y)=y/2.
\]

By (6),

\[
T(y)<\frac23n_*<n_*.
\]

But `y` is already on the orbit of `n_*`, so this would contradict the global-minimum property (1).

Therefore

\[
\boxed{y\text{ is odd}.}\tag{7}
\]

## 3. The endpoint cannot have v2(y+1)=1

Let

\[
q=v_2(y+1).
\]

If `q=1`, write `y=4a+1`. Then

\[
T^2(y)=3a+1=\frac{3y+1}{4}.
\]

Using `y=n_*+d`,

\[
T^2(y)=\frac{3n_*+3d+1}{4}.
\]

By (5),

\[
3d+1<n_*.
\]

Hence

\[
T^2(y)<n_*,
\]

again contradicting (1).

Thus

\[
\boxed{q\ge2.}\tag{8}
\]

## 4. The endpoint cannot have the good L6 exit

Write

\[
y=2^qm-1,
\qquad m\text{ odd}.
\tag{9}
\]

L6 shows that if

\[
3^qm\equiv1\pmod4,
\tag{10}
\]

then the orbit of `y` coalesces exactly with the orbit of a smaller positive integer, with two cases.

### Case A: q even

L6 constructs

\[
y'=(y-1)/2.
\]

Using (6),

\[
y'<y/2<\frac23n_*<n_*.
\]

Thus the coalescing orbit would pass through an integer smaller than `n_*`, contradicting minimality.

### Case B: q odd

Here `q>=3`, and L6 constructs

\[
y'=(3y-1)/4.
\]

Substituting `y=n_*+d`,

\[
y'=\frac{3n_*+3d-1}{4}.
\]

From (5),

\[
3d-1<n_*.
\]

Therefore

\[
y'<n_*,
\]

again impossible.

Hence (10) cannot hold.

## 5. Inherited hard-exit condition

The only remaining L6 exit state is

\[
\boxed{3^qm\equiv3\pmod4.}\tag{11}
\]

Equivalently,

\[
\boxed{
\begin{array}{ll}
q\text{ even}:&m\equiv3\pmod4,\\
q\text{ odd}:&m\equiv1\pmod4.
\end{array}}
\tag{12}
\]

Thus a sufficiently small first near-return endpoint of a least counterexample inherits exactly the same hard-exit condition as the least counterexample itself.

## 6. Immediate residue consequences

Since `q>=2`,

\[
y\equiv-1\pmod4,
\]

so

\[
\boxed{y\equiv3\pmod4.}\tag{13}
\]

L6 already implies that the least counterexample itself has `v_2(n_*+1)>=2`, hence

\[
n_*\equiv3\pmod4.
\tag{14}
\]

Subtracting (14) from (13) and using `y=n_*+d` gives

\[
\boxed{d\equiv0\pmod4.}\tag{15}
\]

Combining with L10:

\[
\boxed{
0\le d\le\left\lfloor\frac{s-1}{3}\right\rfloor,
\qquad
4\mid d.
}\tag{16}
\]

In parity language, the state immediately after the first coefficient contraction must begin a hard-exit block

\[
1^q01,
\qquad q\ge2,
\]

where `q=v_2(y+1)` and the `01` after the initial run follows from `3^qm-1` being exactly `2 mod 4` under (11).

## 7. Application at the L8 first Farey frontier

L8's first coefficient-contraction scale compatible with the published `2^71` lower bound has

\[
s=72\,057\,431\,991.
\]

Since

\[
s<2^{71}<n_*,
\]

hypothesis (4) is automatic at that first frontier.

Therefore a least counterexample contracting for the first time at the L8 Farey denominator must satisfy simultaneously:

1. L9's near-mechanical first-contraction parity constraints;
2. L10's dual tiny-residue and near-return equations;
3. `d` divisible by four;
4. the endpoint `n_*+d` is odd and is itself an L6 hard-exit state.

This still leaves many possibilities, but the constraint now propagates *past* the first contraction rather than terminating there.

## 8. Why this is not a proof

The inheritance theorem uses `s<n_*`. A first coefficient contraction occurring at an odd count comparable to or larger than the least counterexample is not covered by this argument.

Even under `s<n_*`, the hard exit is not itself contradictory. Long positive integers can realize hard-exit blocks.

The next route must first construct a total rooted transition system.  Only
then can it determine whether successive near-minimum/hard-exit constraints
generate a finite forbidden-state grammar or whether the surviving state
complexity continues to grow.  Repetition of the full L9-L11 state is a target,
not a consequence of this lemma.

## 9. Lean targets

Formalize:

1. the L10 bound `3d+1<=s`;
2. `s<n_* -> y<4n_*/3`;
3. even-endpoint contradiction;
4. `q=1` contradiction;
5. both L6 good-exit contradictions below `n_*`;
6. inherited hard condition (11)-(12);
7. `4 | d`.

## 2026-09-05 sharpening

[ L15's quarter-gap certificate](L15_Quarter_Gap_and_Rotation_Block_Certificate.md)
strengthens the gap estimate to `4d<s` and the sufficient inheritance condition
to `3*floor((s-1)/4)+1<n_*`. The original argument remains valid as a weaker
historical bound; its renewal and stopping-time limitations remain.
