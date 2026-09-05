# Mathematical implication checks

These are review calculations, not additions to the Lean development. Return to the [review report](REPORT.md).

## First-crossing extremizer

Let $L=\log_2 3$, let $s\geq1$ be the odd count, and write the zero-based odd positions as $a_0<\cdots<a_{s-1}$. The classical affine numerator is

$$
A=\sum_{r=0}^{s-1}2^{a_r}3^{s-1-r}.
$$

First-crossing minimality gives $2^{a_r}\leq3^r$, hence $a_r\leq\lfloor rL\rfloor$. Each term increases with its position. The increasing deadline word attains these bounds and respects the earlier barriers. Therefore

$$
A\leq M_s:=\sum_{r=0}^{s-1}2^{\lfloor rL\rfloor}3^{s-1-r}.
$$

The monotonicity is classical; this constrained extremizer requires a short additional deadline argument. At the first contraction $k=\lfloor sL\rfloor+1$,

$$
d=\frac A{2^k}-\left(1-\frac{3^s}{2^k}\right)n<\frac A{2^k}.
$$

The project's exact all-count certificate $4M_s\leq s2^k$ consequently implies $4d<s$. The strict inequality uses both $n>0$ and strict coefficient contraction.

## Qualitative eventual quarter is a standard corollary

Set $S_s=\sum_{r=0}^{s-1}2^{-\{rL\}}$. Then $M_s=3^{s-1}S_s$. Irrationality of $L$ follows from unique factorization: $L=a/b$ would imply $3^b=2^a$. Linear equidistribution applied to the Riemann-integrable function $2^{-x}$ gives

$$
\frac{S_s}{s}\to\int_0^1 2^{-x}\,dx=\frac1{2\ln2},\qquad
\frac{M_s}{s3^s}\to\frac1{6\ln2}<\frac14.
$$

This supplies existence of some eventual threshold, without identifying it. Every constant above $1/(6\ln2)$ eventually works in that normalization. The source's extra quantitative statement is validity for every $s\geq16$, propagated by an exact twelve-step certificate after checking bases 16–27. Exact integers at the boundary are

$$
4M_{15}=217653340>15\cdot3^{15}=215233605,
$$
$$
4M_{16}=686514452\leq16\cdot3^{16}=688747536.
$$

This establishes sharpness of the eventual threshold, not failure at every smaller count and not optimality of the coefficient one quarter.

## Halbeisen–Hungerbühler: exact direct-corollary test

Use [their Lemma 5, Corollary 1 and Proposition 2, pp.230–234](https://math.ch/norbert.hungerbuehler/publications/Optimal_bounds_for_the_length_of_rational_Collatz_cycles.pdf). Denote their cyclic extremum by $H_{l,s}$. With $l=\lfloor sL\rfloor+1$, its mechanical representation gives

$$
H_{l,s}=\sum_{r=0}^{s-1}3^{s-1-r}2^{\lfloor rl/s\rfloor}\geq M_s.
$$

At $s=16,l=26$, $H_{26,16}=213933253$, so $4H_{26,16}>16\cdot3^{16}$. The larger cyclic object cannot simply inherit the source's stronger quarter bound.

Here is our algebraic test of the published upper bound, rather than a claim about its historical originality. Write

$$
m=2s-l,\quad x=2^l/3^s>1,\quad
a_1=\frac{2s+3l}{9m},\quad a_2=\frac{6s+l}{27m}.
$$

For the relevant $l>6$, Proposition 2 bounds $H_{l,s}/3^s$ by

$$
B=a_1x^{1-1/m}+a_2\frac{x^{1-1/m}-1}{x^{1/m}-1}.
$$

The second ratio is a geometric sum with $m-1$ terms, each at least one. Thus

$$
B\geq a_1+(m-1)a_2
=\frac{6s+l}{27}+\frac{8l}{27m}>\frac s4.
$$

Consequently direct substitution and transitivity cannot supply $M_s\leq s3^s/4$. For the weaker $2^l$ normalization, choose an infinite subsequence with $l-sL\to0$, available by irrational-rotation density. Then $x\to1$, $m/s\to2-L$, and

$$
\frac{B}{sx}\to\frac{6+L}{27}\approx0.280924537>\frac14.
$$

For precision, if $y=x^{1/m}$, the geometric sum divided by $m$ lies between $(m-1)/m$ and $(m-1)x/m$, both tending to one. Also $a_1/s\to0$ and $a_2m/s\to(6+L)/27$. No floating-point evidence is needed for the nonimplication.

This rules out one concrete direct-corollary route. It does not rule out a different unpublished argument, folklore, or another earlier inequality.

## Harmonic-mean comparison and scope

In the [Rozier–Terracol Theorem 4.2](https://arxiv.org/html/2502.00948v5) normalization, let $C=3^s/2^k$ and let $h$ be the harmonic mean of the odd orbit values. Earlier values are at least $n$, so $h\geq n$. The resulting weakened bound is

$$
d\leq n\left[C\left(1+\frac1{3h}\right)^s-1\right]
\leq n\left[C\left(1+\frac1{3n}\right)^s-1\right].
$$

At the symbolic parameters $n=101,s=41,k=65$, the final expression is about 13.2911, exceeding $s/4=10.25$. These parameters illustrate slack in this substitution; they are **not** claimed to describe an actual orbit satisfying the premises. Reintroducing the position deadlines leads back to a rotation sum and requires additional estimates.

For $n\geq2$, non-descent at the first coefficient contraction would be a counterexample to equality of coefficient and actual stopping times (CST). No known nontrivial witness is supplied here. The case $n=1,k=2,s=1,d=0$ does satisfy the theorem. Declaring every nontrivial instance impossible would require an additional theorem; the quarter bound does not prove that exclusion or Collatz convergence.
