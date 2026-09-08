import Lean
import Solutions.Sol_Erdos302Extension734_full_cardinal_domain
open Lean
run_meta do
  let ci ← getConstInfo `solution
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/Erdos302Extension734_full_cardinal_domain.solution.json" (Json.str fmt.pretty).compress
