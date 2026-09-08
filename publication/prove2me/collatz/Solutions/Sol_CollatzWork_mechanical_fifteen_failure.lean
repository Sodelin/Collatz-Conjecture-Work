import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_QuarterGapStatement
import Definitions.Def_CollatzWork_QuarterGapUniversalStatement



open CollatzWork in
set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in

theorem solution : MechanicalFifteenFailureStatement := by
  unfold MechanicalFifteenFailureStatement
  decide
