import CollatzWork.QuarterGapStatement

namespace CollatzWork

/-- The normalized mechanical envelope holds from the optimal integer
threshold 16 onward. The failure at 15 is stated separately below. -/
def MechanicalSixteenEnvelopeStatement : Prop :=
  ∀ s : Nat, 16 ≤ s → 4 * mechanicalMax s ≤ s * 3 ^ s

/-- Exact boundary witness: the preceding odd count fails this envelope. -/
def MechanicalFifteenFailureStatement : Prop :=
  15 * 3 ^ 15 < 4 * mechanicalMax 15

/-- Independent, universally quantified integer certificate for the L15 bound. -/
def UniversalMechanicalQuarterCertificateStatement : Prop :=
  ∀ s : Nat, 1 ≤ s →
    4 * mechanicalMax s ≤ s * 2 ^ coefficientCrossingExponent s

/-- L15 on the ordinary shortcut Collatz orbit, at any existing first
coefficient contraction that does not descend below its positive start. -/
def FirstContractionQuarterGapStatement : Prop :=
  ∀ n k d : Nat, 0 < n → FirstCoefficientContraction n k →
    shortcutIter k n = n + d →
    4 * d < orbitOddCount n k ∧ d ≤ (orbitOddCount n k - 1) / 4

end CollatzWork
