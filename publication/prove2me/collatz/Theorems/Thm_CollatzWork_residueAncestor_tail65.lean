import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild



theorem CollatzWork.residueAncestor_tail65 (a : Nat) :
    0 < 432 * a + 344 ∧
    (432 * a + 344) % 27 = 20 ∧
    shortcutIter 4 (432 * a + 344) = 81 * a + 65 ∧
    3 * (432 * a + 344) + 8 = 16 * (81 * a + 65) ∧
    432 * a + 344 ≤ 64 * (81 * a + 65) := by sorry

