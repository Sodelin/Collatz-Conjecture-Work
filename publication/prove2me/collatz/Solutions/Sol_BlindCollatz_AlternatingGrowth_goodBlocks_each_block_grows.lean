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

 theorem block_grows (q : Nat) : 16 * q + 11 < block (16 * q + 11) := by
  rw [block_formula]
  omega

 

end BlindCollatz.AlternatingGrowth

namespace BlindCollatz.AlternatingGrowth

 





 

 

end BlindCollatz.AlternatingGrowth

namespace BlindCollatz.AlternatingGrowth



 

 



end BlindCollatz.AlternatingGrowth

namespace BlindCollatz.AlternatingGrowth




















end BlindCollatz.AlternatingGrowth



open BlindCollatz.AlternatingGrowth in
theorem solution (m n : Nat) (hgood : goodBlocks m n) :
    ∀ j : Nat, j < m → blocks j n < blocks (j + 1) n := by
  induction m generalizing n with
  | zero => intro j hj; omega
  | succ m ih =>
    intro j hj
    obtain ⟨⟨q, rfl⟩, hnext⟩ := hgood
    cases j with
    | zero => simpa [blocks] using block_grows q
    | succ j =>
      simpa [blocks] using ih (block (16 * q + 11)) hnext j (by omega)
