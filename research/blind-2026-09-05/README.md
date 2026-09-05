# Independent-phase record

**Node ID:** `BLIND-INDEPENDENT-2026-09-05`

**Node type:** `archive`

These files preserve the independent attempt before repository consultation.
Its verdict was partial results, with no complete Collatz proof and no novelty
assessment. The later [repository reconciliation](../../BLIND_RECONCILIATION_2026-09-05.md)
identifies rediscoveries and records the subsequent mathematical extension.

- [Decision brief and full phase report](BlindAttempt.md).
- [Exact words, repetition, and analytic complexity arguments](SymbolicNotes.md).
- [Inverse certificates and the rejected CRT proof attempt](InverseNotes.md).
- [Ordinary-map descent equivalence](Descent.lean).
- [Explicit growing family](AlternatingGrowth.lean).
- [Generic repetition arithmetic](RepetitionBound.lean).

The three Lean files compile independently with Lean4.33.1 and `Std`.
They are preserved here for provenance; the active proof tree reuses existing
repository definitions and does not claim those repeated identities as new.
The checker's maintained form is
[blind_word_recurrence_check.py](../../verification/blind_word_recurrence_check.py),
with checks that stay active under optimized Python.

## Connections

- **Superseded by:** [repository-informed comparison](../../BLIND_RECONCILIATION_2026-09-05.md) for current relevance and scope.
- **Verified by:** [verification record](../../verification/Blind_Recurrence_Verification_2026-09-05.md).
