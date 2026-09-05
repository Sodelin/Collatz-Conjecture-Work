# Prime renewal and the finite-window no-go

**Primary claim:** `F-PRIME-RETURN-001`

**Companion claim:** `D-HARD-PRIME-REFRESH-001`

**Status:** `STOPPED-USEFUL` / `FORMAL_PENDING` / `NO PROOF OR DISPROOF`

**Novelty:** elementary affine and CRT consequences; no novelty claim

**Global verdict:** Collatz remains unresolved

The initial audit candidates and discussion are preserved in
[GitHub Issue #4](https://github.com/Sodelin/Collatz-Conjecture-Work/issues/4)
and
[GitHub Issue #5](https://github.com/Sodelin/Collatz-Conjecture-Work/issues/5).
This note incorporates their scope corrections and removes the provisional
promotion language.

## 1. Convention and affine corrections

For a positive odd integer `n`, define

$$
T(n)=\frac{3n+1}{2^{v_2(3n+1)}}.
$$

Fix a finite positive valuation word

$$
w=(a_0,\ldots,a_{r-1}),
\qquad a_i\ge1,
$$

and put

$$
A_t=\sum_{i<t}a_i,
\qquad
C_t=\sum_{j=0}^{t-1}3^{t-1-j}2^{A_j}.
$$

Every positive odd realization `n_0,...,n_r` of the word satisfies

$$
\boxed{2^{A_t}n_t=3^tn_0+C_t}
\qquad(0\le t\le r).
$$

The word itself is realized by exactly one odd residue class modulo
`2^(A_r+1)`. One self-contained description is

$$
3^rn_0+C_r\equiv2^{A_r}\pmod{2^{A_r+1}}.
$$

Because `3` is invertible modulo powers of `2`, this selects one residue.
Backward reduction of the congruence gives

$$
3^tn_0+C_t\equiv2^{A_t}\pmod{2^{A_t+1}}
$$

for every prefix, which is exactly the required integrality and odd-cofactor
condition. Thus the class contains infinitely many positive seeds.

## 2. Correction-divisor criterion

Let `p>=5` be prime and suppose `p` divides `n_0`. Since `2` is a unit modulo
`p`, the affine identity gives the exact equivalence

$$
\boxed{p\mid n_t\quad\Longleftrightarrow\quad p\mid C_t.}
$$

Consequently, inside a fixed valuation word, `p` disappears and first returns
at step `r` exactly when

$$
p\mid C_r,
\qquad
p\nmid C_t\quad(1\le t<r).
$$

The dyadic valuation cylinder and the congruence `n_0=0 mod p` are coprime,
so the Chinese remainder theorem supplies infinitely many positive seeds
realizing both conditions.

## 3. The two hard-word constants

For positive odd `u`, let `n=4u+3`. Its forced word is `(1,1)` and

$$
T(n)=6u+5,
\qquad
T^2(n)=9u+8=\frac{9n+5}{4}.
$$

Therefore

$$
\boxed{4T^2(n)-9n=5},
\qquad
\gcd(n,T^2(n))\mid5.
$$

The bound is sharp: `u=3` gives endpoints `15` and `35`, with gcd `5`.

For positive odd `u`, let `n=16u+11`. Its forced word is `(1,2,1)` and

$$
T(n)=24u+17,
\qquad
T^2(n)=18u+13,
\qquad
T^3(n)=27u+20=\frac{27n+23}{16}.
$$

Therefore

$$
\boxed{16T^3(n)-27n=23},
\qquad
\gcd(n,T^3(n))\mid23.
$$

This bound is also sharp: `u=41` gives endpoints `667` and `1127`, with gcd
`23`.

These are the correction-divisor criterion specialized to the two hard words:

$$
\begin{array}{c|ccc}
w&C_1&C_2&C_3\\
\hline
(1,1)&1&5&-\\
(1,2,1)&1&5&23.
\end{array}
$$

The identities concern actual orbit endpoints. The L14 coalescence normalizer
is an abstract termination-preserving rewrite and does not transport prime
support from an input to its smaller representative.

## 4. Arbitrarily delayed first return during maximal growth

For the word of `L` consecutive valuation-`1` steps,

$$
C_t=3^t-2^t.
$$

Given any prime `p>=5`, let

$$
L=\operatorname{ord}_p(3\cdot2^{-1}).
$$

Then

$$
p\nmid3^t-2^t\quad(1\le t<L),
\qquad
p\mid3^L-2^L.
$$

Intersecting the all-ones valuation cylinder with `n_0=0 mod p` therefore
gives a positive odd seed for which `p` disappears immediately and first
returns exactly at step `L`.

The gaps `L` are unbounded as `p` varies. Otherwise, if every order were at
most `R`, every prime `p>=5` would divide the fixed nonzero integer

$$
\prod_{t=1}^R(3^t-2^t),
$$

which has only finitely many prime divisors. The smallest exact example is

$$
15\longrightarrow23\longrightarrow35,
$$

where `p=5`, both valuations are `1`, and the return gap is `2`.

## 5. Every finite concatenation of individually admissible return blocks for pairwise distinct primes is realizable

Choose pairwise distinct primes `p_1,...,p_m>=5`. For each `j`, choose a
finite valuation block that has `p_j` as a first-return correction divisor;
the pure valuation-`1` block of length
`ord_(p_j)(3*2^(-1))` is one canonical choice. Concatenate the blocks into
one finite valuation word, and let `s_j` be the start of block `j`.

At time `s`, the prefix identity has the form

$$
2^{A_s}n_s=3^sn_0+C_s.
$$

Because `3^s` is invertible modulo `p_j`, the block-start condition
`p_j|n_(s_j)` is one congruence on the original seed:

$$
n_0\equiv-C_{s_j}3^{-s_j}\pmod{p_j}.
$$

The distinct prime moduli and the dyadic valuation-cylinder modulus are
pairwise coprime. The Chinese remainder theorem therefore supplies one
positive odd seed satisfying the complete valuation script and every
block-start congruence simultaneously. Relative to each block start, the
chosen prime disappears and returns at the prescribed endpoint.

Thus no obstruction involving only finitely many individually admissible
prescribed blocks for pairwise distinct designated primes can separate genuine
positive Collatz prefixes from a proposed renewal pattern.

## 6. Arbitrarily long rough growth shadows

Let `L>=1` and let `M` be any positive odd integer. Define

$$
n_0=2^{L+1}M-1,
\qquad
n_t=3^t2^{L+1-t}M-1
\quad(0\le t\le L).
$$

For `t<L`,

$$
3n_t+1=2n_{t+1},
$$

and `n_(t+1)` is odd. Hence the first `L` accelerated valuations are exactly
`1`, every step grows, and

$$
n_{t+1}+1=\frac32(n_t+1).
$$

Also `n_t=-1 mod M` for every `t`. If `M` is the product of all odd primes at
most `Y`, every prime divisor of every state in the segment exceeds `Y`.

For every fixed `L,Y`, these conditions—`L` valuation-`1` growth steps and
avoidance of primes at most `Y`—are jointly realizable. Thus those finite
growth/roughness conditions alone do not exclude the transient-prime
architecture.

## 7. Exact route closure and remaining gap

The results above close only finite-window prime arguments:

- local hard-macro support refresh does not prevent later reappearance;
- no single finite upper bound, uniform over both primes `p>=5` and positive
  seeds, exists for these first-return gaps;
- every finite list of distinct delayed-return blocks occurs in one positive
  orbit segment;
- finite roughness plus finite growth is realizable exactly.

The constructed seed depends on the finite script. Passing from every finite
script to one infinite script yields a compatible profinite or 2-adic
specification, not automatically one positive natural number. A proof or
disproof still needs a genuinely global invariant or a fixed positive seed.
Assuming stabilization of the compatible residues would be the prohibited
ghost step.

This note constructs no positive divergent orbit, excludes no nontrivial
cycle, and proves no universal convergence theorem. Its value is to prevent
more computation on finite prime-return, finite roughness, or bounded-window
variants of the same architecture.

## 8. Verification boundary

The companion
[`prime_renewal_regression.py`](../../verification/prime_renewal_regression.py)
replays 10,000 general odd prefixes, 10,000 parameters for each hard-word
identity, all 44 primes from `5` through `199` (largest observed return gap
`178`), one five-prime CRT script of 38 valuation-`1` steps, and 48
rough-growth `(L,Y)` pairs. It is not evidence for an infinite seed or a proof
of the universal prose statements.
