import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Theorems.Thm_CollatzWork_converges_iff_of_coalesces
namespace CollatzWork

/-!
# Convergence, coalescence, and the unresolved universal obligation

This file proves semantic equivalences and a conditional induction rule.
It does not prove `UniversalSmallerCoalescence` or `UniversalDescent`.
The existing refined Mersenne certificate supplies one family of valid
smaller coalescing starts, not the missing universal statement.
-/

theorem converges_one : Converges 1 := ⟨0, rfl⟩



























-- These declarations mechanically check the exported headline theorem types
-- against their trusted statement definitions.













end CollatzWork



open CollatzWork in
theorem solution
    (h : UniversalSmallerCoalescence) : AllPositiveConverge := by
  intro n
  induction n using Nat.strongRecOn with
  | ind n ih =>
      intro hn
      by_cases hone : n = 1
      · subst n
        exact converges_one
      · have hgt : 1 < n := by omega
        obtain ⟨m, hm, hmn, r, s, hcoal⟩ := h n hgt
        exact (converges_iff_of_coalesces hcoal).mpr (ih m hmn hm)
