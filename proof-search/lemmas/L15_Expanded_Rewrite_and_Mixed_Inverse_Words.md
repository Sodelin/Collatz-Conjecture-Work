# L15 — Expanded rewrite boundary and mixed inverse words

**Status:** `PROVED_AUX` / `FORMAL_PENDING` / `STOP_EQUIVALENT`

**Map:** fully accelerated odd map `U`

**Novelty:** elementary inverse-tree and CRT packaging; no novelty claim

**Global verdict:** Collatz remains unresolved

## 1. Convention

For a positive odd integer `n`, define

\[
U(n)=\frac{3n+1}{2^{v_2(3n+1)}}.
\]

Two positive odd integers are called **termination-equivalent** when either
both or neither reach `1` under iteration of `U`.

This note extends the decreasing relation in
[L14](L14_ThreeNMinusOne_Trajectory_Normal_Form.md). It does not claim that
the extension is confluent or that its irreducible set terminates.

## 2. Two additional decreasing predecessor rewrites

Let

\[
\mathcal H=(7+8\mathbb N_0)\cup(27+32\mathbb N_0)
\]

be the L14 terminal set.

### Residue `2 mod 3`

If `x` is positive odd and `x=2 mod 3`, put

\[
y=\frac{2x-1}{3}.
\]

Then `y` is positive odd, `y<x`, and

\[
3y+1=2x,
\qquad U(y)=x.
\]

### Residue `4 mod 9`

If `x` is positive odd and `x=4 mod 9`, put

\[
y=\frac{8x-5}{9},
\qquad z=\frac{4x-1}{3}.
\]

Both are positive odd, `y<x`, and

\[
3y+1=2z,
\qquad 3z+1=4x.
\]

Hence

\[
U(y)=z,
\qquad U^2(y)=x.
\]

Each replacement is therefore a strict decrease preserving
termination-equivalence.

## 3. Exact irreducible set and nonconfluence

Adjoin the two predecessor rewrites above to the L14 decreasing relation.
Every rewrite still lowers a positive integer, so every maximal rewrite
sequence is finite.

A nonunit irreducible must first lie in `H`. The residue-`2 mod 3` rule removes
the odd residues `2,5,8 mod 9`, while the second rule removes `4 mod 9`.
Therefore the irreducibles are exactly

\[
\boxed{
\{1\}\cup
\{h\in\mathcal H:h\bmod9\in\{0,1,3,6,7\}\}.
}
\]

The relation is not confluent. Starting at `11`, the L14 rules can reduce
through `3` to `1`, whereas the first predecessor rewrite gives

\[
11\longmapsto7,
\]

and `7` is irreducible. Thus no unique or canonical normal form is asserted.
A separately specified priority policy can select an endpoint, but it cannot
turn this nonconfluent relation into a confluence theorem.

## 4. Complete accelerated inverse fibers

For completeness, this section recasts the repository's existing inverse-word
machinery directly in the fully accelerated odd-map convention.

Let `x,y` be positive odd integers. Then

\[
U(y)=x
\]

if and only if, for some integer `a>=1`,

\[
y=\frac{2^a x-1}{3}
\]

is a positive integer. The valuation is exactly `a`, because the cofactor
`x` is odd.

The congruence modulo `3` gives the complete exponent classification:

- if `x=0 mod 3`, there is no positive odd predecessor;
- if `x=1 mod 3`, the allowed exponents are the positive even integers;
- if `x=2 mod 3`, the allowed exponents are the positive odd integers.

For consecutive allowed exponents,

\[
y_{a+2}=4y_a+1.
\]

Thus every nonempty one-step inverse fiber is one affine ray.

## 5. Canonical source reduction

This elementary modulo-`9` specialization was not previously recorded as a
standalone repository claim.

Assume `3` does not divide the positive odd integer `x`. Since `2` has order
`6` modulo `9`, there is exactly one `e in {1,...,6}` such that

\[
2^e x\equiv1\pmod9.
\]

Define

\[
D(x)=\frac{2^e x-1}{3}.
\]

Then `D(x)` is the least positive odd predecessor of `x` divisible by `3`.
All such predecessors are

\[
D_r(x)=\frac{2^{e+6r}x-1}{3},
\qquad r\ge0,
\]

and satisfy

\[
D_{r+1}(x)=64D_r(x)+21.
\]

Consequently, the Collatz conjecture is equivalent to its restriction to
positive odd multiples of `3`: every other positive odd `x` is the first
accelerated successor of `D(x)`. This is a domain reduction only. The source
`D(x)` can be much larger than `x`, so the statement supplies no induction
rank or convergence proof.

## 6. Mixed inverse-word calculus

Fix an integer `k>=1`, a positive odd endpoint `x=x_0`, and a word

\[
(a_1,\ldots,a_k)\in\{1,2\}^k,
\]

define, whenever the displayed quotient is integral,

\[
x_i=\frac{2^{a_i}x_{i-1}-1}{3}.
\]

Put `A_0=B_0=0` and

\[
A_i=A_{i-1}+a_i,
\qquad
B_i=2^{a_i}B_{i-1}+3^{i-1}.
\]

Induction gives

\[
\boxed{x_i=\frac{2^{A_i}x-B_i}{3^i}},
\qquad
\boxed{U^i(x_i)=x}.
\]

For a fixed word, the terminal congruence

\[
2^{A_k}x\equiv B_k\pmod{3^k}
\]

selects one class modulo `3^k`. It implies all intermediate congruences: for
`j<=k`,

\[
B_k\equiv2^{A_k-A_j}B_j\pmod{3^j},
\]

and powers of `2` are units modulo powers of `3`. Restricting to odd endpoints
selects one class modulo `2*3^k` by the Chinese remainder theorem.

Because `B_k>0`, every valid positive endpoint satisfying

\[
2^{A_k}<3^k
\]

has a strictly smaller predecessor:

\[
0<x_k=\frac{2^{A_k}x-B_k}{3^k}<x.
\]

This is an exact residue-class descent certificate, not a density argument.

## 7. A concrete mixed-word family

For the word `(2,2,1,1)`,

\[
A_4=6,
\qquad (B_1,B_2,B_3,B_4)=(1,7,23,73).
\]

Its odd validity class is

\[
x\equiv91\pmod{162}.
\]

Writing `x=91+162t` with `t>=0`, the inverse chain is

\[
91+162t
\leftarrow121+216t
\leftarrow161+288t
\leftarrow107+192t
\leftarrow71+128t,
\]

where each arrow points from a `U`-predecessor to its successor when read
right-to-left. Equivalently,

\[
U^4(71+128t)=91+162t.
\]

The four exact valuations, from the endpoint backward, are `(2,2,1,1)`, and

\[
71+128t<91+162t.
\]

The smallest instance is

\[
71\to107\to161\to121\to91.
\]

Thus `91`, although irreducible for the five-rule relation in Section 3, has
a smaller termination-equivalent predecessor. The expanded relation is not a
maximal catalogue of finite trajectory-preserving reductions.

## 8. Exact completion bridge and its open hypothesis

A **forward-inverse certificate** for a positive odd `h>1` consists of a
positive odd `z<h` and integers `p,q>=0` such that

\[
U^p(h)=U^q(z).
\]

If every nonunit irreducible from Section 3 has such a certificate, then
Collatz follows by strong induction: reducible inputs descend through the
rewrite relation, and irreducibles coalesce with a smaller terminating input.

The universal certificate-coverage assertion is unproved. Conversely, if
Collatz holds, take `z=1`, `q=0`, and choose `p` with `U^p(h)=1`. Universal
forward-inverse certificate coverage is therefore logically equivalent to the
Collatz conjecture.

Coverage restricted to `p=0`, meaning `U^q(z)=h`, is impossible: for example,
`15` is a nonunit irreducible from Section 3, but no positive odd multiple of
`3` has a `U`-predecessor. Thus this certificate strategy must allow `p>0`, or
else be replaced by a different mechanism.

## 9. Pure exponent-2 depth obstruction

The narrow policy “repeatedly take the least exponent-2 predecessor” has no
uniform successful depth. For every `K>=1`, choose positive even `w` with

\[
w\equiv2\pmod3,
\qquad 3^K w+1\equiv7\pmod8,
\]

and put

\[
h_i=1+4^i3^{K-i}w,
\qquad0\le i\le K.
\]

Such `w` exists by the Chinese remainder theorem: one may take
`w=2 mod 24` when `K` is odd and `w=14 mod 24` when `K` is even. Moreover,
`h_0=7 mod 8`, while `h_0=7 mod 9` for `K=1` and `h_0=1 mod 9` for `K>=2`.
Hence `h_0` is a nonunit irreducible from Section 3. For `i<K`,
`h_i=1 mod 3`, so `h_(i+1)` is precisely its least allowed inverse, with
valuation label `2`.

Then `U(h_i)=h_{i-1}` for `i>0`, every `h_i` with `i>0` exceeds `h_0`, and
`h_K` is divisible by `3`, so it has no positive odd predecessor. This rules
out only a uniform fixed-depth, label-local repetition of the pure exponent-2
edge. It does not rule out mixed words, adaptive searches, forward merges, or
global arithmetic invariants.

## 10. Relation to the existing archive

The affine inverse-word mechanism substantially overlaps the shortcut-map
calculus in [L4](L4_General_Inverse_Word_Coalescence.md) and the endpoint
congruence machinery in [L10](L10_Near_Return_and_Dual_Residue_Certificate.md).
L15 repackages those ideas for complete accelerated odd inverse fibers and
the post-L14 residual set. The canonical source reduction and the explicit
`91 mod 162` coalescence family were not previously recorded in the
repository, but no mathematical priority is claimed for either elementary
calculation.

## 11. Verification and scope

The companion
[`expanded_rewrite_inverse_word_regression.py`](../../verification/expanded_rewrite_inverse_word_regression.py)
checks 50,000 odd starts through `100000`, 12,500 odd inverse/source endpoints
through `25000`, all 510 binary valuation words through length `8`, 10,001
members of the `91 mod 162` family, and the first 24 pure-`a=2` obstruction
depths. It is not a proof of the universal prose statements.

No statement in this note proves that an irreducible endpoint terminates,
constructs a positive divergent orbit, or supplies a nontrivial positive
cycle. The inverse-tree facts and CRT calculations are elementary and are
recorded here without a novelty or priority claim.
