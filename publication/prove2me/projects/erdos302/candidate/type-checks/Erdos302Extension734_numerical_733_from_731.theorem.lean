import Lean
import Theorems.Thm_Erdos302Extension734_numerical_733_from_731
open Lean
run_meta do
  let ci ← getConstInfo `Erdos302Extension734.numerical_733_from_731
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/Erdos302Extension734_numerical_733_from_731.theorem.json" (Json.str fmt.pretty).compress
