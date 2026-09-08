import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Theorems.Thm_CollatzWork_oddRun



theorem CollatzWork.mersenne_prefix_nondecreasing (L q : Nat) (hq : 0 < q) :
    ∀ k, k < L →
      shortcutIter k (2 ^ L * q - 1) ≤
      shortcutIter (k + 1) (2 ^ L * q - 1) := by sorry

