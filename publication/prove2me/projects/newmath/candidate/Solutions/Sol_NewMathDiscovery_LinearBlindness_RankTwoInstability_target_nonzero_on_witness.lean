import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_LinearBlindness



open NewMathDiscovery.LinearBlindness.RankTwoInstability in
theorem solution (n : Nat) :
    target (witness n) ≠ 0 := by
  simp [target, witness]
  omega
