import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_LinearBlindness



theorem NewMathDiscovery.LinearBlindness.RankTwoInstability.unbounded_target_on_gauge_fixed_kernel (bound : Nat) :
    ∃ n direction,
      observe n direction = 0 ∧
      direction.2 = -1 ∧
      target direction > Int.ofNat bound := by sorry

