import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_AffineRepetitionStatement
import Theorems.Thm_CollatzWork_prefixReturnBernoulli



open CollatzWork in
theorem solution : PrefixReturnNumericalBoundStatement := by
  intro n d h
  have hbern := Nat.mul_le_mul_left 2 (prefixReturnBernoulli d)
  have hscaled := Nat.mul_lt_mul_of_pos_left h (by decide : 0 < 27)
  have hprod : (2 * (27 + 5 * d)) * 27 ^ d < (27 * (n + 1)) * 27 ^ d := by
    calc
      (2 * (27 + 5 * d)) * 27 ^ d = 2 * ((27 + 5 * d) * 27 ^ d) := by ac_rfl
      _ ≤ 2 * (27 * 32 ^ d) := hbern
      _ = 27 * (2 * 32 ^ d) := by ac_rfl
      _ < 27 * (27 ^ d * (n + 1)) := hscaled
      _ = (27 * (n + 1)) * 27 ^ d := by ac_rfl
  have hlinear := Nat.lt_of_mul_lt_mul_right hprod
  constructor <;> omega
