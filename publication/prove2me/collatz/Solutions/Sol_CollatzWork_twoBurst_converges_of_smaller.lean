import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Theorems.Thm_CollatzWork_converges_shortcutIter_iff
import Theorems.Thm_CollatzWork_twoBurstDescent



open CollatzWork in
theorem solution (k l u v m : Nat)
    (hk : 0 < k) (hl : 0 < l) (hu : 0 < u) (hv : 0 < v) (hm : 0 < m)
    (hrecharge : 9 ^ k * u + 1 = 2 ^ (3 * l + 1) * v)
    (hexit : 2 ^ (k + l) * m + 5 = 3 * 9 ^ l * v)
    (ih : ∀ a : Nat, 0 < a → a < 2 * 8 ^ k * u - 5 → Converges a) :
    Converges (2 * 8 ^ k * u - 5) := by
  obtain ⟨hiter, hlt⟩ := twoBurstDescent k l u v m hk hl hu hv hm hrecharge hexit
  exact (converges_shortcutIter_iff (4 * (k + l) + 2) (2 * 8 ^ k * u - 5)).mp
    (by rw [hiter]; exact ih m hm hlt)
