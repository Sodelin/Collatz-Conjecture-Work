import Std
import Init.Grind.Ordered.Module
import Definitions.Def_ArchiveAlternatingGrowth



open BlindCollatz.AlternatingGrowth in
theorem solution (q : Nat) :
    ordinarySteps 5 (16 * q + 11) = 18 * q + 13 := by
  have h₁ : ordinaryStep (16 * q + 11) = 48 * q + 34 := by
    simp only [ordinaryStep, show (16 * q + 11) % 2 ≠ 0 by omega, if_false]
    omega
  have h₂ : ordinaryStep (48 * q + 34) = 24 * q + 17 := by
    simp only [ordinaryStep, show (48 * q + 34) % 2 = 0 by omega, if_true]
    omega
  have h₃ : ordinaryStep (24 * q + 17) = 72 * q + 52 := by
    simp only [ordinaryStep, show (24 * q + 17) % 2 ≠ 0 by omega, if_false]
    omega
  have h₄ : ordinaryStep (72 * q + 52) = 36 * q + 26 := by
    simp only [ordinaryStep, show (72 * q + 52) % 2 = 0 by omega, if_true]
    omega
  have h₅ : ordinaryStep (36 * q + 26) = 18 * q + 13 := by
    simp only [ordinaryStep, show (36 * q + 26) % 2 = 0 by omega, if_true]
    omega
  simp [ordinarySteps, h₁, h₂, h₃, h₄, h₅]
