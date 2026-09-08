import Lean
import Theorems.Thm_NewMathDiscovery_LinearBlindness_RankTwoInstability_target_nonzero_on_witness
open Lean
run_meta do
  let ci ← getConstInfo `NewMathDiscovery.LinearBlindness.RankTwoInstability.target_nonzero_on_witness
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_LinearBlindness_RankTwoInstability_target_nonzero_on_witness.theorem.json" (Json.str fmt.pretty).compress
