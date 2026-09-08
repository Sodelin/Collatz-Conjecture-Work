import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement
import Theorems.Thm_CollatzWork_YAH_weightedGapSum_pos
import Theorems.Thm_CollatzWork_YAH_evalCoefficients_weightedCoefficient
import Theorems.Thm_CollatzWork_YAH_symbolCertificate_cancellation

universe u

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule
variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]

theorem CollatzWork.YAH.noTwoStateSymbolCertificateOrientation (weight : Token → M) :
    ¬ (∀ entry ∈ symbolCertificate,
      if (rule entry.2.ruleName).dynamic = true
      then 0 < symbolGap weight entry.2
      else 0 ≤ symbolGap weight entry.2) := by sorry

