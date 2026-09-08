import Std
import Init.Grind.Ordered.Module
import Definitions.Def_ArchiveAlternatingGrowth



theorem BlindCollatz.AlternatingGrowth.arbitrarily_long_expansion (m : Nat) (hm : 0 < m) :
    ∃ n : Nat, goodBlocks m n ∧ n < blocks m n := by sorry

