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







theorem onceAccelerated_two_mul_sub_one (b : Nat) (hb : 0 < b) :
    onceAccelerated (2 * b - 1) = 3 * b - 1 := by
  rw [onceAccelerated]
  have hodd : (2 * b - 1) % 2 ≠ 0 := by omega
  simp [hodd]
  omega




































end CollatzWork



open CollatzWork in
theorem solution (h q : Nat) (hq : 0 < q) :
    shortcutIter h (2 ^ h * q - 1) = 3 ^ h * q - 1 := by
  induction h generalizing q with
  | zero => simp
  | succ h ih =>
      rw [show 2 ^ (h + 1) * q = 2 * (2 ^ h * q) by
        simp [Nat.pow_succ, Nat.mul_comm, Nat.mul_left_comm]]
      rw [shortcutIter_succ]
      rw [onceAccelerated_two_mul_sub_one]
      · rw [show 3 * (2 ^ h * q) = 2 ^ h * (3 * q) by
          simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]]
        rw [ih (3 * q) (by omega)]
        rw [show 3 ^ h * (3 * q) = 3 ^ (h + 1) * q by
          simp [Nat.pow_succ, Nat.mul_assoc, Nat.mul_comm]]
      · exact Nat.mul_pos (Nat.pow_pos (by omega)) hq
