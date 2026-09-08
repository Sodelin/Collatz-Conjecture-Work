import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_RefinedMersenneChild
namespace CollatzWork

/-!
# Refined Mersenne child identity

This file formalizes one isolated arithmetic certificate for the one-division
shortcut map `onceAccelerated`.  It does not assert termination or route
closure.
-/

























theorem pow_two_split (L : Nat) (hL : 2 ≤ L) :
    2 ^ L = 4 * 2 ^ (L - 2) := by
  have hsplit : L = (L - 2) + 2 := by omega
  calc
    2 ^ L = 2 ^ ((L - 2) + 2) :=
      congrArg (fun k : Nat => 2 ^ k) hsplit
    _ = 2 ^ (L - 2) * 2 ^ 2 := by rw [Nat.pow_add]
    _ = 4 * 2 ^ (L - 2) := by simp [Nat.mul_comm]



theorem refinedA_pos (epsilon z : Nat) : 0 < refinedA epsilon z := by
  unfold refinedA
  omega














end CollatzWork



open CollatzWork in
theorem solution (L epsilon z : Nat) (hL : 2 ≤ L) :
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
