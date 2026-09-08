import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Theorems.Thm_CollatzWork_converges_shortcutIter_iff



open CollatzWork in
theorem solution {n m r s : Nat}
    (h : shortcutIter r n = shortcutIter s m) :
    Converges n ↔ Converges m := by
  calc
    Converges n ↔ Converges (shortcutIter r n) :=
      (converges_shortcutIter_iff r n).symm
    _ ↔ Converges (shortcutIter s m) := by rw [h]
    _ ↔ Converges m := converges_shortcutIter_iff s m
