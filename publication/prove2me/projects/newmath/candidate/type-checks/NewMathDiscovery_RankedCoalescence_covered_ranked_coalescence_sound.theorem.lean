import Lean
import Theorems.Thm_NewMathDiscovery_RankedCoalescence_covered_ranked_coalescence_sound
open Lean
run_meta do
  let ci ← getConstInfo `NewMathDiscovery.RankedCoalescence.covered_ranked_coalescence_sound
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_RankedCoalescence_covered_ranked_coalescence_sound.theorem.json" (Json.str fmt.pretty).compress
