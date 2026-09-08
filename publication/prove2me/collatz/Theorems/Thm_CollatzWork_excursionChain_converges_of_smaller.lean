import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_ExcursionBudgetStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Theorems.Thm_CollatzWork_converges_shortcutIter_iff
import Theorems.Thm_CollatzWork_excursionChain_terminal_descent



theorem CollatzWork.excursionChain_converges_of_smaller (segments : List ExcursionSegment)
    (root steps B E : Nat) (hroot : 3 ≤ root)
    (hchain : ExcursionChain root segments)
    (hterminal : E * shortcutIter steps (shortcutIter (excursionSteps segments) root) <
      B * (shortcutIter (excursionSteps segments) root + 3))
    (hbudget : 2 * (excursionNumerator segments * B) ≤
      excursionDenominator segments * E)
    (ih : ∀ m : Nat, 0 < m → m < root → Converges m) : Converges root := by sorry

