import Std
import Init.Grind.Ordered.Module



theorem solution (n : Nat) :
    0 < n → ∃ e u : Nat, 0 < u ∧ u % 3 ≠ 0 ∧ 3 ^ e * u = n := by
  induction n using Nat.strongRecOn with
  | ind n ih =>
      intro hn
      by_cases hd : n % 3 = 0
      · have hqpos : 0 < n / 3 := by omega
        have hqlt : n / 3 < n := by omega
        obtain ⟨e, u, hu, hunit, he⟩ := ih (n / 3) hqlt hqpos
        refine ⟨e + 1, u, hu, hunit, ?_⟩
        rw [Nat.pow_succ, Nat.mul_comm (3 ^ e) 3, Nat.mul_assoc, he]
        omega
      · exact ⟨0, n, hn, hd, by simp⟩
