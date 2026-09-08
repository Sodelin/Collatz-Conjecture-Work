import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ResidueAncestorStatement
import Theorems.Thm_CollatzWork_residueAncestor_normalized



open CollatzWork in
theorem solution : ResidueAncestorStatement := by
  intro v u r hv hu hunit hguard
  have hvform : v = (v - 3) + 3 := by omega
  rw [hvform] at hguard
  exact residueAncestor_normalized (v - 3) u r (by omega) hu hunit hguard
