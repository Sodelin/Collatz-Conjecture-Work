import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_ExcursionBudgetStatement



open CollatzWork in
theorem solution : ExcursionBudgetDescentStatement := by
  intro root steps A D hroot henvelope hbudget
  have hshift : root + 3 ≤ 2 * root := by omega
  have hcompare : D * shortcutIter steps root < D * root := by
    calc
      D * shortcutIter steps root < A * (root + 3) := henvelope
      _ ≤ A * (2 * root) := Nat.mul_le_mul_left A hshift
      _ = (2 * A) * root := by ac_rfl
      _ ≤ D * root := Nat.mul_le_mul_right root hbudget
  exact Nat.lt_of_mul_lt_mul_left hcompare
