import Std
import Init.Grind.Ordered.Module
import Definitions.Def_ArchiveAlternatingGrowth



theorem BlindCollatz.AlternatingGrowth.goodBlocks_each_block_grows (m n : Nat) (hgood : goodBlocks m n) :
    ∀ j : Nat, j < m → blocks j n < blocks (j + 1) n := by sorry

