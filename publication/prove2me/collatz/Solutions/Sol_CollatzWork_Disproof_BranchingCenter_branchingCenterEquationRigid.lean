import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_Disproof_BranchingCenter
import Theorems.Thm_CollatzWork_Disproof_BranchingCenter_centerTwoPowerOddNormalFormUnique
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



theorem centerOdd_one : CenterOdd 1 := by
  exact ⟨0, by decide⟩





/-- If `n` is positive, then `2^n + 3` is odd. -/
theorem centerOdd_twoPow_add_three (n : Nat) (hn : 0 < n) :
    CenterOdd (2 ^ n + 3) := by
  cases n with
  | zero => omega
  | succ k =>
      refine ⟨2 ^ k + 1, ?_⟩
      rw [Nat.pow_succ]
      omega







end CollatzWork.Disproof.BranchingCenter



open CollatzWork.Disproof.BranchingCenter in
theorem solution
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
