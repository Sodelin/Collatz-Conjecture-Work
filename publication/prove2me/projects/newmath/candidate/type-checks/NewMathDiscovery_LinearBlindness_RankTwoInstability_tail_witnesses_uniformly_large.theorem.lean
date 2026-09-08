import Lean
import Theorems.Thm_NewMathDiscovery_LinearBlindness_RankTwoInstability_tail_witnesses_uniformly_large
open Lean
run_meta do
  let ci ← getConstInfo `NewMathDiscovery.LinearBlindness.RankTwoInstability.tail_witnesses_uniformly_large
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_LinearBlindness_RankTwoInstability_tail_witnesses_uniformly_large.theorem.json" (Json.str fmt.pretty).compress
