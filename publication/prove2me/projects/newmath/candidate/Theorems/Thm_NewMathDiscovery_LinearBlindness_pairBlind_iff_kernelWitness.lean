import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_LinearBlindness



theorem NewMathDiscovery.LinearBlindness.pairBlind_iff_kernelWitness {Index State Value : Type}
    (system : System Index State Value) (selected : Index → Prop) :
    PairBlind system selected ↔ KernelWitness system selected := by sorry

