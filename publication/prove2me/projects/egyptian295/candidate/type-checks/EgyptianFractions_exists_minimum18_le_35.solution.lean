import Lean
import Solutions.Sol_EgyptianFractions_exists_minimum18_le_35
open Lean
run_meta do
  let ci ← getConstInfo `solution
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/EgyptianFractions_exists_minimum18_le_35.solution.json" (Json.str fmt.pretty).compress
