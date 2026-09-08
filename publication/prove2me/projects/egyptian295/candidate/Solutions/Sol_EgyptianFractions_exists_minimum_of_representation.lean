import Std
import Init.Grind.Ordered.Module
import Definitions.Def_EgyptianFractions_Certificate



open EgyptianFractions in
theorem solution {lower terms : Nat}
    (hRepresentation : HasRepresentation lower terms) :
    ∃ minimum, IsMinimumLength lower minimum := by
  classical
  have least : ∀ n, HasRepresentation lower n →
      ∃ minimum, IsMinimumLength lower minimum := by
    intro n
    induction n using Nat.strongRecOn with
    | ind n ih =>
      intro hCurrent
      by_cases hSmaller : ∃ m, m < n ∧ HasRepresentation lower m
      · obtain ⟨m, hLess, hRep⟩ := hSmaller
        exact ih m hLess hRep
      · refine ⟨n, hCurrent, ?_⟩
        intro m hRep
        exact Nat.le_of_not_gt (fun hLess => hSmaller ⟨m, hLess, hRep⟩)
  exact least terms hRepresentation
