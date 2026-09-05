import CollatzWork.QuarterGapStatement

namespace CollatzWork

def FirstContractionTimeStatement : Prop :=
  ∀ n k : Nat, FirstCoefficientContraction n k →
    k = coefficientCrossingExponent (orbitOddCount n k)

def MechanicalCoarseBoundStatement : Prop :=
  ∀ s : Nat, 3 * mechanicalMax s ≤ s * 3 ^ s

/-- The universal old L10 bound, on actual first contractions. -/
def FirstContractionThirdGapStatement : Prop :=
  ∀ n k d : Nat, 0 < n → FirstCoefficientContraction n k →
    shortcutIter k n = n + d →
    3 * d < orbitOddCount n k ∧ d ≤ (orbitOddCount n k - 1) / 3

end CollatzWork
