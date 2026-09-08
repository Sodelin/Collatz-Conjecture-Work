import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Theorems.Thm_CollatzWork_refinedParent_iter
import Theorems.Thm_CollatzWork_refinedChild_iter



open CollatzWork in
theorem solution (L epsilon z : Nat) (hL : 2 ≤ L)
    (hepsilon : epsilon ≤ 1)
    (hparity : epsilon % 2 = L % 2) :
    shortcutIter (L + 2) (refinedParent L epsilon z) =
      shortcutIter L (refinedChild L epsilon z) := by
  rw [refinedParent_iter L epsilon z hepsilon hparity,
    refinedChild_iter L epsilon z hL hepsilon hparity]
