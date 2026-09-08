import Lean
import Solutions.Sol_NewMathDiscovery_LinearBlindness_RankTwoInstability_unbounded_target_on_gauge_fixed_kernel
open Lean
run_meta do
  let ci ← getConstInfo `solution
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_LinearBlindness_RankTwoInstability_unbounded_target_on_gauge_fixed_kernel.solution.json" (Json.str fmt.pretty).compress
