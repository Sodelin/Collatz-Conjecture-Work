import Lean
import Solutions.Sol_NewMathDiscovery_LinearBlindness_pairBlind_iff_kernelWitness
open Lean
run_meta do
  let ci ← getConstInfo `solution
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_LinearBlindness_pairBlind_iff_kernelWitness.solution.json" (Json.str fmt.pretty).compress
