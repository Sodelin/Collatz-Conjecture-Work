import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement
import Theorems.Thm_CollatzWork_YAH_weightedGapSum_pos
import Theorems.Thm_CollatzWork_YAH_evalCoefficients_weightedCoefficient
import Theorems.Thm_CollatzWork_YAH_unlabelledCertificate_cancellation

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule
variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]

theorem CollatzWork.YAH.yah13_forces_ff_negative (weight : Symbol × Symbol → M)
    (horients : ∀ entry ∈ unlabelledCertificate,
      if (rule entry.2.ruleName).dynamic = true
      then 0 < unlabelledGap weight entry.2
      else 0 ≤ unlabelledGap weight entry.2) :
    weight (.f, .f) < 0 := by sorry

