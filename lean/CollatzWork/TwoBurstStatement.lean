import CollatzWork.ConvergenceStatement

namespace CollatzWork

/-!
Trusted statement for a guarded excursion with two growing OOE bursts.
The endpoint is compared to the unchanged original root. The two exact
arithmetic guards are assumptions, not universal coverage assertions.
Oddness of `v` is redundant: the exit guard already implies it. The proof
does not use the separate exact-valuation interpretation of the prose family.
-/

/-- A recharge equation and a sufficiently long final even run force genuine
forward descent below the start, for unbounded positive burst lengths. -/
def TwoBurstDescentStatement : Prop :=
  ∀ k l u v m : Nat, 0 < k → 0 < l → 0 < u → 0 < v → 0 < m →
    9 ^ k * u + 1 = 2 ^ (3 * l + 1) * v →
    2 ^ (k + l) * m + 5 = 3 * 9 ^ l * v →
    shortcutIter (4 * (k + l) + 2) (2 * 8 ^ k * u - 5) = m ∧
      m < 2 * 8 ^ k * u - 5

end CollatzWork
