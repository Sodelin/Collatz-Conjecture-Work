import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_LinearBlindness



theorem NewMathDiscovery.LinearBlindness.RankTwoInstability.tail_witnesses_uniformly_large (offset index : Nat) :
    observe (offset + index) (witness (offset + index)) = 0 ∧
    (witness (offset + index)).2 = -1 ∧
    target (witness (offset + index)) > Int.ofNat offset := by sorry

