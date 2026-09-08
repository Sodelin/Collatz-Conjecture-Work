import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule

theorem CollatzWork.YAH.twoState_rule_equations :
    ∀ name ∈ allRuleNames, ∀ tail : Bool,
      evalWord (rule name).lhs tail = evalWord (rule name).rhs tail := by sorry

