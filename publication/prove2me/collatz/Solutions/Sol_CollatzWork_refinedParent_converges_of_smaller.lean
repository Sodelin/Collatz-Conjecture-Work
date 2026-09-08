import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Theorems.Thm_CollatzWork_refinedParent_converges_iff_child
import Theorems.Thm_CollatzWork_refinedChild_arithmetic



open CollatzWork in
theorem solution (L epsilon z : Nat)
    (hL : 2 ≤ L) (hepsilon : epsilon ≤ 1)
    (hparity : epsilon % 2 = L % 2)
    (ih : ∀ m : Nat, 0 < m → m < refinedParent L epsilon z → Converges m) :
    Converges (refinedParent L epsilon z) := by
  have harith := refinedChild_arithmetic L epsilon z hL
  exact (refinedParent_converges_iff_child L epsilon z hL hepsilon hparity).mpr
    (ih (refinedChild L epsilon z) harith.2.1 harith.2.2.1)
