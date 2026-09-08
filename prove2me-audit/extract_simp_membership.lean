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
run_meta do
  let env ← getEnv
  let simpThms ← Lean.Meta.getSimpTheorems
  let mut rows : Array String := #[]
  for (n, _) in env.constants.toList do
    let some idx := env.getModuleIdxFor? n | continue
    let some m := env.header.moduleNames[idx.toNat]? | continue
    unless m.toString.startsWith "CollatzWork" || m.toString.startsWith "Archive" do continue
    if simpThms.isLemma (.decl n) then
      rows := rows.push (Json.mkObj [("name", toJson n.toString),("module", toJson m.toString)]).compress
  IO.FS.writeFile "prove2me-audit/simp-membership.jsonl" (String.intercalate "\n" rows.toList)
