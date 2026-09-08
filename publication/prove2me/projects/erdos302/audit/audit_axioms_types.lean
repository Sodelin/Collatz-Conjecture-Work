import Lean
import Plateau302
import Extension734
import KernelIsolation
import KernelEndpoints734
open Lean
run_meta do
  let env ← getEnv
  let prefixes : Array Name := #[`Plateau302, `Extension734, `KernelIsolation, `KernelEndpoints734]
  let mut rows : Array String := #[]
  for (n, ci) in env.constants.toList do
    let some idx := env.getModuleIdxFor? n | continue
    let some m := env.header.moduleNames[idx.toNat]? | continue
    unless prefixes.any (fun p => p.isPrefixOf m) do continue
    unless !n.isInternal || (privateToUserName? n).isSome do continue
    let axs ← Lean.collectAxioms n
    let typeFmt ← Lean.Meta.ppExpr ci.type
    let kind := match ci with
      | .thmInfo _ => "theorem" | .defnInfo _ => "def" | .axiomInfo _ => "axiom"
      | .opaqueInfo _ => "opaque" | .inductInfo _ => "inductive" | .ctorInfo _ => "ctor"
      | .recInfo _ => "rec" | .quotInfo _ => "quot"
    let row := Json.mkObj [("name", toJson n.toString), ("module", toJson m.toString),
      ("kind", toJson kind), ("axioms", toJson (axs.map Name.toString)),
      ("type", toJson typeFmt.pretty)]
    rows := rows.push row.compress
  IO.FS.writeFile "prove2me-audit/axiom-types.jsonl" (String.intercalate "\n" rows.toList)
  logInfo s!"audited {rows.size} declarations"
