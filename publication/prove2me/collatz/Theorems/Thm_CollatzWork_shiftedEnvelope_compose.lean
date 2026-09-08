import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild



theorem CollatzWork.shiftedEnvelope_compose (root k l A B D E : Nat)
    (hfirst : D * (shortcutIter k root + 3) ≤ A * (root + 3))
    (hsecond : E * (shortcutIter l (shortcutIter k root) + 3) ≤
      B * (shortcutIter k root + 3)) :
    (D * E) * (shortcutIter (k + l) root + 3) ≤
      (A * B) * (root + 3) := by sorry

