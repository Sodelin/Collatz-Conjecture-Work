import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_BlockArithmetic



theorem CollatzWork.blockNumerator12_exact_bound {B x : Nat} (hB : 0 < B)
    (hxlo : B ≤ x) (hxhi : x < 2 * B) :
    262144 * blockNumerator12 B x ≤ 416200322061 * x := by sorry

