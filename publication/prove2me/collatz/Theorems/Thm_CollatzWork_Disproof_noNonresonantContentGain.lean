import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_Disproof_PolynomialRatchet
import Theorems.Thm_CollatzWork_Disproof_twoPowerOddNormalFormUnique



theorem CollatzWork.Disproof.noNonresonantContentGain
    (d Q K R H p E : Nat)
    (hHodd : ArithOdd H)
    (hLead : 2 ^ R * 3 ^ (d * Q) = 2 ^ (d * K) * H)
    (hp : 1 < p)
    (hp3 : Nat.Coprime p 3)
    (hE : 0 < E)
    (hGain : p ^ E ∣ H) : False := by sorry

