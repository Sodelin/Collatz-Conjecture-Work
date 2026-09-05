import CollatzWork.ConvergenceStatement

namespace CollatzWork

/-!
Trusted integer statements for the L9/L15 certificate path. The orbit is
the existing one-division Collatz map; no alternative transition is introduced.
The universal rotation bound is deliberately not assumed as a project axiom.
-/

/-- Number of odd branches in the first `k` actual shortcut steps. -/
def orbitOddCount (n : Nat) : Nat → Nat
  | 0 => 0
  | k + 1 => orbitOddCount n k +
      if shortcutIter k n % 2 = 0 then 0 else 1

/-- Exact affine remainder along the first `k` actual shortcut steps. -/
def orbitRemainder (n : Nat) : Nat → Nat
  | 0 => 0
  | k + 1 => if shortcutIter k n % 2 = 0 then orbitRemainder n k
      else 3 * orbitRemainder n k + 2 ^ k

/-- The first strict coefficient contraction, including every prior barrier. -/
def FirstCoefficientContraction (n k : Nat) : Prop :=
  0 < k ∧ 3 ^ orbitOddCount n k < 2 ^ k ∧
    ∀ j : Nat, j < k → 2 ^ j ≤ 3 ^ orbitOddCount n j

/-- Integer-only L9 mechanical extremal remainder. -/
def mechanicalMax : Nat → Nat
  | 0 => 0
  | s + 1 => 3 * mechanicalMax s + 2 ^ Nat.log2 (3 ^ s)

/-- First power-of-two exponent strictly above `3^s`. -/
def coefficientCrossingExponent (s : Nat) : Nat := Nat.log2 (3 ^ s) + 1

def OrbitAffineStatement : Prop :=
  ∀ n k : Nat, 2 ^ k * shortcutIter k n =
    3 ^ orbitOddCount n k * n + orbitRemainder n k

def MechanicalEnvelopeStatement : Prop :=
  ∀ n k : Nat,
    (∀ j : Nat, j < k → 2 ^ j ≤ 3 ^ orbitOddCount n j) →
    orbitRemainder n k ≤ mechanicalMax (orbitOddCount n k)

/-- General arithmetic certificate soundness, independent of Collatz. -/
def AffineQuarterCertificateStatement : Prop :=
  ∀ n d a b C s : Nat, 0 < n → a < b →
    b * (n + d) = a * n + C → 4 * C ≤ s * b → 4 * d < s

def SmallMechanicalCertificateStatement : Prop :=
  ∀ s : Nat, 1 ≤ s → s ≤ 107 →
    4 * mechanicalMax s ≤ s * 2 ^ coefficientCrossingExponent s

/-- Actual Collatz first contractions with at most 107 odd steps. -/
def SmallFirstContractionQuarterGapStatement : Prop :=
  ∀ n k d : Nat, 0 < n → FirstCoefficientContraction n k →
    orbitOddCount n k ≤ 107 → shortcutIter k n = n + d →
    4 * d < orbitOddCount n k ∧ d ≤ (orbitOddCount n k - 1) / 4

end CollatzWork
