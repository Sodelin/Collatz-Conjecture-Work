import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_LinearBlindness



theorem NewMathDiscovery.LinearBlindness.pairBlind_downward {Index State Value : Type}
    (system : System Index State Value) {smaller larger : Index → Prop}
    (hsubset : ∀ i, smaller i → larger i)
    (hblind : PairBlind system larger) :
    PairBlind system smaller := by sorry

