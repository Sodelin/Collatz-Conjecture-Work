import Std
import Init.Grind.Ordered.Module



theorem CollatzWork.twoBurst_power_margin (j l : Nat) :
    3 * 9 ^ (j + l + 1) + 3 * 9 ^ l +
        10 * 8 ^ l * 2 ^ (j + l + 1) < 4 * 16 ^ (j + l + 1) := by sorry

