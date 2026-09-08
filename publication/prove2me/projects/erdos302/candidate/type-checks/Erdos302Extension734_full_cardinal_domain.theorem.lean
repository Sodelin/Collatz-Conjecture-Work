import Lean
import Theorems.Thm_Erdos302Extension734_full_cardinal_domain
open Lean
run_meta do
  let ci ← getConstInfo `Erdos302Extension734.full_cardinal_domain
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/Erdos302Extension734_full_cardinal_domain.theorem.json" (Json.str fmt.pretty).compress
