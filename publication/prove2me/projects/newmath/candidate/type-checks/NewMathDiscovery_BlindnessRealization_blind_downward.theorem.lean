import Lean
import Theorems.Thm_NewMathDiscovery_BlindnessRealization_blind_downward
open Lean
run_meta do
  let ci ← getConstInfo `NewMathDiscovery.BlindnessRealization.blind_downward
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_BlindnessRealization_blind_downward.theorem.json" (Json.str fmt.pretty).compress
