# Route A no-go — one exact two-state semantic labeling

**Status:** exact finite obstruction for two named additive interpretation
classes; Lean certificate replay available
**Scope:** not a termination theorem and not a Collatz result

Formal audit and reproducibility boundary:
[`A_yah_finite_obstruction_formal_audit.md`](A_yah_finite_obstruction_formal_audit.md).

Use the eleven-rule mixed binary/ternary string-rewriting system of Yolcu,
Aaronson, and Heule (YAH), on canonical strings

$$
{}^\wedge w\$,\qquad w\in\{f,t,0,1,2\}^*.
$$

Its dynamic rules are

```text
f$ -> $
t$ -> 2$
```

and its auxiliary rules are

```text
f0 -> 0f    f1 -> 0t    f2 -> 1f
t0 -> 1t    t1 -> 2f    t2 -> 2t
^0 -> ^t    ^1 -> ^ff   ^2 -> ^ft
```

## Exact algebra and label convention

Let `A={0,1}`.  Interpret each symbol as a unary map on `A`:

| Symbols | Map |
|---|---|
| `f`, `0`, `^`, `$` | constant `0` |
| `t`, `2` | constant `1` |
| `1` | identity |

Direct substitution verifies both sides of all eleven rules at both argument
values, giving 22 exact equations.

Fix the value of the empty suffix to be `0`.  Label an occurrence of a symbol
`s` by `s_a`, where `a` is the algebra value of the suffix strictly to its
right.  In particular, the terminal marker is `$_0`.  This right-to-left
labeling is deterministic.  The verifier reconstructs every legal immediate
context; there are 441 fixed-terminal labeled rewrite instances and 66 legal
adjacent labeled edges, 50 of them interior.  It also constructs an explicit
canonical extension of every checked local row: a left marker can be added
immediately, while a suffix of value `0` ends in `$_0` and a suffix of value
`1` ends in `t_0 $_0`.  Thus every selected row is syntactically embeddable
in a fixed-terminal canonical labeled word.  This is not a claim that the row
is reached by a positive-length derivation from a narrower input encoding.

## Symbol-additive cancellation

Assign a weight to every labeled symbol and sum the weights along a labeled
word.  The following positive-integer combination uses exact labeled rule
instances:

| Mult. | Instance |
|---:|---|
| 2 | `f_0 $_0 -> $_0` |
| 3 | `t_0 $_0 -> 2_0 $_0` |
| 1 | `f_0 0_1 -> 0_0 f_1` |
| 1 | `f_0 1_0 -> 0_1 t_0` |
| 2 | `f_1 2_0 -> 1_0 f_0` |
| 1 | `^_0 0_0 -> ^_1 t_0` |
| 1 | `^_0 1_0 -> ^_0 f_0 f_0` |
| 1 | `^_1 2_0 -> ^_0 f_1 t_0` |

The signed labeled-symbol counts cancel exactly to zero.  The first two rows
are dynamic, with total positive multiplier five; the other six are
auxiliary.

## Adjacent-edge-additive cancellation

Now assign a weight to each legal adjacent pair of labeled symbols and sum
those weights along the word.  There is an exact 50-row positive-integer
cancellation among legal one-symbol-context instances:

- 3 dynamic rows, with multipliers `57168`, `47250`, and `39639`;
- 47 auxiliary rows;
- total dynamic multiplier `144057`;
- total signed adjacent-edge count exactly zero.

The complete integer row table is embedded in the verifier.  It reconstructs
each row from the original rule, suffix state, and immediate context, rejects
any illegal boundary or label, and then checks the cancellation using only
integer `Counter` arithmetic.  No boundedness or graph-potential inequality
is part of either cancellation.  The 50 rows have positive support on exactly
all 20 labeled rule instances realizable in a fixed-terminal canonical word;
the two absent instances are the impossible dynamic tail-`1` cases.

## Consequence for scalar and finite lex-additive orders

Let every row difference be `Delta = weight(lhs)-weight(rhs)` in a linearly
ordered abelian group.  Weak orientation gives `Delta>=0`; a dynamic row must
give `Delta>0`.  A positive-integer combination of such differences cannot
equal zero when it contains a dynamic row with positive multiplier.  The two
cancellations therefore exclude respectively:

1. scalar potentials additive over labeled symbols; and
2. scalar potentials additive over adjacent labeled edges.

There is a stronger first-removal consequence for the adjacent-edge class.
Assume all 441 legal fixed-terminal contexts are weak.  If any one of the 20
realizable labeled rules were uniformly strict in all its canonical contexts,
then at least one of its positively supported certificate rows would be
strict.  The positive weighted sum could not be zero.  Hence an
adjacent-edge-additive proof cannot make even its first uniform rule-removal
step on this fixed-terminal canonical relation.  This is a contextual-potential
obstruction; an arbitrary adjacent-window potential is not automatically a
compositional interpretation satisfying YAH Theorem 2.15.

The same identities exclude every finite lexicographic tuple of potentials
of the corresponding additive kind.  In the first component, every supported
row difference is nonnegative and their positive combination is zero, so
every supported row has first component zero.  Repeating this argument
component by component forces each supported dynamic difference to be the
zero tuple, contradicting strict lexicographic orientation.  This argument
does not require a separate boundedness assumption.

## Full scalar-arctic strengthening

An additional all-positive cancellation supports every one of the 22 global
labeled instances.  In the dimension-one extended arctic-natural class, it
proves that no labeled rule can be removed at the first full relative step.
See
[`A_yah_two_state_scalar_arctic_full_no_start.md`](A_yah_two_state_scalar_arctic_full_no_start.md).

## Reproduction

From the repository root:

```powershell
python -B verification/yah_two_state_semantic_label_no_go.py
C:\Users\Owner\.elan\bin\lake.exe env lean lean/CollatzWork/YAHFiniteObstruction.lean
```

Expected output ends with:

```text
symbol certificate rows = 8; dynamic mass = 5
symbol weighted delta = {}
edge certificate rows = 50; dynamic mass = 144057
edge supported labeled instances = 20
edge weighted delta = {}
PASS
```

The Lean module independently fixes the rule table and algebra, verifies all
22 algebra equations, checks legality and canonical embeddability of every
selected row, and checks both integer cancellations.  It then derives the
generic no-orientation theorems in a compatible ordered additive group.  Its
public axiom report contains only Lean's standard `propext` and `Quot.sound`,
and no `sorryAx`.  The explicit instantiation to every finite lexicographic
tuple is currently a paper corollary of the generic theorem rather than a
separately named Lean construction.

## Strict scope guard

This is a no-go theorem for this **specific two-state algebra and suffix
labeling**, with potentials additive either over labeled symbols or over
adjacent labeled edges.  The first-removal corollary forces at least one
supported context per labeled rule to have zero delta; it does not assert that
all 441 contextual deltas vanish.  It does not exclude:

- a different finite algebra or label set;
- labels carrying more boundary, phase, or history information;
- an order restricted to a smaller derivation-reachable state language;
- windows of length three or greater;
- matrix, polynomial, automata-composed, or other nonadditive orders;
- a different strategy or relative-termination argument;
- termination of the YAH system; or
- the Collatz conjecture.

The YAH system and its Collatz simulation theorem are from Yolcu, Aaronson,
and Heule, *An Automated Approach to the Collatz Conjecture*, Journal of
Automated Reasoning 67 (2023), Theorem 3.17:
<https://doi.org/10.1007/s10817-022-09658-8>.  The exact rules are in the
authors' source repository, pinned here at upstream commit
`8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340`:
<https://github.com/emreyolcu/rewriting-collatz/blob/8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340/rules/collatz-T.srs>.
That file has SHA-256
`e4777832e5cf8148a54299dffa48cf10254629680961006f2c15bcb6c55aa9d2`.

The two cancellation certificates are project-specific finite artifacts.  No
claim of literature novelty is made.

## Connections

- **Depends on:** [YAH source semantics](../../methodology/YAH_REWRITE_SOURCE_INTEGRATION_2026-08-23.md).
- **Parallel to:** [unlabeled adjacent-edge cancellation](A_yah_2local_edge_potential_no_go.md).
- **Complemented in a separate scalar-arctic slice by:** [dimension-one no-start theorem](A_yah_two_state_scalar_arctic_full_no_start.md).
- **Verified by:** [reproduction manifest](../../verification/README.md).
- **Formalization pending:** [Lean targets](../../LEAN_TARGETS.md).
