import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement
import Theorems.Thm_CollatzWork_YAH_yah13_forces_ff_negative
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













end LinearEvaluation

end GenericCertificate

/-! ## The 13-row unlabelled adjacent-edge certificate -/

















section UnlabelledConsequence

variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]



















omit [LE M] [LT M] [Std.IsPreorder M] [Std.LawfulOrderLT M]
  [OrderedAdd M] in
theorem ffTail_edgePotential
    (weight : Symbol × Symbol → M) (multiplicity : Nat) :
    edgePotential weight
        (List.replicate (multiplicity + 1) .f ++ [.dollar]) =
      multiplicity • weight (.f, .f) + weight (.f, .dollar) := by
  induction multiplicity with
  | zero =>
      simp [edgePotential, adjacentPairs, NatModule.zero_nsmul,
        AddCommMonoid.zero_add, AddCommMonoid.add_zero]
  | succ multiplicity ih =>
      have htail :
          List.foldr (fun edge total => weight edge + total) 0
              (adjacentPairs
                (.f :: (List.replicate multiplicity .f ++ [.dollar]))) =
            multiplicity • weight (.f, .f) + weight (.f, .dollar) := by
        simpa [edgePotential, List.replicate_succ] using ih
      simp [edgePotential, adjacentPairs, List.replicate_succ,
        NatModule.add_one_nsmul, htail, AddCommMonoid.add_assoc,
        AddCommMonoid.add_left_comm]

omit [LE M] [LT M] [Std.IsPreorder M] [Std.LawfulOrderLT M]
  [OrderedAdd M] in
theorem ffPumpPotential_eq_edgePotential
    (weight : Symbol × Symbol → M) (multiplicity : Nat) :
    ffPumpPotential weight multiplicity =
      edgePotential weight (ffPumpWord multiplicity) := by
  have htail := ffTail_edgePotential weight multiplicity
  simp [ffPumpPotential, ffPumpWord, edgePotential, adjacentPairs,
    List.replicate_succ] at htail ⊢
  rw [htail]
  rw [AddCommMonoid.add_assoc]

theorem negative_ff_pump_not_bounded_below
    (weight : Symbol × Symbol → M)
    (hcofinal : NegativeMultiplesCofinal (M := M))
    (hnegative : weight (.f, .f) < 0) :
    ¬ ∃ bound : M, ∀ multiplicity : Nat,
      bound ≤ ffPumpPotential weight multiplicity := by
  intro hbound
  rcases hbound with ⟨bound, hbound⟩
  let left := weight (.hat, .f)
  let middle := weight (.f, .f)
  let right := weight (.f, .dollar)
  obtain ⟨multiplicity, hsmall⟩ :=
    hcofinal middle (by simpa [middle] using hnegative)
      (bound - left - right)
  have hleft : left + multiplicity • middle <
      left + (bound - left - right) :=
    OrderedAdd.add_lt_right left hsmall
  have hboth : left + multiplicity • middle + right <
      left + (bound - left - right) + right :=
    OrderedAdd.add_lt_left hleft right
  have htarget : left + (bound - left - right) + right = bound := by
    calc
      left + (bound - left - right) + right =
          left + ((bound - left - right) + right) :=
        AddCommMonoid.add_assoc left (bound - left - right) right
      _ = left + (bound - left) := by
        rw [AddCommGroup.sub_add_cancel]
      _ = (bound - left) + left := AddCommMonoid.add_comm _ _
      _ = bound := AddCommGroup.sub_add_cancel
  rw [htarget] at hboth
  have hlower := hbound multiplicity
  change bound ≤ left + multiplicity • middle + right at hlower
  exact Preorder.not_ge_of_lt hboth hlower

theorem noBoundedBelowCanonicalFFPump
    (weight : Symbol × Symbol → M)
    (hcofinal : NegativeMultiplesCofinal (M := M))
    (horients : ∀ entry ∈ unlabelledCertificate,
      if (rule entry.2.ruleName).dynamic = true
      then 0 < unlabelledGap weight entry.2
      else 0 ≤ unlabelledGap weight entry.2) :
    ¬ ∃ bound : M, ∀ multiplicity : Nat,
      bound ≤ ffPumpPotential weight multiplicity :=
  negative_ff_pump_not_bounded_below weight hcofinal
    (yah13_forces_ff_negative weight horients)



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
theorem solution
    (weight : Symbol × Symbol → M)
    (hcofinal : NegativeMultiplesCofinal (M := M))
    (horients : ∀ entry ∈ unlabelledCertificate,
      if (rule entry.2.ruleName).dynamic = true
      then 0 < unlabelledGap weight entry.2
      else 0 ≤ unlabelledGap weight entry.2) :
    ¬ ∃ bound : M, ∀ multiplicity : Nat,
      bound ≤ edgePotential weight (ffPumpWord multiplicity) := by
  intro hbound
  apply noBoundedBelowCanonicalFFPump weight hcofinal horients
  rcases hbound with ⟨bound, hbound⟩
  refine ⟨bound, ?_⟩
  intro multiplicity
  rw [ffPumpPotential_eq_edgePotential]
  exact hbound multiplicity
