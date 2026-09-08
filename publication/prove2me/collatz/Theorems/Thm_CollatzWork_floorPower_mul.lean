import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_FloorPower



theorem CollatzWork.floorPower_mul {a x f k : Nat}
    (ha : 2 ^ f ≤ a) (ha' : a < 2 ^ (f + 1))
    (hx : 2 ^ k ≤ x) (hx' : x < 2 ^ (k + 1)) :
    floorPower (a * x) =
      if a * x < 2 ^ (f + 1) * 2 ^ k then 2 ^ f * 2 ^ k
      else 2 ^ (f + 1) * 2 ^ k := by sorry

