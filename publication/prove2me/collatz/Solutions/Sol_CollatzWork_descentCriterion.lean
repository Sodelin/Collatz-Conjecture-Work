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

















theorem smallerCoalescence_of_descent (h : UniversalDescent) :
    UniversalSmallerCoalescence := by
  intro n hn
  obtain ⟨k, _, hpos, hlt⟩ := h n hn
  exact ⟨shortcutIter k n, hpos, hlt, k, 0, rfl⟩

theorem descent_of_allPositiveConverge (h : AllPositiveConverge) :
    UniversalDescent := by
  intro n hn
  obtain ⟨k, hk⟩ := h n (by omega)
  have hkpos : 0 < k := by
    cases k with
    | zero =>
        have hone : n = 1 := hk
        omega
    | succ k => omega
  exact ⟨k, hkpos, by rw [hk]; omega, by rw [hk]; exact hn⟩









-- These declarations mechanically check the exported headline theorem types
-- against their trusted statement definitions.













end CollatzWork



open CollatzWork in
theorem solution : DescentCriterionStatement := by
  constructor
  · exact descent_of_allPositiveConverge
  · intro h
    exact allPositiveConverge_of_smallerCoalescence
      (smallerCoalescence_of_descent h)
