import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_ExcursionBudgetStatement
import Theorems.Thm_CollatzWork_excursionChainEnvelope
import Theorems.Thm_CollatzWork_terminalEnvelope_compose
import Theorems.Thm_CollatzWork_excursionBudgetDescent



open CollatzWork in
theorem solution (segments : List ExcursionSegment)
    (root steps B E : Nat) (hroot : 3 ≤ root)
    (hchain : ExcursionChain root segments)
    (hterminal : E * shortcutIter steps (shortcutIter (excursionSteps segments) root) <
      B * (shortcutIter (excursionSteps segments) root + 3))
    (hbudget : 2 * (excursionNumerator segments * B) ≤
      excursionDenominator segments * E) :
    shortcutIter (excursionSteps segments + steps) root < root := by
  obtain ⟨hprefix, hD⟩ := excursionChainEnvelope segments root hchain
  exact excursionBudgetDescent root (excursionSteps segments + steps)
    (excursionNumerator segments * B) (excursionDenominator segments * E) hroot
    (terminalEnvelope_compose root (excursionSteps segments) steps
      (excursionNumerator segments) B (excursionDenominator segments) E
      hD hprefix hterminal) hbudget
