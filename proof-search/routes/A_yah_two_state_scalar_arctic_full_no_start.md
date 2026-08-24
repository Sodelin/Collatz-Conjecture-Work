# Route A obstruction — no first full scalar-arctic step

**Status:** coefficient-independent exact certificate

**Scope:** dimension-one full/extended arctic-natural interpretations for one
fixed two-state semantic labeling; not a top-termination or Collatz theorem

## Exact statement

Let `T_2` be the 22-rule system obtained by semantically labeling both suffix
states of the eleven-rule mixed-base Collatz system of Yolcu, Aaronson, and
Heule (YAH) with the algebra in
[`A_yah_two_state_semantic_label_no_go.md`](A_yah_two_state_semantic_label_no_go.md).

There is no nonempty subset `Q` of `T_2` for which a dimension-one
arctic-natural interpretation in the standard **extended monotone**,
coefficientwise class weakly orients every rule of `T_2` and strictly orients
every rule of `Q`.  Equivalently, this class cannot make the first full
relative rule-removal step on the exact global labeled system.  The statement
is unchanged after reversal.

## Why dimension one collapses to symbol sums

The arctic-natural carrier is

\[
\mathbb A_{\mathbb N}=\mathbb N\cup\{-\infty\},
\qquad a\oplus b=\max(a,b),\qquad a\otimes b=a+b.
\]

In the extended-monotone version used by YAH, every constant coefficient is
`-infinity`.  In dimension one a labeled token `s` therefore has the form

\[
[s](x)=m_s+x,\qquad m_s\in\mathbb N.
\]

For a labeled word `w`, its finite arctic matrix coefficient is the ordinary
sum of the token coefficients in `w`.  If the labeled rule instance `i` has
sides `l_i -> r_i`, put

\[
\Delta_i=
\sum_{s\in l_i}m_s-
\sum_{s\in r_i}m_s.
\]

Coefficientwise weak orientation gives `Delta_i >= 0`.  Strict orientation in
this extended scalar class requires `Delta_i > 0`; the constant coefficients
are `-infinity` on both sides and already satisfy the arctic auxiliary strict
comparison convention.

## All-positive cancellation

The following multiplier is strictly positive on every one of the 22 labeled
rule instances:

| Instance | Mult. | Instance | Mult. |
|---|---:|---|---:|
| `D_f[0]` | 3 | `D_f[1]` | 1 |
| `D_t[0]` | 6 | `D_t[1]` | 1 |
| `X_f0[0]` | 1 | `X_f0[1]` | 4 |
| `X_f1[0]` | 5 | `X_f1[1]` | 1 |
| `X_f2[0]` | 7 | `X_f2[1]` | 2 |
| `X_t0[0]` | 2 | `X_t0[1]` | 1 |
| `X_t1[0]` | 3 | `X_t1[1]` | 1 |
| `X_t2[0]` | 3 | `X_t2[1]` | 1 |
| `X_^0[0]` | 2 | `X_^0[1]` | 1 |
| `X_^1[0]` | 1 | `X_^1[1]` | 1 |
| `X_^2[0]` | 1 | `X_^2[1]` | 1 |

Its total mass is 49.  Direct labeled-symbol counting gives the exact identity

\[
\sum_i\lambda_i\Delta_i=0
\]

in every one of the 14 token coordinates.  Because every `lambda_i` is
positive and every weak delta is nonnegative, every `Delta_i` is zero.  No
labeled rule can be strict, so no nonempty first removal set exists.  Reversal
does not change labeled-symbol counts in dimension one.

This is an algebraic certificate over the entire unbounded coefficient domain,
not a finite coefficient search.

## Reproduction

From the repository root:

```powershell
python -B verification\yah_two_state_scalar_arctic_full_no_start.py
```

Expected output ends with:

```text
certificate rows = 22
all multipliers positive = PASS
total multiplier = 49
weighted token-count delta = {}
FULL_EXTENDED_SCALAR_ARCTIC_NO_START = PASS
```

The checker uses only the Python standard library.  It reconstructs the eleven
unlabeled rules, verifies their two semantic equations, reconstructs all 22
labeled instances, and checks the cancellation with exact integer arithmetic.

## Impact on the proof search

- The earlier bounded scalar-arctic searches are superseded for this full
  dimension-one class.
- A full/extended scalar arctic-natural proof cannot be the first step, even if
  it tries to remove an auxiliary labeled rule rather than a dynamic one.
- This does not prevent a later scalar step after some different method has
  removed rules.
- The ten weakly-monotone **top** first-step cases (six original boundary and
  four reversed dynamic instances) have no retained solver-independent
  max-dominance certificate.  They are deliberately not part of this theorem
  or the repository claim.

The remaining high-value Route-A frontier is therefore higher-dimensional
natural/arctic interpretations, a different semantic algebra, richer or
transformed orders, and local/reachable-only termination.

## Strict scope guard

The theorem does **not** exclude:

- weakly-monotone/top arctic interpretations;
- dimension two or higher;
- arctic integers, natural, tropical, mixed, matrix, or nonadditive methods;
- a different label algebra or larger label state;
- dependency-pair or other transformations;
- a proof restricted to a closed reachable relation; or
- termination of the YAH system or the Collatz conjecture.

The coefficientwise conditions and extended/top distinction are exactly those
in YAH, Sections 2.2--2.3:
<https://doi.org/10.1007/s10817-022-09658-8>.
The foundational arctic method is due to Koprowski and Waldmann:
<https://doi.org/10.1007/978-3-540-70590-1_14>.

YAH explicitly identifies nonexistence of suitable matrix interpretations for
its mixed-base Collatz system as an interesting result in its own right.  No
exact published match for this fixed-label, dimension-one all-positive
cancellation was found in the bounded primary-source audit.  That is not a
priority or novelty certification.
