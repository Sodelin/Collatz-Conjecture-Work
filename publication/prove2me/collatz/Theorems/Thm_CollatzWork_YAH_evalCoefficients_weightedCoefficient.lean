import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement

universe u

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule
variable {M : Type u} [IntModule M]

theorem CollatzWork.YAH.evalCoefficients_weightedCoefficient {φ : Type _} {ρ : Type _}
    (features : List φ) (weight : φ → M)
    (certificate : List (Nat × ρ)) (delta : ρ → φ → Int) :
    evalCoefficients features weight
        (weightedCoefficient certificate delta) =
      weightedGapSum certificate
        (fun row => evalCoefficients features weight (delta row)) := by sorry

