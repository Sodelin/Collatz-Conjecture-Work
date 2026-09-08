import Lean
import Solutions.Sol_Erdos302Kernel_isolated_nat
open Lean
run_meta do
  let ci ← getConstInfo `solution
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/Erdos302Kernel_isolated_nat.solution.json" (Json.str fmt.pretty).compress
