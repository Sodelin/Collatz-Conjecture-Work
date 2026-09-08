import EgyptianFractions.Certificate

/-!
# A reproduction certificate for the known 35-term bound at N = 18

This file certifies the supplied existing 35-denominator representation. It does
not claim novelty, minimality, a 34-term representation, or a solution of the
asymptotic conjecture in Erdős problem 295. See the research notes for provenance.
-/

namespace EgyptianFractions

/-- The existing 35-term representation, preserved as a reproducible baseline. -/
def baseline18 : List Nat :=
  [18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35,
   36, 38, 39, 40, 42, 43, 44, 45, 48, 50, 52, 54, 63, 640, 337280, 1735650,
   68479214496]

theorem baseline18_length : baseline18.length = 35 := by decide

theorem baseline18_distinct : baseline18.Nodup := by decide

theorem baseline18_denominators : ∀ d ∈ baseline18, 0 < d ∧ 18 ≤ d := by decide

set_option maxRecDepth 4096 in
set_option maxHeartbeats 2000000 in
theorem baseline18_sum : reciprocalSum baseline18 = 1 := by decide +kernel

theorem baseline18_certificate : IsRepresentation 18 baseline18 :=
  ⟨baseline18_distinct, baseline18_denominators, baseline18_sum⟩

/-- Exactly 35 distinct positive unit fractions with denominators at least 18
sum to one. This is a verified upper bound, not a minimality result. -/
theorem exists_35_term_representation : HasRepresentation 18 35 :=
  hasRepresentation_of_certificate baseline18_length baseline18_certificate

/-- If `minimum` is the least length at N = 18, then `minimum ≤ 35`. -/
theorem minimum18_le_35 {minimum : Nat} (hMinimum : IsMinimumLength 18 minimum) :
    minimum ≤ 35 :=
  minimum_le_of_certificate hMinimum baseline18_length baseline18_certificate

/-- The minimum length at N = 18 exists and is at most 35. -/
theorem exists_minimum18_le_35 :
    ∃ minimum, IsMinimumLength 18 minimum ∧ minimum ≤ 35 := by
  obtain ⟨minimum, hMinimum⟩ :=
    exists_minimum_of_representation exists_35_term_representation
  exact ⟨minimum, hMinimum, minimum18_le_35 hMinimum⟩

#print axioms baseline18_sum
#print axioms exists_35_term_representation
#print axioms minimum18_le_35
#print axioms exists_minimum18_le_35

end EgyptianFractions
