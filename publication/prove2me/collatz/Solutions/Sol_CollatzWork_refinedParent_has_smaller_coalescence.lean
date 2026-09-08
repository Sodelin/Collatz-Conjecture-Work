import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Theorems.Thm_CollatzWork_refinedChild_arithmetic
import Theorems.Thm_CollatzWork_refinedMersenneChild_coalesces



open CollatzWork in
theorem solution (L epsilon z : Nat)
    (hL : 2 ≤ L) (hepsilon : epsilon ≤ 1)
    (hparity : epsilon % 2 = L % 2) :
    ∃ m : Nat, 0 < m ∧ m < refinedParent L epsilon z ∧
      ∃ r s : Nat,
        shortcutIter r (refinedParent L epsilon z) = shortcutIter s m := by
  have harith := refinedChild_arithmetic L epsilon z hL
  exact ⟨refinedChild L epsilon z, harith.2.1, harith.2.2.1,
    L + 2, L, refinedMersenneChild_coalesces L epsilon z hL hepsilon hparity⟩
