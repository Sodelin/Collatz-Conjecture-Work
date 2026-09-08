import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_ExcursionBudgetStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Theorems.Thm_CollatzWork_converges_shortcutIter_iff
import Theorems.Thm_CollatzWork_excursionChain_terminal_descent
namespace CollatzWork

/-!
An arbitrary finite list of actual-orbit envelopes composes relative to the
unchanged root. A terminal strict envelope plus an explicit half-margin budget
implies descent. The OOEO power inequalities, parity-word/CRT construction,
ancestor cancellation, and all-root coverage are NOT formalized by this file.
-/











private theorem excursion_positive_step (n : Nat) (hn : 0 < n) :
    0 < onceAccelerated n := by
  unfold onceAccelerated
  split <;> omega

private theorem excursion_positive_iter (steps root : Nat) (hroot : 0 < root) :
    0 < shortcutIter steps root := by
  induction steps generalizing root with
  | zero => exact hroot
  | succ steps ih => exact ih (onceAccelerated root) (excursion_positive_step root hroot)













end CollatzWork



open CollatzWork in
theorem solution (segments : List ExcursionSegment)
    (root steps B E : Nat) (hroot : 3 ≤ root)
    (hchain : ExcursionChain root segments)
    (hterminal : E * shortcutIter steps (shortcutIter (excursionSteps segments) root) <
      B * (shortcutIter (excursionSteps segments) root + 3))
    (hbudget : 2 * (excursionNumerator segments * B) ≤
      excursionDenominator segments * E)
    (ih : ∀ m : Nat, 0 < m → m < root → Converges m) : Converges root := by
  have hsmall := excursionChain_terminal_descent segments root steps B E
    hroot hchain hterminal hbudget
  exact (converges_shortcutIter_iff (excursionSteps segments + steps) root).mp
    (ih _ (excursion_positive_iter _ root (by omega)) hsmall)
