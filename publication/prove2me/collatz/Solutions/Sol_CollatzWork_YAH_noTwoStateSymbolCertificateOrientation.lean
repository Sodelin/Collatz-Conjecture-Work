import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement
import Theorems.Thm_CollatzWork_YAH_weightedGapSum_pos
import Theorems.Thm_CollatzWork_YAH_evalCoefficients_weightedCoefficient
import Theorems.Thm_CollatzWork_YAH_symbolCertificate_cancellation
universe u

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





theorem positiveCertificate_ne_zero {ρ : Type _}
    (certificate : List (Nat × ρ)) (gap : ρ → M)
    (hnonneg : ∀ entry ∈ certificate, 0 ≤ gap entry.2)
    (hstrict : ∃ entry ∈ certificate,
      0 < entry.1 ∧ 0 < gap entry.2) :
    weightedGapSum certificate gap ≠ 0 := by
  have hpos := weightedGapSum_pos certificate gap hnonneg hstrict
  intro hzero
  rw [hzero] at hpos
  exact Preorder.lt_irrefl 0 hpos

end OrderedCertificate

section LinearEvaluation

variable {M : Type u} [IntModule M]









theorem evalCoefficients_eq_zero_of_map_eq {φ : Type _}
    (features : List φ) (weight : φ → M) (coeff : φ → Int)
    (h : features.map coeff = features.map (fun _ => 0)) :
    evalCoefficients features weight coeff = 0 := by
  induction features with
  | nil => rfl
  | cons feature rest ih =>
      simp only [List.map_cons, List.cons.injEq] at h
      rcases h with ⟨hhead, htail⟩
      change coeff feature • weight feature +
        evalCoefficients rest weight coeff = 0
      rw [hhead, IntModule.zero_zsmul, ih htail,
        AddCommMonoid.add_zero]



end LinearEvaluation

end GenericCertificate

/-! ## The 13-row unlabelled adjacent-edge certificate -/

















section UnlabelledConsequence

variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]





























end UnlabelledConsequence

/-! ## The exact fixed two-state suffix algebra -/















/-! ## The 50-row fixed-label adjacent-edge certificate -/











/-! ## Ordered-algebra consequences of the exact zero cancellations -/

section LabeledNoGo

variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]





omit [LE M] [LT M] [Std.IsPreorder M] [Std.LawfulOrderLT M]
  [OrderedAdd M] in
theorem symbolCertificate_weightedGap_zero (weight : Token → M) :
    weightedGapSum symbolCertificate (symbolGap weight) = 0 := by
  calc
    weightedGapSum symbolCertificate (symbolGap weight) =
        evalCoefficients allTokens weight
          (weightedCoefficient symbolCertificate labeledSymbolDelta) := by
            exact (evalCoefficients_weightedCoefficient allTokens weight
              symbolCertificate labeledSymbolDelta).symm
    _ = 0 := evalCoefficients_eq_zero_of_map_eq allTokens weight _
      symbolCertificate_cancellation











end LabeledNoGo















end CollatzWork.YAH

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule
variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]

open CollatzWork.YAH in
theorem solution (weight : Token → M) :
    ¬ (∀ entry ∈ symbolCertificate,
      if (rule entry.2.ruleName).dynamic = true
      then 0 < symbolGap weight entry.2
      else 0 ≤ symbolGap weight entry.2) := by
  intro horients
  have hnonneg : ∀ entry ∈ symbolCertificate,
      0 ≤ symbolGap weight entry.2 := by
    intro entry hentry
    have h := horients entry hentry
    by_cases hdynamic : (rule entry.2.ruleName).dynamic = true
    · simp [hdynamic] at h
      exact Preorder.le_of_lt h
    · simp [hdynamic] at h
      exact h
  let first : Nat × LabeledInstance :=
    (2, canonicalLabeledInstance .Df false)
  have hfirstMem : first ∈ symbolCertificate := by
    simp [first, symbolCertificate]
  have hfirstPos : 0 < symbolGap weight first.2 := by
    have h := horients first hfirstMem
    simpa [first, canonicalLabeledInstance, rule] using h
  have hne := positiveCertificate_ne_zero symbolCertificate
    (symbolGap weight) hnonneg
    ⟨first, hfirstMem, by decide, hfirstPos⟩
  exact hne (symbolCertificate_weightedGap_zero weight)
