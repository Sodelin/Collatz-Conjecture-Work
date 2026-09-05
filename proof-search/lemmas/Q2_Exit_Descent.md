---
node_id: AC-Q2-EXIT-DESCENT-2026-09-05
node_type: lemma
routes: [B, AB]
tags: [collatz, immutable-root, burst-exit, exact-descent, infinite-family]
---

# A guarded escape at every OOE depth congruent to two modulo three

**Proved result.** A new family of positive residue20 roots, all outside the
currently selected inverse-ancestor guards, has an explicitly smaller later return. For k≥1 its first return grows. The initial shadow depth
`q(r)=v2(r+5)` can be any value `3k+2`, including arbitrarily large k. The
exit uses three consecutive odd steps followed by a guarded even run:

\[
\boxed{(OOE)^k\;OOO\;E^e.}
\]

This addresses the q2 exit class left outside the earlier q0 burst family.
It is a sufficient guarded escape mechanism, not a proof that every q2
root meets the exit guard. It does not prove universal termination or
claim external novelty.

## 1. General exact orbit theorem

Use the positive shortcut Collatz map

\[
T(n)=\begin{cases}n/2&n\text{ even},\\(3n+1)/2&n\text{ odd}.\end{cases}
\]

Let integers `k>=0`, `u>=1`, and `e>=max(2,k+1)` satisfy

\[
\boxed{2^{e+1}\mid27\cdot9^k u-29.}\tag{EXIT2}
\]

Define

\[
r=4\cdot8^k u-5,
\qquad m=\frac{27\cdot9^k u-29}{2^{e+1}}.
\]

Then

\[
\boxed{0<m<r,\qquad T^{3k+3+e}(r)=m,\qquad v_2(r+5)=3k+2.}\tag{1}
\]

All inequalities refer to the unchanged original root r.

### Branch and exit proof

Because `e>=2`, reducing EXIT2 modulo8 gives `3u=5 mod8`, hence

\[
u\equiv7\pmod8,\quad u\ge7.
\]

For each `0<=j<=k`, the state after j OOE blocks is

\[
r_j=4\cdot8^{k-j}9^j u-5.
\]

For j<k this has form `8A−5`, and its three exact steps are

\[
8A-5\xrightarrow{O}12A-7\xrightarrow{O}18A-10\xrightarrow{E}9A-5.
\]

Thus after exactly k consecutive OOE blocks the state is

\[
x=4\cdot9^k u-5.
\]

The initial and exit shadow depths are `3k+2` and2, respectively. Since
`9^k u=7 mod8`,

\[
v_2(x+1)=v_2(4(9^k u-1))=3.
\]

Consequently x has exactly three consecutive odd steps. Their endpoint is

\[
y=T^3(x)=27\frac{x+1}{8}-1
=\frac{27\cdot9^k u-29}{2}.
\]

EXIT2 makes y divisible by `2^e`, so e actual even steps reach m. This proves
the complete guarded parity word and the exact iterate count in (1).

### Descent proof for k>=1

First use the weaker amount of halving `e_0=k+1`. Let

\[
m_0=\frac{27\cdot9^k u-29}{2^{k+2}}.
\]

EXIT2 makes m0 integral and `m<=m0`. A direct subtraction gives

\[
2^{k+2}(r-m_0)=A_k u-20\cdot2^k+29,
\quad A_k=16^{k+1}-27\cdot9^k.
\]

Here `A_1=13` and

\[
A_{k+1}=16A_k+189\cdot9^k,
\]

so induction gives `A_k>=13*2^(k−1)`. Since u≥7,

\[
2^{k+2}(r-m_0)
\ge(91-40)2^{k-1}+29
=51\cdot2^{k-1}+29>0.
\]

Thus `m<=m0<r`. Positivity follows directly from the numerator and the
exact integer quotient.

For k0, use e≥2 instead. Then

\[
m\le\frac{27u-29}{8},\qquad
r-\frac{27u-29}{8}=\frac{5u-11}{8}>0
\]

because u≥7. This covers the boundary case without applying the k≥1
coefficient estimate outside its domain.

## 2. An explicit residue20 family at each q2 depth

For any integers `k,t>=0`, choose

\[
e=e_k=2+18\left\lfloor\frac{k+16}{18}\right\rfloor.
\]

Then `e=2 mod18`, `e>=max(2,k+1)`, and for k≥1 the extra padding
`e−(k+1)` lies between0 and17. Let

\[
M=2^{e+1},
\quad a=29(27\cdot9^k)^{-1}\bmod M,
\quad b=25(4\cdot8^k)^{-1}\bmod729,
\]

with canonical nonnegative residues, and define

\[
d=(b-a)M^{-1}\bmod729,
\qquad
\boxed{u=a+Md+729Mt.}\tag{2}
\]

All inverses exist because they are between powers of2 and3. This explicit
Chinese remainder formula yields

\[
27\cdot9^k u\equiv29\pmod M,
\qquad4\cdot8^k u\equiv25\pmod{729}.
\]

In particular u7mod8 and u≥7. The general theorem applies, and

\[
r\equiv20\pmod{729}.
\]

For the target, `2^e=4 mod27`. The exact equation

\[
2^{e+1}m=27\cdot9^k u-29\equiv-2\pmod{27}
\]

therefore gives

\[
\boxed{m\equiv20\pmod{27}.}\tag{3}
\]

Every k supplies an infinite arithmetic progression of roots through t.
Varying k makes q=3k+2 and the certified trajectory length unbounded. Roots
from distinct k have different exact q values, so these parameterized
depths do not coincide. The assertion is conditional on (2), not a claim
that every root with q2mod3 is covered.

## 3. Entirely new coverage relative to the current selected families

Writing `r=20+729a` gives

\[
r+7=27(1+27a),
\qquad4r+1=81(1+36a).
\]

Hence every root in the constructed family satisfies

\[
\boxed{v_3(r+7)=3,\quad v_3(4r+1)=4.}
\]

It is normal for the older internal rule c, whose guard requires
`v3(r+7)>=5`. Moreover, the refined ancestor selector's unit class is

\[
\theta=2^{4-2}\frac{4r+1}{3^4}\bmod9=4.
\]

All refined theta4 subcases require valuation at least6; this family's
valuation is exactly4. Thus **every** root here falls outside every current
refined-ancestor guard. This is exact disjointness from that selected
certificate, not a claim of irreducibility under every possible method.

The earlier guarded q0 burst family's initial depth is divisible by3.
The present depth is2mod3, so these source families are also disjoint.
No convergence assumption is used to establish either comparison.

## 4. Growing first return, then certified escape

When k≥1, the first four parities are OOEO and the residues are

\[
20\to17\to26\to13\to20\pmod{27}.
\]

Thus the first positive-time residue20 return is at time4, with

\[
y_1=T^4(r)=\frac{27r+23}{16}>r.
\]

Because `y_1+7=27(r+5)/16` and `3∤(r+5)`, this return is also c-normal:
`v3(y_1+7)=3`. The first growing return is not removed by that normalizer.
The descent theorem instead continues to the original-root comparison at
time `3k+3+e`, which is at least8.

The smallest positive burst length gives a modest concrete example:

\[
k=1,\quad e=2,\quad u=3623,
\]

\[
\boxed{r=115,931,
\quad T^4(r)=195,635>r,
\quad T^8(r)=110,045<r.}
\]

All three displayed values lie in residue20 modulo27. The complete word is
`OOE OOO EE`.

The k0 boundary has first return at time5 rather than4 and already descends.
The first CRT example is `r=19,703`, `T^5(r)=16,625`. It is included for a
complete q2 depth statement, not as the main unbounded-burst contribution.

## 5. Missing bridge and next target

This theorem supplies a new guarded escape after the q2 OOE exit. It does
not establish that EXIT2 holds for arbitrary q2 roots. It specifically uses
u7mod8 to make the next odd run exactly3, then requires enough even
valuation at that run's endpoint. Other unit residues, longer odd runs,
short even exits, and subsequent recharge remain unproved.

Thus a hypothetical least nonconvergent root must avoid this new family as
well as the prior ones. There is no proof that the accumulated exclusions
exhaust the residue20 class. Root425 has q1mod3 and is outside this theorem;
its finite orbit is not used as a surrogate for a universal argument.

The next mathematical target is control of the complementary exit residues
or a recharge mechanism that gives a strict comparison with the same root.
A polynomial rank on the current q coordinate is not assumed.

## 6. Verification and formal scope

`q2_exit_descent_check.py` independently replays every indicated parity and
the actual shortcut trajectory. It verifies514 CRT instances,279 instances
of the general theorem with other allowed e values, large depths through
k1023, exact disjointness from the prior guards, and first-return growth.
A missing-EXIT2 control is rejected before any integer division can mask a
failed parity condition. Checks remain active under `python -O -B`.

The universal result follows from the exact path, induction inequality,
and explicit CRT arithmetic. The finite tests are regression evidence.
This packet has no Lean certificate yet; a formalization must distinguish
the general guarded descent from the target-set CRT specialization.

**11. Process assessment.** Both valuation exit conditions, the full parity
word, the strict original-root inequality, and the finite congruence guards
were checked separately. The k0 case was proved separately instead of
extending the k≥1 bound without justification.

**12. Robustness assessment.** The proof covers unbounded k and units under
its explicit guards. Its sources are rigorously outside the old selected
families. The surviving complement and absence of universal recharge
control prevent any closure inference.


## Connections

- **Depends on:** [the OOE identity and prior guarded descent](Root_Relative_Burst_Descent.md).
- **Parallel to:** [two-burst recharge escape](Two_Burst_Recharge_Escape.md) and [second-coordinate ancestors](Complementary_Ancestor_Cylinders.md).
- **Verified by:** [manifest](../../verification/README.md) and [independent checker](../../verification/q2_exit_descent_check.py).
- **Formalized by / pending:** [formal scope](../../LEAN_TARGETS.md); this q2 theorem remains a prose proof.
