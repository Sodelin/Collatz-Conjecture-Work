import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_BlockArithmetic
import Definitions.Def_CollatzWork_FloorPower
import Definitions.Def_CollatzWork_QuarterGapStatement
import Theorems.Thm_CollatzWork_floorPower_mul
namespace CollatzWork





theorem floorPower_mul_canonical {a x : Nat} (ha : a ≠ 0) (hx : x ≠ 0) :
    floorPower (a * x) =
      if a * x < 2 ^ (Nat.log2 a + 1) * floorPower x then
        2 ^ Nat.log2 a * floorPower x
      else 2 ^ (Nat.log2 a + 1) * floorPower x :=
  floorPower_mul (Nat.log2_self_le ha) Nat.lt_log2_self
    (Nat.log2_self_le hx) Nat.lt_log2_self




end CollatzWork



open CollatzWork in
theorem solution (s : Nat) :
    mechanicalMax (s + 12) = 531441 * mechanicalMax s +
      blockNumerator12 (floorPower (3 ^ s)) (3 ^ s) := by
  have hp : 3 ^ s ≠ 0 := Nat.ne_of_gt (Nat.pow_pos (by decide))
  have hxhi : 3 ^ s < 2 * floorPower (3 ^ s) := by
    simpa [floorPower, Nat.pow_succ, Nat.mul_comm] using
      (Nat.lt_log2_self (n := 3 ^ s))
  have h1 : 2 ^ Nat.log2 (3 ^ (s + 1)) =
      (if 3 * 3 ^ s < 4 * floorPower (3 ^ s) then
        2 * floorPower (3 ^ s) else 4 * floorPower (3 ^ s)) := by
    change floorPower (3 ^ (s + 1)) = _
    rw [Nat.pow_add, Nat.mul_comm]
    exact floorPower_mul_canonical (a := 3 ^ 1) (by decide) hp
  have h2 : 2 ^ Nat.log2 (3 ^ (s + 2)) =
      (if 9 * 3 ^ s < 16 * floorPower (3 ^ s) then
        8 * floorPower (3 ^ s) else 16 * floorPower (3 ^ s)) := by
    change floorPower (3 ^ (s + 2)) = _
    rw [Nat.pow_add, Nat.mul_comm]
    exact floorPower_mul_canonical (a := 3 ^ 2) (by decide) hp
  have h3 : 2 ^ Nat.log2 (3 ^ (s + 3)) =
      (if 27 * 3 ^ s < 32 * floorPower (3 ^ s) then
        16 * floorPower (3 ^ s) else 32 * floorPower (3 ^ s)) := by
    change floorPower (3 ^ (s + 3)) = _
    rw [Nat.pow_add, Nat.mul_comm]
    exact floorPower_mul_canonical (a := 3 ^ 3) (by decide) hp
  have h4 : 2 ^ Nat.log2 (3 ^ (s + 4)) =
      (if 81 * 3 ^ s < 128 * floorPower (3 ^ s) then
        64 * floorPower (3 ^ s) else 128 * floorPower (3 ^ s)) := by
    change floorPower (3 ^ (s + 4)) = _
    rw [Nat.pow_add, Nat.mul_comm]
    exact floorPower_mul_canonical (a := 3 ^ 4) (by decide) hp
  have h5 : 2 ^ Nat.log2 (3 ^ (s + 5)) =
      (if 243 * 3 ^ s < 256 * floorPower (3 ^ s) then
        128 * floorPower (3 ^ s) else 256 * floorPower (3 ^ s)) := by
    change floorPower (3 ^ (s + 5)) = _
    rw [Nat.pow_add, Nat.mul_comm]
    exact floorPower_mul_canonical (a := 3 ^ 5) (by decide) hp
  have h6 : 2 ^ Nat.log2 (3 ^ (s + 6)) =
      (if 729 * 3 ^ s < 1024 * floorPower (3 ^ s) then
        512 * floorPower (3 ^ s) else 1024 * floorPower (3 ^ s)) := by
    change floorPower (3 ^ (s + 6)) = _
    rw [Nat.pow_add, Nat.mul_comm]
    exact floorPower_mul_canonical (a := 3 ^ 6) (by decide) hp
  have h7 : 2 ^ Nat.log2 (3 ^ (s + 7)) =
      (if 2187 * 3 ^ s < 4096 * floorPower (3 ^ s) then
        2048 * floorPower (3 ^ s) else 4096 * floorPower (3 ^ s)) := by
    change floorPower (3 ^ (s + 7)) = _
    rw [Nat.pow_add, Nat.mul_comm]
    exact floorPower_mul_canonical (a := 3 ^ 7) (by decide) hp
  have h8 : 2 ^ Nat.log2 (3 ^ (s + 8)) =
      (if 6561 * 3 ^ s < 8192 * floorPower (3 ^ s) then
        4096 * floorPower (3 ^ s) else 8192 * floorPower (3 ^ s)) := by
    change floorPower (3 ^ (s + 8)) = _
    rw [Nat.pow_add, Nat.mul_comm]
    exact floorPower_mul_canonical (a := 3 ^ 8) (by decide) hp
  have h9 : 2 ^ Nat.log2 (3 ^ (s + 9)) =
      (if 19683 * 3 ^ s < 32768 * floorPower (3 ^ s) then
        16384 * floorPower (3 ^ s) else 32768 * floorPower (3 ^ s)) := by
    change floorPower (3 ^ (s + 9)) = _
    rw [Nat.pow_add, Nat.mul_comm]
    exact floorPower_mul_canonical (a := 3 ^ 9) (by decide) hp
  have h10 : 2 ^ Nat.log2 (3 ^ (s + 10)) =
      (if 59049 * 3 ^ s < 65536 * floorPower (3 ^ s) then
        32768 * floorPower (3 ^ s) else 65536 * floorPower (3 ^ s)) := by
    change floorPower (3 ^ (s + 10)) = _
    rw [Nat.pow_add, Nat.mul_comm]
    exact floorPower_mul_canonical (a := 3 ^ 10) (by decide) hp
  have h11 : 2 ^ Nat.log2 (3 ^ (s + 11)) =
      (if 177147 * 3 ^ s < 262144 * floorPower (3 ^ s) then
        131072 * floorPower (3 ^ s) else 262144 * floorPower (3 ^ s)) := by
    change floorPower (3 ^ (s + 11)) = _
    rw [Nat.pow_add, Nat.mul_comm]
    exact floorPower_mul_canonical (a := 3 ^ 11) (by decide) hp
  simp only [mechanicalMax, h1, h2, h3, h4, h5, h6, h7, h8, h9, h10, h11, blockNumerator12, if_pos hxhi]
  unfold floorPower
  omega
