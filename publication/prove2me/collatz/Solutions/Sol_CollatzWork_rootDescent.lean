import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Definitions.Def_CollatzWork_RootDescentStatement
import Theorems.Thm_CollatzWork_rootDescentBurst
namespace CollatzWork

/-!
# Refined Mersenne child identity

This file formalizes one isolated arithmetic certificate for the one-division
shortcut map `onceAccelerated`.  It does not assert termination or route
closure.
-/





theorem shortcutIter_add (r s n : Nat) :
    shortcutIter (r + s) n = shortcutIter s (shortcutIter r n) := by
  induction r generalizing n with
  | zero => simp
  | succ r ih =>
      simp [Nat.succ_add, ih]






































end CollatzWork
namespace CollatzWork

/-!
# Root-relative forward descent after an unbounded OOE burst

The proof uses the actual one-division Collatz map throughout. The divisibility
guard is explicit and is not a universal coverage claim. In particular, the
theorem does not prove the Collatz conjecture.
-/







/-- An exact forward even run, including the zero-length case. -/
theorem shortcutIter_evenRun (k m : Nat) :
    shortcutIter k (2 ^ k * m) = m := by
  induction k with
  | zero => simp
  | succ k ih =>
      rw [show 2 ^ (k + 1) * m = 2 * (2 ^ k * m) by
        simp [Nat.pow_succ, Nat.mul_comm, Nat.mul_left_comm]]
      rw [shortcutIter_succ, onceAccelerated_two_mul, ih]

/-- The coefficient margin exceeds the entire additive subtraction loss. -/
theorem rootDescent_power_margin (j : Nat) :
    9 ^ (j + 1) + 5 * 2 ^ (j + 1) < 16 ^ (j + 1) + 5 := by
  induction j with
  | zero => decide
  | succ j ih =>
      change 9 ^ (j + 1) * 9 + 5 * (2 ^ (j + 1) * 2) <
        16 ^ (j + 1) * 16 + 5
      have htwo : 0 < 2 ^ (j + 1) := Nat.pow_pos (by omega)
      have hsixteen : 0 < 16 ^ (j + 1) := Nat.pow_pos (by omega)
      omega

theorem rootDescent_scaled_margin (k u : Nat) (hk : 0 < k) (hu : 0 < u) :
    9 ^ k * u + 5 * 2 ^ k < 16 ^ k * u + 5 := by
  have hmargin : 9 ^ k + 5 * 2 ^ k < 16 ^ k + 5 := by
    cases k with
    | zero => omega
    | succ j => exact rootDescent_power_margin j
  have htwo : 0 < 2 ^ k := Nat.pow_pos (by omega)
  have hcoeff : 9 ^ k ≤ 16 ^ k := by omega
  have hdiff : 9 ^ k + (16 ^ k - 9 ^ k) = 16 ^ k := by omega
  have hscale : 16 ^ k - 9 ^ k ≤ (16 ^ k - 9 ^ k) * u := by
    simpa using Nat.mul_le_mul_left (16 ^ k - 9 ^ k) hu
  have hproduct : 16 ^ k * u = 9 ^ k * u + (16 ^ k - 9 ^ k) * u := by
    calc
      16 ^ k * u = (9 ^ k + (16 ^ k - 9 ^ k)) * u :=
        congrArg (fun a => a * u) hdiff.symm
      _ = 9 ^ k * u + (16 ^ k - 9 ^ k) * u := Nat.add_mul _ _ _
  omega



















end CollatzWork



open CollatzWork in
theorem solution : RootDescentStatement := by
  intro k u m hk hu hm hguard
  have hburst := rootDescentBurst k u hu
  have hendpoint : 9 ^ k * u - 5 = 2 ^ k * m := by omega
  have hiter : shortcutIter (4 * k) (8 ^ k * u - 5) = m := by
    rw [show 4 * k = 3 * k + k by omega, shortcutIter_add,
      hburst, hendpoint, shortcutIter_evenRun]
  have height : 8 ≤ 8 ^ k := by
    cases k with
    | zero => omega
    | succ j =>
        have hp : 0 < 8 ^ j := Nat.pow_pos (by omega)
        rw [Nat.pow_succ]
        omega
  have hrootlarge : 5 ≤ 8 ^ k * u := by
    have hp : 8 ^ k ≤ 8 ^ k * u := by
      simpa using Nat.mul_le_mul_left (8 ^ k) hu
    omega
  have hroot : (8 ^ k * u - 5) + 5 = 8 ^ k * u := by omega
  have hscaled := congrArg (fun n => 2 ^ k * n) hroot
  have hpowers : 2 ^ k * 8 ^ k = 16 ^ k := (Nat.mul_pow 2 8 k).symm
  simp only [Nat.mul_add, ← Nat.mul_assoc, hpowers] at hscaled
  have hmargin := rootDescent_scaled_margin k u hk hu
  have hcompare : 2 ^ k * m < 2 ^ k * (8 ^ k * u - 5) := by
    omega
  exact ⟨hiter, Nat.lt_of_mul_lt_mul_left hcompare⟩
