import Std
import Init.Grind.Ordered.Module
import Definitions.Def_ArchiveAlternatingGrowth
import Theorems.Thm_BlindCollatz_AlternatingGrowth_ordinary_five



theorem BlindCollatz.AlternatingGrowth.shortcut_three_eq_ordinary_five (q : Nat) :
    block (16 * q + 11) = ordinarySteps 5 (16 * q + 11) := by sorry

