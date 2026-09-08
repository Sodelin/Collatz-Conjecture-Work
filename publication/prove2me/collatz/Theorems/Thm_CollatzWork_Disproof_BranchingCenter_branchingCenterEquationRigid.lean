import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_Disproof_BranchingCenter
import Theorems.Thm_CollatzWork_Disproof_BranchingCenter_centerTwoPowerOddNormalFormUnique



theorem CollatzWork.Disproof.BranchingCenter.branchingCenterEquationRigid
    (a b c : Nat)
    (_ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hEq : 2 ^ (b + c) + 3 * 2 ^ b =
      2 ^ (a + b) + 3 * 2 ^ a) :
    a = b ∧ b = c := by sorry

