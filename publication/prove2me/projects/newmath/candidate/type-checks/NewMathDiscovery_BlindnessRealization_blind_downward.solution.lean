import Lean
import Solutions.Sol_NewMathDiscovery_BlindnessRealization_blind_downward
open Lean
run_meta do
  let ci ← getConstInfo `solution
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_BlindnessRealization_blind_downward.solution.json" (Json.str fmt.pretty).compress
