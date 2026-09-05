# Bounded natural-matrix first-removal attack

Status: no Collatz closure obtained. Z3 returned UNSAT for the finite
coefficient range 0 through 2; the larger range 0 through 8 timed out.
No claim is made about arbitrary coefficients or higher dimensions.

Primary source: [Yolcu, Aaronson, and Heule, arXiv:2105.14697v3](https://arxiv.org/abs/2105.14697v3),
especially Section 2.3.1 (page 9), the eleven rules (page 19), and
Example 4.3 and the rule-removal discussion (pages 28--29).

## Exact search target

For each of the seven symbols `f,t,0,1,2,^,$`, choose a 2 by 2 matrix
`A_s` and length-two vector `b_s`, with natural entries in `0..B`, such
that `A_s[0,0] >= 1`. Interpret a string by composing the corresponding
affine functions from left to right, with the leftmost symbol outermost.

For all eleven rules `l -> r`, require the composed matrix and vector
for `l` to be componentwise greater than or equal to those for `r`.
Require the first component of the composed constant vector to be
strictly larger for at least one rule.

These requirements make the interpretation monotone in arbitrary
contexts and give relative termination of a nonempty set of rules.
The paper proves termination of every subsystem formed by deleting one
rule, so a valid witness here would provide the missing first removal.
The search found no such witness.

## Encoding and validation

There are 42 bounded coefficient variables. The bitvector encoding
zero-extends them before multiplication. Every rule word has length at
most three. For an entry bound `B`, every composed matrix entry is at most
`4 B^3`, and every composed constant is at most `4 B^3 + 2 B^2 + B`.
The chosen arithmetic widths accommodate those bounds exactly, so the
SMT inequalities represent natural arithmetic without modular overflow.

The independent checker uses ordinary Python integer multiplication of
3 by 3 homogeneous matrices. The SMT builder instead composes 2 by 2
affine functions from right to left. Both reproduce the primary-source
Example 4.3: all ten retained rules strictly decrease, while the omitted
`f1 -> 0t` rule fails weak orientation.

## Recorded results

| Coefficient range | Arithmetic width | Maximum composed entry | Result | Solver time |
|---|---:|---:|---|---:|
| 0 through 8 | 12 bits | 2184 | UNKNOWN: timeout | 60.021 s |
| 0 through 2 | 6 bits | 42 | UNSAT | 0.488 s |

Solver: z3-solver 5.1.0.0. Exact timings and positive-control details are
in `result.json`; complete SMT instances are retained. The UNSAT result
is a solver report, not an independently checked proof certificate.
The larger-bound timeout provides no evidence of nonexistence at that
bound. The finite smaller-bound exclusion supplies no general no-go.

To reproduce, install `z3-solver==5.1.0.0` in a suitable Python environment,
then run `python -B verification/yah_natural_matrix_2d/search_natural_matrices.py`
from the repository root. Do not use `-O`. The search overwrites its local
SMT instances and result file; preserve the recorded evidence when comparing
a new run. Timings and timeout outcomes may vary by machine.

No further search was performed after the decisive finite outcome.

## Connections

- **Tests:** [Route A](../../proof-search/APPROACH_REGISTRY.md).
- **Recorded in:** [research pass](../../ASTRA_RESEARCH_PASS_2026-09-05.md).
- **Compared with:** [certified scalar-arctic obstruction](../../proof-search/routes/A_yah_two_state_scalar_arctic_full_no_start.md).

This experiment used the first-pass source state at remote commit
`699509d61873c1c81a810096a4e045709b302813`. Its standalone rules and
positive control come from the named primary source, not an altered subsystem.
