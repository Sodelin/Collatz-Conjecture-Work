import Std
import Init.Grind.Ordered.Module
import Theorems.Thm_BlindCollatz_RepetitionBound_telescope
/-!
An exact bound for repeated rational-affine blocks after a positive shift.
This is a restriction on one fixed block, not a proof of Collatz termination.
-/

namespace BlindCollatz.RepetitionBound



/-- Coprimality turns the recurrence into divisibility of its initial height. -/
theorem power_dvd_initial (a b : Nat) (hab : b.Coprime a)
    (y : Nat → Nat) (k : Nat)
    (h : ∀ i, i < k → b * y (i + 1) = a * y i) :
    b ^ k ∣ y 0 := by
  have hmul : b ^ k ∣ a ^ k * y 0 :=
    ⟨y k, (telescope a b y k h).symm⟩
  exact ((hab.pow_left k).pow_right k).dvd_of_dvd_mul_left hmul

/-- An exact finite-prefix repetition bound; no asymptotics or probability. -/
theorem finite_repetition_bound (a b : Nat) (hab : b.Coprime a)
    (y : Nat → Nat) (hpos : 0 < y 0) (k : Nat)
    (h : ∀ i, i < k → b * y (i + 1) = a * y i) :
    b ^ k ≤ y 0 :=
  Nat.le_of_dvd hpos (power_dvd_initial a b hab y k h)









/-- Alternating odd-step division counts (1,2) give this affine recurrence. -/
theorem alternating_shift (x z : Nat) (h : 8 * z = 9 * x + 5) :
    8 * (z + 5) = 9 * (x + 5) := by omega












end BlindCollatz.RepetitionBound



open BlindCollatz.RepetitionBound in
theorem solution (x : Nat → Nat) (k : Nat)
    (h : ∀ i, i < k → 8 * x (i + 1) = 9 * x i + 5) :
    8 ^ k ≤ x 0 + 5 := by
  apply finite_repetition_bound 9 8 (by decide) (fun i => x i + 5) (by omega) k
  intro i hi
  exact alternating_shift (x i) (x (i + 1)) (h i hi)
