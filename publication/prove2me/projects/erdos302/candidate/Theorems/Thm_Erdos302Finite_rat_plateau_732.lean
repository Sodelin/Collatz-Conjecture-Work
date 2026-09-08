import Std
import Init.Grind.Ordered.Module
import Definitions.Def_Plateau302
import Theorems.Thm_Erdos302Finite_replacement_admissible
import Theorems.Thm_Erdos302Finite_replacement_cardinal



theorem Erdos302Finite.rat_plateau_732 (k : Nat) :
 (∃ S : Nat → Bool, RatAdmissible 732 S ∧ k ≤ cardinal S) ↔
 (∃ S : Nat → Bool, RatAdmissible 731 S ∧ k ≤ cardinal S) := by sorry

