import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement
import Theorems.Thm_CollatzWork_YAH_yah13_forces_ff_negative

universe u

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule
variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]

theorem CollatzWork.YAH.noBoundedBelowCanonicalFFPumpWords
    (weight : Symbol × Symbol → M)
    (hcofinal : NegativeMultiplesCofinal (M := M))
    (horients : ∀ entry ∈ unlabelledCertificate,
      if (rule entry.2.ruleName).dynamic = true
      then 0 < unlabelledGap weight entry.2
      else 0 ≤ unlabelledGap weight entry.2) :
    ¬ ∃ bound : M, ∀ multiplicity : Nat,
      bound ≤ edgePotential weight (ffPumpWord multiplicity) := by sorry

