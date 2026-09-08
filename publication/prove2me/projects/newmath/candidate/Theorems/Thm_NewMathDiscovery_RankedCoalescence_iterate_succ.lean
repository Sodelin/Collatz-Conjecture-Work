import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_RankedCoalescenceSound



@[simp]
theorem NewMathDiscovery.RankedCoalescence.iterate_succ {α : Type} (f : α → α) (k : Nat) (x : α) :
    iterate f (k + 1) x = f (iterate f k x) := by sorry

