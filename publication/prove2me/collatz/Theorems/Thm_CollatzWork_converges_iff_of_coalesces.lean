import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Theorems.Thm_CollatzWork_converges_shortcutIter_iff



theorem CollatzWork.converges_iff_of_coalesces {n m r s : Nat}
    (h : shortcutIter r n = shortcutIter s m) :
    Converges n ↔ Converges m := by sorry

