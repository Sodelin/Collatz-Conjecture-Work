import Std
import Init.Grind.Ordered.Module
import Definitions.Def_Extension734
import Definitions.Def_Plateau302

open Erdos302Finite

open Erdos302Extension734 in
theorem solution (S : Nat → Bool) :
 fullCardinal S = (fullDomain.filter S).length := by
 cases h1 : S 733 <;> cases h2 : S 734 <;> simp [fullCardinal, fullDomain, cardinal, h1, h2] <;> omega
