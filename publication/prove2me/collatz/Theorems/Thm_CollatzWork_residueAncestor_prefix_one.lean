import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Theorems.Thm_CollatzWork_rootDescentAncestor



theorem CollatzWork.residueAncestor_prefix_one (k u r : Nat) (hu : 0 < u)
    (hguard : 3 ^ (k + 3) * u = 4 * r + 1) :
    shortcutIter (k + 3) (6 * (2 ^ k * u) - 1) = r := by sorry

