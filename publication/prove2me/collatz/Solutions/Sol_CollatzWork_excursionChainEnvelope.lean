import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_ExcursionBudgetStatement
import Theorems.Thm_CollatzWork_shiftedEnvelope_compose



open CollatzWork in
theorem solution : ExcursionChainEnvelopeStatement := by
  intro segments
  induction segments with
  | nil =>
      intro root h
      simp [excursionDenominator, excursionNumerator, excursionSteps, shortcutIter]
  | cons s rest ih =>
      intro root h
      obtain ⟨hpos, hlocal, htail⟩ := h
      obtain ⟨htailBound, htailPos⟩ := ih (shortcutIter s.steps root) htail
      constructor
      · exact shiftedEnvelope_compose root s.steps (excursionSteps rest)
          s.numerator (excursionNumerator rest) s.denominator
          (excursionDenominator rest) hlocal htailBound
      · exact Nat.mul_pos hpos htailPos
