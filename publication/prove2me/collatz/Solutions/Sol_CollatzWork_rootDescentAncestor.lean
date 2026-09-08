import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Definitions.Def_CollatzWork_RootDescentStatement
import Theorems.Thm_CollatzWork_oddRun
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







/-- An exact forward even run, including the zero-length case. -/
theorem shortcutIter_evenRun (k m : Nat) :
    shortcutIter k (2 ^ k * m) = m := by
  induction k with
  | zero => simp
  | succ k ih =>
      rw [show 2 ^ (k + 1) * m = 2 * (2 ^ k * m) by
        simp [Nat.pow_succ, Nat.mul_comm, Nat.mul_left_comm]]
      rw [shortcutIter_succ, onceAccelerated_two_mul, ih]









/-- The guarded final even, odd block of an ancestor word. -/
theorem shortcutIter_EO_of_affine_guard (x r : Nat)
    (hguard : 3 * x + 2 = 4 * r) : shortcutIter 2 x = r := by
  have heven : x % 2 = 0 := by omega
  have hodd : (x / 2) % 2 ≠ 0 := by omega
  have hfirst : onceAccelerated x = x / 2 := by
    simp [onceAccelerated, heven]
  change onceAccelerated (onceAccelerated x) = r
  rw [hfirst]
  simp only [onceAccelerated, hodd, ↓reduceIte]
  omega













end CollatzWork



open CollatzWork in
theorem solution : RootDescentAncestorStatement := by
  intro e L q r hq hguard
  rw [shortcutIter_add (e + L) 2, shortcutIter_add e L,
    shortcutIter_evenRun, oddRun L q hq]
  apply shortcutIter_EO_of_affine_guard
  have hp : 0 < 3 ^ L * q := Nat.mul_pos (Nat.pow_pos (by omega)) hq
  have hpower : 3 ^ (L + 1) * q = 3 * (3 ^ L * q) := by
    simp [Nat.pow_succ, Nat.mul_comm, Nat.mul_left_comm]
  rw [hpower] at hguard
  omega
