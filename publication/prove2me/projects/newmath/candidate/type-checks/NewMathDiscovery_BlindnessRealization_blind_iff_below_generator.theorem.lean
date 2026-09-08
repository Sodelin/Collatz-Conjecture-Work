import Lean
import Theorems.Thm_NewMathDiscovery_BlindnessRealization_blind_iff_below_generator
open Lean
run_meta do
  let ci ← getConstInfo `NewMathDiscovery.BlindnessRealization.blind_iff_below_generator
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_BlindnessRealization_blind_iff_below_generator.theorem.json" (Json.str fmt.pretty).compress
