import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_QuarterGapStatement
namespace CollatzWork

private theorem shortcutIter_succ_last (k n : Nat) :
    shortcutIter (k + 1) n = onceAccelerated (shortcutIter k n) := by
  induction k generalizing n with
  | zero => rfl
  | succ k ih => exact ih (onceAccelerated n)

private theorem twice_onceAccelerated_even {m : Nat} (h : m % 2 = 0) :
    2 * onceAccelerated m = m := by
  simp only [onceAccelerated, if_pos h]
  omega

private theorem twice_onceAccelerated_odd {m : Nat} (h : m % 2 ≠ 0) :
    2 * onceAccelerated m = 3 * m + 1 := by
  simp only [onceAccelerated, if_neg h]
  omega




























end CollatzWork



open CollatzWork in
theorem solution : OrbitAffineStatement := by
  intro n k
  induction k with
  | zero => simp [shortcutIter, orbitOddCount, orbitRemainder]
  | succ k ih =>
      rw [shortcutIter_succ_last]
      by_cases h : shortcutIter k n % 2 = 0
      · have hs := congrArg (fun x => 2 ^ k * x) (twice_onceAccelerated_even h)
        simp only [orbitOddCount, orbitRemainder, if_pos h, Nat.add_zero]
        calc
          2 ^ (k + 1) * onceAccelerated (shortcutIter k n) =
              2 ^ k * (2 * onceAccelerated (shortcutIter k n)) := by
                simp only [Nat.pow_succ, Nat.mul_assoc]
          _ = 2 ^ k * shortcutIter k n := hs
          _ = 3 ^ orbitOddCount n k * n + orbitRemainder n k := ih
      · have hs := congrArg (fun x => 2 ^ k * x) (twice_onceAccelerated_odd h)
        simp only [orbitOddCount, orbitRemainder, if_neg h]
        calc
          2 ^ (k + 1) * onceAccelerated (shortcutIter k n) =
              2 ^ k * (2 * onceAccelerated (shortcutIter k n)) := by
                simp only [Nat.pow_succ, Nat.mul_assoc]
          _ = 2 ^ k * (3 * shortcutIter k n + 1) := hs
          _ = 3 * (2 ^ k * shortcutIter k n) + 2 ^ k := by
                simp [Nat.mul_add, Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
          _ = 3 * (3 ^ orbitOddCount n k * n + orbitRemainder n k) + 2 ^ k := by rw [ih]
          _ = 3 ^ (orbitOddCount n k + 1) * n +
                (3 * orbitRemainder n k + 2 ^ k) := by
                simp [Nat.pow_succ, Nat.mul_add, Nat.mul_assoc, Nat.mul_comm,
                  Nat.mul_left_comm, Nat.add_assoc]
