import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstruction
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule

theorem CollatzWork.YAH.symbolCertificate_canonically_embeddable :
    symbolCertificate.all (fun entry =>
      canonicalLabeled (canonicalExtension entry.2.lhs) &&
      canonicalLabeled (canonicalExtension entry.2.rhs)) = true := by sorry

