import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_BlindnessRealization



open NewMathDiscovery.BlindnessRealization in
theorem solution {I J : Type} (F : J → I → Bool)
    (S : I → Prop) :
    Blind S (State.observe F) State.target ↔
      ∃ j, ∀ i, S i → F j i = true := by
  constructor
  · rintro ⟨x, y, htarget, hagree⟩
    cases x with
    | base =>
        cases y with
        | base => exact False.elim (htarget rfl)
        | face j =>
            refine ⟨j, ?_⟩
            intro i hi
            have hobs := hagree i hi
            simp [State.observe] at hobs
            cases hF : F j i <;> simp [hF] at hobs ⊢
    | face j =>
        cases y with
        | base =>
            refine ⟨j, ?_⟩
            intro i hi
            have hobs := hagree i hi
            simp [State.observe] at hobs
            cases hF : F j i <;> simp [hF] at hobs ⊢
        | face k => exact False.elim (htarget rfl)
  · rintro ⟨j, hj⟩
    refine ⟨State.base, State.face j, by simp [State.target], ?_⟩
    intro i hi
    simp [State.observe, hj i hi]
