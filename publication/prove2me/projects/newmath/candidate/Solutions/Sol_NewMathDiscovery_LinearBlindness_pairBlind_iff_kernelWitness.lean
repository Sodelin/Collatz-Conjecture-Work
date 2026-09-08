import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_LinearBlindness



open NewMathDiscovery.LinearBlindness in
theorem solution {Index State Value : Type}
    (system : System Index State Value) (selected : Index → Prop) :
    PairBlind system selected ↔ KernelWitness system selected := by
  constructor
  · rintro ⟨x, y, htarget, hagree⟩
    refine ⟨system.subState x y, ?_, ?_⟩
    · intro i hi
      rw [system.observe_sub]
      exact (system.sub_eq_zero_iff _ _).2 (hagree i hi)
    · rw [system.target_sub]
      intro hzero
      exact htarget ((system.sub_eq_zero_iff _ _).1 hzero)
  · rintro ⟨direction, hkernel, htarget⟩
    refine ⟨direction, system.zeroState, ?_, ?_⟩
    · simpa only [system.target_zero] using htarget
    · intro i hi
      simpa only [system.observe_zero] using hkernel i hi
