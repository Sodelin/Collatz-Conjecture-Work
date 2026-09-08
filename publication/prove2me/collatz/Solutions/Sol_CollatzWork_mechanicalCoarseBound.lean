import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_FirstContractionStatement
import Definitions.Def_CollatzWork_QuarterGapStatement



open CollatzWork in
theorem solution : MechanicalCoarseBoundStatement := by
  intro s
  induction s with
  | zero => simp [mechanicalMax]
  | succ s ih =>
      have hp : 3 ^ s ≠ 0 := Nat.ne_of_gt (Nat.pow_pos (by decide))
      have hfloor := Nat.log2_self_le hp
      calc
        3 * mechanicalMax (s + 1) =
            3 * (3 * mechanicalMax s) + 3 * 2 ^ Nat.log2 (3 ^ s) := by
              simp [mechanicalMax, Nat.mul_add]
        _ ≤ 3 * (s * 3 ^ s) + 3 * 3 ^ s :=
          Nat.add_le_add (Nat.mul_le_mul_left 3 ih) (Nat.mul_le_mul_left 3 hfloor)
        _ = (s + 1) * 3 ^ (s + 1) := by
          simp [Nat.pow_succ, Nat.add_mul, Nat.mul_add, Nat.mul_assoc,
            Nat.mul_comm, Nat.mul_left_comm]
