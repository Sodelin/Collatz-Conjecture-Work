import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_FirstContractionStatement
import Definitions.Def_CollatzWork_QuarterGapStatement



open CollatzWork in
theorem solution : FirstContractionTimeStatement := by
  intro n k hfirst
  cases k with
  | zero => exact False.elim (by have := hfirst.1; omega)
  | succ j =>
      have hprev := hfirst.2.2 j (by omega)
      have hcontract := hfirst.2.1
      by_cases heven : shortcutIter j n % 2 = 0
      · simp only [orbitOddCount, if_pos heven, Nat.add_zero] at hcontract ⊢
        have hp : 3 ^ orbitOddCount n j ≠ 0 := Nat.ne_of_gt (Nat.pow_pos (by decide))
        have hlog : Nat.log2 (3 ^ orbitOddCount n j) = j :=
          (Nat.log2_eq_iff hp).mpr ⟨hprev, hcontract⟩
        simp only [coefficientCrossingExponent, hlog]
      · simp only [orbitOddCount, if_neg heven, Nat.pow_succ] at hcontract
        have hscaled := Nat.mul_le_mul_right 3 hprev
        have hpositive : 0 < 2 ^ j := Nat.two_pow_pos j
        omega
