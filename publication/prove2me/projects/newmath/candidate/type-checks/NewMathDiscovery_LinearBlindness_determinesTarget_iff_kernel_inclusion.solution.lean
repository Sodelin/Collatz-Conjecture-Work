import Lean
import Solutions.Sol_NewMathDiscovery_LinearBlindness_determinesTarget_iff_kernel_inclusion
open Lean
run_meta do
  let ci ← getConstInfo `solution
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_LinearBlindness_determinesTarget_iff_kernel_inclusion.solution.json" (Json.str fmt.pretty).compress
