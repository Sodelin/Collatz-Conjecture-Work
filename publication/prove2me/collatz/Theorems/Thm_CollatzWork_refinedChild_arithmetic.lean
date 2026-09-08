import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_RefinedMersenneChild



theorem CollatzWork.refinedChild_arithmetic (L epsilon z : Nat) (hL : 2 ≤ L) :
    0 < refinedParent L epsilon z ∧
    0 < refinedChild L epsilon z ∧
    refinedChild L epsilon z < refinedParent L epsilon z ∧
    refinedChild L epsilon z = (3 * refinedParent L epsilon z - 1) / 4 := by sorry

