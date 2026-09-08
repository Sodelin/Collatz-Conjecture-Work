import Lean
import CollatzWork.AffineRepetition
import CollatzWork.AffineRepetitionStatement
import CollatzWork.BlockArithmetic
import CollatzWork.Convergence
import CollatzWork.ConvergenceStatement
import CollatzWork.Disproof.BranchingCenter
import CollatzWork.Disproof.FiniteResidueFirstIntegral
import CollatzWork.Disproof.PolynomialRatchet
import CollatzWork.Disproof.TwoPumpDependency
import CollatzWork.ExcursionBudget
import CollatzWork.ExcursionBudgetStatement
import CollatzWork.FinitePaletteObstruction
import CollatzWork.FinitePaletteObstructionStatement
import CollatzWork.FirstContraction
import CollatzWork.FirstContractionStatement
import CollatzWork.FloorPower
import CollatzWork.InverseWordBoundary
import CollatzWork.InverseWordBoundaryStatement
import CollatzWork.PrefixCollision
import CollatzWork.PrefixCollisionStatement
import CollatzWork.QuarterGap
import CollatzWork.QuarterGapStatement
import CollatzWork.QuarterGapUniversal
import CollatzWork.QuarterGapUniversalStatement
import CollatzWork.RefinedMersenneChild
import CollatzWork.ResidueAncestor
import CollatzWork.ResidueAncestorStatement
import CollatzWork.ResidueAncestorTails
import CollatzWork.RootDescent
import CollatzWork.RootDescentStatement
import CollatzWork.TwoBurst
import CollatzWork.TwoBurstStatement
import CollatzWork.YAHFiniteObstruction
import CollatzWork.YAHFiniteObstructionStatement
import CollatzWork
import ArchiveAlternatingGrowth
import ArchiveDescent
import ArchiveRepetitionBound
open Lean
set_option pp.universes true
set_option pp.explicit true
set_option pp.fullNames true
run_meta do
  let env ← getEnv
  let mut rows : Array String := #[]
  for (n, ci) in env.constants.toList do
    let some idx := env.getModuleIdxFor? n | continue
    let some m := env.header.moduleNames[idx.toNat]? | continue
    unless m.toString.startsWith "CollatzWork" || m.toString.startsWith "Archive" do continue
    let .thmInfo _ := ci | continue
    let ax ← Lean.collectAxioms n
    let ty ← Lean.Meta.ppExpr ci.type
    let range ← findDeclarationRanges? n
    let sl := range.map (·.range.pos.line) |>.getD 0
    rows := rows.push (Json.mkObj [("name", toJson n.toString),
      ("module", toJson m.toString), ("startLine", toJson sl),
      ("axioms", toJson (ax.map (·.toString))), ("type", toJson ty.pretty)]).compress
  IO.FS.writeFile "prove2me-audit/axiom-type-audit.jsonl" (String.intercalate "\n" rows.toList)
  logInfo s!"Audited {rows.size} theorems"
