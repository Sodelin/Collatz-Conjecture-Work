import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_PrefixCollisionStatement



theorem CollatzWork.parityPrefix_dvd_sub_of_le (k n m : Nat) (hnm : n ≤ m)
    (h : SameParityPrefix k n m) : 2 ^ k ∣ m - n := by sorry

