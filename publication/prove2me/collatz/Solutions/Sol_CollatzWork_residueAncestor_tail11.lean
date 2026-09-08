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
    0 < 1728 * a + 74 ∧
    (1728 * a + 74) % 27 = 20 ∧
    shortcutIter 6 (1728 * a + 74) = 243 * a + 11 ∧
    9 * (1728 * a + 74) + 38 = 64 * (243 * a + 11) ∧
    1728 * a + 74 ≤ 64 * (243 * a + 11) := by
  refine ⟨by omega, by omega, ?_, by omega, by omega⟩
  have h0 : onceAccelerated (1728 * a + 74) = 864 * a + 37 := by
    rw [show 1728 * a + 74 = 2 * (864 * a + 37) by omega,
      onceAccelerated_two_mul]
  have h1 : onceAccelerated (864 * a + 37) = 1296 * a + 56 := by
    rw [show 864 * a + 37 = 2 * (432 * a + 18) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  have h2 : onceAccelerated (1296 * a + 56) = 648 * a + 28 := by
    rw [show 1296 * a + 56 = 2 * (648 * a + 28) by omega,
      onceAccelerated_two_mul]
  have h3 : onceAccelerated (648 * a + 28) = 324 * a + 14 := by
    rw [show 648 * a + 28 = 2 * (324 * a + 14) by omega,
      onceAccelerated_two_mul]
  have h4 : onceAccelerated (324 * a + 14) = 162 * a + 7 := by
    rw [show 324 * a + 14 = 2 * (162 * a + 7) by omega,
      onceAccelerated_two_mul]
  have h5 : onceAccelerated (162 * a + 7) = 243 * a + 11 := by
    rw [show 162 * a + 7 = 2 * (81 * a + 3) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  simp only [shortcutIter, h0, h1, h2, h3, h4, h5]
