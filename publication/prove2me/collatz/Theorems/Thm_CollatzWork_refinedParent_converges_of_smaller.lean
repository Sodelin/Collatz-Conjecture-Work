import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Theorems.Thm_CollatzWork_refinedParent_converges_iff_child
import Theorems.Thm_CollatzWork_refinedChild_arithmetic



theorem CollatzWork.refinedParent_converges_of_smaller (L epsilon z : Nat)
    (hL : 2 ≤ L) (hepsilon : epsilon ≤ 1)
    (hparity : epsilon % 2 = L % 2)
    (ih : ∀ m : Nat, 0 < m → m < refinedParent L epsilon z → Converges m) :
    Converges (refinedParent L epsilon z) := by sorry

