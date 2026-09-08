import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule

open CollatzWork.YAH in
theorem solution :
    ∀ name ∈ allRuleNames, ∀ tail : Bool,
      evalWord (rule name).lhs tail = evalWord (rule name).rhs tail := by
  intro name hname tail
  cases name <;> cases tail <;> decide
