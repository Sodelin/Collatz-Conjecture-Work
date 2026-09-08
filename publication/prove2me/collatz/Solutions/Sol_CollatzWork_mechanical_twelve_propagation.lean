import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_BlockArithmetic
import Definitions.Def_CollatzWork_FloorPower
import Definitions.Def_CollatzWork_QuarterGapStatement
import Theorems.Thm_CollatzWork_blockNumerator12_exact_bound
import Theorems.Thm_CollatzWork_mechanical_twelve_identity
namespace CollatzWork





/-- A strict twelve-step bound follows from the exact endpoint envelope. -/
theorem blockNumerator12_strict_bound {B x : Nat} (hB : 0 < B)
    (hxlo : B ≤ x) (hxhi : x < 2 * B) :
    4 * blockNumerator12 B x < 12 * 531441 * x := by
  have h := blockNumerator12_exact_bound hB hxlo hxhi
  omega

/-- The non-strict form used by the mechanical-remainder recurrence. -/
theorem blockNumerator12_bound {B x : Nat} (hB : 0 < B)
    (hxlo : B ≤ x) (hxhi : x < 2 * B) :
    4 * blockNumerator12 B x ≤ 12 * 531441 * x :=
  Nat.le_of_lt (blockNumerator12_strict_bound hB hxlo hxhi)





end CollatzWork



open CollatzWork in
theorem solution (s : Nat)
    (hstart : 4 * mechanicalMax s ≤ s * 3 ^ s) :
    4 * mechanicalMax (s + 12) ≤ (s + 12) * 3 ^ (s + 12) := by
  have hp : 3 ^ s ≠ 0 := Nat.ne_of_gt (Nat.pow_pos (by decide))
  have hB : 0 < floorPower (3 ^ s) := Nat.two_pow_pos _
  have hlo : floorPower (3 ^ s) ≤ 3 ^ s := Nat.log2_self_le hp
  have hhi : 3 ^ s < 2 * floorPower (3 ^ s) := by
    simpa [floorPower, Nat.pow_succ, Nat.mul_comm] using
      (Nat.lt_log2_self (n := 3 ^ s))
  have hblock := blockNumerator12_bound hB hlo hhi
  calc
    4 * mechanicalMax (s + 12) =
        531441 * (4 * mechanicalMax s) +
          4 * blockNumerator12 (floorPower (3 ^ s)) (3 ^ s) := by
            rw [mechanical_twelve_identity]
            simp [Nat.mul_add, Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
    _ ≤ 531441 * (s * 3 ^ s) + 12 * 531441 * 3 ^ s :=
      Nat.add_le_add (Nat.mul_le_mul_left 531441 hstart) hblock
    _ = (s + 12) * 3 ^ (s + 12) := by
      simp [Nat.pow_add, Nat.add_mul, Nat.mul_add, Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
