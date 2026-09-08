import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule

set_option maxRecDepth 100000 in
theorem CollatzWork.YAH.edgeCertificate_cancellation :
    allTokenEdges.map
        (weightedCoefficient edgeCertificate labeledEdgeDelta) =
      allTokenEdges.map (fun _ => 0) := by sorry

