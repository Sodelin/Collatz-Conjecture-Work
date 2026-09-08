import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_Disproof_BranchingCenter



theorem CollatzWork.Disproof.BranchingCenter.centerTwoPowerOddNormalFormUnique :
    ∀ R S A B : Nat,
      CenterOdd A → CenterOdd B →
      2 ^ R * A = 2 ^ S * B →
      R = S ∧ A = B := by sorry

