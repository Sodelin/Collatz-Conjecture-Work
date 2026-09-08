import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
namespace CollatzWork

/-!
# Refined Mersenne child identity

This file formalizes one isolated arithmetic certificate for the one-division
shortcut map `onceAccelerated`.  It does not assert termination or route
closure.
-/





theorem shortcutIter_add (r s n : Nat) :
    shortcutIter (r + s) n = shortcutIter s (shortcutIter r n) := by
  induction r generalizing n with
  | zero => simp
  | succ r ih =>
      simp [Nat.succ_add, ih]






































end CollatzWork



open CollatzWork in
theorem solution (root k l A B D E : Nat) (hD : 0 < D)
    (hprefix : D * (shortcutIter k root + 3) ≤ A * (root + 3))
    (hterminal : E * shortcutIter l (shortcutIter k root) <
      B * (shortcutIter k root + 3)) :
    (D * E) * shortcutIter (k + l) root < (A * B) * (root + 3) := by
  rw [shortcutIter_add]
  calc
    (D * E) * shortcutIter l (shortcutIter k root) =
        D * (E * shortcutIter l (shortcutIter k root)) := by ac_rfl
    _ < D * (B * (shortcutIter k root + 3)) :=
      Nat.mul_lt_mul_of_pos_left hterminal hD
    _ = B * (D * (shortcutIter k root + 3)) := by ac_rfl
    _ ≤ B * (A * (root + 3)) := Nat.mul_le_mul_left B hprefix
    _ = (A * B) * (root + 3) := by ac_rfl
