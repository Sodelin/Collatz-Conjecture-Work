# Route F checkpoint — bounded-alphabet endpoint-residue gate

**Claim ID:** `F-BOUNDED-ALPHABET-ENDPOINT-GATE-001`

**Status:** exact characterization, independently reconstructed; no Collatz
proof or disproof

**Map convention:** the accelerated odd map

\[
U(n)=\frac{3n+1}{2^{v_2(3n+1)}}
\qquad(n\text{ a positive odd integer}).
\]

## 1. Statement

Fix an integer `A>=1`, and let `(a_k)_(k>=0)` be an infinite sequence with

\[
1\le a_k\le A.
\]

Define

\[
q_0=0,\qquad q_k=\sum_{i=0}^{k-1}a_i,
\]

and the usual affine-prefix coefficients

\[
C_0=0,\qquad C_{k+1}=3C_k+2^{q_k}. \tag{1}
\]

For `k>=1`, let `M_k` be the unique integer satisfying

\[
1\le M_k<3^k,
\qquad
2^{q_k}M_k\equiv C_k\pmod{3^k}, \tag{2}
\]

and put `M_0=0`.  Finally define the integer `t_k` by

\[
2^{a_k}M_{k+1}=3M_k+1+t_k3^{k+1}. \tag{3}
\]

Then

\[
0\le t_k<2^{a_k} \tag{4}
\]

for every `k`, and the following four assertions are equivalent:

1. `(a_k)` is the exact accelerated valuation sequence of a positive odd
   integer;
2. `t_k=0` for all sufficiently large `k`;
3. `M_k/3^k -> 0`;
4. `limsup_(k->infinity) M_k^(1/k) < 3`.

If these assertions fail, then

\[
t_k\ge1\text{ for infinitely many }k,\qquad
\limsup_{k\to\infty}\frac{M_k}{3^k}\ge2^{-A},
\qquad
\limsup_{k\to\infty}M_k^{1/k}=3. \tag{5}
\]

This is an exact **bounded-alphabet positive-realizability test**.  It does
not say which branch an arbitrary structured code occupies.

## 2. Endpoint representatives and the carry identity

The prefix with valuations `a_0,...,a_(k-1)` has affine form

\[
U^k(n)=\frac{3^kn+C_k}{2^{q_k}}. \tag{6}
\]

Because `2` is invertible modulo `3^k`, (2) has a unique residue.  It is
nonzero: from (1),

\[
C_k\equiv2^{q_{k-1}}\not\equiv0\pmod3
\qquad(k\ge1).
\]

Thus the representative really lies in `[1,3^k)`.  Reducing (1) modulo
`3^(k+1)` and using (2) gives

\[
2^{a_k}M_{k+1}\equiv3M_k+1\pmod{3^{k+1}},
\]

which defines the integer in (3).  If `t_k<=-1`, then

\[
3M_k+1+t_k3^{k+1}
\le3(3^k-1)+1-3^{k+1}=-2,
\]

contradicting the positive left side.  If `t_k>=2^(a_k)`, the right side is
strictly larger than `2^(a_k)3^(k+1)`, while
`M_(k+1)<3^(k+1)`.  This proves (4).

A positive carry has a fixed normalized cost:

\[
t_k\ge1
\quad\Longrightarrow\quad
\frac{M_{k+1}}{3^{k+1}}
\ge2^{-a_k}\ge2^{-A}. \tag{7}
\]

The uniform final inequality is exactly where the bounded-alphabet
hypothesis is used.

## 3. Positive realization forces vanishing endpoint residues

Suppose a positive odd integer `n_0=N` realizes the code, and write
`n_k=U^k(N)`.  Equation (6) implies

\[
n_k\equiv M_k\pmod{3^k},
\qquad 0<M_k\le n_k. \tag{8}
\]

Every accelerated step satisfies

\[
n_{k+1}+1\le\frac32(n_k+1),
\]

so

\[
M_k\le n_k<(N+1)(3/2)^k. \tag{9}
\]

Consequently `M_k/3^k<=(N+1)/2^k -> 0` and

\[
\limsup M_k^{1/k}\le3/2<3. \tag{10}
\]

In fact, once `2^k>N+1`, (9) gives `n_k<3^k`; then (8) forces `M_k=n_k`.
Substitution in the actual orbit equation makes every later carry zero.

## 4. Vanishing, subcubic growth, and eventual zero carry

If `M_k/3^k -> 0`, (7) rules out positive carries after some finite index, so
`t_k=0` eventually.

If positive carries occurred infinitely often, (7) would give a subsequence
on which

\[
M_k\ge2^{-A}3^k.
\]

Since always `M_k<3^k`, this would force
`limsup M_k^(1/k)=3`.  Therefore subcubic root growth also forces eventual
zero carry.  Conversely, Section 5 turns eventual zero carry into a positive
realization, and (10) then supplies both asymptotic conditions.

## 5. Eventual zero carry reconstructs a positive orbit

Assume `t_k=0` for every `k>=K`, increasing `K` if necessary so that
`K>=1`.  Then

\[
2^{a_k}M_{k+1}=3M_k+1. \tag{11}
\]

The equation at `k` makes `M_k` odd, while the equation at `k+1` makes
`M_(k+1)` odd.  Hence

\[
v_2(3M_k+1)=a_k,
\qquad U(M_k)=M_{k+1} \tag{12}
\]

for every `k>=K`.  Thus the `M_k` form an exact positive accelerated tail.

It remains to reconstruct the finite prefix without importing a rational or
2-adic ghost.  Put `z_K=M_K` and, descending from `j=K-1` to `0`, set

\[
z_j=\frac{2^{a_j}z_{j+1}-1}{3}. \tag{13}
\]

The transition congruence preceding (3) says

\[
2^{a_j}M_{j+1}\equiv3M_j+1\pmod{3^{j+1}}. \tag{14}
\]

Starting with `z_K=M_K`, (14) proves inductively that every division in
(13) is integral and that `z_j congruent M_j (mod 3^j)`.  Positivity is also
inductive, because `z_(j+1)>=1` and `a_j>=1`.  Finally, if `z_(j+1)` is odd,

\[
3z_j+1=2^{a_j}z_{j+1}
\]

makes `z_j` odd and proves that the exact valuation is `a_j`.  The base
`z_K=M_K` is odd by (11).  Therefore `z_0` is a positive odd integer whose
entire valuation sequence is `(a_k)`.

This closes the parity, integrality, positivity, and exact-valuation gaps in
the converse.

## 6. Endpoint-rate corollary

Kramer's endpoint diagnostic is

\[
\rho_M(k)=\frac1k\log\left(1+\frac{M_k}{(3/2)^k}\right). \tag{15}
\]

Within a bounded valuation alphabet, the theorem gives the sharp dichotomy

\[
\begin{cases}
\rho_M(k)\to0,&\text{for a positive realization};\\
\limsup\rho_M(k)=\log2,&\text{otherwise}.
\end{cases} \tag{16}
\]

Indeed, (9) bounds the fraction in (15) for a realization.  In the other
case, infinitely many carries give
`M_k/(3/2)^k >= 2^(-A)2^k` along a subsequence, while `M_k<3^k` supplies the
matching upper exponential rate.

## 7. Exact global-coupling target for the `{1,3}` hard blocks

The theorem does not solve the remaining separated-block problem, but it
turns that problem into one exact endpoint question.

After the first step of any `{1,3}` valuation code, every odd state is
`2 (mod 3)` and can be written `x=6z-1`.  In this coordinate,

\[
a=1:\quad z\mapsto\frac{3z}{2}\quad(z\text{ even}),
\]

\[
a=3:\quad z\mapsto\frac{3z+1}{8}\quad(z\equiv5\pmod8). \tag{17}
\]

A guarded block `1^L 3`, starting with `z=2^Lh`, therefore sends

\[
z\mapsto z'=\frac{3^{L+1}h+1}{8}. \tag{18}
\]

For every `L>=3`, `z'>z`.  Hence a positive realization of an infinite code

\[
(1^{L_0}3)(1^{L_1}3)(1^{L_2}3)\cdots,
\qquad L_i\ge3,
\]

would have an unbounded positive orbit and would be a genuine Collatz
disproof.  By the theorem, constructing such an orbit is **equivalent** to
making its canonical endpoint representatives satisfy `M_k/3^k -> 0` (or
eventually zero carry).  Proving that every such guarded code instead has
infinitely many carries would eliminate this family.  Neither direction is
proved here.

Every finite valuation word is realized by infinitely many positive starts,
so no finite collection of separated exceptional blocks can settle this
question.  The obstruction is the infinite-tail coupling.

## 8. Scope, prior work, and novelty

- Wang's E-sequence construction gives the finite endpoint representatives,
  backward reconstruction, and a canonical-start stabilization/escape
  criterion.  It also leaves universal aperiodic escape as an explicit open
  conjecture and proves several stronger-hypothesis global escape theorems.
- Kramer defines the paired 2-adic start and 3-adic endpoint representatives
  and proves a necessary endpoint-rate condition for positive codes.  The
  bounded-alphabet converse and full-rate alternative in (16) are not stated
  there.
- Bernstein--Lagarias parity coding and the finite full-shift phenomenon are
  classical background.

Primary links:

- Jin Wen Wang, [“An E-sequence approach to the 3x+1 problem”](https://arxiv.org/abs/1809.02278).
- Oliver Kramer, [“Adaptive Search in Collatz Exponent-Code Space via 2-adic and 3-adic Constraints”](https://arxiv.org/abs/2607.10041).
- Daniel J. Bernstein and Jeffrey C. Lagarias,
  [“The 3x+1 Conjugacy Map”](https://doi.org/10.4153/CJM-1996-060-x).

**Novelty classification:** elementary strengthening/package relative to the
cited endpoint criteria; exact statement not located in a bounded search;
no priority or broad novelty claim.  The result is a route gate, not a proof,
disproof, or finite forbidden-word theorem.

## 9. Executable evidence

Run

```powershell
python -B verification\bounded_alphabet_endpoint_residue_gate.py
```

The standard-library checker independently recomputes `(q_k,C_k,M_k,t_k)`,
exhausts every word over `{1,2,3}` through length 8, reconstructs several
actual positive orbits, and tests the constant-`1`, constant-`2`, and
periodic-`1113` boundary cases.  It is regression evidence for the displayed
finite identities, not a proof of the infinite theorem.
