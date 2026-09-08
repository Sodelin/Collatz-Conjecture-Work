import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_BlindnessRealization
import Theorems.Thm_NewMathDiscovery_BlindnessRealization_blind_iff_below_generator



theorem NewMathDiscovery.BlindnessRealization.blind_downward {I J : Type} (F : J → I → Bool)
    {S T : I → Prop}
    (hsub : ∀ i, S i → T i)
    (hblind : Blind T (State.observe F) State.target) :
    Blind S (State.observe F) State.target := by sorry

