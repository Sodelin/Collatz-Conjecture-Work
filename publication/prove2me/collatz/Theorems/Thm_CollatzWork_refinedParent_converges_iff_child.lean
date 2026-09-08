import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Theorems.Thm_CollatzWork_converges_iff_of_coalesces
import Theorems.Thm_CollatzWork_refinedMersenneChild_coalesces



theorem CollatzWork.refinedParent_converges_iff_child (L epsilon z : Nat) (hL : 2 ≤ L)
    (hepsilon : epsilon ≤ 1)
    (hparity : epsilon % 2 = L % 2) :
    Converges (refinedParent L epsilon z) ↔
      Converges (refinedChild L epsilon z) := by sorry

