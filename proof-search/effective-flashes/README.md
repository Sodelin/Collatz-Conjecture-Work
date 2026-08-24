# Effective-flash review notes

This directory preserves conservative mathematical transcriptions of selected
GitHub issue proposals. These notes are review aids, not accepted project
claims. They add no row to the
[`CLAIM_REGISTRY.md`](../CLAIM_REGISTRY.md), do not change the route statuses
in the [`APPROACH_REGISTRY.md`](../APPROACH_REGISTRY.md), and cannot override
either registry.

Throughout these notes,

\[
U(n)=\frac{3n+1}{2^{\nu_2(3n+1)}}
\]

denotes the fully accelerated map on positive odd integers. This convention
must not be confused with a one-division shortcut map.

| Packet | Upstream discussion | Durable status |
|---|---|---|
| [Reciprocal summability](issue-7-reciprocal-summability.md) | [Issue #7](https://github.com/Sodelin/Collatz-Conjecture-Work/issues/7) | Exact internal algebra; external interval-count input and provenance remain blocked. |
| [Global block-schedule rigidity](issue-9-global-carry-rigidity.md) | [Issue #9](https://github.com/Sodelin/Collatz-Conjecture-Work/issues/9) | Exact recurrence and a nonrealizable schedule; proposed carry corollary remains provisional. |
| [Phase and reciprocal summability](issue-10-phase-summability.md) | [Issue #10](https://github.com/Sodelin/Collatz-Conjecture-Work/issues/10) | Exact equivalence and conditional equidistribution, with the fixed point `1` as false control. |
| [Finite adelic phase freedom](issue-11-finite-adelic-phase.md) | [Issue #11](https://github.com/Sodelin/Collatz-Conjecture-Work/issues/11) | Exact finite-word realization with prescribed endpoint phase; no fixed-orbit bridge. |

None of these packets is Lean-formalized or otherwise proof-assistant
formalized. None is publication-ready, establishes novelty or priority, proves
Collatz, or produces a positive counterexample. Promotion would require the
handoff packet and review gates in [`CONTINUATION.md`](../../CONTINUATION.md),
including source verification where an external theorem is used.
