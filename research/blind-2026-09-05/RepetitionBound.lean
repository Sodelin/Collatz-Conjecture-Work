import Std

/-!
An exact bound for repeated rational-affine blocks after a positive shift.
This is a restriction on one fixed block, not a proof of Collatz termination.
-/

namespace BlindCollatz.RepetitionBound

/-- Telescoping a finite multiplicative recurrence. -/
theorem telescope (a b : Nat) (y : Nat → Nat) (k : Nat)
    (h : ∀ i, i < k → b * y (i + 1) = a * y i) :
    b ^ k * y k = a ^ k * y 0 := by
  induction k with
  | zero => simp
  | succ k ih =>
    have hp := ih (fun i hi => h i (by omega))
    calc
      b ^ (k + 1) * y (k + 1)
          = b ^ k * (b * y (k + 1)) := by
              rw [Nat.pow_succ, Nat.mul_assoc]
      _ = b ^ k * (a * y k) := by rw [h k (by omega)]
      _ = a * (b ^ k * y k) := by ac_rfl
      _ = a * (a ^ k * y 0) := by rw [hp]
      _ = a ^ (k + 1) * y 0 := by rw [Nat.pow_succ]; ac_rfl

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

/-- A fixed denominator greater than one cannot divide a positive height forever. -/
theorem no_infinite_positive_recurrence (a b : Nat) (hab : b.Coprime a)
    (hb : 1 < b) (y : Nat → Nat) (hpos : 0 < y 0) :
    ¬ (∀ i, b * y (i + 1) = a * y i) := by
  intro h
  have hbound := finite_repetition_bound a b hab y hpos (y 0)
    (fun i _ => h i)
  have hlarge : y 0 < b ^ (y 0) := Nat.lt_pow_self hb
  omega

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

/-- Bound for k exact repetitions of any coprime expanding affine block. -/
theorem affine_repetition_bound (b d c : Nat)
    (hcop : b.Coprime (b + d)) (x : Nat → Nat)
    (hpos : 0 < d * x 0 + c) (k : Nat)
    (h : ∀ i, i < k → b * x (i + 1) = (b + d) * x i + c) :
    b ^ k ≤ d * x 0 + c := by
  apply finite_repetition_bound (b + d) b hcop
    (fun i => d * x i + c) hpos k
  intro i hi
  exact affine_shift b d c (x i) (x (i + 1)) (h i hi)

/-- No positive shifted orbit can follow a fixed such affine block forever. -/
theorem no_infinite_expanding_affine_blocks (b d c : Nat)
    (hcop : b.Coprime (b + d)) (hb : 1 < b) (x : Nat → Nat)
    (hpos : 0 < d * x 0 + c) :
    ¬ (∀ i, b * x (i + 1) = (b + d) * x i + c) := by
  intro h
  apply no_infinite_positive_recurrence (b + d) b hcop hb
    (fun i => d * x i + c) hpos
  intro i
  exact affine_shift b d c (x i) (x (i + 1)) (h i)

/-- Alternating odd-step division counts (1,2) give this affine recurrence. -/
theorem alternating_shift (x z : Nat) (h : 8 * z = 9 * x + 5) :
    8 * (z + 5) = 9 * (x + 5) := by omega

theorem alternating_repetition_bound (x : Nat → Nat) (k : Nat)
    (h : ∀ i, i < k → 8 * x (i + 1) = 9 * x i + 5) :
    8 ^ k ≤ x 0 + 5 := by
  apply finite_repetition_bound 9 8 (by decide) (fun i => x i + 5) (by omega) k
  intro i hi
  exact alternating_shift (x i) (x (i + 1)) (h i hi)

theorem no_infinite_alternating_blocks (x : Nat → Nat) :
    ¬ (∀ i, 8 * x (i + 1) = 9 * x i + 5) := by
  intro h
  apply no_infinite_positive_recurrence 9 8 (by decide) (by decide)
    (fun i => x i + 5) (by omega)
  intro i
  exact alternating_shift (x i) (x (i + 1)) (h i)

#print axioms finite_repetition_bound
#print axioms no_infinite_positive_recurrence
#print axioms affine_repetition_bound
#print axioms no_infinite_expanding_affine_blocks
#print axioms alternating_repetition_bound
#print axioms no_infinite_alternating_blocks

end BlindCollatz.RepetitionBound
