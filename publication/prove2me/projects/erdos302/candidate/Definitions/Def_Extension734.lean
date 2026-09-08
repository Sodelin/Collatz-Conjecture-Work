import Std
import Init.Grind.Ordered.Module
import Definitions.Def_Plateau302
/-! Exact maximum transfers through 734. The numerical corollaries retain an explicit external baseline. -/

namespace Erdos302Extension734
open Erdos302Finite



def fullCardinal (S : Nat → Bool) : Nat :=
 cardinal S + (S 733).toNat + (S 734).toNat

def fullDomain : List Nat := (outside ++ gadget) ++ [733,734]









def trim (S : Nat → Bool) (x : Nat) : Bool := S x && decide (x ≤ 732)
def liftTo (S : Nat → Bool) (n x : Nat) : Bool :=
 if x ≤ 732 then S x else (x == 733 || x == 734) && decide (x ≤ n)

















def FullExactMaximum (n k : Nat) : Prop :=
 (∃ S : Nat → Bool, Admissible n S ∧ fullCardinal S = k) ∧
 (∀ S : Nat → Bool, Admissible n S → fullCardinal S ≤ k)





-- These numerical conclusions have an explicit external 731 baseline premise.












def add734 (S : Nat → Bool) (x : Nat) : Bool := if x = 734 then true else S x
def erase734 (S : Nat → Bool) (x : Nat) : Bool := if x = 734 then false else S x

















end Erdos302Extension734
