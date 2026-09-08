import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_AffineRepetitionStatement
import Theorems.Thm_CollatzWork_finiteRepetitionBound
namespace CollatzWork









/-- A rational-affine block becomes multiplicative after an integral shift. -/
theorem affineRepetitionShift (b d c x z : Nat)
    (h : b * z = (b + d) * x + c) :
    b * (d * z + c) = (b + d) * (d * x + c) := by
  calc
    b * (d * z + c) = d * (b * z) + b * c := by
      rw [Nat.mul_add]
      congr 1
      ac_rfl
    _ = d * ((b + d) * x + c) + b * c := by rw [h]
    _ = (b + d) * (d * x + c) := by
      simp only [Nat.mul_add, Nat.add_mul]
      ac_rfl























end CollatzWork



open CollatzWork in
theorem solution : AffineRepetitionBoundStatement := by
  intro b d c hcop x hpos k h
  apply finiteRepetitionBound (b + d) b hcop (fun i => d * x i + c) hpos k
  intro i hi
  exact affineRepetitionShift b d c (x i) (x (i + 1)) (h i hi)
