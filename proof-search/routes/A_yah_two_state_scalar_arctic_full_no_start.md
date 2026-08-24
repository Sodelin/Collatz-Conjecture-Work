# Route A obstruction — no first scalar-arctic dimension-one step

**Status:** exact coefficient-independent full certificate plus exact
Farkas/RUP top certificates

**Scope:** the original eleven-rule Yolcu--Aaronson--Heule (YAH) system and
one fixed two-state semantic labeling, in the standard dimension-one
arctic-natural coefficientwise interpretation class. This is a proof-method
obstruction, not a termination or Collatz theorem.

## Exact result

Let `T` be the eleven-rule mixed-base Collatz string-rewriting system of YAH.
Let `T_2` be the 22-rule system obtained by labeling both suffix states with
the exact two-state algebra in
[`A_yah_two_state_semantic_label_no_go.md`](A_yah_two_state_semantic_label_no_go.md).

No nonempty first rule-removal step exists in either of these scalar
arctic-natural classes:

1. **Full/extended:** all rules are weakly oriented and at least one rule is
   strictly oriented, in either `T` or `T_2`.
2. **YAH top opportunities:** a nonempty subset of the three original boundary
   rules, or a nonempty subset of the two reversed dynamic rules, is strictly
   oriented while all rules are weakly oriented. The certificate checks all
   six labeled boundary targets and all four labeled reversed-dynamic targets.

Testing one strict target at a time is complete: an interpretation strict on a
nonempty subset is strict on at least one member of that subset.

For the original unlabelled system, item 2 is exactly the pair of special
relative-top entry points supplied by YAH Lemma 3.18. For the labeled system,
the ten cases are a syntactic interpretation no-go; no separate claim that
semantic labeling reflects top termination is needed here.

## Full/extended all-positive cancellations

The arctic-natural carrier is

\[
\mathbb A_{\mathbb N}=\mathbb N\cup\{-\infty\},\qquad
a\oplus b=\max(a,b),\qquad a\otimes b=a+b.
\]

In the standard extended class used by YAH, a dimension-one token has

\[
[s](x)=m_s+x,\qquad m_s\in\mathbb N,
\]

and its constant is `-infinity`. A word coefficient is therefore the ordinary
sum of its symbol coefficients. If `Delta_i` is the left-minus-right symbol
sum for rule `i`, weak orientation gives `Delta_i >= 0`.

For the original eleven rules in their published order, the strictly positive
multipliers are

```text
D_f=4, D_t=7, X_f0=5, X_f1=6, X_f2=9,
X_t0=3, X_t1=4, X_t2=4, X_^0=3, X_^1=2, X_^2=2.
```

They have total mass 49 and satisfy

\[
\sum_i \lambda_i\Delta_i=0
\]

in every unlabelled symbol coordinate. Hence every weak delta is zero and no
original rule can be strict.

The previously published labeled certificate has a positive multiplier on
each of the 22 instances, also of total mass 49, and cancels all 14 labeled
token coordinates. Its state-pair sums are exactly the eleven multipliers
above. Thus both full results cover the unbounded coefficient domain; neither
is a finite coefficient search.

## Exact top certificate

In the weakly monotone scalar class, a labeled token is

\[
[s](x)=\max(m_s+x,v_s),\qquad
m_s,v_s\in\mathbb N\cup\{-\infty\},
\]

with at least one of `m_s,v_s` finite. Word composition produces a slope and
the maximum of finitely many prefix-plus-intercept terms.

The dependency-free checker reconstructs the eleven rules and all original
and reversed labeled instances. For each of the ten targets it expands:

- finite versus `-infinity` support;
- the exact word slope and every possible intercept-max term;
- coefficientwise weak comparison for every rule; and
- coefficientwise arctic strict comparison for the target, including the
  convention `-infinity` \(\gg\) `-infinity`.

Natural strictness is first encoded exactly as an integer gap of at least one.
Each resulting branch is then relaxed from nonnegative natural coefficients
to nonnegative real coefficients. This only enlarges that branch, so
unsatisfiability of the relaxation implies unsatisfiability over arctic
naturals; it does not claim to exclude a separate arctic-real method with a
strict gap between zero and one. Every infeasible branch is certified by a
positive-integer Farkas combination. The remaining Boolean contradiction is
certified by reverse unit propagation (RUP).

The retained payload contains:

- 10 target cases;
- 491 integer Farkas lemmas;
- 426 RUP clauses; and
- total positive Farkas multiplier mass 10,183.

The certificate SHA-256 is
`ac7c6a43600d95ebdf4353b3b10e66b24267295a506ab6ea8793ca086c0c0d2a`.
The exact rule-instance fingerprint is
`7b0dad87f3d82606686251f72e4aaf5acd8f3f4fe97d615a8f40b5d320f57d9d`.

Z3 was used to discover the Farkas and RUP payload. The published replay does
not trust Z3 or any third-party package: it reconstructs the constraints and
checks every integer identity and every RUP step using the Python standard
library.

## Why this applies to the original system

Suppose the original unlabelled YAH system had one of the forbidden scalar
interpretations. Give both state-labeled versions of each symbol the same
coefficients. Every labeled word then has exactly the same interpretation as
its unlabelled word, so every original weak comparison lifts to both labeled
instances, and any strict target lifts as well. This would contradict the
labeled certificate. Therefore a separate unlabelled top payload is not
logically necessary.

## Reproduction

From the repository root:

```powershell
python -S -B verification\yah_two_state_scalar_arctic_full_no_start.py
python -S -B verification\yah_scalar_arctic_top\verify_top_certificates.py
```

The first checker prints both
`ORIGINAL_FULL_EXTENDED_SCALAR_ARCTIC_NO_START = PASS` and
`FULL_EXTENDED_SCALAR_ARCTIC_NO_START = PASS`. The second prints ten case
passes, the certificate totals, and
`TOP_SCALAR_ARCTIC_NO_FIRST_STEP = PASS`.

## Impact and strict scope guard

The earlier bounded scalar searches are superseded for this exact first-step
dimension-one class. A standard scalar arctic-natural interpretation cannot
start YAH rule removal, even through either Lemma-3.18 top shortcut. A later
scalar step after another method has removed or transformed rules is not
excluded.

The theorem does **not** exclude:

- dimension two or higher;
- arctic integers, ordinary natural, tropical, mixed, or other carriers;
- a different semantic algebra or label set;
- dependency-pair or other transformations beyond the two YAH top shortcuts;
- non-coefficientwise, automaton, polynomial, or other orders;
- a proof restricted to a separately proved closed reachable relation; or
- termination of the YAH system or the Collatz conjecture.

The interpretation conditions and full/top distinction are from YAH,
Sections 2.2--2.3 and Lemma 3.18:
<https://doi.org/10.1007/s10817-022-09658-8>. The foundational arctic method is
due to Koprowski and Waldmann:
<https://doi.org/10.1007/978-3-540-70590-1_14>.

YAH explicitly identifies nonexistence of suitable matrix interpretations for
its mixed-base system as useful future work. A bounded primary-source search
found no exact match for this dimension-one no-first-step theorem. That is not
a novelty or priority certification; external term-rewriting review remains
required.

## Connections

- **Depends on:** [YAH source semantics](../../methodology/YAH_REWRITE_SOURCE_INTEGRATION_2026-08-23.md).
- **Adds a separate carrier-specific obstruction alongside:** [fixed two-state additive cancellations](A_yah_two_state_semantic_label_no_go.md).
- **Verified by:** [reproduction manifest](../../verification/README.md).
- **Formalization pending:** [Lean targets](../../LEAN_TARGETS.md).
- **Updates:** [Route A](../APPROACH_REGISTRY.md) and the [atomic claim registry](../CLAIM_REGISTRY.md).
