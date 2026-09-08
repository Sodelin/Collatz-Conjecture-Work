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



theorem parityPrefix_separation (k n m : Nat)
    (h : SameParityPrefix k n m) (hne : n ≠ m) :
    2 ^ k ≤ prefixGap n m := by
  unfold prefixGap
  by_cases hnm : n ≤ m
  · have hd := parityPrefix_dvd_sub_of_le k n m hnm h
    have hb := Nat.le_of_dvd (show 0 < m - n by omega) hd
    omega
  · have hmn : m ≤ n := by omega
    have hd := parityPrefix_dvd_sub_of_le k m n hmn (sameParityPrefix_symm h)
    have hb := Nat.le_of_dvd (show 0 < n - m by omega) hd
    omega











end CollatzWork



open CollatzWork in
theorem solution : PrefixSeparationStatement := parityPrefix_separation
