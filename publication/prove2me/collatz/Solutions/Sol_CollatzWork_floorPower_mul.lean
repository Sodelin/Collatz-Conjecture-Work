import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_FloorPower



open CollatzWork in
theorem solution {a x f k : Nat}
    (ha : 2 ^ f ≤ a) (ha' : a < 2 ^ (f + 1))
    (hx : 2 ^ k ≤ x) (hx' : x < 2 ^ (k + 1)) :
    floorPower (a * x) =
      if a * x < 2 ^ (f + 1) * 2 ^ k then 2 ^ f * 2 ^ k
      else 2 ^ (f + 1) * 2 ^ k := by
  have hlow := Nat.mul_le_mul ha hx
  have hupp := Nat.mul_lt_mul_of_lt_of_lt ha' hx'
  have hapos : 0 < a := Nat.lt_of_lt_of_le (Nat.two_pow_pos f) ha
  have hxpos : 0 < x := Nat.lt_of_lt_of_le (Nat.two_pow_pos k) hx
  have hax : a * x ≠ 0 := Nat.ne_of_gt (Nat.mul_pos hapos hxpos)
  unfold floorPower
  by_cases h : a * x < 2 ^ (f + 1) * 2 ^ k
  · rw [if_pos h]
    have hlog : Nat.log2 (a * x) = f + k := by
      apply (Nat.log2_eq_iff hax).mpr
      constructor
      · simpa only [Nat.pow_add] using hlow
      · simpa only [Nat.pow_add, Nat.pow_succ, Nat.mul_assoc,
          Nat.mul_comm, Nat.mul_left_comm] using h
    rw [hlog, Nat.pow_add]
  · rw [if_neg h]
    have hlog : Nat.log2 (a * x) = f + k + 1 := by
      apply (Nat.log2_eq_iff hax).mpr
      constructor
      · have hle : 2 ^ (f + 1) * 2 ^ k ≤ a * x := by omega
        simpa only [Nat.pow_add, Nat.pow_succ, Nat.mul_assoc,
          Nat.mul_comm, Nat.mul_left_comm] using hle
      · simpa only [Nat.pow_add, Nat.pow_succ, Nat.mul_assoc,
          Nat.mul_comm, Nat.mul_left_comm] using hupp
    rw [hlog]
    simp only [Nat.pow_add, Nat.pow_succ, Nat.mul_assoc,
      Nat.mul_comm, Nat.mul_left_comm]
