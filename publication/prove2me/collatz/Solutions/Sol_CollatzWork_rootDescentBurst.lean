import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Definitions.Def_CollatzWork_RootDescentStatement
import Theorems.Thm_CollatzWork_shortcutIter_OOE
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
namespace CollatzWork

/-!
# Root-relative forward descent after an unbounded OOE burst

The proof uses the actual one-division Collatz map throughout. The divisibility
guard is explicit and is not a universal coverage claim. In particular, the
theorem does not prove the Collatz conjecture.
-/



theorem shortcutIter_OOE_shifted (w : Nat) (hw : 0 < w) :
    shortcutIter 3 (8 * w - 5) = 9 * w - 5 := by
  have hinput : 8 * w - 5 = 8 * (w - 1) + 3 := by omega
  rw [hinput, shortcutIter_OOE]
  omega



























end CollatzWork



open CollatzWork in
theorem solution : RootDescentBurstStatement := by
  intro k
  induction k with
  | zero => intro u hu; simp [shortcutIter]
  | succ k ih =>
      intro u hu
      have hw : 0 < 8 ^ k * u := Nat.mul_pos (Nat.pow_pos (by omega)) hu
      rw [show 3 * (k + 1) = 3 + 3 * k by omega, shortcutIter_add]
      rw [show 8 ^ (k + 1) * u = 8 * (8 ^ k * u) by
        simp [Nat.pow_succ, Nat.mul_comm, Nat.mul_left_comm]]
      rw [shortcutIter_OOE_shifted _ hw]
      rw [show 9 * (8 ^ k * u) = 8 ^ k * (9 * u) by
        simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]]
      rw [ih (9 * u) (by omega)]
      simp [Nat.pow_succ, Nat.mul_assoc, Nat.mul_comm]
