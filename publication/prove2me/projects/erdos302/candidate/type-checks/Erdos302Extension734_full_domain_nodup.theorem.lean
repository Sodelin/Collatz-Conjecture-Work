import Lean
import Theorems.Thm_Erdos302Extension734_full_domain_nodup
open Lean
run_meta do
  let ci ← getConstInfo `Erdos302Extension734.full_domain_nodup
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/Erdos302Extension734_full_domain_nodup.theorem.json" (Json.str fmt.pretty).compress
