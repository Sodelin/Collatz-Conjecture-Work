# Lean formalization targets

The project does **not** currently include a Lean proof. This file records a suggested formalization order so that a future Lean effort has a bounded target rather than trying to formalize the entire Collatz project at once.

## Target 1: accelerated odd map and valuations

Formalize the odd-to-odd map

\[
S(n)=\frac{3n+1}{2^{\nu_2(3n+1)}}
\]

for positive odd integers, together with the exact valuation facts needed to iterate a prescribed finite valuation word.

## Target 2: affine valuation-word iterate

For a word \(a=(a_0,\ldots,a_{m-1})\), total \(A=\sum a_i\), formalize

\[
S^m(x)=\frac{3^m x+C(a)}{2^A}
\]

on the residue class realizing the word.

## Target 3: rational periodic point

Under \(3^m>2^A\), define the associated rational periodic point and prove it realizes the valuation word exactly.

## Target 4: positive integer lift

This is the highest-priority fragile lemma. Prove that for every repetition depth \(r\) and adequate 2-adic reserve, a positive odd integer can be chosen whose accelerated trajectory realizes exactly \(r\) copies of the word, including the final valuation endpoint.

## Target 5: same-phase scaling

Prove exact return scaling around the rational periodic point:

\[
n_{i+(k+1)m}-c_i
=
\lambda\,(n_{i+km}-c_i),
\qquad
\lambda=3^m/2^A.
\]

Extract the corresponding logarithmic asymptotic used by Round 6A.

## Target 6: last-minimum β-debt theorem

Formalize `Theorem_6A1_Public_Review_Note.md`, especially:

1. the last-global-minimum suffix property;
2. the floor inequality;
3. \(\log_2N_r=rA+k_r\log_2\lambda+O(1)\);
4. the rearrangement yielding
   \[
   \liminf k_r/r\ge(m-\beta A)/(m+\beta\log_2\lambda);
   \]
5. the same-phase correction-debt lower bound.

## Target 7: explicit `w_m` limit

For \(w_m=(2,1^{m-1})\), prove symbolically that the normalized necessary debt coefficient tends to

\[
\rho_\beta=\frac{1-\beta}{1+\beta\log_2(3/2)}.
\]

## Verification policy

Passing Python tests is not a substitute for the Lean proof. The Python checker is retained only as an executable diagnostic record and for finding indexing/valuation mistakes during formalization.
