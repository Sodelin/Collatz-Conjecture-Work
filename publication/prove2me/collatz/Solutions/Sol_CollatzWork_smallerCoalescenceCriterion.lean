import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Theorems.Thm_CollatzWork_allPositiveConverge_of_smallerCoalescence
namespace CollatzWork

/-!
# Convergence, coalescence, and the unresolved universal obligation

This file proves semantic equivalences and a conditional induction rule.
It does not prove `UniversalSmallerCoalescence` or `UniversalDescent`.
The existing refined Mersenne certificate supplies one family of valid
smaller coalescing starts, not the missing universal statement.
-/













/-- Convergence itself supplies the common endpoint `1` and smaller start
`1`, showing that the universal coalescence obligation is Collatz-equivalent. -/
theorem smallerCoalescence_of_allPositiveConverge
    (h : AllPositiveConverge) : UniversalSmallerCoalescence := by
  intro n hn
  obtain ⟨k, hk⟩ := h n (by omega)
  exact ⟨1, by omega, hn, k, 0, hk⟩















-- These declarations mechanically check the exported headline theorem types
-- against their trusted statement definitions.













end CollatzWork



open CollatzWork in
theorem solution : SmallerCoalescenceCriterionStatement :=
  ⟨smallerCoalescence_of_allPositiveConverge,
    allPositiveConverge_of_smallerCoalescence⟩
