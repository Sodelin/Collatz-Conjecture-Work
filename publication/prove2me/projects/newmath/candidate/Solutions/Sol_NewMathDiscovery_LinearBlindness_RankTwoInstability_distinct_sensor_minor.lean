import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_LinearBlindness



open NewMathDiscovery.LinearBlindness.RankTwoInstability in
theorem solution {m n : Nat} (hne : m ≠ n) :
    determinant (sensorRow m) (sensorRow n) ≠ 0 := by
  simp [determinant, sensorRow]
  omega
