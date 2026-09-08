import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_ExcursionBudgetStatement
import Theorems.Thm_CollatzWork_excursionChainEnvelope
import Theorems.Thm_CollatzWork_terminalEnvelope_compose
import Theorems.Thm_CollatzWork_excursionBudgetDescent



theorem CollatzWork.excursionChain_terminal_descent (segments : List ExcursionSegment)
    (root steps B E : Nat) (hroot : 3 ≤ root)
    (hchain : ExcursionChain root segments)
    (hterminal : E * shortcutIter steps (shortcutIter (excursionSteps segments) root) <
      B * (shortcutIter (excursionSteps segments) root + 3))
    (hbudget : 2 * (excursionNumerator segments * B) ≤
      excursionDenominator segments * E) :
    shortcutIter (excursionSteps segments + steps) root < root := by sorry

