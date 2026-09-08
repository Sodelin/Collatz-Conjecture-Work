import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_Disproof_PolynomialRatchet
import Theorems.Thm_CollatzWork_Disproof_twoPowerOddNormalFormUnique
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










end CollatzWork.Disproof



open CollatzWork.Disproof in
theorem solution
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
