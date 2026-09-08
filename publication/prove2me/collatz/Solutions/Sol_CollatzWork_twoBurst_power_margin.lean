import Std
import Init.Grind.Ordered.Module
namespace CollatzWork

/-!
# Two-burst recharge followed by descent below the original root

Only the ordinary shortcut Collatz map is iterated. All arithmetic guards
are explicit. This does not prove that every start has these guards, or
that every recharge eventually produces such an escape.
-/





private theorem nine_power_le_sixteen (l : Nat) : 9 ^ l ≤ 16 ^ l := by
  induction l with
  | zero => decide
  | succ l ih =>
      simp only [Nat.pow_succ]
      omega

















end CollatzWork



open CollatzWork in
theorem solution (j l : Nat) :
    3 * 9 ^ (j + l + 1) + 3 * 9 ^ l +
        10 * 8 ^ l * 2 ^ (j + l + 1) < 4 * 16 ^ (j + l + 1) := by
  induction j with
  | zero =>
      have hle := nine_power_le_sixteen l
      have hpos : 0 < 16 ^ l := Nat.pow_pos (by omega)
      have hpowers : 8 ^ l * 2 ^ l = 16 ^ l :=
        (Nat.mul_pow 8 2 l).symm
      simp only [Nat.zero_add, Nat.pow_succ]
      have hterm : 10 * 8 ^ l * (2 ^ l * 2) = 20 * 16 ^ l := by
        calc
          10 * 8 ^ l * (2 ^ l * 2) = (10 * 2) * (8 ^ l * 2 ^ l) := by
            ac_rfl
          _ = 20 * (8 ^ l * 2 ^ l) := rfl
          _ = 20 * 16 ^ l := by rw [hpowers]
      rw [hterm]
      omega
  | succ j ih =>
      rw [show j + 1 + l + 1 = (j + l + 1) + 1 by omega]
      change 3 * (9 ^ (j + l + 1) * 9) + 3 * 9 ^ l +
        10 * 8 ^ l * (2 ^ (j + l + 1) * 2) <
          4 * (16 ^ (j + l + 1) * 16)
      have hterm : 10 * 8 ^ l * (2 ^ (j + l + 1) * 2) =
          2 * (10 * 8 ^ l * 2 ^ (j + l + 1)) := by
        simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
      rw [hterm]
      omega
