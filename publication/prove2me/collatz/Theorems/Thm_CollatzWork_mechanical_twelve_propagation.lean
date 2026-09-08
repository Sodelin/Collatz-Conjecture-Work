import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_BlockArithmetic
import Definitions.Def_CollatzWork_FloorPower
import Definitions.Def_CollatzWork_QuarterGapStatement
import Theorems.Thm_CollatzWork_blockNumerator12_exact_bound
import Theorems.Thm_CollatzWork_mechanical_twelve_identity



theorem CollatzWork.mechanical_twelve_propagation (s : Nat)
    (hstart : 4 * mechanicalMax s ≤ s * 3 ^ s) :
    4 * mechanicalMax (s + 12) ≤ (s + 12) * 3 ^ (s + 12) := by sorry

