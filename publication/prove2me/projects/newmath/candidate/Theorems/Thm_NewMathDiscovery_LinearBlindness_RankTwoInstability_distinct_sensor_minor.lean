import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_LinearBlindness



theorem NewMathDiscovery.LinearBlindness.RankTwoInstability.distinct_sensor_minor {m n : Nat} (hne : m ≠ n) :
    determinant (sensorRow m) (sensorRow n) ≠ 0 := by sorry

