import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_ResidueAncestorStatement
import Theorems.Thm_CollatzWork_residueAncestor
import Theorems.Thm_CollatzWork_residueAncestor_factor_unit



open CollatzWork in
theorem solution : ResidueAncestorDivisibilityStatement := by
  intro r hdiv
  obtain ⟨a, ha⟩ := hdiv
  have ha0 : a ≠ 0 := by
    intro hzero
    rw [hzero, Nat.mul_zero] at ha
    omega
  obtain ⟨e, u, hu, hunit, he⟩ :=
    residueAncestor_factor_unit a (Nat.pos_of_ne_zero ha0)
  apply residueAncestor (13 + e) u r (by omega) hu hunit
  rw [Nat.pow_add, Nat.mul_assoc, he]
  exact ha.symm
