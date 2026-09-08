import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Theorems.Thm_CollatzWork_rootDescentAncestor



open CollatzWork in
theorem solution (k u r : Nat) (hu : 0 < u)
    (hguard : 3 ^ (k + 3) * u = 4 * r + 1) :
    shortcutIter (k + 3) (6 * (2 ^ k * u) - 1) = r := by
  have hc : 3 ^ ((k + 1) + 1) * (3 * u) = 4 * r + 1 := by
    calc
      _ = 3 ^ (((k + 1) + 1) + 1) * u := by
        rw [Nat.pow_succ 3 ((k + 1) + 1)]
        simp only [Nat.mul_assoc]
      _ = 3 ^ (k + 3) * u := by rw [show ((k + 1) + 1) + 1 = k + 3 by omega]
      _ = 4 * r + 1 := hguard
  have h := rootDescentAncestor 0 (k + 1) (3 * u) r (by omega) hc
  have hz : 2 ^ (k + 1) * (3 * u) = 6 * (2 ^ k * u) := by
    rw [Nat.pow_succ, Nat.mul_assoc, ← Nat.mul_assoc 2 3 u]
    exact Nat.mul_left_comm (2 ^ k) 6 u
  simpa only [Nat.zero_add, Nat.pow_zero, Nat.one_mul, hz,
    show k + 1 + 2 = k + 3 by omega] using h
