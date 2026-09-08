import Std
import Init.Grind.Ordered.Module



theorem solution (a b : Nat) (y : Nat → Nat) (k : Nat)
    (h : ∀ i, i < k → b * y (i + 1) = a * y i) :
    b ^ k * y k = a ^ k * y 0 := by
  induction k with
  | zero => simp
  | succ k ih =>
    have hp := ih (fun i hi => h i (by omega))
    calc
      b ^ (k + 1) * y (k + 1)
          = b ^ k * (b * y (k + 1)) := by
              rw [Nat.pow_succ, Nat.mul_assoc]
      _ = b ^ k * (a * y k) := by rw [h k (by omega)]
      _ = a * (b ^ k * y k) := by ac_rfl
      _ = a * (a ^ k * y 0) := by rw [hp]
      _ = a ^ (k + 1) * y 0 := by rw [Nat.pow_succ]; ac_rfl
