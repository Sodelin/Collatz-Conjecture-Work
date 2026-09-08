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











theorem onceAccelerated_two_mul_add_one (b : Nat) :
    onceAccelerated (2 * b + 1) = 3 * b + 2 := by
  rw [onceAccelerated]
  simp
  omega
































end CollatzWork



open CollatzWork in
theorem solution (a : Nat) :
    0 < 216 * a + 101 ∧
    (216 * a + 101) % 27 = 20 ∧
    shortcutIter 3 (216 * a + 101) = 81 * a + 38 ∧
    3 * (216 * a + 101) + 1 = 8 * (81 * a + 38) ∧
    216 * a + 101 ≤ 64 * (81 * a + 38) := by
  refine ⟨by omega, by omega, ?_, by omega, by omega⟩
  have h0 : onceAccelerated (216 * a + 101) = 324 * a + 152 := by
    rw [show 216 * a + 101 = 2 * (108 * a + 50) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  have h1 : onceAccelerated (324 * a + 152) = 162 * a + 76 := by
    rw [show 324 * a + 152 = 2 * (162 * a + 76) by omega,
      onceAccelerated_two_mul]
  have h2 : onceAccelerated (162 * a + 76) = 81 * a + 38 := by
    rw [show 162 * a + 76 = 2 * (81 * a + 38) by omega,
      onceAccelerated_two_mul]
  simp only [shortcutIter, h0, h1, h2]
