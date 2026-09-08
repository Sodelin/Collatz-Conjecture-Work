import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_LinearBlindness



open NewMathDiscovery.LinearBlindness in
theorem solution {Index State Value : Type}
    (system : System Index State Value) {smaller larger : Index → Prop}
    (hsubset : ∀ i, smaller i → larger i)
    (hblind : PairBlind system larger) :
    PairBlind system smaller := by
  obtain ⟨x, y, htarget, hagree⟩ := hblind
  exact ⟨x, y, htarget, fun i hi => hagree i (hsubset i hi)⟩
