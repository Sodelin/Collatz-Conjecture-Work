import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Theorems.Thm_CollatzWork_oddRun
namespace CollatzWork







private theorem mersenne_prefix (L k q : Nat) (hk : k ≤ L) (hq : 0 < q) :
    shortcutIter k (2 ^ L * q - 1) = 3 ^ k * (2 ^ (L - k) * q) - 1 := by
  have hfactor : 2 ^ L * q = 2 ^ k * (2 ^ (L - k) * q) := by
    rw [← Nat.mul_assoc, ← Nat.pow_add, Nat.add_sub_of_le hk]
  rw [hfactor]
  exact oddRun k (2 ^ (L - k) * q)
    (Nat.mul_pos (Nat.pow_pos (by omega)) hq)









end CollatzWork


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

theorem onceAccelerated_two_mul_sub_one (b : Nat) (hb : 0 < b) :
    onceAccelerated (2 * b - 1) = 3 * b - 1 := by
  rw [onceAccelerated]
  have hodd : (2 * b - 1) % 2 ≠ 0 := by omega
  simp [hodd]
  omega




































end CollatzWork



open CollatzWork in
theorem solution (L q : Nat) (hq : 0 < q) :
    ∀ k, k < L →
      shortcutIter k (2 ^ L * q - 1) ≤
      shortcutIter (k + 1) (2 ^ L * q - 1) := by
  intro k hk
  let b := 3 ^ k * (2 ^ (L - k - 1) * q)
  have hb : 0 < b := Nat.mul_pos (Nat.pow_pos (by omega))
    (Nat.mul_pos (Nat.pow_pos (by omega)) hq)
  have hp : 2 ^ (L - k) = 2 * 2 ^ (L - k - 1) := by
    have he : L - k = (L - k - 1) + 1 := by omega
    rw [he, Nat.pow_succ]
    have he' : L - k - 1 + 1 - 1 = L - k - 1 := by omega
    rw [he']
    exact Nat.mul_comm _ _
  have hform : shortcutIter k (2 ^ L * q - 1) = 2 * b - 1 := by
    rw [mersenne_prefix L k q (by omega) hq, hp]
    unfold b
    simp only [Nat.mul_assoc, Nat.mul_left_comm]
  rw [shortcutIter_add k 1, hform]
  simp only [shortcutIter_succ, shortcutIter_zero]
  rw [onceAccelerated_two_mul_sub_one b hb]
  omega
