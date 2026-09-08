import Std
import Init.Grind.Ordered.Module
import Theorems.Thm_BlindCollatz_RepetitionBound_telescope



theorem BlindCollatz.RepetitionBound.affine_repetition_bound (b d c : Nat)
    (hcop : b.Coprime (b + d)) (x : Nat → Nat)
    (hpos : 0 < d * x 0 + c) (k : Nat)
    (h : ∀ i, i < k → b * x (i + 1) = (b + d) * x i + c) :
    b ^ k ≤ d * x 0 + c := by sorry

