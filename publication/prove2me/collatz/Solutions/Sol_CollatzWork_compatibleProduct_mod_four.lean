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






















end CollatzWork



open CollatzWork in
theorem solution
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
