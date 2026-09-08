import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement
import Theorems.Thm_CollatzWork_YAH_weightedGapSum_pos
import Theorems.Thm_CollatzWork_YAH_evalCoefficients_weightedCoefficient
import Theorems.Thm_CollatzWork_YAH_unlabelledCertificate_cancellation
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







end OrderedCertificate

section LinearEvaluation

variable {M : Type u} [IntModule M]











theorem evalCoefficients_eq_of_map_eq {φ : Type _}
    (features : List φ) (weight : φ → M) (left right : φ → Int)
    (h : features.map left = features.map right) :
    evalCoefficients features weight left =
      evalCoefficients features weight right := by
  induction features with
  | nil => rfl
  | cons feature rest ih =>
      simp only [List.map_cons, List.cons.injEq] at h
      rcases h with ⟨hhead, htail⟩
      change left feature • weight feature +
          evalCoefficients rest weight left =
        right feature • weight feature +
          evalCoefficients rest weight right
      rw [hhead, ih htail]

end LinearEvaluation

end GenericCertificate

/-! ## The 13-row unlabelled adjacent-edge certificate -/

















section UnlabelledConsequence

variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]



omit [LE M] [LT M] [Std.IsPreorder M] [Std.LawfulOrderLT M]
  [OrderedAdd M] in
theorem eval_negativeFFCoefficient
    (weight : Symbol × Symbol → M) :
    evalCoefficients allSymbolEdges weight negativeFFCoefficient =
      - weight (.f, .f) := by
  simp [allSymbolEdges, allSymbols, negativeFFCoefficient,
    evalCoefficients, IntModule.zero_zsmul, IntModule.neg_zsmul,
    IntModule.one_zsmul, AddCommMonoid.add_zero]

omit [LE M] [LT M] [Std.IsPreorder M] [Std.LawfulOrderLT M]
  [OrderedAdd M] in
theorem unlabelledCertificate_weightedGap_eq_neg_ff
    (weight : Symbol × Symbol → M) :
    weightedGapSum unlabelledCertificate (unlabelledGap weight) =
      - weight (.f, .f) := by
  calc
    weightedGapSum unlabelledCertificate (unlabelledGap weight) =
        evalCoefficients allSymbolEdges weight
          (weightedCoefficient unlabelledCertificate unlabelledEdgeDelta) := by
            exact (evalCoefficients_weightedCoefficient allSymbolEdges weight
              unlabelledCertificate unlabelledEdgeDelta).symm
    _ = evalCoefficients allSymbolEdges weight negativeFFCoefficient := by
      exact evalCoefficients_eq_of_map_eq allSymbolEdges weight _ _
        unlabelledCertificate_cancellation
    _ = - weight (.f, .f) := eval_negativeFFCoefficient weight























end UnlabelledConsequence

/-! ## The exact fixed two-state suffix algebra -/















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
theorem solution (weight : Symbol × Symbol → M)
    (horients : ∀ entry ∈ unlabelledCertificate,
      if (rule entry.2.ruleName).dynamic = true
      then 0 < unlabelledGap weight entry.2
      else 0 ≤ unlabelledGap weight entry.2) :
    weight (.f, .f) < 0 := by
  have hnonneg : ∀ entry ∈ unlabelledCertificate,
      0 ≤ unlabelledGap weight entry.2 := by
    intro entry hentry
    have h := horients entry hentry
    by_cases hdynamic : (rule entry.2.ruleName).dynamic = true
    · simp [hdynamic] at h
      exact Preorder.le_of_lt h
    · simp [hdynamic] at h
      exact h
  let first : Nat × UnlabelledInstance :=
    (1, ⟨.Dt, [.hat, .d2], []⟩)
  have hfirstMem : first ∈ unlabelledCertificate := by
    simp [first, unlabelledCertificate, unlabelledRows]
  have hfirstPos : 0 < unlabelledGap weight first.2 := by
    have h := horients first hfirstMem
    simpa [first, rule] using h
  have hsumPos := weightedGapSum_pos unlabelledCertificate
    (unlabelledGap weight) hnonneg
    ⟨first, hfirstMem, by decide, hfirstPos⟩
  rw [unlabelledCertificate_weightedGap_eq_neg_ff weight] at hsumPos
  exact OrderedAdd.neg_pos_iff.mp hsumPos
