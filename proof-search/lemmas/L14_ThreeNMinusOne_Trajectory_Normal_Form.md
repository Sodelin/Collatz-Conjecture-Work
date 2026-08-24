# L14 — A `3n-1` trajectory normal form for the odd Collatz map

**Status:** `PROVED_AUX` / `FORMAL_PENDING` / `STOP_EQUIVALENT`  
**Map:** fully accelerated odd map `U`  
**Novelty:** elementary explicit packaging; no novelty claim  
**Global verdict:** Collatz remains unresolved

## 1. Map convention

Let `O` be the positive odd integers and define

$$
U(x)=\frac{3x+1}{2^{v_2(3x+1)}}\qquad(x\in O).
$$

Write

$$
\operatorname{Cvg}_U(x)\iff \exists k\ge 0,\ U^k(x)=1.
$$

This is **not** the repository's one-division shortcut map

$$
T(n)=
\begin{cases}
n/2,&n\text{ even},\\
(3n+1)/2,&n\text{ odd}.
\end{cases}
$$

The distinction is essential.  For example,
`v_2(3*5+1)=4`, so `U(5)=1<5`, whereas `T(5)=8>5`.

## 2. Exact theorem

Define

$$
\begin{aligned}
\mathcal H
&=\{4u+3:u\text{ is positive odd}\}
  \cup\{16u+11:u\text{ is positive odd}\}\\
&=(7+8\mathbb N_0)\cup(27+32\mathbb N_0).
\end{aligned}
$$

### Theorem (`L14-3M1-NF`)

For every positive odd integer `n`, there is a finite strictly decreasing
chain

$$
n=x_0>x_1>\cdots>x_m=h
$$

such that

$$
h\in\{1\}\cup\mathcal H
$$

and every edge preserves convergence in both directions:

$$
\operatorname{Cvg}_U(x_i)
\iff
\operatorname{Cvg}_U(x_{i+1}).
$$

Consequently,

$$
h\le n,
\qquad
\operatorname{Cvg}_U(n)\iff\operatorname{Cvg}_U(h),
$$

and ordinary Collatz convergence is equivalent to

$$
\forall h\in\mathcal H,\quad \operatorname{Cvg}_U(h).
$$

For an arbitrary positive integer, first remove its power of two.  This gives
the corresponding statement for the ordinary or one-division shortcut map.

## 3. The decreasing reducer

Let `x>1` be odd and set

$$
a=v_2(3x+1).
$$

### Case 1: `a>=2`

Replace `x` by `U(x)`.  Then

$$
U(x)\le \frac{3x+1}{4}<x.
$$

This is one forward `U` step, so it preserves convergence equivalence.

### Case 2: `a=1`

Now `x=3 (mod 4)`.  Put

$$
c=v_2(3x-1),
\qquad
p=\frac{3x-1}{2^c}.
$$

Then `c>=2`, `p` is positive odd, and

$$
x=\frac{2^c p+1}{3}.
$$

#### Odd `c`

Write

$$
c=2j+3,\qquad j\ge0,
$$

and define

$$
y=3^j p.
$$

For `0<=r<=j`, direct iteration gives

$$
U^{r+1}(x)=3^r2^{2j+2-2r}p+1.
$$

At the last displayed state, one more accelerated step removes the complete
power of two from `3^{j+1}p+1`.  Hence

$$
\boxed{U^{j+2}(x)=U(y).}
$$

Also

$$
x-y
=\frac{(2^{2j+3}-3^{j+1})p+1}{3}>0,
$$

because `2^{2j+3}=8*4^j>3*3^j=3^{j+1}`.  Thus `y` is a
strictly smaller positive odd integer whose orbit coalesces with the orbit of
`x`.

#### Even `c` beyond the two stopping cases

Write

$$
c=2j+2,\qquad j\ge2,
$$

and define

$$
y=2\cdot3^j p+1.
$$

For `0<=r<=j`, direct iteration gives

$$
U^{r+1}(x)=3^r2^{2j+1-2r}p+1.
$$

In particular,

$$
\boxed{U^{j+1}(x)=y.}
$$

The decrease is exact:

$$
x-y
=\frac{(4^{j+1}-2\cdot3^{j+1})p-2}{3}>0.
$$

At `j=2`, the coefficient of `p` is `64-54=10`; if it is
positive at `j`, then the next coefficient is four times the old one plus
`2*3^{j+1}`, so it remains positive.  The numerator is therefore at least
`10p-2>0`.

## 4. Termination and the terminal residues

Every defined replacement produces a smaller positive odd integer.  Ordinary
well-foundedness therefore makes the reduction finite.

The reducer stops away from `1` exactly when

$$
a=1,
\qquad
c\in\{2,4\}.
$$

These two cases are precisely

$$
\begin{aligned}
c=2
&\iff x\equiv7\pmod8
 \iff x=4u+3\quad(u\text{ positive odd}),\\
c=4
&\iff x\equiv27\pmod{32}
 \iff x=16u+11\quad(u\text{ positive odd}).
\end{aligned}
$$

That proves the claimed terminal set.  A direct step obviously preserves
convergence.  In the odd-`c` case, `U^{j+2}(x)=U(y)` gives a common
successor; in the even-`c` case, `y` is itself a forward iterate of `x`.
Thus every edge preserves convergence in both directions, completing the
proof.

## 5. What this theorem does not prove

The residual assertion

$$
\forall h\in\mathcal H,\quad\operatorname{Cvg}_U(h)
$$

is equivalent to Collatz, not a proof of it.  This particular normalizer stops
exactly on `H`; it does **not** prove that members of `H` admit no other finite
trajectory-preserving rewrite.

Indeed, the rejected exhaustion claim has two exact counterexamples.

First, the infinite family `x=64s+55` lies in `H` and satisfies

$$
64s+55
\xmapsto{U}96s+83
\xmapsto{U}144s+125
\xmapsto{U}54s+47
<64s+55.
$$

The smallest instance is

$$
55\mapsto83\mapsto125\mapsto47.
$$

Second, the already-recorded L13 shortcut-map coalescence reduces the terminal
state `23` to `17`:

$$
T^5(23)=20=T^3(17),
\qquad
17=\frac{3\cdot23-1}{4}<23.
$$

Therefore the safe stopping statement is:

> These rules give an exact normal form relative to the displayed `(a,c)`
> case split.  Further work may refine `H` or analyze a residual return map,
> but no exhaustion theorem for all finite/local affine rewrites has been
> proved.

## 6. The auxiliary `3n-1` map

If the odd `3n-1` map is mentioned, it must be defined separately:

$$
V(x)=\frac{3x-1}{2^{v_2(3x-1)}}.
$$

Then

$$
V(5)=7,
\qquad
V(7)=5.
$$

This cycle prevents any silent assumption that repeated `3n-1` acceleration
terminates.  The proof above uses `3x-1` only to select and verify finite
coalescence macros; it never assumes termination of `V`.

## 7. Relation to the existing archive

L13 and the hard-return system parameterize inputs using `v_2(x+1)` and the
one-division map `T`.  L14 instead uses `v_2(3x+1)`, `v_2(3x-1)`, and the
odd-only map `U`.  The exact partitions differ, and neither normalizer subsumes
the other: L14 reduces the L13-hard state `11`, while L13 reduces the L14
terminal state `23`.

Their composition may shrink a residual set, but it supplies no proved
well-founded rank for every recurring residual transition.  L14 is therefore
another exact Route-AB normalizer and sufficient-set presentation, not a new
closure mechanism.

## 8. Prior art and novelty classification

Monks proved that every nonconstant arithmetic progression is a sufficient
set for the `3x+1` map
([Proc. Amer. Math. Soc. 134 (2006), 2861–2872](https://doi.org/10.1090/S0002-9939-06-08567-4)).
Since `7+8*N_0` is already one component of `H`, the consequence that
convergence on `H` suffices for Collatz is known in substantially stronger
form.  Monks et al. later developed strongly sufficient sets and unions of
power-of-two residue classes
([Discrete Math. 313 (2013), 468–489](https://arxiv.org/abs/1204.3904)).

General parity-affine and `3n-1` trajectory identities are classical; relevant
sources include Andrei–Kudlek–Niculescu
([Acta Informatica 37 (2000), 145–160](https://doi.org/10.1007/s002360000039)),
Lagarias
([Amer. Math. Monthly 92 (1985), 3–23](https://doi.org/10.1080/00029890.1985.11971528)),
and Trümper
([Int. J. Math. Math. Sci. 2014, 756917](https://doi.org/10.1155/2014/756917)).

A bounded source search did not locate this exact two-branch decreasing
packaging.  That is not a priority result: the claim is classified `N1`
(elementary repackaging), with no novelty claim.

## 9. Verification boundary

`verification/trajectory_normal_form_regression.py` exactly replays the local
identities and terminal classification over its stated finite range and checks
the infinite counterfamily symbolically instance by instance over a stated
finite parameter range.  It is a regression test, not a proof of the universal
theorem.  The proof above remains prose and is not Lean-formalized.

## Connections

- **Parallel to:** [L13 refined Mersenne macros](L13_Refined_Mersenne_Child_Macros.md) and the [hard boundary return system](../routes/AB_hard_boundary_return_system.md).
- **Verified computationally within the stated finite scope by:** [reproduction manifest](../../verification/README.md).
- **Formalization pending:** [Lean targets](../../LEAN_TARGETS.md).
- **Status and novelty recorded in:** [atomic claim registry](../CLAIM_REGISTRY.md).
