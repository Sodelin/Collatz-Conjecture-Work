import Std
import Init.Grind.Ordered.Module
import Theorems.Thm_BlindCollatz_RepetitionBound_telescope



theorem BlindCollatz.RepetitionBound.no_infinite_alternating_blocks (x : Nat → Nat) :
    ¬ (∀ i, 8 * x (i + 1) = 9 * x i + 5) := by sorry

