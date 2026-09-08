import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement
import Theorems.Thm_CollatzWork_YAH_noTwoStateSymbolCertificateOrientation

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule
variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]

theorem CollatzWork.YAH.noTwoStateSymbolAdditiveOrder (weight : Token → M) :
    ¬ (∀ row : LabeledInstance, validLabeledInstance row = true →
      if (rule row.ruleName).dynamic = true
      then 0 < symbolGap weight row
      else 0 ≤ symbolGap weight row) := by sorry

