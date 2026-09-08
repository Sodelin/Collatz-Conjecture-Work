import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_AffineRepetitionStatement
import Theorems.Thm_CollatzWork_noInfinitePositiveRecurrence
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
theorem solution : NoInfiniteExpandingAffineBlocksStatement := by
  intro b d c hcop hb x hpos h
  apply noInfinitePositiveRecurrence (b + d) b hcop hb (fun i => d * x i + c) hpos
  intro i
  exact affineRepetitionShift b d c (x i) (x (i + 1)) (h i)
