import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_AffineRepetitionStatement
import Theorems.Thm_CollatzWork_fixedRatioDivisibility



open CollatzWork in
theorem solution : FiniteRepetitionBoundStatement := by
  intro a b hab y hpos k h
  exact Nat.le_of_dvd hpos (fixedRatioDivisibility a b hab y k h)
