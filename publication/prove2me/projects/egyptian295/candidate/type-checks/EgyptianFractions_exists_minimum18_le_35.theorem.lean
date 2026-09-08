import Lean
import Theorems.Thm_EgyptianFractions_exists_minimum18_le_35
open Lean
run_meta do
  let ci ← getConstInfo `EgyptianFractions.exists_minimum18_le_35
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/EgyptianFractions_exists_minimum18_le_35.theorem.json" (Json.str fmt.pretty).compress
