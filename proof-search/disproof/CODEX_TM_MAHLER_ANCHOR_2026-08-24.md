# Conditional Thue–Morse 2-adic anchor

**Claim ID:** `C-TM-MAHLER-ANCHOR-001`

**Status:** `PAUSED_AWAITING_EXACT_2_ADIC_MEMBERSHIP` / `NO DISPROOF`

**Map:** fully accelerated odd Collatz map

**Novelty:** unclassified; do not cite as a priority claim

**Global verdict:** Collatz remains unresolved

## 1. Exact conditional construction

Let `t_i` be the Thue–Morse bits,

\[
t_i\equiv s_2(i)\pmod2,
\]

where `s_2(i)` is the sum of the binary digits of `i`. Put

\[
a_i=1+t_i,
\qquad
A_j=\sum_{i<j}a_i.
\]

In the 2-adic integers, define

\[
N=-\sum_{j\ge0}\frac{2^{A_j}}{3^{j+1}}.
\]

The series converges because `A_j` tends to infinity and powers of `3` are
2-adic units.

For every `k>=0`, define the shifted series

\[
N_k=-\sum_{j\ge0}\frac{2^{A_{k+j}-A_k}}{3^{j+1}}.
\]

Here `N_0=N`. Each `N_k` is odd: its `j=0` term is `-1/3`, while the
sum of all remaining terms lies in \(2\mathbb Z_2\). Moreover,

\[
\begin{aligned}
3N_k+1
&=-\sum_{j\ge1}\frac{2^{A_{k+j}-A_k}}{3^j}\\
&=2^{a_k}N_{k+1}.
\end{aligned}
\]

Thus

\[
\boxed{3N_k+1=2^{a_k}N_{k+1}}.
\]

Because `N_(k+1)` is odd, the recurrence already gives, in \(\mathbb Z_2\),

\[
v_2(3N_k+1)=a_k.
\]

Now suppose that

\[
\boxed{N=N_0\in\mathbb Z_{>0}}.
\]

If `N_k` is a positive ordinary integer, then

\[
N_{k+1}=\frac{3N_k+1}{2^{a_k}}\in\mathbb Z_2.
\]

Since the numerator is an ordinary integer, membership of this quotient in
`Z_2` implies

\[
2^{a_k}\mid3N_k+1
\]

in \(\mathbb Z\). Hence `N_(k+1)` is a positive ordinary integer; it is odd by the
shifted-series argument above. Induction therefore makes every `N_k` a
positive odd ordinary integer, and the exact valuation identity shows that
this sequence is precisely the fully accelerated Collatz orbit of `N`.

## 2. Exact product identity

The Thue–Morse relations

\[
t_{2r}=t_r,
\qquad
t_{2r+1}=1-t_r
\]

give

\[
A_{2r}=3r,
\qquad
A_{2r+1}=3r+1+t_r.
\]

Let `epsilon_r=(-1)^{t_r}` and `x=8/9`. Splitting the defining series into
even and odd indices gives

\[
\sum_{j\ge0}\frac{2^{A_j}}{3^{j+1}}
=\frac19\sum_{r\ge0}(6-\epsilon_r)x^r.
\]

The classical formal Thue–Morse product identity

\[
\sum_{r\ge0}\epsilon_r x^r
=\prod_{m\ge0}(1-x^{2^m})
\]

is valid here in `Q_2`, since `v_2(x)=3>0`. Also

\[
\sum_{r\ge0}x^r=\frac1{1-x}=9.
\]

Therefore

\[
\boxed{
N=\frac19\prod_{m\ge0}
\left(1-\left(\frac89\right)^{2^m}\right)-6,
}
\]

where the product is interpreted 2-adically.

## 3. Conditional divergence bound

Unrolling the affine recurrence gives

\[
2^{A_k}N_k
=3^kN+\sum_{i<k}3^{k-1-i}2^{A_i}.
\]

If `N` is a positive ordinary integer, the correction sum is nonnegative for
`k>=0` and positive for `k>=1`. Therefore

\[
N_k\ge\frac{3^kN}{2^{A_k}}
\]

for `k>=0`, with strict inequality for `k>=1`.

The exact formulas for `A_k` imply

\[
A_k\le\frac{3k+1}{2}.
\]

Consequently, for `k>=1`,

\[
N_k>\frac{N}{\sqrt2}
\left(\frac{3}{2\sqrt2}\right)^k.
\]

For `k=0`, the same strict bound holds separately because
`N_0=N>N/sqrt(2)`. Thus, for every `k>=0`,

\[
\boxed{
N_k>\frac{N}{\sqrt2}
\left(\frac{3}{2\sqrt2}\right)^k.
}
\]

Since `3/(2*sqrt(2))>1`, this would imply `N_k` tends to positive infinity.

## 4. Exact unresolved gate

The construction is **not** a disproof unless

\[
N\in\mathbb Z_{>0}
\]

is proved. For every fixed finite prefix, one can choose a positive ordinary
seed realizing that prefix. Finite-prefix realizability, however, does not
produce one ordinary seed realizing all prefixes; the chosen seeds need not
stabilize to a fixed ordinary integer. The infinite series itself currently
supplies only one element of \(\mathbb Z_2\). Treating that 2-adic limit as a
positive ordinary integer without proving \(N\in\mathbb Z_{>0}\) is precisely
the prohibited 2-adic-ghost step.

The familiar real or complex value of the Thue–Morse product at `8/9` is the
Archimedean limit of the rational partial products, whereas the value above is
their 2-adic limit. A result about the Archimedean limit does not by itself
determine the 2-adic limit. Any theorem used to close the gate must explicitly
apply 2-adically at `x=8/9` to this product.

Thus the note establishes only the conditional statement that, if this
particular 2-adic integer belongs to \(\mathbb Z_{>0}\), it generates a
divergent Collatz orbit. It neither proves nor supplies evidence for that
membership claim, and therefore gives no counterexample or disproof.
