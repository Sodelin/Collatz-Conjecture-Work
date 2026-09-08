import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Theorems.Thm_CollatzWork_oddRun
import Theorems.Thm_CollatzWork_compatibleProduct_mod_four



theorem CollatzWork.refinedChild_iter (L epsilon z : Nat) (hL : 2 ≤ L)
    (hepsilon : epsilon ≤ 1)
    (hparity : epsilon % 2 = L % 2) :
    shortcutIter L (refinedChild L epsilon z) =
      (3 ^ L * refinedA epsilon z - 1) / 4 := by sorry

