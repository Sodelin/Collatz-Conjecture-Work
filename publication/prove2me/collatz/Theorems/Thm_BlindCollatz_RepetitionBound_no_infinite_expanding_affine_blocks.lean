import Std
import Init.Grind.Ordered.Module
import Theorems.Thm_BlindCollatz_RepetitionBound_telescope



theorem BlindCollatz.RepetitionBound.no_infinite_expanding_affine_blocks (b d c : Nat)
    (hcop : b.Coprime (b + d)) (hb : 1 < b) (x : Nat → Nat)
    (hpos : 0 < d * x 0 + c) :
    ¬ (∀ i, b * x (i + 1) = (b + d) * x i + c) := by sorry

