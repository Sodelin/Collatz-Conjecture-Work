import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule

open CollatzWork.YAH in
theorem solution :
    edgeCertificate.length = 50 ∧
    (edgeCertificate.filter fun entry => (rule entry.2.ruleName).dynamic).foldr
      (fun entry total => entry.1 + total) 0 = 144057 := by decide
