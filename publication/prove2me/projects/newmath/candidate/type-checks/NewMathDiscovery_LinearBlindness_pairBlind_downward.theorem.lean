import Lean
import Theorems.Thm_NewMathDiscovery_LinearBlindness_pairBlind_downward
open Lean
run_meta do
  let ci ← getConstInfo `NewMathDiscovery.LinearBlindness.pairBlind_downward
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_LinearBlindness_pairBlind_downward.theorem.json" (Json.str fmt.pretty).compress
