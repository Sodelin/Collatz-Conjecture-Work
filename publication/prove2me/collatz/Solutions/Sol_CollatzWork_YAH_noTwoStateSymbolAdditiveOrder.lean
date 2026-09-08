import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement
import Theorems.Thm_CollatzWork_YAH_noTwoStateSymbolCertificateOrientation
namespace CollatzWork.YAH

/-!
# Kernel-checked YAH finite obstruction certificates

The concrete data below replay the project's 13-row unlabelled adjacent-edge
certificate and the fixed two-state 8-row symbol / 50-row edge certificates.
The exported theorems concern only these finite identities and their generic
positive-combination consequence.
-/

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule

section GenericCertificate

section OrderedCertificate

variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M]
  [IntModule M] [OrderedAdd M]







end OrderedCertificate

section LinearEvaluation

variable {M : Type u} [IntModule M]













end LinearEvaluation

end GenericCertificate

/-! ## The 13-row unlabelled adjacent-edge certificate -/

















section UnlabelledConsequence

variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]





























end UnlabelledConsequence

/-! ## The exact fixed two-state suffix algebra -/







theorem symbolCertificate_legal :
    symbolCertificate.all (fun entry => validLabeledInstance entry.2) = true := by
  decide







/-! ## The 50-row fixed-label adjacent-edge certificate -/











/-! ## Ordered-algebra consequences of the exact zero cancellations -/

section LabeledNoGo

variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]

















end LabeledNoGo















end CollatzWork.YAH

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule
variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]

open CollatzWork.YAH in
theorem solution (weight : Token → M) :
    ¬ (∀ row : LabeledInstance, validLabeledInstance row = true →
      if (rule row.ruleName).dynamic = true
      then 0 < symbolGap weight row
      else 0 ≤ symbolGap weight row) := by
  intro hall
  apply noTwoStateSymbolCertificateOrientation weight
  intro entry hentry
  exact hall entry.2
    ((List.all_eq_true.mp symbolCertificate_legal) entry hentry)
