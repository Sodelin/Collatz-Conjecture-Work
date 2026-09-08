import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild



theorem CollatzWork.converges_shortcutIter_iff (r n : Nat) :
    Converges (shortcutIter r n) ↔ Converges n := by sorry

