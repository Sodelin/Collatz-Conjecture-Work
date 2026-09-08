import Lean
import Theorems.Thm_NewMathDiscovery_LinearBlindness_RankTwoInstability_distinct_sensor_minor
open Lean
run_meta do
  let ci ← getConstInfo `NewMathDiscovery.LinearBlindness.RankTwoInstability.distinct_sensor_minor
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_LinearBlindness_RankTwoInstability_distinct_sensor_minor.theorem.json" (Json.str fmt.pretty).compress
