import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Theorems.Thm_CollatzWork_oddRun
import Theorems.Thm_CollatzWork_compatibleProduct_mod_four
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





theorem onceAccelerated_two_mul_add_one (b : Nat) :
    onceAccelerated (2 * b + 1) = 3 * b + 2 := by
  rw [onceAccelerated]
  simp
  omega















theorem pow_three_split (L : Nat) (hL : 1 ≤ L) :
    3 ^ L = 3 * 3 ^ (L - 1) := by
  have hsplit : L = (L - 1) + 1 := by omega
  calc
    3 ^ L = 3 ^ ((L - 1) + 1) :=
      congrArg (fun k : Nat => 3 ^ k) hsplit
    _ = 3 ^ (L - 1) * 3 := by rw [Nat.pow_succ]
    _ = 3 * 3 ^ (L - 1) := by omega

theorem refinedA_pos (epsilon z : Nat) : 0 < refinedA epsilon z := by
  unfold refinedA
  omega














end CollatzWork



open CollatzWork in
theorem solution (L epsilon z : Nat) (hL : 2 ≤ L)
    (hepsilon : epsilon ≤ 1)
    (hparity : epsilon % 2 = L % 2) :
    shortcutIter L (refinedChild L epsilon z) =
      (3 ^ L * refinedA epsilon z - 1) / 4 := by
  let a := refinedA epsilon z
  let y := 3 ^ (L - 1) * a
  let b := (y - 3) / 4
  let p := (3 ^ L * a - 1) / 4
  have ha : 0 < a := refinedA_pos epsilon z
  have hprev : 1 ≤ L - 1 := by omega
  have hpowPrev : 3 ^ (L - 1) = 3 * 3 ^ (L - 2) := by
    have hsub : L - 1 - 1 = L - 2 := by omega
    simpa only [hsub] using pow_three_split (L - 1) hprev
  have hcoeff : 3 ^ (L - 2) * (3 * a) = y := by
    unfold y
    rw [hpowPrev]
    simp [Nat.mul_assoc, Nat.mul_comm]
  have hchildForm : refinedChild L epsilon z =
      2 ^ (L - 2) * (3 * a) - 1 := by
    unfold refinedChild a
    simp [Nat.mul_comm, Nat.mul_left_comm]
  have hrun : shortcutIter (L - 2) (refinedChild L epsilon z) = y - 1 := by
    rw [hchildForm, oddRun (L - 2) (3 * a) (by omega), hcoeff]
  have hxy : 3 ^ L * a = 3 * y := by
    unfold y
    rw [pow_three_split L (by omega)]
    simp [Nat.mul_assoc]
  have hxmod : (3 ^ L * a) % 4 = 1 := by
    unfold a
    exact compatibleProduct_mod_four L epsilon z hepsilon hparity
  have hymod : y % 4 = 3 := by
    rw [hxy] at hxmod
    omega
  have hyForm : y - 1 = 2 * (2 * b + 1) := by
    unfold b
    omega
  have hpForm : p = 3 * b + 2 := by
    unfold p b
    rw [hxy]
    omega
  have hLsplit : L = (L - 2) + 2 := by omega
  calc
    shortcutIter L (refinedChild L epsilon z) =
        shortcutIter ((L - 2) + 2) (refinedChild L epsilon z) := by
          exact congrArg (fun k => shortcutIter k (refinedChild L epsilon z)) hLsplit
    _ = shortcutIter 2 (shortcutIter (L - 2) (refinedChild L epsilon z)) := by
          rw [shortcutIter_add]
    _ = shortcutIter 2 (y - 1) := by rw [hrun]
    _ = shortcutIter 2 (2 * (2 * b + 1)) := by rw [hyForm]
    _ = 3 * b + 2 := by simp [shortcutIter, onceAccelerated_two_mul_add_one]
    _ = p := hpForm.symm
    _ = (3 ^ L * refinedA epsilon z - 1) / 4 := rfl
