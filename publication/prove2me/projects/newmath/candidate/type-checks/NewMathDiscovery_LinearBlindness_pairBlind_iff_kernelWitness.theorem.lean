import Lean
import Theorems.Thm_NewMathDiscovery_LinearBlindness_pairBlind_iff_kernelWitness
open Lean
run_meta do
  let ci ← getConstInfo `NewMathDiscovery.LinearBlindness.pairBlind_iff_kernelWitness
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/NewMathDiscovery_LinearBlindness_pairBlind_iff_kernelWitness.theorem.json" (Json.str fmt.pretty).compress
