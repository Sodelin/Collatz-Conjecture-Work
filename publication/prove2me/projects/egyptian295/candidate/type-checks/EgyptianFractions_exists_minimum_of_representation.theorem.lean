import Lean
import Theorems.Thm_EgyptianFractions_exists_minimum_of_representation
open Lean
run_meta do
  let ci ← getConstInfo `EgyptianFractions.exists_minimum_of_representation
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/EgyptianFractions_exists_minimum_of_representation.theorem.json" (Json.str fmt.pretty).compress
