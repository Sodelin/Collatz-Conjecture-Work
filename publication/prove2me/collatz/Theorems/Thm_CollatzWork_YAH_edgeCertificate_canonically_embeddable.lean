import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule

set_option maxRecDepth 100000 in
theorem CollatzWork.YAH.edgeCertificate_canonically_embeddable :
    edgeCertificate.all (fun entry =>
      canonicalLabeled (canonicalExtension entry.2.lhs) &&
      canonicalLabeled (canonicalExtension entry.2.rhs)) = true := by sorry

