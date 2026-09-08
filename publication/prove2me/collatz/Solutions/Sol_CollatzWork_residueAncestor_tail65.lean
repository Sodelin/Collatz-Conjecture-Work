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
    0 < 432 * a + 344 ∧
    (432 * a + 344) % 27 = 20 ∧
    shortcutIter 4 (432 * a + 344) = 81 * a + 65 ∧
    3 * (432 * a + 344) + 8 = 16 * (81 * a + 65) ∧
    432 * a + 344 ≤ 64 * (81 * a + 65) := by
  refine ⟨by omega, by omega, ?_, by omega, by omega⟩
  have h0 : onceAccelerated (432 * a + 344) = 216 * a + 172 := by
    rw [show 432 * a + 344 = 2 * (216 * a + 172) by omega,
      onceAccelerated_two_mul]
  have h1 : onceAccelerated (216 * a + 172) = 108 * a + 86 := by
    rw [show 216 * a + 172 = 2 * (108 * a + 86) by omega,
      onceAccelerated_two_mul]
  have h2 : onceAccelerated (108 * a + 86) = 54 * a + 43 := by
    rw [show 108 * a + 86 = 2 * (54 * a + 43) by omega,
      onceAccelerated_two_mul]
  have h3 : onceAccelerated (54 * a + 43) = 81 * a + 65 := by
    rw [show 54 * a + 43 = 2 * (27 * a + 21) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  simp only [shortcutIter, h0, h1, h2, h3]
