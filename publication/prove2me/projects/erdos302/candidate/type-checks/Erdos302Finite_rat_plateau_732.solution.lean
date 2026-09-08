import Lean
import Solutions.Sol_Erdos302Finite_rat_plateau_732
open Lean
run_meta do
  let ci ← getConstInfo `solution
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/Erdos302Finite_rat_plateau_732.solution.json" (Json.str fmt.pretty).compress
