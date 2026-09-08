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
    0 < 6912 * a + 2612 ∧
    (6912 * a + 2612) % 27 = 20 ∧
    shortcutIter 8 (6912 * a + 2612) = 243 * a + 92 ∧
    9 * (6912 * a + 2612) + 44 = 256 * (243 * a + 92) ∧
    6912 * a + 2612 ≤ 64 * (243 * a + 92) := by
  refine ⟨by omega, by omega, ?_, by omega, by omega⟩
  have h0 : onceAccelerated (6912 * a + 2612) = 3456 * a + 1306 := by
    rw [show 6912 * a + 2612 = 2 * (3456 * a + 1306) by omega,
      onceAccelerated_two_mul]
  have h1 : onceAccelerated (3456 * a + 1306) = 1728 * a + 653 := by
    rw [show 3456 * a + 1306 = 2 * (1728 * a + 653) by omega,
      onceAccelerated_two_mul]
  have h2 : onceAccelerated (1728 * a + 653) = 2592 * a + 980 := by
    rw [show 1728 * a + 653 = 2 * (864 * a + 326) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  have h3 : onceAccelerated (2592 * a + 980) = 1296 * a + 490 := by
    rw [show 2592 * a + 980 = 2 * (1296 * a + 490) by omega,
      onceAccelerated_two_mul]
  have h4 : onceAccelerated (1296 * a + 490) = 648 * a + 245 := by
    rw [show 1296 * a + 490 = 2 * (648 * a + 245) by omega,
      onceAccelerated_two_mul]
  have h5 : onceAccelerated (648 * a + 245) = 972 * a + 368 := by
    rw [show 648 * a + 245 = 2 * (324 * a + 122) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  have h6 : onceAccelerated (972 * a + 368) = 486 * a + 184 := by
    rw [show 972 * a + 368 = 2 * (486 * a + 184) by omega,
      onceAccelerated_two_mul]
  have h7 : onceAccelerated (486 * a + 184) = 243 * a + 92 := by
    rw [show 486 * a + 184 = 2 * (243 * a + 92) by omega,
      onceAccelerated_two_mul]
  simp only [shortcutIter, h0, h1, h2, h3, h4, h5, h6, h7]
