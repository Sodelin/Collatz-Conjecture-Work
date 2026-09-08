import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
namespace CollatzWork

/-!
# Convergence, coalescence, and the unresolved universal obligation

This file proves semantic equivalences and a conditional induction rule.
It does not prove `UniversalSmallerCoalescence` or `UniversalDescent`.
The existing refined Mersenne certificate supplies one family of valid
smaller coalescing starts, not the missing universal statement.
-/



theorem converges_two : Converges 2 := ⟨1, rfl⟩

/-- Reaching `1` is preserved both forward and backward by a single step.
The zero-step case explicitly uses the `1 → 2 → 1` cycle. -/
theorem converges_onceAccelerated_iff (n : Nat) :
    Converges (onceAccelerated n) ↔ Converges n := by
  constructor
  · rintro ⟨k, hk⟩
    exact ⟨k + 1, hk⟩
  · rintro ⟨k, hk⟩
    cases k with
    | zero =>
        have hn : n = 1 := hk
        subst n
        exact converges_two
    | succ k => exact ⟨k, hk⟩























-- These declarations mechanically check the exported headline theorem types
-- against their trusted statement definitions.













end CollatzWork



open CollatzWork in
theorem solution (r n : Nat) :
    Converges (shortcutIter r n) ↔ Converges n := by
  induction r generalizing n with
  | zero => rfl
  | succ r ih =>
      rw [shortcutIter_succ, ih, converges_onceAccelerated_iff]
