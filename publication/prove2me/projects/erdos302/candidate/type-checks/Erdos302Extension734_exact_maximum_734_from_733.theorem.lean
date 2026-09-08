import Lean
import Theorems.Thm_Erdos302Extension734_exact_maximum_734_from_733
open Lean
run_meta do
  let ci ← getConstInfo `Erdos302Extension734.exact_maximum_734_from_733
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/Erdos302Extension734_exact_maximum_734_from_733.theorem.json" (Json.str fmt.pretty).compress
