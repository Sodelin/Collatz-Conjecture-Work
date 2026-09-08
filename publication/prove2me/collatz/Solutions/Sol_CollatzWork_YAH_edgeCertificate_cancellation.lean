import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule

open CollatzWork.YAH in
set_option maxRecDepth 100000 in
theorem solution :
    allTokenEdges.map
        (weightedCoefficient edgeCertificate labeledEdgeDelta) =
      allTokenEdges.map (fun _ => 0) := by decide
