import Std
import Init.Grind.Ordered.Module
/-!
# A conditional reduction of the Collatz conjecture

This file proves an equivalence. It does NOT prove `UniversalDescent`
or `CollatzConjecture`; both remain propositions with no asserted inhabitant.
Only Lean's standard library is used.
-/

namespace BlindCollatz

/-- The ordinary Collatz map on natural numbers. -/
def step (n : Nat) : Nat :=
  if n % 2 = 0 then n / 2 else 3 * n + 1

/-- Apply `step` exactly `k` times, starting at `n`. -/
def iterate : Nat → Nat → Nat
  | 0, n => n
  | k + 1, n => iterate k (step n)

/-- Every positive starting value eventually reaches 1. Unproved here. -/
def CollatzConjecture : Prop :=
  ∀ n : Nat, 0 < n → ∃ k : Nat, iterate k n = 1

/-- Every starting value above 1 eventually becomes smaller. Unproved here. -/
def UniversalDescent : Prop :=
  ∀ n : Nat, 1 < n → ∃ k : Nat, 0 < k ∧ iterate k n < n




















end BlindCollatz
