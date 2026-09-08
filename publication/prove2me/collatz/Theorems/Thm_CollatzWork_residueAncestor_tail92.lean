import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild



theorem CollatzWork.residueAncestor_tail92 (a : Nat) :
    0 < 6912 * a + 2612 ∧
    (6912 * a + 2612) % 27 = 20 ∧
    shortcutIter 8 (6912 * a + 2612) = 243 * a + 92 ∧
    9 * (6912 * a + 2612) + 44 = 256 * (243 * a + 92) ∧
    6912 * a + 2612 ≤ 64 * (243 * a + 92) := by sorry

