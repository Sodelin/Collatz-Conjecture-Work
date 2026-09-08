import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement
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

omit [LT M] [Std.LawfulOrderLT M] in
theorem weightedGapSum_nonneg
    (certificate : List (Nat × ρ)) (gap : ρ → M)
    (h : ∀ entry ∈ certificate, 0 ≤ gap entry.2) :
    0 ≤ weightedGapSum certificate gap := by
  induction certificate with
  | nil => exact Std.IsPreorder.le_refl 0
  | cons entry rest ih =>
      rcases entry with ⟨multiplicity, row⟩
      change 0 ≤ multiplicity • gap row + weightedGapSum rest gap
      have hrow : 0 ≤ gap row := h (multiplicity, row) (by simp)
      have htail : 0 ≤ weightedGapSum rest gap := by
        apply ih
        intro entry hentry
        exact h entry (by simp [hentry])
      have hsum := OrderedAdd.add_le_add
        (OrderedAdd.nsmul_nonneg (k := multiplicity) hrow) htail
      rw [AddCommMonoid.zero_add] at hsum
      exact hsum





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
  [Std.LawfulOrderLT M]
  [IntModule M] [OrderedAdd M]

open CollatzWork.YAH in
theorem solution
    (certificate : List (Nat × ρ)) (gap : ρ → M)
    (hnonneg : ∀ entry ∈ certificate, 0 ≤ gap entry.2)
    (hstrict : ∃ entry ∈ certificate,
      0 < entry.1 ∧ 0 < gap entry.2) :
    0 < weightedGapSum certificate gap := by
  induction certificate with
  | nil => simp at hstrict
  | cons entry rest ih =>
      rcases entry with ⟨multiplicity, row⟩
      change 0 < multiplicity • gap row + weightedGapSum rest gap
      have hrow : 0 ≤ gap row := hnonneg (multiplicity, row) (by simp)
      have htailNonneg : 0 ≤ weightedGapSum rest gap := by
        apply weightedGapSum_nonneg
        intro entry hentry
        exact hnonneg entry (by simp [hentry])
      rcases hstrict with ⟨entry, hmem, hmult, hgap⟩
      simp only [List.mem_cons] at hmem
      rcases hmem with heq | hmem
      · cases heq
        have hheadPos : 0 < multiplicity • gap row :=
          (OrderedAdd.nsmul_pos_iff hgap).2 hmult
        have hle : multiplicity • gap row ≤
            multiplicity • gap row + weightedGapSum rest gap := by
          have raw := OrderedAdd.add_le_right
            (multiplicity • gap row) htailNonneg
          rw [AddCommMonoid.add_zero] at raw
          exact raw
        exact Preorder.lt_of_lt_of_le hheadPos hle
      · have htailPos : 0 < weightedGapSum rest gap := by
          apply ih
          · intro entry hentry
            exact hnonneg entry (by simp [hentry])
          · exact ⟨entry, hmem, hmult, hgap⟩
        have hheadNonneg : 0 ≤ multiplicity • gap row :=
          OrderedAdd.nsmul_nonneg hrow
        have hle : weightedGapSum rest gap ≤
            multiplicity • gap row + weightedGapSum rest gap := by
          have raw := OrderedAdd.add_le_left
            hheadNonneg (weightedGapSum rest gap)
          rw [AddCommMonoid.zero_add] at raw
          exact raw
        exact Preorder.lt_of_lt_of_le htailPos hle
