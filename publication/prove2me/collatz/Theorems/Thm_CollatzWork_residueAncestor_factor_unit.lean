import Std
import Init.Grind.Ordered.Module



theorem CollatzWork.residueAncestor_factor_unit (n : Nat) :
    0 < n → ∃ e u : Nat, 0 < u ∧ u % 3 ≠ 0 ∧ 3 ^ e * u = n := by sorry

