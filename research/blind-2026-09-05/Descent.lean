import Std

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

theorem step_pos {n : Nat} (hn : 0 < n) : 0 < step n := by
  unfold step
  split
  · omega
  · omega

theorem iterate_pos (k : Nat) {n : Nat} (hn : 0 < n) :
    0 < iterate k n := by
  induction k generalizing n with
  | zero => exact hn
  | succ k ih => exact ih (step_pos hn)

theorem iterate_add (a b n : Nat) :
    iterate (a + b) n = iterate b (iterate a n) := by
  induction a generalizing n with
  | zero => simp [iterate]
  | succ a ih => simpa [Nat.succ_add, iterate] using ih (step n)

theorem convergence_implies_descent
    (hc : CollatzConjecture) : UniversalDescent := by
  intro n hn
  obtain ⟨k, hk⟩ := hc n (by omega)
  refine ⟨k, ?_, ?_⟩
  · cases k with
    | zero => simp [iterate] at hk; omega
    | succ k => omega
  · omega

theorem descent_implies_convergence
    (hd : UniversalDescent) : CollatzConjecture := by
  intro n
  induction n using Nat.strongRecOn with
  | ind n ih =>
    intro hn
    by_cases hOne : n = 1
    · exact ⟨0, hOne⟩
    · obtain ⟨k, _, hk⟩ := hd n (by omega)
      obtain ⟨j, hj⟩ := ih (iterate k n) hk (iterate_pos k hn)
      exact ⟨k + j, (iterate_add k j n).trans hj⟩

/-- Exact reduction only: proving either side would prove the conjecture. -/
theorem descent_iff_convergence : UniversalDescent ↔ CollatzConjecture :=
  ⟨descent_implies_convergence, convergence_implies_descent⟩

#print axioms step_pos
#print axioms iterate_pos
#print axioms iterate_add
#print axioms descent_implies_convergence
#print axioms convergence_implies_descent
#print axioms descent_iff_convergence

end BlindCollatz
