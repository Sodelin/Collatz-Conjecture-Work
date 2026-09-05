import CollatzWork.AffineRepetitionStatement

namespace CollatzWork

/-- Telescoping a finite multiplicative recurrence. -/
theorem affineRecurrenceTelescope (a b : Nat) (y : Nat → Nat) (k : Nat)
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

theorem fixedRatioDivisibility : FixedRatioDivisibilityStatement := by
  intro a b hab y k h
  have hmul : b ^ k ∣ a ^ k * y 0 :=
    ⟨y k, (affineRecurrenceTelescope a b y k h).symm⟩
  exact ((hab.pow_left k).pow_right k).dvd_of_dvd_mul_left hmul

theorem finiteRepetitionBound : FiniteRepetitionBoundStatement := by
  intro a b hab y hpos k h
  exact Nat.le_of_dvd hpos (fixedRatioDivisibility a b hab y k h)

theorem noInfinitePositiveRecurrence : NoInfinitePositiveRecurrenceStatement := by
  intro a b hab hb y hpos h
  have hbound := finiteRepetitionBound a b hab y hpos (y 0) (fun i _ => h i)
  have hlarge : y 0 < b ^ (y 0) := Nat.lt_pow_self hb
  omega

/-- A rational-affine block becomes multiplicative after an integral shift. -/
theorem affineRepetitionShift (b d c x z : Nat)
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

theorem affineRepetitionBound : AffineRepetitionBoundStatement := by
  intro b d c hcop x hpos k h
  apply finiteRepetitionBound (b + d) b hcop (fun i => d * x i + c) hpos k
  intro i hi
  exact affineRepetitionShift b d c (x i) (x (i + 1)) (h i hi)

theorem noInfiniteExpandingAffineBlocks : NoInfiniteExpandingAffineBlocksStatement := by
  intro b d c hcop hb x hpos h
  apply noInfinitePositiveRecurrence (b + d) b hcop hb (fun i => d * x i + c) hpos
  intro i
  exact affineRepetitionShift b d c (x i) (x (i + 1)) (h i)

/-- An integral form of Bernoulli's inequality for the ratio 32/27. -/
theorem prefixReturnBernoulli (d : Nat) :
    (27 + 5 * d) * 27 ^ d ≤ 27 * 32 ^ d := by
  induction d with
  | zero => simp
  | succ d ih =>
    have hcoeff : 27 * (32 + 5 * d) ≤ 32 * (27 + 5 * d) := by omega
    calc
      (27 + 5 * (d + 1)) * 27 ^ (d + 1)
          = (27 * (32 + 5 * d)) * 27 ^ d := by
              rw [Nat.pow_succ]
              have h : 27 + 5 * (d + 1) = 32 + 5 * d := by omega
              rw [h]
              ac_rfl
      _ ≤ (32 * (27 + 5 * d)) * 27 ^ d := Nat.mul_le_mul_right _ hcoeff
      _ = 32 * ((27 + 5 * d) * 27 ^ d) := by ac_rfl
      _ ≤ 32 * (27 * 32 ^ d) := Nat.mul_le_mul_left 32 ih
      _ = 27 * 32 ^ (d + 1) := by rw [Nat.pow_succ]; ac_rfl

theorem prefixReturnNumericalBound : PrefixReturnNumericalBoundStatement := by
  intro n d h
  have hbern := Nat.mul_le_mul_left 2 (prefixReturnBernoulli d)
  have hscaled := Nat.mul_lt_mul_of_pos_left h (by decide : 0 < 27)
  have hprod : (2 * (27 + 5 * d)) * 27 ^ d < (27 * (n + 1)) * 27 ^ d := by
    calc
      (2 * (27 + 5 * d)) * 27 ^ d = 2 * ((27 + 5 * d) * 27 ^ d) := by ac_rfl
      _ ≤ 2 * (27 * 32 ^ d) := hbern
      _ = 27 * (2 * 32 ^ d) := by ac_rfl
      _ < 27 * (27 ^ d * (n + 1)) := hscaled
      _ = (27 * (n + 1)) * 27 ^ d := by ac_rfl
  have hlinear := Nat.lt_of_mul_lt_mul_right hprod
  constructor <;> omega

example : FixedRatioDivisibilityStatement := fixedRatioDivisibility
example : FiniteRepetitionBoundStatement := finiteRepetitionBound
example : NoInfinitePositiveRecurrenceStatement := noInfinitePositiveRecurrence
example : AffineRepetitionBoundStatement := affineRepetitionBound
example : NoInfiniteExpandingAffineBlocksStatement := noInfiniteExpandingAffineBlocks
example : PrefixReturnNumericalBoundStatement := prefixReturnNumericalBound

#print axioms CollatzWork.fixedRatioDivisibility
#print axioms CollatzWork.finiteRepetitionBound
#print axioms CollatzWork.noInfinitePositiveRecurrence
#print axioms CollatzWork.affineRepetitionBound
#print axioms CollatzWork.noInfiniteExpandingAffineBlocks
#print axioms CollatzWork.prefixReturnNumericalBound

end CollatzWork
