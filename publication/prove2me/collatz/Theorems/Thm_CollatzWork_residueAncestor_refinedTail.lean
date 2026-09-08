import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Theorems.Thm_CollatzWork_residueAncestor_tail38
import Theorems.Thm_CollatzWork_residueAncestor_tail65
import Theorems.Thm_CollatzWork_residueAncestor_tail11
import Theorems.Thm_CollatzWork_residueAncestor_tail92
import Theorems.Thm_CollatzWork_residueAncestor_tail173



theorem CollatzWork.residueAncestor_refinedTail (z : Nat) (hz : z % 27 = 11) :
    ∃ m b : Nat, 0 < m ∧ m % 27 = 20 ∧
      shortcutIter b m = z ∧ m ≤ 64 * z := by sorry

