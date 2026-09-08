import Std
import Init.Grind.Ordered.Module



theorem solution (d : Nat) :
    (27 + 5 * d) * 27 ^ d ≤ 27 * 32 ^ d := by
  induction d with
  | zero => simp
  | succ d ih =>
    have hcoeff : 27 * (32 + 5 * d) ≤ 32 * (27 + 5 * d) := by omega
    calc
      (27 + 5 * (d + 1)) * 27 ^ (d + 1)
          = (27 * (32 + 5 * d)) * 27 ^ d := by
              rw [Nat.pow_succ]
              have h : 27 + 5 * (d + 1) = 32 + 5 * d := by omega
              rw [h]
              ac_rfl
      _ ≤ (32 * (27 + 5 * d)) * 27 ^ d := Nat.mul_le_mul_right _ hcoeff
      _ = 32 * ((27 + 5 * d) * 27 ^ d) := by ac_rfl
      _ ≤ 32 * (27 * 32 ^ d) := Nat.mul_le_mul_left 32 ih
      _ = 27 * 32 ^ (d + 1) := by rw [Nat.pow_succ]; ac_rfl
