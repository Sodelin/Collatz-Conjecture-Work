import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_Disproof_BranchingCenter
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





theorem centerOdd_not_two_mul (n : Nat) : ¬ CenterOdd (2 * n) := by
  rintro ⟨t, ht⟩
  omega











end CollatzWork.Disproof.BranchingCenter



open CollatzWork.Disproof.BranchingCenter in
theorem solution :
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
