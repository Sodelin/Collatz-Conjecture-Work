# L12 — Hard-exit gap valuation transition

**Cycle:** Round 7, 2026-08-23
**Status:** `FORMAL_PENDING`
**Correctness note:** informal proof by elementary 2-adic valuation arithmetic survived independent hostile audit
**Novelty:** unchecked; no novelty claim
**Usefulness:** propagates more than the mod-4 conclusion of L11 across a positive near-return gap
**Collatz relevance:** necessary-condition sharpening only; not a resolution

## 1. Setup

Use the accelerated Collatz map

$$
T(n)=\begin{cases}
n/2,&n\text{ even},\\
(3n+1)/2,&n\text{ odd}.
\end{cases}
$$

L6 calls an odd positive integer `x` a **hard-exit state** when, on writing

$$
x+1=2^r u,
\qquad
r=v_2(x+1)\ge2,
\qquad
u\text{ odd},
$$

one has

$$
3^r u\equiv3\pmod4.\tag{1}
$$

Define the hard odd-quotient residue

$$
\boxed{
h(r)=
\begin{cases}
3,&r\text{ even},\\
1,&r\text{ odd}.
\end{cases}}
\tag{2}
$$

Since `3^r` is `1 mod 4` for even `r` and `3 mod 4` for odd `r`, condition (1) is equivalent to

$$
\boxed{u\equiv h(r)\pmod4.}\tag{3}
$$

Equivalently, every hard-exit state satisfies the exact residue-cylinder condition

$$
x+1\equiv2^r h(r)\pmod{2^{r+2}}.\tag{4}
$$

Let `n` and

$$
y=n+d
$$

be two hard-exit states with a **positive** gap `d>0`. Write

$$
n+1=2^q m,
\qquad
y+1=2^{q'}m',
\tag{5}
$$

where

$$
q=v_2(n+1),
\qquad
q'=v_2(y+1),
\qquad
m\equiv h(q)\pmod4,
\qquad
m'\equiv h(q')\pmod4.
\tag{6}
$$

Finally put

$$
e=v_2(d),
\qquad
u_d=\frac d{2^e},
\tag{7}
$$

so `u_d` is odd.

## 2. Hard-exit gap valuation theorem

Exactly one of the following three cases holds.

### Case A: endpoint valuation decreases, `q'<q`

Then

$$
\boxed{e=q'}\tag{8}
$$

and

$$
\boxed{
u_d\equiv
h(q')-2^{q-q'}h(q)
\pmod4.}
\tag{9}
$$

Equivalently,

$$
u_d\equiv
\begin{cases}
h(q')-2\pmod4,&q-q'=1,\\
h(q')\pmod4,&q-q'\ge2.
\end{cases}
\tag{10}
$$

### Case B: endpoint valuation is unchanged, `q'=q`

Then

$$
\boxed{e\ge q+2.}\tag{11}
$$

In particular, both

$$
\boxed{e=q\text{ and }e=q+1\text{ are impossible}.}\tag{12}
$$

Thus two distinct hard-exit states in the same `v_2(x+1)=q` cylinder differ by a multiple of `2^{q+2}`, not merely by a multiple of four.

### Case C: endpoint valuation increases, `q'>q`

Then

$$
\boxed{e=q}\tag{13}
$$

and

$$
\boxed{
u_d\equiv
2^{q'-q}h(q')-h(q)
\pmod4.}
\tag{14}
$$

Equivalently,

$$
u_d\equiv
\begin{cases}
2-h(q)\pmod4,&q'-q=1,\\
-h(q)\pmod4,&q'-q\ge2.
\end{cases}
\tag{15}
$$

## 3. Proof

Subtract the two identities in (5):

$$
\boxed{d=2^{q'}m'-2^q m.}\tag{16}
$$

### Proof of Case A

If `q'<q`, factor out `2^{q'}`:

$$
d=2^{q'}\left(m'-2^{q-q'}m\right).
\tag{17}
$$

The quantity in parentheses is odd, because `m'` is odd and `2^{q-q'}m` is even. Hence `e=q'`, proving (8). Dividing (17) by `2^e` and reducing modulo four gives

$$
u_d
\equiv
m'-2^{q-q'}m
\equiv
h(q')-2^{q-q'}h(q)
\pmod4,
$$

which is (9). If `q-q'=1`, the second term is `2 mod 4` because `h(q)` is odd. If `q-q'>=2`, it vanishes modulo four. This proves (10).

### Proof of Case B

If `q'=q`, then

$$
d=2^q(m'-m).
\tag{18}
$$

Both odd quotients have the same hard residue:

$$
m'\equiv m\equiv h(q)\pmod4.
$$

Therefore

$$
4\mid(m'-m).
$$

Because `d>0`, the difference is nonzero, and consequently

$$
e=q+v_2(m'-m)\ge q+2.
$$

This proves (11) and the exclusions in (12).

### Proof of Case C

If `q'>q`, factor out `2^q`:

$$
d=2^q\left(2^{q'-q}m'-m\right).
\tag{19}
$$

The quantity in parentheses is odd, because its first term is even and `m` is odd. Hence `e=q`, proving (13). Division by `2^e` and reduction modulo four give

$$
u_d
\equiv
2^{q'-q}m'-m
\equiv
2^{q'-q}h(q')-h(q)
\pmod4,
$$

which is (14). If `q'-q=1`, the first term is `2 mod 4`; if `q'-q>=2`, it vanishes modulo four. This proves (15).

The three integer relations `q'<q`, `q'=q`, and `q'>q` are mutually exclusive and exhaustive, completing the proof.

## 4. Immediate structural corollary

For `d>0`, the theorem can be summarized as

$$
\boxed{
q\ne q'\Longrightarrow e=\min(q,q'),
}
\tag{20}
$$

whereas

$$
\boxed{
q=q'\Longrightarrow q\le e-2.
}
\tag{21}
$$

Thus the gap valuation either equals the smaller endpoint valuation or exceeds their common valuation by at least two. The hard-exit congruences exclude the otherwise possible equal-valuation transition `e=q+1`.

## 5. Separation of the zero-gap case

The hypothesis `d>0` is essential.

If

$$
d=0,
$$

then `y=n`, so

$$
q'=q,
\qquad
m'=m.
$$

There is no finite gap valuation `e=v_2(d)` to classify. In the L10 first-contraction setting, the near-cycle equation

$$
C=Dn+2^\tau d
$$

reduces to

$$
\boxed{C=Dn,}\tag{22}
$$

and

$$
T^\tau(n)=n.
$$

This is an exact positive periodic orbit. For a hypothetical least counterexample `n_*>1`, it is the nontrivial-cycle branch. L12 supplies no additional obstruction in this case; it must be handled by an independent cycle exclusion or a certificate that also covers `d=0`.

## 6. Consequence at the first L8 Farey frontier

Suppose a hypothetical least counterexample contracts for the first time at

$$
J=114\,208\,327\,604.
$$

Then the corresponding odd count is

$$
s=72\,057\,431\,991.
$$

Since `s<2^71<n_*`, L11 applies. It proves that both

$$
n_*
\qquad\text{and}\qquad
y=T^J(n_*)=n_*+d
$$

are hard-exit states, and L10 gives

$$
0\le d\le
\left\lfloor\frac{s-1}{3}\right\rfloor
=24\,019\,143\,996.
\tag{23}
$$

Assume `d>0`. Since

$$
24\,019\,143\,996<2^{35},
$$

we have

$$
\boxed{e=v_2(d)\le34.}\tag{24}
$$

Consequently:

- if $q\ne q'$, then
  $$
  \boxed{\min(q,q')=e\le34;}
  \tag{25}
  $$
- if `q=q'`, then (11) and (24) give
  $$
  \boxed{q=q'\le32.}
  \tag{26}
  $$

Thus, for every positive-gap survivor at the first Farey frontier, at least one of the two hard-exit valuations is at most `34`; if the valuations agree, both are at most `32`. Equations (9) and (14) additionally fix the odd part of the gap modulo four in every unequal-valuation case.

This is a finite exact split by the gap valuation and the smaller endpoint
valuation, stronger than L11's conclusion `4 | d`.  In unequal-valuation
cases the larger of `q,q'` remains unbounded, so this is not a finite full
valuation-state space and does not make the remaining parity-word search
finite.

## 7. Why this does not repair L11's renewal gap

L12 relates the hard-exit valuation of the least counterexample to the hard-exit valuation of its first near-return endpoint. It does **not** prove that the full L9-L11 state can be restarted at that endpoint.

Let

$$
y=T^\tau(n_*)=n_*+d
$$

and define the coefficient stopping time local to `y` by

$$
\tau_y=
\min\{k\ge1:3^{q_k(y)}<2^k\},
$$

when this set is nonempty.

To apply L9 anew at `y`, one must still prove

$$
\tau_y<\infty.
$$

To apply L10 with another nonnegative near-return defect, one additionally needs

$$
T^{\tau_y}(y)\ge y.
$$

Least-counterexample minimality gives only

$$
T^k(y)\ge n_*
\qquad(k\ge0),
$$

not `T^k(y)>=y`. If the local first coefficient contraction lands below `y` but remains at least `n_*`, it merely decreases the excess above the global minimum. That may be useful as a ranked recursive edge, but it is not a contradiction and is not another L10 near-return state.

Likewise, even a second non-descending near-return need not remain close enough to `n_*` for the L11 hard-exit inheritance proof to apply again. A sufficient band-retention condition for a later endpoint `z` is

$$
3(z-n_*)+1<n_*.
$$

No theorem in L8-L12 currently supplies local coefficient-stopping finiteness, non-descent relative to each restarted state, band retention, or a well-founded rank covering all alternatives.

Therefore L12 is an exact congruence refinement, not the missing recursive closure theorem.

## 8. Proposed use and first falsification test

For the positive-gap branch at the first Farey frontier, a symbolic certificate search may now split by the finite gap-valuation range

$$
2\le e\le34
$$

while retaining an unbounded symbolic parameter for the larger endpoint
valuation in the unequal cases.

and impose:

1. L9's deadline/displacement constraints on the first-contraction word;
2. L10's exact equation `C=Dn+2^Jd` and bound on `d`;
3. the L6 hard residue at `n`;
4. the L6 hard residue at `n+d`;
5. the transition alternatives (8)-(15).

The first falsification test is to enumerate manageable smaller first-contraction scales exactly and determine whether the hard-gap transition eliminates survivor words or merely relabels a large persistent family. A negative result should be recorded before attempting a huge fixed-depth search at `J`.

## 9. Lean targets

Formalize:

1. equivalence between the L6 hard condition and `m = h(q) mod 4`;
2. the difference identity (16);
3. valuation cases `q'<q`, `q'=q`, and `q'>q`;
4. formulas (9) and (14);
5. exclusion of `e=q+1` in the equal case;
6. separation of `d=0` from the finite-valuation theorem;
7. the finite bounds (24)-(26) as a concrete regression theorem under the named L10/L11 frontier hypotheses.
