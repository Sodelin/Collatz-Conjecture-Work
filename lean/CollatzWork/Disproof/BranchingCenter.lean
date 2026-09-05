import Std.Tactic

namespace CollatzWork.Disproof.BranchingCenter

/-!
# Rigidity of the two-center, three-edge branching ansatz

This module checks the arithmetic core of one narrowly scoped attempted
divergence construction.  For accelerated odd Collatz macros

`U_j(x) = (3*x + 1) / 2^j`,

the proposed center graph has edges `A -a-> A`, `A -b-> B`, and
`B -c-> A`.  Eliminating the two rational centers gives

`2^(b+c) + 3*2^b = 2^(a+b) + 3*2^a`.

For positive labels, the theorem below proves that this equation forces
`a = b = c`.  Thus the proposed graph collapses before positive-natural
membership, guard invariance, or escape can be established.  This is only a
route obstruction; it is not a proof or disproof of the Collatz conjecture.
-/

/-- Elementary oddness, stated explicitly so the normal-form argument does
not depend on a library parity API. -/
def CenterOdd (n : Nat) : Prop := ∃ t : Nat, n = 2 * t + 1

theorem centerOdd_one : CenterOdd 1 := by
  exact ⟨0, by decide⟩

theorem centerOdd_not_two_mul (n : Nat) : ¬ CenterOdd (2 * n) := by
  rintro ⟨t, ht⟩
  omega

/-- Exact uniqueness of a power-of-two times an odd natural. -/
theorem centerTwoPowerOddNormalFormUnique :
    ∀ R S A B : Nat,
      CenterOdd A → CenterOdd B →
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
          exact False.elim
            (centerOdd_not_two_mul (2 ^ S * B) (hEven ▸ hA))
  | succ R ih =>
      intro S A B hA hB hEq
      cases S with
      | zero =>
          have hEven : B = 2 * (2 ^ R * A) := by
            simpa [Nat.pow_succ, Nat.mul_assoc, Nat.mul_comm,
              Nat.mul_left_comm] using hEq.symm
          exact False.elim
            (centerOdd_not_two_mul (2 ^ R * A) (hEven ▸ hB))
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

/-- If `n` is positive, then `2^n + 3` is odd. -/
theorem centerOdd_twoPow_add_three (n : Nat) (hn : 0 < n) :
    CenterOdd (2 ^ n + 3) := by
  cases n with
  | zero => omega
  | succ k =>
      refine ⟨2 ^ k + 1, ?_⟩
      rw [Nat.pow_succ]
      omega

/-- The exact center-consistency equation admits no genuinely distinct
positive labels: it forces `a = b = c`. -/
theorem branchingCenterEquationRigid
    (a b c : Nat)
    (_ha : 0 < a) (hb : 0 < b) (hc : 0 < c)
    (hEq : 2 ^ (b + c) + 3 * 2 ^ b =
      2 ^ (a + b) + 3 * 2 ^ a) :
    a = b ∧ b = c := by
  have hFactored :
      2 ^ b * (2 ^ c + 3) = 2 ^ a * (2 ^ b + 3) := by
    calc
      2 ^ b * (2 ^ c + 3) = 2 ^ (b + c) + 3 * 2 ^ b := by
        simp [Nat.pow_add, Nat.mul_add, Nat.mul_comm]
      _ = 2 ^ (a + b) + 3 * 2 ^ a := hEq
      _ = 2 ^ a * (2 ^ b + 3) := by
        simp [Nat.pow_add, Nat.mul_add, Nat.mul_comm]
  obtain ⟨hba, hOddFactors⟩ :=
    centerTwoPowerOddNormalFormUnique b a (2 ^ c + 3) (2 ^ b + 3)
      (centerOdd_twoPow_add_three c hc)
      (centerOdd_twoPow_add_three b hb) hFactored
  have hPowers : 2 ^ c = 2 ^ b := by
    omega
  obtain ⟨hcb, _⟩ :=
    centerTwoPowerOddNormalFormUnique c b 1 1 centerOdd_one centerOdd_one
      (by simpa using hPowers)
  exact ⟨hba.symm, hcb.symm⟩

#print axioms CollatzWork.Disproof.BranchingCenter.centerTwoPowerOddNormalFormUnique
#print axioms CollatzWork.Disproof.BranchingCenter.centerOdd_twoPow_add_three
#print axioms CollatzWork.Disproof.BranchingCenter.branchingCenterEquationRigid

end CollatzWork.Disproof.BranchingCenter
