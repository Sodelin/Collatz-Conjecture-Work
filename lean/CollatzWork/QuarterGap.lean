import CollatzWork.QuarterGapStatement
import Std.Tactic

namespace CollatzWork

private theorem shortcutIter_succ_last (k n : Nat) :
    shortcutIter (k + 1) n = onceAccelerated (shortcutIter k n) := by
  induction k generalizing n with
  | zero => rfl
  | succ k ih => exact ih (onceAccelerated n)

private theorem twice_onceAccelerated_even {m : Nat} (h : m % 2 = 0) :
    2 * onceAccelerated m = m := by
  simp only [onceAccelerated, if_pos h]
  omega

private theorem twice_onceAccelerated_odd {m : Nat} (h : m % 2 ≠ 0) :
    2 * onceAccelerated m = 3 * m + 1 := by
  simp only [onceAccelerated, if_neg h]
  omega

theorem orbitAffine : OrbitAffineStatement := by
  intro n k
  induction k with
  | zero => simp [shortcutIter, orbitOddCount, orbitRemainder]
  | succ k ih =>
      rw [shortcutIter_succ_last]
      by_cases h : shortcutIter k n % 2 = 0
      · have hs := congrArg (fun x => 2 ^ k * x) (twice_onceAccelerated_even h)
        simp only [orbitOddCount, orbitRemainder, if_pos h, Nat.add_zero]
        calc
          2 ^ (k + 1) * onceAccelerated (shortcutIter k n) =
              2 ^ k * (2 * onceAccelerated (shortcutIter k n)) := by
                simp only [Nat.pow_succ, Nat.mul_assoc]
          _ = 2 ^ k * shortcutIter k n := hs
          _ = 3 ^ orbitOddCount n k * n + orbitRemainder n k := ih
      · have hs := congrArg (fun x => 2 ^ k * x) (twice_onceAccelerated_odd h)
        simp only [orbitOddCount, orbitRemainder, if_neg h]
        calc
          2 ^ (k + 1) * onceAccelerated (shortcutIter k n) =
              2 ^ k * (2 * onceAccelerated (shortcutIter k n)) := by
                simp only [Nat.pow_succ, Nat.mul_assoc]
          _ = 2 ^ k * (3 * shortcutIter k n + 1) := hs
          _ = 3 * (2 ^ k * shortcutIter k n) + 2 ^ k := by
                simp [Nat.mul_add, Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
          _ = 3 * (3 ^ orbitOddCount n k * n + orbitRemainder n k) + 2 ^ k := by rw [ih]
          _ = 3 ^ (orbitOddCount n k + 1) * n +
                (3 * orbitRemainder n k + 2 ^ k) := by
                simp [Nat.pow_succ, Nat.mul_add, Nat.mul_assoc, Nat.mul_comm,
                  Nat.mul_left_comm, Nat.add_assoc]

theorem mechanicalEnvelope : MechanicalEnvelopeStatement := by
  intro n k
  induction k with
  | zero => simp [orbitRemainder, orbitOddCount, mechanicalMax]
  | succ k ih =>
      intro hbarrier
      have hprev := ih (fun j hj => hbarrier j (by omega))
      by_cases h : shortcutIter k n % 2 = 0
      · simpa only [orbitRemainder, orbitOddCount, if_pos h, Nat.add_zero] using hprev
      · have hp : 3 ^ orbitOddCount n k ≠ 0 := Nat.ne_of_gt (Nat.pow_pos (by decide))
        have hlog : k ≤ Nat.log2 (3 ^ orbitOddCount n k) :=
          (Nat.le_log2 hp).mpr (hbarrier k (by omega))
        have hpower := Nat.pow_le_pow_right (n := 2) (by decide) hlog
        have htriple := Nat.mul_le_mul_left 3 hprev
        simpa only [orbitRemainder, orbitOddCount, if_neg h, mechanicalMax] using
          Nat.add_le_add htriple hpower

theorem affine_gap_strict {n d a b C : Nat} (hn : 0 < n) (hab : a < b)
    (haffine : b * (n + d) = a * n + C) : b * d < C := by
  have hscale : a * n < b * n := Nat.mul_lt_mul_of_pos_right hab hn
  rw [Nat.mul_add] at haffine
  omega

theorem affineQuarterCertificate : AffineQuarterCertificateStatement := by
  intro n d a b C s hn hab haffine hcert
  have hgap := affine_gap_strict hn hab haffine
  have hscaled := Nat.mul_lt_mul_of_pos_left hgap (by decide : 0 < 4)
  have hresult : (4 * d) * b < s * b := by
    have : 4 * (b * d) = (4 * d) * b := by
      simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
    omega
  exact Nat.lt_of_mul_lt_mul_right hresult

set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
theorem smallMechanicalCertificate : SmallMechanicalCertificateStatement := by
  have hfinite : ∀ s : Fin 108, 1 ≤ s.val →
      4 * mechanicalMax s.val ≤ s.val * 2 ^ coefficientCrossingExponent s.val := by
    decide
  intro s hs hsmax
  exact hfinite ⟨s, by omega⟩ hs

/-- A numerical certificate at an odd count is sound for every corresponding
actual first contraction, with no trajectory sampling. -/
theorem firstContraction_quarter_of_certificate {n k d : Nat}
    (hn : 0 < n) (hfirst : FirstCoefficientContraction n k)
    (hreturn : shortcutIter k n = n + d)
    (hcert : 4 * mechanicalMax (orbitOddCount n k) ≤
      orbitOddCount n k * 2 ^ coefficientCrossingExponent (orbitOddCount n k)) :
    4 * d < orbitOddCount n k := by
  have henv := mechanicalEnvelope n k hfirst.2.2
  have haffine := orbitAffine n k
  rw [hreturn] at haffine
  have hp : 3 ^ orbitOddCount n k ≠ 0 := Nat.ne_of_gt (Nat.pow_pos (by decide))
  have hlog : Nat.log2 (3 ^ orbitOddCount n k) < k :=
    (Nat.log2_lt hp).mpr hfirst.2.1
  have htime : coefficientCrossingExponent (orbitOddCount n k) ≤ k := by
    unfold coefficientCrossingExponent
    omega
  have hpower := Nat.pow_le_pow_right (n := 2) (by decide) htime
  have hsmall : 4 * orbitRemainder n k ≤ orbitOddCount n k * 2 ^ k :=
    Nat.le_trans (Nat.mul_le_mul_left 4 henv)
      (Nat.le_trans hcert (Nat.mul_le_mul_left _ hpower))
  exact affineQuarterCertificate n d (3 ^ orbitOddCount n k) (2 ^ k)
    (orbitRemainder n k) (orbitOddCount n k) hn hfirst.2.1 haffine hsmall

theorem smallFirstContractionQuarterGap : SmallFirstContractionQuarterGapStatement := by
  intro n k d hn hfirst hsmax hreturn
  have haffine := orbitAffine n k
  rw [hreturn] at haffine
  have hgap := affine_gap_strict hn hfirst.2.1 haffine
  have henv := mechanicalEnvelope n k hfirst.2.2
  have hspos : 1 ≤ orbitOddCount n k := by
    by_cases hz : orbitOddCount n k = 0
    · rw [hz] at henv
      simp only [mechanicalMax] at henv
      omega
    · omega
  have hquarter := firstContraction_quarter_of_certificate hn hfirst hreturn
    (smallMechanicalCertificate (orbitOddCount n k) hspos hsmax)
  exact ⟨hquarter, by omega⟩

example : OrbitAffineStatement := orbitAffine
example : MechanicalEnvelopeStatement := mechanicalEnvelope
example : AffineQuarterCertificateStatement := affineQuarterCertificate
example : SmallMechanicalCertificateStatement := smallMechanicalCertificate
example : SmallFirstContractionQuarterGapStatement := smallFirstContractionQuarterGap

#print axioms CollatzWork.orbitAffine
#print axioms CollatzWork.mechanicalEnvelope
#print axioms CollatzWork.affineQuarterCertificate
#print axioms CollatzWork.smallMechanicalCertificate
#print axioms CollatzWork.firstContraction_quarter_of_certificate
#print axioms CollatzWork.smallFirstContractionQuarterGap

end CollatzWork
