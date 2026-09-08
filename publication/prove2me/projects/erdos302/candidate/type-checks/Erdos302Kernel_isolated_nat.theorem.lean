import Lean
import Theorems.Thm_Erdos302Kernel_isolated_nat
open Lean
run_meta do
  let ci ← getConstInfo `Erdos302Kernel.isolated_nat
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/Erdos302Kernel_isolated_nat.theorem.json" (Json.str fmt.pretty).compress
