import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_Disproof_PolynomialRatchet
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







theorem arithOdd_not_two_mul (n : Nat) : ¬ ArithOdd (2 * n) := by
  rintro ⟨t, ht⟩
  omega














end CollatzWork.Disproof



open CollatzWork.Disproof in
theorem solution :
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
