import Lean
import Solutions.Sol_Erdos302Finite_replacement_admissible
open Lean
run_meta do
  let ci ← getConstInfo `solution
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/Erdos302Finite_replacement_admissible.solution.json" (Json.str fmt.pretty).compress
