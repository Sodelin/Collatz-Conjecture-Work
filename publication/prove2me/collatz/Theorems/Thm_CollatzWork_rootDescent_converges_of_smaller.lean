import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Theorems.Thm_CollatzWork_converges_shortcutIter_iff
import Theorems.Thm_CollatzWork_rootDescent



theorem CollatzWork.rootDescent_converges_of_smaller (k u m : Nat)
    (hk : 0 < k) (hu : 0 < u) (hm : 0 < m)
    (hguard : 2 ^ k * m + 5 = 9 ^ k * u)
    (ih : ∀ a : Nat, 0 < a → a < 8 ^ k * u - 5 → Converges a) :
    Converges (8 ^ k * u - 5) := by sorry

