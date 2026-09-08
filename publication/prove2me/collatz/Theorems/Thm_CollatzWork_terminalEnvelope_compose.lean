import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild



theorem CollatzWork.terminalEnvelope_compose (root k l A B D E : Nat) (hD : 0 < D)
    (hprefix : D * (shortcutIter k root + 3) ≤ A * (root + 3))
    (hterminal : E * shortcutIter l (shortcutIter k root) <
      B * (shortcutIter k root + 3)) :
    (D * E) * shortcutIter (k + l) root < (A * B) * (root + 3) := by sorry

