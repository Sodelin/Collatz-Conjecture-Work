# Route A no-go — canonical adjacent-edge additive potentials

**Status:** exact finite obstruction for one named interpretation class;
Lean certificate replay available
**Scope:** not a termination or Collatz result

Formal audit and reproducibility boundary:
[`A_yah_finite_obstruction_formal_audit.md`](A_yah_finite_obstruction_formal_audit.md).

Use the exact 11-rule mixed binary/ternary system of
Yolcu--Aaronson--Heule (YAH), with canonical syntactic words `^w$`,
`w in {f,t,0,1,2}*`.  Its dynamic rules implement the one-division shortcut
map

\[
T(n)=n/2\quad(n\text{ even}),
\qquad
T(n)=(3n+1)/2\quad(n\text{ odd}),
\]

and its nine auxiliary rules preserve the represented value.

## Named potential class

Assign a real weight `W_ab` to every adjacent pair permitted in a canonical
word and define

\[
\mu(s)=\sum_{ab\text{ adjacent in }s}W_{ab}. \tag{1}
\]

There are 36 variables if the empty word `^$` is allowed: 25 internal digit
pairs, five left-boundary pairs, five right-boundary pairs, and `W_^$`.
There are 35 if the empty word is excluded; the certificate below is
unchanged.

Suppose `mu` is bounded below on the canonical language, every legal
canonical-context auxiliary instance weakly decreases it, and every legal
canonical-context dynamic instance strictly decreases it.  No such `mu`
exists.  The finite contradiction actually uses only the twelve displayed
auxiliary instances and the displayed `t$ -> 2$` instance; it never invokes
the other dynamic rule.

## Integer cancellation certificate

For each row, take `mu(lhs)-mu(rhs)`.  Row 1 is strict; rows 2--13 are weak.
Use multiplicity two only on row 9.

| # | Mult. | Exact canonical one-step instance | Source rule |
|---:|---:|---|---|
| 1 | 1 | `^2t$ -> ^22$` | `t$ -> 2$` |
| 2 | 1 | `^1f12$ -> ^10t2$` | `f1 -> 0t` |
| 3 | 1 | `^2f10$ -> ^20t0$` | `f1 -> 0t` |
| 4 | 1 | `^f22$ -> ^1f2$` | `f2 -> 1f` |
| 5 | 1 | `^1f22$ -> ^11f2$` | `f2 -> 1f` |
| 6 | 1 | `^1t02$ -> ^11t2$` | `t0 -> 1t` |
| 7 | 1 | `^2t02$ -> ^21t2$` | `t0 -> 1t` |
| 8 | 1 | `^2t11$ -> ^22f1$` | `t1 -> 2f` |
| 9 | 2 | `^0t22$ -> ^02t2$` | `t2 -> 2t` |
| 10 | 1 | `^1t2$ -> ^12t$` | `t2 -> 2t` |
| 11 | 1 | `^2t20$ -> ^22t0$` | `t2 -> 2t` |
| 12 | 1 | `^2t21$ -> ^22t1$` | `t2 -> 2t` |
| 13 | 1 | `^11$ -> ^ff1$` | `^1 -> ^ff` |

The signed adjacent-edge counts cancel exactly to

\[
-W_{ff}. \tag{2}
\]

If the strict gap in row 1 is `delta>0`, summing the thirteen required
inequalities gives

\[
-W_{ff}\ge\delta>0,
\qquad W_{ff}<0. \tag{3}
\]

But for every integer `m >= 1`, the word `^f^m$` is syntactically canonical and

\[
\mu({}^\wedge f^m\$)
=W_{{}^\wedge f}+(m-1)W_{ff}+W_{f\$}, \tag{4}
\]

which tends to minus infinity.  This contradicts boundedness below.

After rescaling a hypothetical real solution by its positive row-1 gap, we
may normalize that gap to one; then (3) reads `W_ff<=-1`.  The exact replay
checks that every row has exactly one named redex, that row 1
represents `11 -> 17 = T(11)`, that rows 2--13 preserve value, and that the
integer edge-count sum is exactly (2).

## Reproduction

```powershell
python -B verification/yah_2local_edge_no_go.py
C:\Users\Owner\.elan\bin\lake.exe env lean lean/CollatzWork/YAHFiniteObstruction.lean
```

The Python replay must end in `PASS`.  The Lean module checks the exact rule
table, legality and arithmetic of all thirteen rows, the cancellation to
`-W_ff`, the forced sign `W_ff<0`, and the bounded-below contradiction under
an explicit Archimedean/cofinal hypothesis.  Its public axiom report contains
only Lean's standard `propext` and `Quot.sound`, and no `sorryAx`.

## Scope guard

This theorem concerns **all syntactically legal canonical-context
instances**.  No separate claim about reachability from a narrower selected
encoding is needed or made.  It excludes only bounded-below scalar potentials
additive over adjacent pairs.  It does not exclude reachable-state-only
orders on some narrower language, longer-window or automaton-state labels,
natural/arctic matrix interpretations, nonadditive orders, local relative
termination by another mechanism, or termination of the YAH system itself.

## Source and prior-art status

The system and its simulation theorem are from Yolcu, Aaronson, and Heule,
*An Automated Approach to the Collatz Conjecture*, Journal of Automated
Reasoning 67 (2023), Theorem 3.17:
<https://doi.org/10.1007/s10817-022-09658-8>.  The exact rules are in the
official source file, pinned here at upstream commit
`8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340`:
<https://github.com/emreyolcu/rewriting-collatz/blob/8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340/rules/collatz-T.srs>.
That file has SHA-256
`e4777832e5cf8148a54299dffa48cf10254629680961006f2c15bcb6c55aa9d2`.

The 13-row cancellation is a project-specific finite certificate.  No exact
published match was located in the bounded audit, but this is not a
certified novelty claim and is not being submitted as a standalone theorem.
