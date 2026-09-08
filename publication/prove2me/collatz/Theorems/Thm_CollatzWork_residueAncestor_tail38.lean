import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild



theorem CollatzWork.residueAncestor_tail38 (a : Nat) :
    0 < 216 * a + 101 ∧
    (216 * a + 101) % 27 = 20 ∧
    shortcutIter 3 (216 * a + 101) = 81 * a + 38 ∧
    3 * (216 * a + 101) + 1 = 8 * (81 * a + 38) ∧
    216 * a + 101 ≤ 64 * (81 * a + 38) := by sorry

