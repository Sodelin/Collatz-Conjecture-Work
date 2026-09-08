import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild



open CollatzWork in
theorem solution (z : Nat) :
    shortcutIter 3 (8 * z + 3) = 9 * z + 4 := by
  have hfirst : onceAccelerated (8 * z + 3) = 12 * z + 5 := by
    unfold onceAccelerated
    have hodd : (8 * z + 3) % 2 ≠ 0 := by omega
    simp only [hodd, ↓reduceIte]
    omega
  have hsecond : onceAccelerated (12 * z + 5) = 18 * z + 8 := by
    unfold onceAccelerated
    have hodd : (12 * z + 5) % 2 ≠ 0 := by omega
    simp only [hodd, ↓reduceIte]
    omega
  have hthird : onceAccelerated (18 * z + 8) = 9 * z + 4 := by
    rw [show 18 * z + 8 = 2 * (9 * z + 4) by omega]
    exact onceAccelerated_two_mul _
  simp only [shortcutIter, hfirst, hsecond, hthird]
