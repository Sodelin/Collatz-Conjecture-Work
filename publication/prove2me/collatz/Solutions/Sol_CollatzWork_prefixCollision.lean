import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_PrefixCollisionStatement
import Theorems.Thm_CollatzWork_parityPrefix_dvd_sub_of_le
namespace CollatzWork

/-!
# Actual-orbit prefix collisions

These results bound repetitions of finite parity prefixes. They neither assert
that any positive orbit descends nor exclude every infinite nonconvergent orbit.
-/









theorem sameParityPrefix_symm {k n m : Nat}
    (h : SameParityPrefix k n m) : SameParityPrefix k m n :=
  fun i hi => (h i hi).symm

theorem parityPrefix_mod_eq (k n m : Nat) (h : SameParityPrefix k n m) :
    n % 2 ^ k = m % 2 ^ k := by
  by_cases hnm : n ≤ m
  · obtain ⟨w, hw⟩ := parityPrefix_dvd_sub_of_le k n m hnm h
    apply Nat.mod_eq_mod_iff.mpr
    refine ⟨w, 0, ?_⟩
    rw [Nat.mul_comm w]
    omega
  · have hmn : m ≤ n := by omega
    obtain ⟨w, hw⟩ := parityPrefix_dvd_sub_of_le k m n hmn (sameParityPrefix_symm h)
    apply Nat.mod_eq_mod_iff.mpr
    refine ⟨0, w, ?_⟩
    rw [Nat.mul_comm w]
    omega













end CollatzWork



open CollatzWork in
theorem solution : PrefixCollisionStatement := parityPrefix_mod_eq
