# Route A no-go — one exact two-state semantic labeling

**Status:** exact finite obstruction for two named additive interpretation
classes
**Scope:** not a termination theorem and not a Collatz result

Use the eleven-rule mixed binary/ternary string-rewriting system of Yolcu,
Aaronson, and Heule (YAH), on canonical strings

\[
{}^\wedge w\$,\qquad w\in\{f,t,0,1,2\}^*.
\]

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
`1` ends in `t_0 $_0`.  Thus the cancellation does not use unreachable local
contexts.

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
is part of either cancellation.

## Consequence for scalar and finite lex-additive orders

Let every row difference be `Delta = weight(lhs)-weight(rhs)` in a linearly
ordered abelian group.  Weak orientation gives `Delta>=0`; a dynamic row must
give `Delta>0`.  A positive-integer combination of such differences cannot
equal zero when it contains a dynamic row with positive multiplier.  The two
cancellations therefore exclude respectively:

1. scalar potentials additive over labeled symbols; and
2. scalar potentials additive over adjacent labeled edges.

The same identities exclude every finite lexicographic tuple of potentials
of the corresponding additive kind.  In the first component, every supported
row difference is nonnegative and their positive combination is zero, so
every supported row has first component zero.  Repeating this argument
component by component forces each supported dynamic difference to be the
zero tuple, contradicting strict lexicographic orientation.  This argument
does not require a separate boundedness assumption.

## Reproduction

From the repository root:

```powershell
python verification/yah_two_state_semantic_label_no_go.py
```

Expected output ends with:

```text
symbol certificate rows = 8; dynamic mass = 5
symbol weighted delta = {}
edge certificate rows = 50; dynamic mass = 144057
edge weighted delta = {}
PASS
```

## Strict scope guard

This is a no-go theorem for this **specific two-state algebra and suffix
labeling**, with potentials additive either over labeled symbols or over
adjacent labeled edges.  It does not exclude:

- a different finite algebra or label set;
- labels carrying more boundary, phase, or history information;
- windows of length three or greater;
- matrix, polynomial, automata-composed, or other nonadditive orders;
- a different strategy or relative-termination argument;
- termination of the YAH system; or
- the Collatz conjecture.

The YAH system and its Collatz simulation theorem are from Yolcu, Aaronson,
and Heule, *An Automated Approach to the Collatz Conjecture*, Journal of
Automated Reasoning 67 (2023), Theorem 3:
<https://doi.org/10.1007/s10817-022-09658-8>.  The exact rules are in the
authors' source repository:
<https://github.com/emreyolcu/rewriting-collatz/blob/main/rules/collatz-T.srs>.

The two cancellation certificates are project-specific finite artifacts.  No
claim of literature novelty is made.
