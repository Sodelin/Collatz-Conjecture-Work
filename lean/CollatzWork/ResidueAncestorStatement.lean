import CollatzWork.ConvergenceStatement

namespace CollatzWork

/-- Complete uniform refined residue-20 ancestor theorem in factorized form.
The exponent and positive 3-adic unit are unbounded. The factorization guard
implies that the original root is also 20 modulo 27. The conclusion gives
an actual forward orbit from a strictly smaller positive root in that class.
This statement does not assert that all roots satisfy the valuation guard. -/
def ResidueAncestorStatement : Prop :=
  ∀ v u r : Nat, 13 ≤ v → 0 < u → u % 3 ≠ 0 →
    3 ^ v * u = 4 * r + 1 →
    ∃ m b : Nat, 0 < m ∧ m < r ∧ m % 27 = 20 ∧ shortcutIter b m = r

end CollatzWork
