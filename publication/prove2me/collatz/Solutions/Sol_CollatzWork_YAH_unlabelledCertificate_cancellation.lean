import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule

open CollatzWork.YAH in
theorem solution :
    allSymbolEdges.map
        (weightedCoefficient unlabelledCertificate unlabelledEdgeDelta) =
      allSymbolEdges.map negativeFFCoefficient := by decide
