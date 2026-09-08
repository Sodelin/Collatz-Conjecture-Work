import Lean
import Solutions.Sol_NewMathDiscovery_RankedCoalescence_covered_ranked_coalescence_sound
open Lean
run_meta do
  let ci ← getConstInfo `solution
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_RankedCoalescence_covered_ranked_coalescence_sound.solution.json" (Json.str fmt.pretty).compress
