import CollatzWork.ConvergenceStatement

namespace CollatzWork

/-!
Trusted interfaces for cumulative bounds on actual shortcut orbits.
The segment envelopes and final budget are hypotheses, NOT universal coverage.
This file imports definitions only, not the solution or its proof tactics.
-/

structure ExcursionSegment where
  steps : Nat
  numerator : Nat
  denominator : Nat

def excursionSteps : List ExcursionSegment → Nat
  | [] => 0
  | s :: rest => s.steps + excursionSteps rest

def excursionNumerator : List ExcursionSegment → Nat
  | [] => 1
  | s :: rest => s.numerator * excursionNumerator rest

def excursionDenominator : List ExcursionSegment → Nat
  | [] => 1
  | s :: rest => s.denominator * excursionDenominator rest

/-- Each segment is evaluated on the actual endpoint of its predecessor. -/
def ExcursionChain (n : Nat) : List ExcursionSegment → Prop
  | [] => True
  | s :: rest =>
      0 < s.denominator ∧
      s.denominator * (shortcutIter s.steps n + 3) ≤ s.numerator * (n + 3) ∧
      ExcursionChain (shortcutIter s.steps n) rest

def ExcursionChainEnvelopeStatement : Prop :=
  ∀ (segments : List ExcursionSegment) (root : Nat),
    ExcursionChain root segments →
    excursionDenominator segments * (shortcutIter (excursionSteps segments) root + 3) ≤
      excursionNumerator segments * (root + 3) ∧
    0 < excursionDenominator segments

def ExcursionBudgetDescentStatement : Prop :=
  ∀ root steps A D : Nat, 3 ≤ root →
    D * shortcutIter steps root < A * (root + 3) → 2 * A ≤ D →
    shortcutIter steps root < root

end CollatzWork
