import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_LinearBlindness



theorem NewMathDiscovery.LinearBlindness.determinesTarget_iff_kernel_inclusion {Index State Value : Type}
    (system : System Index State Value) (selected : Index → Prop) :
    DeterminesTarget system selected ↔
      ∀ direction,
        InObservationKernel system selected direction →
          system.target direction = system.zeroValue := by sorry

