import Lean
import Theorems.Thm_Erdos302Extension734_lift_admissible
open Lean
run_meta do
  let ci ← getConstInfo `Erdos302Extension734.lift_admissible
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/Erdos302Extension734_lift_admissible.theorem.json" (Json.str fmt.pretty).compress
