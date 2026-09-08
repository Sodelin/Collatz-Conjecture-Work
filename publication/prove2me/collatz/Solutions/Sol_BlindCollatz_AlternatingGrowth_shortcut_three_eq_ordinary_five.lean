import Std
import Init.Grind.Ordered.Module
import Definitions.Def_ArchiveAlternatingGrowth
import Theorems.Thm_BlindCollatz_AlternatingGrowth_ordinary_five
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

 





 

 

end BlindCollatz.AlternatingGrowth

namespace BlindCollatz.AlternatingGrowth



 

 



end BlindCollatz.AlternatingGrowth

namespace BlindCollatz.AlternatingGrowth




















end BlindCollatz.AlternatingGrowth



open BlindCollatz.AlternatingGrowth in
theorem solution (q : Nat) :
    block (16 * q + 11) = ordinarySteps 5 (16 * q + 11) := by
  rw [block_formula, ordinary_five]
