import Std
import Init.Grind.Ordered.Module
import Definitions.Def_ArchiveDescent
/-!
# A conditional reduction of the Collatz conjecture

This file proves an equivalence. It does NOT prove `UniversalDescent`
or `CollatzConjecture`; both remain propositions with no asserted inhabitant.
Only Lean's standard library is used.
-/

namespace BlindCollatz









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










end BlindCollatz



open BlindCollatz in
theorem solution : UniversalDescent ↔ CollatzConjecture :=
  ⟨descent_implies_convergence, convergence_implies_descent⟩
