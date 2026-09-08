import Lean
import Theorems.Thm_Erdos302Finite_rat_plateau_732
open Lean
run_meta do
  let ci ← getConstInfo `Erdos302Finite.rat_plateau_732
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/Erdos302Finite_rat_plateau_732.theorem.json" (Json.str fmt.pretty).compress
