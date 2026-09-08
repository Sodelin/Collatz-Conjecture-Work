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



/-- A rational-affine block of numerator b+d becomes multiplicative after a shift. -/
theorem affine_shift (b d c x z : Nat)
    (h : b * z = (b + d) * x + c) :
    b * (d * z + c) = (b + d) * (d * x + c) := by
  calc
    b * (d * z + c) = d * (b * z) + b * c := by
      rw [Nat.mul_add]
      congr 1
      ac_rfl
    _ = d * ((b + d) * x + c) + b * c := by rw [h]
    _ = (b + d) * (d * x + c) := by
      simp only [Nat.mul_add, Nat.add_mul]
      ac_rfl


















end BlindCollatz.RepetitionBound



open BlindCollatz.RepetitionBound in
theorem solution (b d c : Nat)
    (hcop : b.Coprime (b + d)) (x : Nat → Nat)
    (hpos : 0 < d * x 0 + c) (k : Nat)
    (h : ∀ i, i < k → b * x (i + 1) = (b + d) * x i + c) :
    b ^ k ≤ d * x 0 + c := by
  apply finite_repetition_bound (b + d) b hcop
    (fun i => d * x i + c) hpos k
  intro i hi
  exact affine_shift b d c (x i) (x (i + 1)) (h i hi)
