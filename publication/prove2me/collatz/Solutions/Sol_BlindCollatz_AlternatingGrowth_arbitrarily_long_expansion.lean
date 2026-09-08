import Std
import Init.Grind.Ordered.Module
import Definitions.Def_ArchiveAlternatingGrowth
namespace BlindCollatz.AlternatingGrowth





 theorem first_step (q : Nat) : step (16 * q + 11) = 24 * q + 17 := by
  simp only [step, show (16 * q + 11) % 2 ≠ 0 by omega, if_false]
  omega

 theorem second_step (q : Nat) : step (24 * q + 17) = 36 * q + 26 := by
  simp only [step, show (24 * q + 17) % 2 ≠ 0 by omega, if_false]
  omega

 theorem third_step (q : Nat) : step (36 * q + 26) = 18 * q + 13 := by
  simp only [step, show (36 * q + 26) % 2 = 0 by omega, if_true]
  omega

 theorem block_formula (q : Nat) : block (16 * q + 11) = 18 * q + 13 := by
  simp [block, first_step, second_step, third_step]

 

 

end BlindCollatz.AlternatingGrowth

namespace BlindCollatz.AlternatingGrowth

 theorem block_scaled (x : Nat) (hx : 0 < x) :
    block (16 * x - 5) = 18 * x - 5 := by
  have h : 16 * x - 5 = 16 * (x - 1) + 11 := by omega
  rw [h, block_formula]
  omega





 theorem block_seed_succ (m t : Nat) (ht : 0 < t) :
    block (seed (m + 1) t) = seed m (9 * t) := by
  simp only [seed]
  rw [block_scaled _ (Nat.mul_pos (Nat.pow_pos (by decide)) ht)]
  have h₁ : 8 ^ (m + 1) * t = 8 * (8 ^ m * t) := by
    rw [Nat.pow_succ]
    ac_rfl
  have h₂ : 8 ^ m * (9 * t) = 9 * (8 ^ m * t) := by ac_rfl
  rw [h₁, h₂]
  omega

 theorem iterated_seed (m t : Nat) (ht : 0 < t) :
    blocks m (seed m t) = 16 * (9 ^ m * t) - 5 := by
  induction m generalizing t with
  | zero => simp [blocks, seed]
  | succ m ih =>
    rw [blocks, block_seed_succ m t ht, ih (9 * t) (by omega)]
    have h : 9 ^ m * (9 * t) = 9 ^ (m + 1) * t := by
      rw [Nat.pow_succ]
      ac_rfl
    rw [h]

end BlindCollatz.AlternatingGrowth

namespace BlindCollatz.AlternatingGrowth



 theorem seed_good_blocks (m t : Nat) (ht : 0 < t) :
    goodBlocks m (seed m t) := by
  induction m generalizing t with
  | zero => trivial
  | succ m ih =>
    constructor
    · refine ⟨8 ^ (m + 1) * t - 1, ?_⟩
      have hpos : 0 < 8 ^ (m + 1) * t := Nat.mul_pos (Nat.pow_pos (by decide : 0 < 8)) ht
      simp only [seed]
      omega
    · rw [block_seed_succ m t ht]
      exact ih (9 * t) (by omega)

 theorem iterated_seed_grows (m t : Nat) (hm : 0 < m) (ht : 0 < t) :
    seed m t < blocks m (seed m t) := by
  rw [iterated_seed m t ht]
  simp only [seed]
  have hp := Nat.pow_lt_pow_left (by decide : 8 < 9) (by omega : m ≠ 0)
  have hh := Nat.mul_lt_mul_of_pos_right hp ht
  have hpos : 0 < 8 ^ m * t := Nat.mul_pos (Nat.pow_pos (by decide : 0 < 8)) ht
  omega



end BlindCollatz.AlternatingGrowth

namespace BlindCollatz.AlternatingGrowth




















end BlindCollatz.AlternatingGrowth



open BlindCollatz.AlternatingGrowth in
theorem solution (m : Nat) (hm : 0 < m) :
    ∃ n : Nat, goodBlocks m n ∧ n < blocks m n := by
  exact ⟨seed m 1, seed_good_blocks m 1 (by decide),
    iterated_seed_grows m 1 hm (by decide)⟩
