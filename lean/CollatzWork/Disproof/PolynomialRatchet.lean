import Std.Tactic

namespace CollatzWork.Disproof

/-!
# Normalized polynomial-ratchet arithmetic

This module checks only the arithmetic core of a narrowly scoped route
obstruction.  It does not define the Collatz map and proves neither the
Collatz conjecture nor its negation.

For primitive integral state polynomials transported around a finite directed
cycle by affine macros of slope `3^q / 2^k`, minimally clearing powers of two
leaves odd contents.  Comparing degrees first forces every integral quotient
to be constant.  Comparing leading coefficients then has the arithmetic form

`2^R * 3^(d*Q) = 2^(d*K) * H`,

where `H` is the product of those odd contents.  The theorems below certify
the unique odd normal form and the resulting exclusion of gain at any base
coprime to three.  The resonant base `p = 3` is intentionally not excluded.
-/

/-- An explicit arithmetic version of oddness, kept local so the proof does
not depend on a particular library representation of parity. -/
def ArithOdd (n : Nat) : Prop := ∃ t : Nat, n = 2 * t + 1

theorem arithOdd_one : ArithOdd 1 := by
  exact ⟨0, by decide⟩

theorem arithOdd_three_pow (n : Nat) : ArithOdd (3 ^ n) := by
  induction n with
  | zero => exact arithOdd_one
  | succ n ih =>
      obtain ⟨t, ht⟩ := ih
      refine ⟨3 * t + 1, ?_⟩
      rw [Nat.pow_succ, ht]
      omega

theorem arithOdd_not_two_mul (n : Nat) : ¬ ArithOdd (2 * n) := by
  rintro ⟨t, ht⟩
  omega

/-- Uniqueness of the decomposition of a positive natural as a power of two
times an odd natural.  Positivity is automatic from `ArithOdd`. -/
theorem twoPowerOddNormalFormUnique :
    ∀ R S A B : Nat,
      ArithOdd A → ArithOdd B →
      2 ^ R * A = 2 ^ S * B →
      R = S ∧ A = B := by
  intro R
  induction R with
  | zero =>
      intro S A B hA hB hEq
      cases S with
      | zero =>
          simp at hEq
          exact ⟨rfl, hEq⟩
      | succ S =>
          have hEven : A = 2 * (2 ^ S * B) := by
            simpa [Nat.pow_succ, Nat.mul_assoc, Nat.mul_comm,
              Nat.mul_left_comm] using hEq
          exact False.elim (arithOdd_not_two_mul (2 ^ S * B) (hEven ▸ hA))
  | succ R ih =>
      intro S A B hA hB hEq
      cases S with
      | zero =>
          have hEven : B = 2 * (2 ^ R * A) := by
            simpa [Nat.pow_succ, Nat.mul_assoc, Nat.mul_comm,
              Nat.mul_left_comm] using hEq.symm
          exact False.elim (arithOdd_not_two_mul (2 ^ R * A) (hEven ▸ hB))
      | succ S =>
          have hCancel : 2 ^ R * A = 2 ^ S * B := by
            apply Nat.mul_left_cancel (n := 2) (by decide)
            calc
              2 * (2 ^ R * A) = 2 ^ (R + 1) * A := by
                rw [Nat.pow_succ]
                ac_rfl
              _ = 2 ^ (S + 1) * B := hEq
              _ = 2 * (2 ^ S * B) := by
                rw [Nat.pow_succ]
                ac_rfl
          obtain ⟨hRS, hAB⟩ := ih S A B hA hB hCancel
          exact ⟨congrArg Nat.succ hRS, hAB⟩

/-- The minimally cleared leading-coefficient telescope fixes both the total
power-of-two clearing and the product of odd contents. -/
theorem normalizedLeadingTelescope
    (d Q K R H : Nat)
    (hHodd : ArithOdd H)
    (hLead : 2 ^ R * 3 ^ (d * Q) = 2 ^ (d * K) * H) :
    R = d * K ∧ H = 3 ^ (d * Q) := by
  obtain ⟨hRK, hPow⟩ :=
    twoPowerOddNormalFormUnique R (d * K) (3 ^ (d * Q)) H
      (arithOdd_three_pow (d * Q)) hHodd hLead
  exact ⟨hRK, hPow.symm⟩

/-- If a positive power of a base coprime to three divides the normalized
content product, the leading-coefficient telescope is impossible.  For an odd
prime `p != 3`, the hypotheses `1 < p` and `Nat.Coprime p 3` hold. -/
theorem noNonresonantContentGain
    (d Q K R H p E : Nat)
    (hHodd : ArithOdd H)
    (hLead : 2 ^ R * 3 ^ (d * Q) = 2 ^ (d * K) * H)
    (hp : 1 < p)
    (hp3 : Nat.Coprime p 3)
    (hE : 0 < E)
    (hGain : p ^ E ∣ H) : False := by
  have hH : H = 3 ^ (d * Q) :=
    (normalizedLeadingTelescope d Q K R H hHodd hLead).2
  have hCoprime : Nat.Coprime (p ^ E) (3 ^ (d * Q)) :=
    Nat.Coprime.pow E (d * Q) hp3
  have hOne : p ^ E = 1 := by
    apply hCoprime.eq_one_of_dvd
    simpa [hH] using hGain
  have hOneLt : 1 < p ^ E := Nat.one_lt_pow (Nat.ne_of_gt hE) hp
  omega

/-- Degree telescoping leaves no nonconstant quotient: nonnegative quotient
degrees summing to zero are all zero.  The polynomial degree identities around
a state cycle produce exactly the premise of this theorem. -/
theorem quotientDegreesVanish
    (degrees : List Nat)
    (hSum : degrees.sum = 0) :
    ∀ g ∈ degrees, g = 0 := by
  induction degrees with
  | nil => simp
  | cons a tail ih =>
      simp only [List.sum_cons] at hSum
      have ha : a = 0 := by omega
      have hTail : tail.sum = 0 := by omega
      intro g hg
      simp only [List.mem_cons] at hg
      rcases hg with rfl | hg
      · exact ha
      · exact ih hTail g hg

#print axioms CollatzWork.Disproof.twoPowerOddNormalFormUnique
#print axioms CollatzWork.Disproof.normalizedLeadingTelescope
#print axioms CollatzWork.Disproof.noNonresonantContentGain
#print axioms CollatzWork.Disproof.quotientDegreesVanish

end CollatzWork.Disproof
