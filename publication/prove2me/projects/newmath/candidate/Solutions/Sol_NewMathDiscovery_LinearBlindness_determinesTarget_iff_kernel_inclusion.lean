import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_LinearBlindness



open NewMathDiscovery.LinearBlindness in
theorem solution {Index State Value : Type}
    (system : System Index State Value) (selected : Index → Prop) :
    DeterminesTarget system selected ↔
      ∀ direction,
        InObservationKernel system selected direction →
          system.target direction = system.zeroValue := by
  constructor
  · intro hdetermines direction hkernel
    have hagree : ∀ i, selected i →
        system.observe i direction = system.observe i system.zeroState := by
      intro i hi
      rw [system.observe_zero]
      exact hkernel i hi
    have htarget := hdetermines direction system.zeroState hagree
    simpa only [system.target_zero] using htarget
  · intro hinclusion x y hagree
    have hkernel : InObservationKernel system selected
        (system.subState x y) := by
      intro i hi
      rw [system.observe_sub]
      exact (system.sub_eq_zero_iff _ _).2 (hagree i hi)
    have htargetZero := hinclusion (system.subState x y) hkernel
    rw [system.target_sub] at htargetZero
    exact (system.sub_eq_zero_iff _ _).1 htargetZero
