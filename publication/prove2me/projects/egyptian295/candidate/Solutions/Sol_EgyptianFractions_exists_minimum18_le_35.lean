import Std
import Init.Grind.Ordered.Module
import Definitions.Def_EgyptianFractions_Baseline18
import Definitions.Def_EgyptianFractions_Certificate
import Theorems.Thm_EgyptianFractions_exists_minimum_of_representation
/-!
# Exact certificates for distinct Egyptian fractions

All sums use Lean's standard exact rational number type `Rat`. A certificate is
a proposition about actual rational addition and division, not an unconnected
Boolean or a floating-point computation. `decide +kernel` checks closed finite
instances by reduction in Lean's kernel; no native evaluation axiom is needed.
-/

namespace EgyptianFractions











/-- An exact finite certificate supplies a genuine mathematical witness. -/
theorem hasRepresentation_of_certificate {lower terms : Nat}
    {denominators : List Nat} (hLength : denominators.length = terms)
    (hRepresentation : IsRepresentation lower denominators) :
    HasRepresentation lower terms :=
  ⟨denominators, hLength, hRepresentation⟩

/-- Every minimum is at most the length of a verified certificate. -/
theorem minimum_le_of_certificate {lower minimum terms : Nat}
    {denominators : List Nat}
    (hMinimum : IsMinimumLength lower minimum)
    (hLength : denominators.length = terms)
    (hRepresentation : IsRepresentation lower denominators) :
    minimum ≤ terms :=
  hMinimum.2 terms (hasRepresentation_of_certificate hLength hRepresentation)



end EgyptianFractions
/-!
# A reproduction certificate for the known 35-term bound at N = 18

This file certifies the supplied existing 35-denominator representation. It does
not claim novelty, minimality, a 34-term representation, or a solution of the
asymptotic conjecture in Erdős problem 295. See the research notes for provenance.
-/

namespace EgyptianFractions



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








end EgyptianFractions



open EgyptianFractions in
theorem solution :
    ∃ minimum, IsMinimumLength 18 minimum ∧ minimum ≤ 35 := by
  obtain ⟨minimum, hMinimum⟩ :=
    exists_minimum_of_representation exists_35_term_representation
  exact ⟨minimum, hMinimum, minimum18_le_35 hMinimum⟩
