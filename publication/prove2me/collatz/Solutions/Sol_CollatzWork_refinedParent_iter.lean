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























theorem refinedA_pos (epsilon z : Nat) : 0 < refinedA epsilon z := by
  unfold refinedA
  omega














end CollatzWork



open CollatzWork in
theorem solution (L epsilon z : Nat)
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
