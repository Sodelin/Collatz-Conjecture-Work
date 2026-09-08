import Std
import Init.Grind.Ordered.Module
import Definitions.Def_Extension734
import Definitions.Def_KernelEndpoints734
import Definitions.Def_Plateau302

open Erdos302Finite

theorem Erdos302Extension734.lift_admissible (S : Nat → Bool) (n : Nat)
 (hnlo : 732 ≤ n) (hnhi : n ≤ 734) (hS : Admissible 732 S) :
 Admissible n (liftTo S n) := by sorry

