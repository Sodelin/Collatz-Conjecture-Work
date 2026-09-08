import Std
import Init.Grind.Ordered.Module



theorem BlindCollatz.AlternatingGrowth.odd_exponents_one_two (q : Nat) :
    (3 * (16 * q + 11) + 1) % 4 = 2 ∧
    (3 * (24 * q + 17) + 1) % 8 = 4 := by sorry

