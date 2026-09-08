import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_RefinedMersenneChild



theorem CollatzWork.compatibleProduct_mod_four
    (L epsilon z : Nat) (hepsilon : epsilon ≤ 1)
    (hparity : epsilon % 2 = L % 2) :
    (3 ^ L * refinedA epsilon z) % 4 = 1 := by sorry

