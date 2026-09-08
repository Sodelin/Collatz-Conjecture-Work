import Lean
import Theorems.Thm_NewMathDiscovery_LinearBlindness_RankTwoInstability_unbounded_target_on_gauge_fixed_kernel
open Lean
run_meta do
  let ci ← getConstInfo `NewMathDiscovery.LinearBlindness.RankTwoInstability.unbounded_target_on_gauge_fixed_kernel
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_LinearBlindness_RankTwoInstability_unbounded_target_on_gauge_fixed_kernel.theorem.json" (Json.str fmt.pretty).compress
