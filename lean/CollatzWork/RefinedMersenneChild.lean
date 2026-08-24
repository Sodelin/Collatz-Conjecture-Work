import CollatzWork.InverseWordBoundaryStatement
import Std.Tactic

namespace CollatzWork

/-!
# Refined Mersenne child identity

This file formalizes one isolated arithmetic certificate for the one-division
shortcut map `onceAccelerated`.  It does not assert termination or route
closure.
-/

/-- Iteration of the one-division shortcut map, with the first step applied
before the recursive tail. -/
def shortcutIter : Nat → Nat → Nat
  | 0, n => n
  | k + 1, n => shortcutIter k (onceAccelerated n)

@[simp] theorem shortcutIter_zero (n : Nat) : shortcutIter 0 n = n := rfl

@[simp] theorem shortcutIter_succ (k n : Nat) :
    shortcutIter (k + 1) n = shortcutIter k (onceAccelerated n) := rfl

theorem shortcutIter_add (r s n : Nat) :
    shortcutIter (r + s) n = shortcutIter s (shortcutIter r n) := by
  induction r generalizing n with
  | zero => simp
  | succ r ih =>
      simp [Nat.succ_add, ih]

theorem onceAccelerated_two_mul_sub_one (b : Nat) (hb : 0 < b) :
    onceAccelerated (2 * b - 1) = 3 * b - 1 := by
  rw [onceAccelerated]
  have hodd : (2 * b - 1) % 2 ≠ 0 := by omega
  simp [hodd]
  omega

@[simp] theorem onceAccelerated_two_mul (b : Nat) :
    onceAccelerated (2 * b) = b := by
  rw [onceAccelerated]
  simp

theorem onceAccelerated_two_mul_add_one (b : Nat) :
    onceAccelerated (2 * b + 1) = 3 * b + 2 := by
  rw [onceAccelerated]
  simp
  omega

theorem oddRun (h q : Nat) (hq : 0 < q) :
    shortcutIter h (2 ^ h * q - 1) = 3 ^ h * q - 1 := by
  induction h generalizing q with
  | zero => simp
  | succ h ih =>
      rw [show 2 ^ (h + 1) * q = 2 * (2 ^ h * q) by
        simp [Nat.pow_succ, Nat.mul_comm, Nat.mul_left_comm]]
      rw [shortcutIter_succ]
      rw [onceAccelerated_two_mul_sub_one]
      · rw [show 3 * (2 ^ h * q) = 2 ^ h * (3 * q) by
          simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]]
        rw [ih (3 * q) (by omega)]
        rw [show 3 ^ h * (3 * q) = 3 ^ (h + 1) * q by
          simp [Nat.pow_succ, Nat.mul_assoc, Nat.mul_comm]]
      · exact Nat.mul_pos (Nat.pow_pos (by omega)) hq

/-- The parameter used by the two residue children. -/
def refinedA (epsilon z : Nat) : Nat := 4 * z + 2 * epsilon + 1

/-- The exact-valuation Mersenne parent after splitting its odd parameter
modulo four. -/
def refinedParent (L epsilon z : Nat) : Nat :=
  2 ^ L * refinedA epsilon z - 1

/-- The smaller coalescing child on the parity-compatible branch. -/
def refinedChild (L epsilon z : Nat) : Nat :=
  3 * 2 ^ (L - 2) * refinedA epsilon z - 1

theorem threePow_mod_four (L : Nat) :
    3 ^ L % 4 = if L % 2 = 0 then 1 else 3 := by
  induction L with
  | zero => simp
  | succ L ih =>
      rw [Nat.pow_succ, Nat.mul_mod, ih]
      by_cases h : L % 2 = 0
      · have hs : (L + 1) % 2 ≠ 0 := by omega
        simp [h, hs]
      · have hLone : L % 2 = 1 := by omega
        have hs : (L + 1) % 2 = 0 := by omega
        simp [hLone, hs]

theorem compatibleProduct_mod_four
    (L epsilon z : Nat) (hepsilon : epsilon ≤ 1)
    (hparity : epsilon % 2 = L % 2) :
    (3 ^ L * refinedA epsilon z) % 4 = 1 := by
  by_cases he : epsilon = 0
  · subst epsilon
    have hL : L % 2 = 0 := by omega
    have hp : 3 ^ L % 4 = 1 := by
      simpa [hL] using threePow_mod_four L
    rw [Nat.mul_mod, hp]
    unfold refinedA
    omega
  · have heone : epsilon = 1 := by omega
    subst epsilon
    have hL : L % 2 = 1 := by omega
    have hp : 3 ^ L % 4 = 3 := by
      simpa [hL] using threePow_mod_four L
    rw [Nat.mul_mod, hp]
    unfold refinedA
    omega

theorem pow_two_split (L : Nat) (hL : 2 ≤ L) :
    2 ^ L = 4 * 2 ^ (L - 2) := by
  have hsplit : L = (L - 2) + 2 := by omega
  calc
    2 ^ L = 2 ^ ((L - 2) + 2) :=
      congrArg (fun k : Nat => 2 ^ k) hsplit
    _ = 2 ^ (L - 2) * 2 ^ 2 := by rw [Nat.pow_add]
    _ = 4 * 2 ^ (L - 2) := by simp [Nat.mul_comm]

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

/-- Positivity, strict decrease, and the exact integral inverse formula for
the parity-compatible child.  These arithmetic facts do not require the
parity hypothesis itself. -/
theorem refinedChild_arithmetic (L epsilon z : Nat) (hL : 2 ≤ L) :
    0 < refinedParent L epsilon z ∧
    0 < refinedChild L epsilon z ∧
    refinedChild L epsilon z < refinedParent L epsilon z ∧
    refinedChild L epsilon z = (3 * refinedParent L epsilon z - 1) / 4 := by
  let b := 2 ^ (L - 2) * refinedA epsilon z
  have hb : 0 < b :=
    Nat.mul_pos (Nat.pow_pos (by omega)) (refinedA_pos epsilon z)
  have hparent : refinedParent L epsilon z = 4 * b - 1 := by
    unfold refinedParent b
    rw [pow_two_split L hL]
    simp [Nat.mul_assoc]
  have hchild : refinedChild L epsilon z = 3 * b - 1 := by
    unfold refinedChild b
    simp [Nat.mul_assoc]
  rw [hparent, hchild]
  omega

/-- The parent reaches the common endpoint after `L+2` one-division shortcut
steps on the parity-compatible residue child. -/
theorem refinedParent_iter (L epsilon z : Nat)
    (hepsilon : epsilon ≤ 1)
    (hparity : epsilon % 2 = L % 2) :
    shortcutIter (L + 2) (refinedParent L epsilon z) =
      (3 ^ L * refinedA epsilon z - 1) / 4 := by
  let a := refinedA epsilon z
  let p := (3 ^ L * a - 1) / 4
  have ha : 0 < a := refinedA_pos epsilon z
  have hrun : shortcutIter L (refinedParent L epsilon z) =
      3 ^ L * a - 1 := by
    unfold refinedParent a
    exact oddRun L (refinedA epsilon z) ha
  have hmod : (3 ^ L * a) % 4 = 1 := by
    unfold a
    exact compatibleProduct_mod_four L epsilon z hepsilon hparity
  have hfour : 3 ^ L * a - 1 = 2 * (2 * p) := by
    unfold p
    omega
  rw [shortcutIter_add L 2, hrun, hfour]
  simp [shortcutIter]
  omega

/-- The strictly smaller child reaches the same endpoint after `L`
one-division shortcut steps. -/
theorem refinedChild_iter (L epsilon z : Nat) (hL : 2 ≤ L)
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

/-- Full coalescence statement for the audited compatible residue child. -/
theorem refinedMersenneChild_coalesces (L epsilon z : Nat) (hL : 2 ≤ L)
    (hepsilon : epsilon ≤ 1)
    (hparity : epsilon % 2 = L % 2) :
    shortcutIter (L + 2) (refinedParent L epsilon z) =
      shortcutIter L (refinedChild L epsilon z) := by
  rw [refinedParent_iter L epsilon z hepsilon hparity,
    refinedChild_iter L epsilon z hL hepsilon hparity]

#print axioms CollatzWork.refinedChild_arithmetic
#print axioms CollatzWork.refinedParent_iter
#print axioms CollatzWork.refinedChild_iter
#print axioms CollatzWork.refinedMersenneChild_coalesces

end CollatzWork
