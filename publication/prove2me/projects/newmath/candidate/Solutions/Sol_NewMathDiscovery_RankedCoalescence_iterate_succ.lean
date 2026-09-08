import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_RankedCoalescenceSound



open NewMathDiscovery.RankedCoalescence in
@[simp]
theorem solution {α : Type} (f : α → α) (k : Nat) (x : α) :
    iterate f (k + 1) x = f (iterate f k x) := rfl
