import Std
import Init.Grind.Ordered.Module



theorem CollatzWork.affineRecurrenceTelescope (a b : Nat) (y : Nat → Nat) (k : Nat)
    (h : ∀ i, i < k → b * y (i + 1) = a * y i) :
    b ^ k * y k = a ^ k * y 0 := by sorry

