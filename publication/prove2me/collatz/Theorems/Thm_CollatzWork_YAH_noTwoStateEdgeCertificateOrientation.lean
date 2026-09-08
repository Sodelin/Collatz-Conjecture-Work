import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement
import Theorems.Thm_CollatzWork_YAH_weightedGapSum_pos
import Theorems.Thm_CollatzWork_YAH_evalCoefficients_weightedCoefficient
import Theorems.Thm_CollatzWork_YAH_edgeCertificate_cancellation

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule
variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]

theorem CollatzWork.YAH.noTwoStateEdgeCertificateOrientation
    (weight : Token × Token → M) :
    ¬ (∀ entry ∈ edgeCertificate,
      if (rule entry.2.ruleName).dynamic = true
      then 0 < edgeGap weight entry.2
      else 0 ≤ edgeGap weight entry.2) := by sorry

