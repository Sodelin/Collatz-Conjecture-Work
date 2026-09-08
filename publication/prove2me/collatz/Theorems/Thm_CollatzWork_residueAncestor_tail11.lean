import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild



theorem CollatzWork.residueAncestor_tail11 (a : Nat) :
    0 < 1728 * a + 74 ∧
    (1728 * a + 74) % 27 = 20 ∧
    shortcutIter 6 (1728 * a + 74) = 243 * a + 11 ∧
    9 * (1728 * a + 74) + 38 = 64 * (243 * a + 11) ∧
    1728 * a + 74 ≤ 64 * (243 * a + 11) := by sorry

