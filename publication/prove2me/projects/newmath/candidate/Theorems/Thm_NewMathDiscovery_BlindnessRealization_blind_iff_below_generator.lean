import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_BlindnessRealization



theorem NewMathDiscovery.BlindnessRealization.blind_iff_below_generator {I J : Type} (F : J → I → Bool)
    (S : I → Prop) :
    Blind S (State.observe F) State.target ↔
      ∃ j, ∀ i, S i → F j i = true := by sorry

