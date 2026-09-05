import CollatzWork.QuarterGapStatement

namespace CollatzWork

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

