import Std
import Init.Grind.Ordered.Module



theorem solution (q : Nat) :
    (3 * (16 * q + 11) + 1) % 4 = 2 ∧
    (3 * (24 * q + 17) + 1) % 8 = 4 := by
  constructor <;> omega
