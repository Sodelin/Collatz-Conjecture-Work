import Lean
import Solutions.Sol_CollatzWork_refinedChild_arithmetic
import Theorems.Thm_CollatzWork_refinedChild_arithmetic

open Lean Meta
set_option maxHeartbeats 0
set_option maxRecDepth 10000
set_option pp.universes true
set_option pp.explicit true
set_option pp.fullNames true
run_meta do
  let si ← getConstInfo `solution
  let ti ← getConstInfo `CollatzWork.refinedChild_arithmetic
  let countEqual := si.levelParams.length == ti.levelParams.length
  let levels := (List.range si.levelParams.length).map fun i => Level.param (Name.mkSimple ("audit_universe_" ++ toString i))
  let st := si.type.instantiateLevelParams si.levelParams levels
  let tt := ti.type.instantiateLevelParams ti.levelParams levels
  let noMetavariables := !(st.hasMVar || tt.hasMVar || st.hasLevelMVar || tt.hasLevelMVar)
  let matched ← if countEqual && noMetavariables then isDefEq st tt else pure false
  let sty ← ppExpr st
  let tty ← ppExpr tt
  let row := Json.mkObj [
    ("theorem_name", toJson "CollatzWork.refinedChild_arithmetic"),
    ("passed", toJson (countEqual && noMetavariables && matched)),
    ("universe_count_equal", toJson countEqual),
    ("solution_universe_parameters", toJson (si.levelParams.map toString)),
    ("target_universe_parameters", toJson (ti.levelParams.map toString)),
    ("rigid_universe_parameters", toJson ((List.range si.levelParams.length).map fun i => "audit_universe_" ++ toString i)),
    ("no_metavariables", toJson noMetavariables),
    ("definitionally_equal_at_rigid_levels", toJson matched),
    ("solution_type", toJson sty.pretty),
    ("target_type", toJson tty.pretty)]
  IO.println ("TYPECHECK_JSON " ++ row.compress)
  unless countEqual && noMetavariables && matched do
    throwError "solution and target differ at independent rigid universe parameters"
