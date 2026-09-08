import Lean
import Theorems.Thm_NewMathDiscovery_LinearBlindness_determinesTarget_iff_kernel_inclusion
open Lean
run_meta do
  let ci ← getConstInfo `NewMathDiscovery.LinearBlindness.determinesTarget_iff_kernel_inclusion
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_LinearBlindness_determinesTarget_iff_kernel_inclusion.theorem.json" (Json.str fmt.pretty).compress
