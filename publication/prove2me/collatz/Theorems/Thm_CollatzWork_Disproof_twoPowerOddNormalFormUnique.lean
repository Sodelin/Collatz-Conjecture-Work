import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_Disproof_PolynomialRatchet



theorem CollatzWork.Disproof.twoPowerOddNormalFormUnique :
    ∀ R S A B : Nat,
      ArithOdd A → ArithOdd B →
      2 ^ R * A = 2 ^ S * B →
      R = S ∧ A = B := by sorry

