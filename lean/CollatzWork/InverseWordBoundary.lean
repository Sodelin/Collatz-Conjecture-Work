import CollatzWork.InverseWordBoundaryStatement
import Std.Tactic

namespace CollatzWork

/-- Whole-family proof of the corrected equal-slope affine criterion. -/
theorem equalSlopeSmaller : EqualSlopeSmallerStatement := by
  intro A B R
  constructor
  · intro h
    simpa using h 0
  · intro h x
    exact Nat.add_lt_add_left h (A * x)

/-- Exact type-checked replay of the `8x+5` / `8x+4` boundary witness. -/
theorem equalSlopeWitness : EqualSlopeWitnessStatement := by
  intro x
  have hn1 : onceAccelerated (8 * x + 5) = 12 * x + 8 := by
    rw [onceAccelerated]
    have hodd : (8 * x + 5) % 2 ≠ 0 := by omega
    simp [hodd]
    omega
  have hn2 : onceAccelerated (12 * x + 8) = 6 * x + 4 := by
    rw [onceAccelerated]
    have heven : (12 * x + 8) % 2 = 0 := by omega
    simp [heven]
    omega
  have hn3 : onceAccelerated (6 * x + 4) = 3 * x + 2 := by
    rw [onceAccelerated]
    have heven : (6 * x + 4) % 2 = 0 := by omega
    simp [heven]
    omega
  have hm1 : onceAccelerated (8 * x + 4) = 4 * x + 2 := by
    rw [onceAccelerated]
    have heven : (8 * x + 4) % 2 = 0 := by omega
    simp [heven]
    omega
  have hm2 : onceAccelerated (4 * x + 2) = 2 * x + 1 := by
    rw [onceAccelerated]
    have heven : (4 * x + 2) % 2 = 0 := by omega
    simp [heven]
    omega
  have hm3 : onceAccelerated (2 * x + 1) = 3 * x + 2 := by
    rw [onceAccelerated]
    simp
    omega
  simp [hn1, hn2, hn3, hm1, hm2, hm3]

#print axioms CollatzWork.equalSlopeSmaller
#print axioms CollatzWork.equalSlopeWitness

end CollatzWork
