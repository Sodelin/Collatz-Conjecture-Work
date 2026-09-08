import Lean
import Theorems.Thm_Erdos302Finite_replacement_admissible
open Lean
run_meta do
  let ci ← getConstInfo `Erdos302Finite.replacement_admissible
  let fmt ← Lean.Meta.ppExpr ci.type
  IO.FS.writeFile "type-checks/Erdos302Finite_replacement_admissible.theorem.json" (Json.str fmt.pretty).compress
