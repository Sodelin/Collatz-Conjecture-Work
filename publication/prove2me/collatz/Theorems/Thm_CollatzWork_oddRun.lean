import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild



theorem CollatzWork.oddRun (h q : Nat) (hq : 0 < q) :
    shortcutIter h (2 ^ h * q - 1) = 3 ^ h * q - 1 := by sorry

