# L13 — Refined Mersenne child macros and exact successor normalization

**Status:** audited arithmetic certificate; not route closure
**Map convention:** the one-division shortcut map

\[
T(n)=\begin{cases}
n/2,&n\equiv0\pmod2,\\
(3n+1)/2,&n\equiv1\pmod2.
\end{cases}
\]

This note records a parameter refinement that survives hostile symbolic audit.
It supplies a uniform strong-induction edge on one of two children and an exact
normalization of the other child's successor.  It does **not** supply a rank
for the recurrent hard child and therefore does not prove Collatz.

## 1. Exhaustive refinement

Let `L>=2`, `epsilon in {0,1}`, and `z>=0`, and put

\[
a=4z+2\varepsilon+1,
\qquad
N_{L,\varepsilon}(z)=2^L a-1. \tag{1}
\]

Every odd parameter in `2^Lq-1` is uniquely `q=4z+1` or `q=4z+3`, so
the two values of `epsilon` exhaust the parent family disjointly.

For `0<=j<=L`, direct guarded iteration gives

\[
T^j(N_{L,\varepsilon}(z))
=2^{L-j}3^j a-1. \tag{2}
\]

## 2. The compatible child is a valid induction edge

Assume

\[
\varepsilon\equiv L\pmod2. \tag{3}
\]

Define

\[
m_{L,\varepsilon}(z)
=3\,2^{L-2}a-1
=\frac{3N_{L,\varepsilon}(z)-1}{4}. \tag{4}
\]

Writing `b=2^(L-2)a`, equations (1) and (4) become `N=4b-1` and
`m=3b-1`.  Hence

\[
0<m_{L,\varepsilon}(z)<N_{L,\varepsilon}(z),
\qquad N-m=b>0. \tag{5}
\]

The parity condition (3) gives `3^L a = 1 (mod 4)`.  Therefore

\[
T^{L+2}(N_{L,\varepsilon}(z))
=T^L(m_{L,\varepsilon}(z))
=\frac{3^L a-1}{4}. \tag{6}
\]

The forward word from `m` is `O^(L-2) E O`; equivalently, the inverse
word from the common endpoint, applied left-to-right, is

\[
O\,E\,O^{L-2}. \tag{7}
\]

This includes the edge `L=2,z=0`.  Equation (6), together with (5), is a
valid strong-induction step **assuming convergence is already known for all
smaller positive integers**.  It is not a standalone proof of the compatible
subclass.

## 3. Exact scope of the hard-sibling inverse-word no-go

Now assume

\[
\varepsilon\not\equiv L\pmod2. \tag{8}
\]

The uniform forward path is `O^L E O`.  Its state at time `L+2` is

\[
Y(z)=3^{L+1}z+\frac{3^{L+1+\varepsilon}-1}{4}. \tag{9}
\]

On this hard child, no uniform forward time `0<=t<=L+2` followed by any
uniformly admissible unrefined L4 inverse word produces a positive affine
family eventually strictly below `N`.

For `0<=t<=L`, an inverse word with `e` even inverses and `r` odd inverses
has leading-coefficient ratio

\[
2^e\left(\frac32\right)^{t-r}\ge1, \tag{10}
\]

because uniform admissibility forces `r<=t`.  Equality forces the exact
replay `O^t`, which reconstructs `N`, including the empty word when `t=0`.

At `t=L+1`, the ratio is

\[
2^{e-1}\left(\frac32\right)^{L-r}. \tag{11}
\]

The possible equal-slope word is the replay `E O^L`.  Strict-slope odd
inverses fail their mod-3 guard.  The remaining empty suffix must also be
rejected explicitly: its `z`-coefficient is `2*3^L`, whereas the original
coefficient is `2^(L+2)`, and

\[
2\,3^L>2^{L+2}\qquad(L\ge2). \tag{12}
\]

At `t=L+2`, the equal-slope word is the replay `O E O^L`.  Among the
`e=0` strict-slope candidates, the empty word and `O` are the only
admissible possibilities; their coefficient/intercept or mod-3 tests do not
produce eventual strict reduction.  Every other potentially admissible
candidate has larger slope.

This is a no-go only for the unrefined one-shot L4 certificate language
through the stated forward times.  It leaves parameter refinement, mixed
families, and ranked recursion untouched.

## 4. The hard macro grows

Subtracting (1) from (9) gives, with

\[
A=3^{L+1}-2^{L+2}>0,
\]

\[
Y-N=
\begin{cases}
Az+(A+3)/4,&\varepsilon=0,\\
Az+3(A+1)/4,&\varepsilon=1.
\end{cases} \tag{13}
\]

Under (8), `epsilon=0` means odd `L>=3`, while `epsilon=1` means even
`L>=2`.  Thus (13) is positive in every stated case.  The known hard macro
is expanding, not a decreasing back-edge.

## 5. Exact successor normalization

Put

\[
p=3^{L+1},
\qquad
b=\frac{3^{L+1+\varepsilon}+3}{4}.
\]

Hard parity makes `b` an odd positive integer, and (9) gives

\[
Y(z)+1=pz+b. \tag{14}
\]

For every `r>=0` and `eta in {0,1}`, `p` is invertible modulo
`2^(r+2)`, so there is a unique residue

\[
z_{r,\eta}\pmod{2^{r+2}}
\]

satisfying

\[
pz_{r,\eta}+b\equiv2^r(2\eta+1)\pmod{2^{r+2}}. \tag{15}
\]

These cells are disjoint and exhaust all `z>=0`: equation (15) says exactly

\[
v_2(Y(z)+1)=r,
\qquad
\frac{Y(z)+1}{2^r}\equiv2\eta+1\pmod4. \tag{16}
\]

Choose the least representative `0<=z0<2^(r+2)` and write
`z=z0+2^(r+2)u`, where `u>=0`.  Set

\[
q_0=\frac{pz_0+b}{2^r}=4c+(2\eta+1). \tag{17}
\]

Then `c>=0` is integral and

\[
Y(z)+1
=2^r\bigl(4(pu+c)+(2\eta+1)\bigr),
\]

so the successor is exactly

\[
Y(z)=N_{r,\eta}(pu+c). \tag{18}
\]

Equivalently, the new parameter `w=pu+c` satisfies both

\[
w\equiv c\pmod p,
\qquad
w\ge c, \tag{19}
\]

and these two conditions are necessary and sufficient for the chosen least
representative.  The case `r=0` is included.

Every exact valuation `r` occurs.  Consequently no finite bounded-depth
residue partition can attach one fixed complete `O^r E` successor macro to
every hard parameter.  This does **not** rule out a finite-state iterative
normalizer.  More importantly, the odd-modulus restriction in (19) grows as
`3^(L+1)` and accumulates under recursion; no finite quotient or
well-founded rank for those constrained successors is presently known.

## 6. Formal verification

`lean/CollatzWork/RefinedMersenneChild.lean` formalizes (2), positivity,
strict decrease, (4), both iterate identities in (6), and their coalescence
under pinned Lean 4.33.1.  It deliberately does not formalize the hard
inverse-word classification or claim termination.

## 7. Prior-art classification

The arithmetic mechanism is prior art.  This note is an elementary
certificate specialization of known Mersenne/parity-vector identities; an
exact published statement with this packaging was not located in a bounded
search, and no novelty claim is made.

- Andrei, Kudlek, and Niculescu, *Some results on the Collatz problem*
  (2000), equation `(*)`, record the ordinary-map staircase identity and
  attribute its source to Andrei--Masalagiu (1998):
  <https://doi.org/10.1007/s002360000039>.
- Conway, *On Unsettleable Arithmetical Problems* (2013), independently
  iterates the `2m-1` to `3m-1` staircase:
  <https://gwern.net/doc/cs/computable/2013-conway.pdf>.
- Sinyor, *The Collatz conjecture as a string rewriting system* (2010),
  Section 3, records the Mersenne endpoint under its one-division shortcut
  convention: <https://doi.org/10.1155/2010/458563>.
- Lagarias, *The 3x+1 problem and its generalizations* (1985), equations
  (2.4)--(2.6), gives the general parity-affine formula from which the short
  macros follow: <https://doi.org/10.1080/00029890.1985.11971528>.
- Applegate--Lagarias Lemma 2.2 is related but is a different mod-6 identity;
  it is not used as an exact match:
  <https://arxiv.org/html/math/0411140v2#S2>.

## 8. Exact unresolved obligation

The compatible child closes by strong induction.  The other child maps by
(18) into exact-valuation families with accumulating odd-modulus guards and
contains recurrent hard-to-hard branches.  Neither `L`, the integer value,
nor the affine parameter is presently a decreasing rank on all such
transitions.  A proof route must still exhibit a total guarded transition
system and a well-founded rank for this recurrent branch.
