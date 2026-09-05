import CollatzWork.InverseWordBoundaryStatement

namespace CollatzWork

/-!
# Trusted convergence statements

All iteration below uses the exact one-division map `onceAccelerated` from
`InverseWordBoundaryStatement`. In particular, `1` maps to `2`, then back to
`1`; reaching `1` does not make an orbit constant. These definitions import
no solution proofs.
-/

/-- Iterate the one-division shortcut map, applying the first step before
the recursive tail. -/
def shortcutIter : Nat → Nat → Nat
  | 0, n => n
  | k + 1, n => shortcutIter k (onceAccelerated n)

/-- An orbit converges exactly when it reaches `1` after finitely many steps. -/
def Converges (n : Nat) : Prop := ∃ k : Nat, shortcutIter k n = 1

/-- The positive-natural Collatz conjecture for the one-division shortcut map. -/
def AllPositiveConverge : Prop := ∀ n : Nat, 0 < n → Converges n

/-- Every positive start other than `1` shares an orbit point with a strictly
smaller positive start. The step counts may differ, and may be zero. -/
def UniversalSmallerCoalescence : Prop :=
  ∀ n : Nat, 1 < n →
    ∃ m : Nat, 0 < m ∧ m < n ∧
      ∃ r s : Nat, shortcutIter r n = shortcutIter s m

/-- Every start above `1` eventually reaches a strictly smaller positive value
on its own forward orbit. The witnessing step count must be positive. -/
def UniversalDescent : Prop :=
  ∀ n : Nat, 1 < n →
    ∃ k : Nat, 0 < k ∧ 0 < shortcutIter k n ∧ shortcutIter k n < n

/-- Trusted statement of the strong-induction coalescence criterion. -/
def SmallerCoalescenceCriterionStatement : Prop :=
  AllPositiveConverge ↔ UniversalSmallerCoalescence

/-- Trusted statement of the usual all-start forward-descent criterion. -/
def DescentCriterionStatement : Prop :=
  AllPositiveConverge ↔ UniversalDescent

end CollatzWork
