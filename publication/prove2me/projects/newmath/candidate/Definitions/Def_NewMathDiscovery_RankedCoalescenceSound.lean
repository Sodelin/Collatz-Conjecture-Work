import Std
import Init.Grind.Ordered.Module
namespace NewMathDiscovery.RankedCoalescence

/-- Exact finite iteration, with the zeroth iterate equal to the input. -/
def iterate {α : Type} (f : α → α) : Nat → α → α
  | 0 => fun x => x
  | k + 1 => fun x => f (iterate f k x)









/-- `x` reaches the distinguished terminal element under finite iteration. -/
def Reaches {α : Type} (f : α → α) (one x : α) : Prop :=
  ∃ k : Nat, iterate f k x = one















end NewMathDiscovery.RankedCoalescence
