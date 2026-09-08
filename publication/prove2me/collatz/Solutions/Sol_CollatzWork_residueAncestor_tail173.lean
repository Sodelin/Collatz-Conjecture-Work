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
    0 < 864 * a + 614 ∧
    (864 * a + 614) % 27 = 20 ∧
    shortcutIter 5 (864 * a + 614) = 243 * a + 173 ∧
    9 * (864 * a + 614) + 10 = 32 * (243 * a + 173) ∧
    864 * a + 614 ≤ 64 * (243 * a + 173) := by
  refine ⟨by omega, by omega, ?_, by omega, by omega⟩
  have h0 : onceAccelerated (864 * a + 614) = 432 * a + 307 := by
    rw [show 864 * a + 614 = 2 * (432 * a + 307) by omega,
      onceAccelerated_two_mul]
  have h1 : onceAccelerated (432 * a + 307) = 648 * a + 461 := by
    rw [show 432 * a + 307 = 2 * (216 * a + 153) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  have h2 : onceAccelerated (648 * a + 461) = 972 * a + 692 := by
    rw [show 648 * a + 461 = 2 * (324 * a + 230) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  have h3 : onceAccelerated (972 * a + 692) = 486 * a + 346 := by
    rw [show 972 * a + 692 = 2 * (486 * a + 346) by omega,
      onceAccelerated_two_mul]
  have h4 : onceAccelerated (486 * a + 346) = 243 * a + 173 := by
    rw [show 486 * a + 346 = 2 * (243 * a + 173) by omega,
      onceAccelerated_two_mul]
  simp only [shortcutIter, h0, h1, h2, h3, h4]
