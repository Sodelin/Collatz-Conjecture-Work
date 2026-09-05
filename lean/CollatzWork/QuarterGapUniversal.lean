import CollatzWork.QuarterGapUniversalStatement
import CollatzWork.FirstContraction
import CollatzWork.FloorPower
import CollatzWork.BlockArithmetic

namespace CollatzWork

/-- Exact twelve-step recurrence, with all twelve phase cases represented by
the separately verified finite arithmetic expression. -/
theorem mechanical_twelve_identity (s : Nat) :
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

/-- Sound twelve-step propagation of the stronger asymptotic envelope. -/
theorem mechanical_twelve_propagation (s : Nat)
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

set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
theorem mechanical_large_base : ∀ s : Fin 28, 16 ≤ s.val →
    4 * mechanicalMax s.val ≤ s.val * 3 ^ s.val := by
  decide

/-- All large odd counts, by a verified twelve-step induction. -/
theorem mechanical_large_bound : MechanicalSixteenEnvelopeStatement := by
  intro s
  induction s using Nat.strongRecOn with
  | ind s ih =>
      intro hs
      by_cases hsmall : s < 28
      · exact mechanical_large_base ⟨s, hsmall⟩ hs
      · have hprior : 16 ≤ s - 12 := by omega
        have hlt : s - 12 < s := by omega
        have hrec := mechanical_twelve_propagation (s - 12) (ih (s - 12) hlt hprior)
        have heq : s - 12 + 12 = s := by omega
        simpa only [heq] using hrec

set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
/-- The cutoff is sharp for an envelope asserted at every subsequent odd
count: s=15 fails, while all s≥16 satisfy it. -/
theorem mechanical_fifteen_failure : MechanicalFifteenFailureStatement := by
  decide

theorem universalMechanicalQuarterCertificate :
    UniversalMechanicalQuarterCertificateStatement := by
  intro s hs
  by_cases hsmall : s ≤ 15
  · exact smallMechanicalCertificate s hs (by omega)
  · have hlarge := mechanical_large_bound s (by omega)
    have hcross : 3 ^ s ≤ 2 ^ coefficientCrossingExponent s :=
      Nat.le_of_lt Nat.lt_log2_self
    exact Nat.le_trans hlarge (Nat.mul_le_mul_left s hcross)

/-- L15's actual universal quarter-gap theorem. This does not assert that
a first coefficient contraction exists for every start. -/
theorem firstContractionQuarterGap : FirstContractionQuarterGapStatement := by
  intro n k d hn hfirst hreturn
  have hthird := firstContractionThirdGap n k d hn hfirst hreturn
  have hs : 1 ≤ orbitOddCount n k := by omega
  have hquarter := firstContraction_quarter_of_certificate hn hfirst hreturn
    (universalMechanicalQuarterCertificate (orbitOddCount n k) hs)
  exact ⟨hquarter, by omega⟩

example : MechanicalSixteenEnvelopeStatement := mechanical_large_bound
example : MechanicalFifteenFailureStatement := mechanical_fifteen_failure
example : UniversalMechanicalQuarterCertificateStatement :=
  universalMechanicalQuarterCertificate
example : FirstContractionQuarterGapStatement := firstContractionQuarterGap

#print axioms CollatzWork.mechanical_twelve_identity
#print axioms CollatzWork.mechanical_twelve_propagation
#print axioms CollatzWork.mechanical_large_base
#print axioms CollatzWork.mechanical_large_bound
#print axioms CollatzWork.mechanical_fifteen_failure
#print axioms CollatzWork.universalMechanicalQuarterCertificate
#print axioms CollatzWork.firstContractionQuarterGap

end CollatzWork
