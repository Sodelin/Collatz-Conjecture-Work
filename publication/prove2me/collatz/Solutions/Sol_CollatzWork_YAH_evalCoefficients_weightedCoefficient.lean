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







end OrderedCertificate

section LinearEvaluation

variable {M : Type u} [IntModule M]

theorem evalCoefficients_zero (features : List φ) (weight : φ → M) :
    evalCoefficients features weight (fun _ => 0) = 0 := by
  induction features with
  | nil => rfl
  | cons feature rest ih =>
      change 0 • weight feature +
        evalCoefficients rest weight (fun _ => 0) = 0
      rw [IntModule.zero_zsmul, ih, AddCommMonoid.add_zero]

theorem evalCoefficients_add (features : List φ) (weight : φ → M)
    (left right : φ → Int) :
    evalCoefficients features weight (fun feature => left feature + right feature) =
      evalCoefficients features weight left +
        evalCoefficients features weight right := by
  induction features with
  | nil => simp [evalCoefficients, AddCommMonoid.add_zero]
  | cons feature rest ih =>
      change (left feature + right feature) • weight feature +
          evalCoefficients rest weight
            (fun feature => left feature + right feature) =
        (left feature • weight feature +
          evalCoefficients rest weight left) +
        (right feature • weight feature +
          evalCoefficients rest weight right)
      rw [IntModule.add_zsmul, ih]
      let a := left feature • weight feature
      let b := right feature • weight feature
      let c := evalCoefficients rest weight left
      let d := evalCoefficients rest weight right
      change (a + b) + (c + d) = (a + c) + (b + d)
      calc
        (a + b) + (c + d) = a + (b + (c + d)) :=
          AddCommMonoid.add_assoc a b (c + d)
        _ = a + (c + (b + d)) := by
          exact congrArg (fun value => a + value)
            (AddCommMonoid.add_left_comm b c d)
        _ = (a + c) + (b + d) :=
          (AddCommMonoid.add_assoc a c (b + d)).symm

theorem evalCoefficients_scale (features : List φ) (weight : φ → M)
    (multiplicity : Nat) (coeff : φ → Int) :
    evalCoefficients features weight
        (fun feature => Int.ofNat multiplicity * coeff feature) =
      multiplicity • evalCoefficients features weight coeff := by
  induction features with
  | nil => simp [evalCoefficients, NatModule.nsmul_zero]
  | cons feature rest ih =>
      change (Int.ofNat multiplicity * coeff feature) • weight feature +
          evalCoefficients rest weight
            (fun feature => Int.ofNat multiplicity * coeff feature) =
        multiplicity •
          (coeff feature • weight feature +
            evalCoefficients rest weight coeff)
      rw [IntModule.mul_zsmul, ih]
      have hcast : Int.ofNat multiplicity •
          (coeff feature • weight feature) =
          multiplicity • (coeff feature • weight feature) :=
        IntModule.zsmul_natCast_eq_nsmul multiplicity
          (coeff feature • weight feature)
      rw [hcast]
      exact (NatModule.nsmul_add multiplicity
        (coeff feature • weight feature)
        (evalCoefficients rest weight coeff)).symm







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
variable {M : Type u} [IntModule M]

open CollatzWork.YAH in
theorem solution
    (features : List φ) (weight : φ → M)
    (certificate : List (Nat × ρ)) (delta : ρ → φ → Int) :
    evalCoefficients features weight
        (weightedCoefficient certificate delta) =
      weightedGapSum certificate
        (fun row => evalCoefficients features weight (delta row)) := by
  induction certificate with
  | nil =>
      change evalCoefficients features weight (fun _ => 0) = 0
      exact evalCoefficients_zero features weight
  | cons entry rest ih =>
      rcases entry with ⟨multiplicity, row⟩
      change evalCoefficients features weight
          (fun feature => Int.ofNat multiplicity * delta row feature +
            weightedCoefficient rest delta feature) =
        multiplicity • evalCoefficients features weight (delta row) +
          weightedGapSum rest
            (fun row => evalCoefficients features weight (delta row))
      rw [evalCoefficients_add, evalCoefficients_scale, ih]
