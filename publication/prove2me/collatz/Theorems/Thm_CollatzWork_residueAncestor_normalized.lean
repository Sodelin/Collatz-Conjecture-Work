import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Theorems.Thm_CollatzWork_residueAncestor_prefix_one
import Theorems.Thm_CollatzWork_residueAncestor_prefix_two
import Theorems.Thm_CollatzWork_residueAncestor_refinedTail



theorem CollatzWork.residueAncestor_normalized (k u r : Nat) (hk : 10 ≤ k)
    (hu : 0 < u) (hunit : u % 3 ≠ 0)
    (hguard : 3 ^ (k + 3) * u = 4 * r + 1) :
    ∃ m b : Nat, 0 < m ∧ m < r ∧ m % 27 = 20 ∧ shortcutIter b m = r := by sorry

