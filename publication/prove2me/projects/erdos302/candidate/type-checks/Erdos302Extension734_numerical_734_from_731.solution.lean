import Lean
import Solutions.Sol_Erdos302Extension734_numerical_734_from_731
open Lean
run_meta do
  let ci ← getConstInfo `solution
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/Erdos302Extension734_numerical_734_from_731.solution.json" (Json.str fmt.pretty).compress
