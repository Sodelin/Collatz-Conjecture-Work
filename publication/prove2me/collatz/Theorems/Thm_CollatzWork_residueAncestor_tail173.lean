import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild



theorem CollatzWork.residueAncestor_tail173 (a : Nat) :
    0 < 864 * a + 614 ∧
    (864 * a + 614) % 27 = 20 ∧
    shortcutIter 5 (864 * a + 614) = 243 * a + 173 ∧
    9 * (864 * a + 614) + 10 = 32 * (243 * a + 173) ∧
    864 * a + 614 ≤ 64 * (243 * a + 173) := by sorry

