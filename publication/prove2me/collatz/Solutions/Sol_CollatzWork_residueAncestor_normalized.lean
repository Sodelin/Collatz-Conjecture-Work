import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Theorems.Thm_CollatzWork_residueAncestor_prefix_one
import Theorems.Thm_CollatzWork_residueAncestor_prefix_two
import Theorems.Thm_CollatzWork_residueAncestor_refinedTail
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























end CollatzWork
namespace CollatzWork

/-!
# Complete guarded uniform residue-20 ancestor construction

The variable prefix, five refined inverse tails, exhaustive selector,
positive size comparison, and actual orbit composition are all proved here.
All comparisons retain the unchanged original root. Coverage remains guarded
by the displayed factorization with valuation at least 13.
-/

/-- The strict common slope bound holds uniformly above the exact base 13. -/
theorem residueAncestor_powerBound_shifted (j : Nat) :
    192 * 2 ^ (j + 13) < 3 ^ (j + 13) := by
  induction j with
  | zero => decide
  | succ j ih =>
      change 192 * (2 ^ (j + 13) * 2) < 3 ^ (j + 13) * 3
      have hp : 0 < 2 ^ (j + 13) := Nat.pow_pos (by omega)
      omega

theorem residueAncestor_powerBound (v : Nat) (hv : 13 ≤ v) :
    192 * 2 ^ v < 3 ^ v := by
  have h := residueAncestor_powerBound_shifted (v - 13)
  have hi : v - 13 + 13 = v := by omega
  simpa only [hi] using h

theorem residueAncestor_twoPow_unit (k : Nat) : 2 ^ k % 3 ≠ 0 := by
  induction k with
  | zero => decide
  | succ k ih =>
      rw [Nat.pow_succ, Nat.mul_mod]
      have hb : 2 ^ k % 3 < 3 := Nat.mod_lt _ (by omega)
      omega

theorem residueAncestor_product_unit (k u : Nat) (hu : u % 3 ≠ 0) :
    (2 ^ k * u) % 3 ≠ 0 := by
  have hp := residueAncestor_twoPow_unit k
  have hb : 2 ^ k % 3 < 3 := Nat.mod_lt _ (by omega)
  have hub : u % 3 < 3 := Nat.mod_lt _ (by omega)
  have hpCases : 2 ^ k % 3 = 1 ∨ 2 ^ k % 3 = 2 := by omega
  have huCases : u % 3 = 1 ∨ u % 3 = 2 := by omega
  rcases hpCases with hp1 | hp2 <;> rcases huCases with hu1 | hu2
  · simp [Nat.mul_mod, hp1, hu1]
  · simp [Nat.mul_mod, hp1, hu2]
  · simp [Nat.mul_mod, hp2, hu1]
  · simp [Nat.mul_mod, hp2, hu2]





theorem residueAncestor_even_tail (e b z r : Nat)
    (h : shortcutIter b z = r) : shortcutIter (e + b) (2 ^ e * z) = r := by
  rw [shortcutIter_add, shortcutIter_evenRun, h]


















end CollatzWork



open CollatzWork in
theorem solution (k u r : Nat) (hk : 10 ≤ k)
    (hu : 0 < u) (hunit : u % 3 ≠ 0)
    (hguard : 3 ^ (k + 3) * u = 4 * r + 1) :
    ∃ m b : Nat, 0 < m ∧ m < r ∧ m % 27 = 20 ∧ shortcutIter b m = r := by
  let x := 2 ^ k * u
  have hx : 0 < x := Nat.mul_pos (Nat.pow_pos (by omega)) hu
  have hxu : x % 3 ≠ 0 := residueAncestor_product_unit k u hunit
  have hpow := residueAncestor_powerBound (k + 3) (by omega)
  have hscaled := Nat.mul_lt_mul_of_pos_right hpow hu
  have htwo : 2 ^ (k + 3) = 8 * 2 ^ k := by
    simp [Nat.pow_add, Nat.mul_comm]
  rw [htwo, hguard] at hscaled
  have hglobal : 1536 * x < 4 * r + 1 := by
    simpa [x, ← Nat.mul_assoc] using hscaled
  have hp1 : shortcutIter (k + 3) (6 * x - 1) = r :=
    residueAncestor_prefix_one k u r hu hguard
  have hp2 : shortcutIter (k + 2) (9 * x - 1) = r :=
    residueAncestor_prefix_two k u r hu hguard
  have hclasses : x % 9 = 1 ∨ x % 9 = 2 ∨ x % 9 = 4 ∨
      x % 9 = 5 ∨ x % 9 = 7 ∨ x % 9 = 8 := by omega
  rcases hclasses with h1 | h2 | h4 | h5 | h7 | h8
  · refine ⟨4 * (6 * x - 1), 2 + (k + 3), by omega, by omega, by omega, ?_⟩
    exact residueAncestor_even_tail 2 (k + 3) (6 * x - 1) r hp1
  · have hz : (6 * x - 1) % 27 = 11 := by omega
    obtain ⟨m, b, hm, hres, htail, hbound⟩ := residueAncestor_refinedTail (6 * x - 1) hz
    refine ⟨m, b + (k + 3), hm, by omega, hres, ?_⟩
    rw [shortcutIter_add, htail, hp1]
  · refine ⟨16 * (9 * x - 1), 4 + (k + 2), by omega, by omega, by omega, ?_⟩
    exact residueAncestor_even_tail 4 (k + 2) (9 * x - 1) r hp2
  · refine ⟨64 * (6 * x - 1), 6 + (k + 3), by omega, by omega, by omega, ?_⟩
    exact residueAncestor_even_tail 6 (k + 3) (6 * x - 1) r hp1
  · refine ⟨16 * (9 * x - 1), 4 + (k + 2), by omega, by omega, by omega, ?_⟩
    exact residueAncestor_even_tail 4 (k + 2) (9 * x - 1) r hp2
  · exact ⟨6 * x - 1, k + 3, by omega, by omega, by omega, hp1⟩
