import Std
import Init.Grind.Ordered.Module
import Theorems.Thm_BlindCollatz_RepetitionBound_telescope



theorem BlindCollatz.RepetitionBound.alternating_repetition_bound (x : Nat → Nat) (k : Nat)
    (h : ∀ i, i < k → 8 * x (i + 1) = 9 * x i + 5) :
    8 ^ k ≤ x 0 + 5 := by sorry

