import CollatzWork.FirstContractionStatement
import CollatzWork.QuarterGap

namespace CollatzWork

theorem firstContractionTime : FirstContractionTimeStatement := by
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

theorem mechanicalCoarseBound : MechanicalCoarseBoundStatement := by
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

theorem firstContractionThirdGap : FirstContractionThirdGapStatement := by
  intro n k d hn hfirst hreturn
  have henv := mechanicalEnvelope n k hfirst.2.2
  have haffine := orbitAffine n k
  rw [hreturn] at haffine
  have hgap := affine_gap_strict hn hfirst.2.1 haffine
  have hcoarse := mechanicalCoarseBound (orbitOddCount n k)
  have hcert : 3 * orbitRemainder n k ≤ orbitOddCount n k * 2 ^ k :=
    Nat.le_trans (Nat.mul_le_mul_left 3 henv)
      (Nat.le_trans hcoarse
        (Nat.mul_le_mul_left (orbitOddCount n k) (Nat.le_of_lt hfirst.2.1)))
  have hscaled := Nat.mul_lt_mul_of_pos_left hgap (by decide : 0 < 3)
  have hprod : (3 * d) * 2 ^ k < orbitOddCount n k * 2 ^ k := by
    have : 3 * (2 ^ k * d) = (3 * d) * 2 ^ k := by
      simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
    omega
  have hthird := Nat.lt_of_mul_lt_mul_right hprod
  exact ⟨hthird, by omega⟩

example : FirstContractionTimeStatement := firstContractionTime
example : MechanicalCoarseBoundStatement := mechanicalCoarseBound
example : FirstContractionThirdGapStatement := firstContractionThirdGap

#print axioms CollatzWork.firstContractionTime
#print axioms CollatzWork.mechanicalCoarseBound
#print axioms CollatzWork.firstContractionThirdGap

end CollatzWork
