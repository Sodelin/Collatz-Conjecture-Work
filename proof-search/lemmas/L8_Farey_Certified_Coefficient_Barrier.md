# L8 — Farey-certified coefficient barrier: 114,208,327,604 accelerated steps

**Cycle:** Round 7, 2026-08-23  
**Status:** `PROVED_AUX` conditional on two cited external results; exact arithmetic certificate committed; Lean pending  
**Novelty:** exact corollary not priority-certified; no novelty claim  
**Usefulness:** major strengthening of Route D's least-counterexample prefix constraint  
**Collatz relevance:** necessary condition only, not a resolution

## 1. External inputs

We use the accelerated map

\[
T(n)=\begin{cases}
(3n+1)/2,&n\text{ odd},\\
n/2,&n\text{ even}.
\end{cases}
\]

### A. Verified base range

Barina (2025), *Improved verification limit for the convergence of the Collatz conjecture*, reports convergence verification through

\[
B=2^{71}.
\]

Hence a least nonconvergent positive integer, if one exists, satisfies

\[
\boxed{n_*>B.}\tag{1}
\]

### B. Rozier–Terracol harmonic-mean obstruction

Rozier–Terracol (2026), *Paradoxical behavior in Collatz sequences*, Corollary 4.4, gives the following necessary condition for a paradoxical length-`j` prefix.

Let `h` be the harmonic mean of the odd terms among the first `j` iterates and define

\[
\alpha=\frac{\log 2}{\log 3},
\qquad
q_j=\lfloor \alpha j\rfloor.
\]

Then

\[
\boxed{
h\le H(j):=
\frac{1}{2^{j/q_j}-3}
}\tag{2}
\]

whenever the expression applies (`j>=2` and the prefix is paradoxical).

## 2. Why every coefficient contraction of a least counterexample is paradoxical

If `n_*` is the least nonconvergent positive integer, every iterate satisfies

\[
T^i(n_*)\ge n_*.
\tag{3}
\]

Thus if a prefix has `q` odd terms and

\[
\frac{3^q}{2^j}<1,
\]

it is paradoxical: its multiplicative coefficient predicts contraction while its actual endpoint is still at least the start.

Moreover, every odd term in that prefix is at least `n_*`, so its harmonic mean satisfies

\[
\boxed{h\ge n_*>B.}\tag{4}
\]

Combining (2) and (4), any coefficient-contracting prefix of `n_*` must satisfy

\[
\boxed{H(j)>B.}\tag{5}
\]

## 3. Convert the analytic condition to a rational-approximation interval

Set

\[
\beta_B=
\frac{\log 2}{\log(3+B^{-1})}.
\tag{6}
\]

Because `q_j=\lfloor\alpha j\rfloor`, we always have

\[
\frac{q_j}{j}<\alpha.
\]

Now

\[
H(j)>B
\]

is equivalent to

\[
2^{j/q_j}<3+B^{-1},
\]

which is equivalent to

\[
\frac{j}{q_j}<\log_2(3+B^{-1}),
\]

and therefore

\[
\boxed{
\beta_B<\frac{q_j}{j}<\alpha.
}\tag{7}
\]

So the first possible paradoxical prefix of a least counterexample is controlled by a purely Diophantine question:

> What is the smallest denominator of a rational number strictly between `beta_B` and `alpha`?

## 4. Exact Farey certificate

Define the rational numbers

\[
L=\frac{6\,586\,818\,670}{10\,439\,860\,591},
\]

\[
M=\frac{72\,057\,431\,991}{114\,208\,327\,604},
\]

and

\[
R=\frac{65\,470\,613\,321}{103\,768\,467\,013}.
\]

The committed exact checker proves, using rational interval bounds for logarithms rather than floating-point comparisons,

\[
\boxed{L<\beta_B<M<\alpha<R.}\tag{8}
\]

It also verifies

\[
65\,470\,613\,321\cdot10\,439\,860\,591
-
6\,586\,818\,670\cdot103\,768\,467\,013
=1.
\tag{9}
\]

Thus `L` and `R` are Farey neighbors.

A standard Farey/Stern–Brocot fact says that every rational strictly between Farey neighbors `a/b<c/d` has denominator at least `b+d`, and the unique rational attaining that minimum is their mediant

\[
\frac{a+c}{b+d}.
\]

Here

\[
M=\frac{L_{\rm num}+R_{\rm num}}{L_{\rm den}+R_{\rm den}},
\]

so the smallest denominator of **any** rational in `(L,R)`, hence of any rational in `(beta_B,alpha)`, is exactly

\[
\boxed{J=114\,208\,327\,604.}\tag{10}
\]

The exact interval checker additionally certifies

\[
\frac{72\,057\,431\,991}{J}<\alpha<
\frac{72\,057\,431\,992}{J},
\]

so

\[
\lfloor\alpha J\rfloor=72\,057\,431\,991.
\]

Therefore the mediant is actually the relevant `q_J/J`, and `H(J)>B`.

## 5. Main consequence

For every

\[
2\le j<J,
\]

there is no rational with denominator `j` satisfying (7). Hence

\[
H(j)\le B.
\]

But any coefficient-contracting prefix of a least counterexample would require `H(j)>B` by (5).

Therefore:

\[
\boxed{
3^{q_j(n_*)}\ge2^j
\quad\text{for every }1\le j<114\,208\,327\,604.
}\tag{11}
\]

Equivalently, if the coefficient stopping time

\[
\tau(n_*)=
\min\{j\ge1:3^{q_j(n_*)}<2^j\}
\]

is finite, then

\[
\boxed{
\tau(n_*)\ge114\,208\,327\,604.
}\tag{12}
\]

This supersedes L7's `301,994` lower bound by more than five orders of magnitude.

## 6. Why the certificate is rigorous rather than a floating-point coincidence

`verification/round7_farey_coefficient_barrier.py` constructs exact rational intervals for

\[
\log 2,\quad\log 3,\quad\log(3+2^{-71})
\]

using the positive atanh series

\[
\log x=2\sum_{k=0}^{\infty}
\frac{z^{2k+1}}{2k+1},
\qquad
z=\frac{x-1}{x+1},
\]

with an explicit geometric upper bound on the omitted positive tail.

All comparisons in (8) are then comparisons of Python `Fraction` objects. The decimal approximations printed by the script are diagnostics only and are not used to establish the inequalities.

The only non-computational number-theory ingredient in the certificate is the elementary Farey-neighbor denominator theorem.

## 7. Interaction with existing Round-7 structure

A hypothetical least counterexample must now simultaneously satisfy:

1. `n_*>2^71` (Barina base range);
2. L6's exact hard exit from its initial `-1`/Mersenne shadow;
3. a multiplicatively noncontracting accelerated parity prefix for more than `1.142*10^11` steps;
4. all exact mixed-radix compatibility conditions needed for one fixed positive integer to realize that prefix.

This does not make the remaining space finite by itself. It does, however, push the next search away from shallow residue enumeration and toward **symbolic characterization of indefinitely near-critical compatible codes**.

## 8. The next theorem-sized bridge

The most promising synthesis target is now:

> Prove that an arbitrarily long prefix satisfying the noncontraction condition in (11), while also remaining compatible with one fixed positive integer and avoiding all smaller-orbit coalescence certificates, forces a positive 2-adic or 3-adic incompatibility rate.

Kramer's 2026 exponent-code framework supplies a language for this compatibility question: finite odd-to-odd exponent codes determine real drift, a 2-adic start representative, and a 3-adic endpoint representative, while codes generated by a fixed positive integer must satisfy vanishing residue-rate conditions asymptotically.

That proposed bridge is **not proved**. It is now a precise Route-D/AB target rather than a conclusion.

## 9. Sources

- David Barina, *The Journal of Supercomputing* 81, 810 (2025), DOI `10.1007/s11227-025-07337-0`.
- Olivier Rozier and Claude Terracol, *Discrete Mathematics* 349, 115167 (2026), DOI `10.1016/j.disc.2026.115167`, especially Corollary 4.4.
- Oliver Kramer, arXiv:2607.10041 (2026), used only to motivate the next compatibility target, not as an input to the proof above.

## 10. Lean targets

Formalization can be cleanly split:

1. minimal-counterexample harmonic-mean lower bound;
2. import/hypothesis wrapper for Rozier–Terracol Corollary 4.4;
3. algebraic equivalence `H(j)>B <-> beta_B < floor(alpha*j)/j`;
4. a rational log-interval checker or independently proved logarithm bounds;
5. Farey-neighbor lemma;
6. concrete rational certificate `(L,M,R)`;
7. final coefficient-stopping-time theorem.

The external Barina and Rozier–Terracol results should remain explicit hypotheses until independently formalized or imported.
