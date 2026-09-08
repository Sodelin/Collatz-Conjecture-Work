import Lean
import Theorems.Thm_BlindCollatz_AlternatingGrowth_arbitrarily_long_expansion
import Theorems.Thm_BlindCollatz_AlternatingGrowth_goodBlocks_each_block_grows
import Theorems.Thm_BlindCollatz_AlternatingGrowth_odd_exponents_one_two
import Theorems.Thm_BlindCollatz_AlternatingGrowth_ordinary_five
import Theorems.Thm_BlindCollatz_AlternatingGrowth_shortcut_three_eq_ordinary_five
import Theorems.Thm_BlindCollatz_RepetitionBound_affine_repetition_bound
import Theorems.Thm_BlindCollatz_RepetitionBound_alternating_repetition_bound
import Theorems.Thm_BlindCollatz_RepetitionBound_no_infinite_alternating_blocks
import Theorems.Thm_BlindCollatz_RepetitionBound_no_infinite_expanding_affine_blocks
import Theorems.Thm_BlindCollatz_RepetitionBound_telescope
import Theorems.Thm_BlindCollatz_descent_iff_convergence
import Theorems.Thm_CollatzWork_Disproof_BranchingCenter_branchingCenterEquationRigid
import Theorems.Thm_CollatzWork_Disproof_BranchingCenter_centerTwoPowerOddNormalFormUnique
import Theorems.Thm_CollatzWork_Disproof_FiniteResidueFirstIntegral_commutator_transitive_forces_constant
import Theorems.Thm_CollatzWork_Disproof_firstRotatedDeterminantCoefficients
import Theorems.Thm_CollatzWork_Disproof_noNonresonantContentGain
import Theorems.Thm_CollatzWork_Disproof_quotientDegreesVanish
import Theorems.Thm_CollatzWork_Disproof_secondRotatedDeterminantCoefficients
import Theorems.Thm_CollatzWork_Disproof_twoPowerOddNormalFormUnique
import Theorems.Thm_CollatzWork_Disproof_twoPumpCoefficientDependencies
import Theorems.Thm_CollatzWork_Disproof_twoPumpConstantObstructionVanishes
import Theorems.Thm_CollatzWork_Disproof_twoPumpSyzygy
import Theorems.Thm_CollatzWork_YAH_edgeCertificate_cancellation
import Theorems.Thm_CollatzWork_YAH_edgeCertificate_canonically_embeddable
import Theorems.Thm_CollatzWork_YAH_edgeCertificate_shape
import Theorems.Thm_CollatzWork_YAH_evalCoefficients_weightedCoefficient
import Theorems.Thm_CollatzWork_YAH_ffPumpWord_canonical
import Theorems.Thm_CollatzWork_YAH_noBoundedBelowCanonicalFFPumpWords
import Theorems.Thm_CollatzWork_YAH_noTwoStateEdgeAdditiveOrder
import Theorems.Thm_CollatzWork_YAH_noTwoStateEdgeCertificateOrientation
import Theorems.Thm_CollatzWork_YAH_noTwoStateSymbolAdditiveOrder
import Theorems.Thm_CollatzWork_YAH_noTwoStateSymbolCertificateOrientation
import Theorems.Thm_CollatzWork_YAH_symbolCertificate_cancellation
import Theorems.Thm_CollatzWork_YAH_symbolCertificate_canonically_embeddable
import Theorems.Thm_CollatzWork_YAH_symbolCertificate_shape
import Theorems.Thm_CollatzWork_YAH_twoState_rule_equations
import Theorems.Thm_CollatzWork_YAH_unlabelledCertificate_cancellation
import Theorems.Thm_CollatzWork_YAH_unlabelledCertificate_shape
import Theorems.Thm_CollatzWork_YAH_unlabelledRows_legal
import Theorems.Thm_CollatzWork_YAH_unlabelledRows_semantic
import Theorems.Thm_CollatzWork_YAH_weightedGapSum_pos
import Theorems.Thm_CollatzWork_YAH_yah13_forces_ff_negative
import Theorems.Thm_CollatzWork_affineQuarterCertificate
import Theorems.Thm_CollatzWork_affineRecurrenceTelescope
import Theorems.Thm_CollatzWork_affineRepetitionBound
import Theorems.Thm_CollatzWork_allPositiveConverge_of_smallerCoalescence
import Theorems.Thm_CollatzWork_blockNumerator12_exact_bound
import Theorems.Thm_CollatzWork_compatibleProduct_mod_four
import Theorems.Thm_CollatzWork_converges_iff_of_coalesces
import Theorems.Thm_CollatzWork_converges_shortcutIter_iff
import Theorems.Thm_CollatzWork_descentCriterion
import Theorems.Thm_CollatzWork_equalSlopeSmaller
import Theorems.Thm_CollatzWork_equalSlopeWitness
import Theorems.Thm_CollatzWork_excursionBudgetDescent
import Theorems.Thm_CollatzWork_excursionChainEnvelope
import Theorems.Thm_CollatzWork_excursionChain_converges_of_smaller
import Theorems.Thm_CollatzWork_excursionChain_terminal_descent
import Theorems.Thm_CollatzWork_finitePaletteObstruction
import Theorems.Thm_CollatzWork_finitePalette_path_obstruction
import Theorems.Thm_CollatzWork_finiteRepetitionBound
import Theorems.Thm_CollatzWork_firstContractionQuarterGap
import Theorems.Thm_CollatzWork_firstContractionThirdGap
import Theorems.Thm_CollatzWork_firstContractionTime
import Theorems.Thm_CollatzWork_firstContraction_quarter_of_certificate
import Theorems.Thm_CollatzWork_fixedRatioDivisibility
import Theorems.Thm_CollatzWork_floorPower_mul
import Theorems.Thm_CollatzWork_mechanicalCoarseBound
import Theorems.Thm_CollatzWork_mechanicalEnvelope
import Theorems.Thm_CollatzWork_mechanical_fifteen_failure
import Theorems.Thm_CollatzWork_mechanical_large_bound
import Theorems.Thm_CollatzWork_mechanical_twelve_identity
import Theorems.Thm_CollatzWork_mechanical_twelve_propagation
import Theorems.Thm_CollatzWork_mersenne_prefix_nondecreasing
import Theorems.Thm_CollatzWork_noInfiniteExpandingAffineBlocks
import Theorems.Thm_CollatzWork_noInfinitePositiveRecurrence
import Theorems.Thm_CollatzWork_oddRun
import Theorems.Thm_CollatzWork_orbitAffine
import Theorems.Thm_CollatzWork_parityPrefix_dvd_sub_of_le
import Theorems.Thm_CollatzWork_prefixCollision
import Theorems.Thm_CollatzWork_prefixReturnBernoulli
import Theorems.Thm_CollatzWork_prefixReturnNumericalBound
import Theorems.Thm_CollatzWork_prefixSeparation
import Theorems.Thm_CollatzWork_refinedChild_arithmetic
import Theorems.Thm_CollatzWork_refinedChild_iter
import Theorems.Thm_CollatzWork_refinedMersenneChild_coalesces
import Theorems.Thm_CollatzWork_refinedParent_converges_iff_child
import Theorems.Thm_CollatzWork_refinedParent_converges_of_smaller
import Theorems.Thm_CollatzWork_refinedParent_has_smaller_coalescence
import Theorems.Thm_CollatzWork_refinedParent_iter
import Theorems.Thm_CollatzWork_residueAncestor
import Theorems.Thm_CollatzWork_residueAncestor_factor_unit
import Theorems.Thm_CollatzWork_residueAncestor_normalized
import Theorems.Thm_CollatzWork_residueAncestor_of_divisibility
import Theorems.Thm_CollatzWork_residueAncestor_prefix_one
import Theorems.Thm_CollatzWork_residueAncestor_prefix_two
import Theorems.Thm_CollatzWork_residueAncestor_refinedTail
import Theorems.Thm_CollatzWork_residueAncestor_tail11
import Theorems.Thm_CollatzWork_residueAncestor_tail173
import Theorems.Thm_CollatzWork_residueAncestor_tail38
import Theorems.Thm_CollatzWork_residueAncestor_tail65
import Theorems.Thm_CollatzWork_residueAncestor_tail92
import Theorems.Thm_CollatzWork_rootDescent
import Theorems.Thm_CollatzWork_rootDescentAncestor
import Theorems.Thm_CollatzWork_rootDescentBurst
import Theorems.Thm_CollatzWork_rootDescent_converges_of_smaller
import Theorems.Thm_CollatzWork_shiftedEnvelope_compose
import Theorems.Thm_CollatzWork_shortcutIter_OOE
import Theorems.Thm_CollatzWork_smallerCoalescenceCriterion
import Theorems.Thm_CollatzWork_terminalEnvelope_compose
import Theorems.Thm_CollatzWork_twoBurstDescent
import Theorems.Thm_CollatzWork_twoBurst_converges_of_smaller
import Theorems.Thm_CollatzWork_twoBurst_power_margin
import Theorems.Thm_CollatzWork_universalMechanicalQuarterCertificate
open Lean
set_option maxRecDepth 10000
set_option maxHeartbeats 0
set_option pp.universes true
set_option pp.explicit true
set_option pp.fullNames true
run_meta do
  let mut rows : Array String := #[]
  let ci ← getConstInfo `BlindCollatz.AlternatingGrowth.arbitrarily_long_expansion
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "BlindCollatz.AlternatingGrowth.arbitrarily_long_expansion"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `BlindCollatz.AlternatingGrowth.goodBlocks_each_block_grows
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "BlindCollatz.AlternatingGrowth.goodBlocks_each_block_grows"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `BlindCollatz.AlternatingGrowth.odd_exponents_one_two
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "BlindCollatz.AlternatingGrowth.odd_exponents_one_two"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `BlindCollatz.AlternatingGrowth.ordinary_five
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "BlindCollatz.AlternatingGrowth.ordinary_five"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `BlindCollatz.AlternatingGrowth.shortcut_three_eq_ordinary_five
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "BlindCollatz.AlternatingGrowth.shortcut_three_eq_ordinary_five"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `BlindCollatz.RepetitionBound.affine_repetition_bound
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "BlindCollatz.RepetitionBound.affine_repetition_bound"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `BlindCollatz.RepetitionBound.alternating_repetition_bound
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "BlindCollatz.RepetitionBound.alternating_repetition_bound"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `BlindCollatz.RepetitionBound.no_infinite_alternating_blocks
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "BlindCollatz.RepetitionBound.no_infinite_alternating_blocks"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `BlindCollatz.RepetitionBound.no_infinite_expanding_affine_blocks
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "BlindCollatz.RepetitionBound.no_infinite_expanding_affine_blocks"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `BlindCollatz.RepetitionBound.telescope
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "BlindCollatz.RepetitionBound.telescope"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `BlindCollatz.descent_iff_convergence
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "BlindCollatz.descent_iff_convergence"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.Disproof.BranchingCenter.branchingCenterEquationRigid
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.Disproof.BranchingCenter.branchingCenterEquationRigid"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.Disproof.BranchingCenter.centerTwoPowerOddNormalFormUnique
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.Disproof.BranchingCenter.centerTwoPowerOddNormalFormUnique"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.Disproof.FiniteResidueFirstIntegral.commutator_transitive_forces_constant
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.Disproof.FiniteResidueFirstIntegral.commutator_transitive_forces_constant"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.Disproof.firstRotatedDeterminantCoefficients
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.Disproof.firstRotatedDeterminantCoefficients"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.Disproof.noNonresonantContentGain
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.Disproof.noNonresonantContentGain"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.Disproof.quotientDegreesVanish
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.Disproof.quotientDegreesVanish"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.Disproof.secondRotatedDeterminantCoefficients
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.Disproof.secondRotatedDeterminantCoefficients"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.Disproof.twoPowerOddNormalFormUnique
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.Disproof.twoPowerOddNormalFormUnique"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.Disproof.twoPumpCoefficientDependencies
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.Disproof.twoPumpCoefficientDependencies"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.Disproof.twoPumpConstantObstructionVanishes
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.Disproof.twoPumpConstantObstructionVanishes"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.Disproof.twoPumpSyzygy
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.Disproof.twoPumpSyzygy"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.edgeCertificate_cancellation
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.edgeCertificate_cancellation"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.edgeCertificate_canonically_embeddable
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.edgeCertificate_canonically_embeddable"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.edgeCertificate_shape
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.edgeCertificate_shape"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.evalCoefficients_weightedCoefficient
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.evalCoefficients_weightedCoefficient"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.ffPumpWord_canonical
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.ffPumpWord_canonical"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.noBoundedBelowCanonicalFFPumpWords
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.noBoundedBelowCanonicalFFPumpWords"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.noTwoStateEdgeAdditiveOrder
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.noTwoStateEdgeAdditiveOrder"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.noTwoStateEdgeCertificateOrientation
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.noTwoStateEdgeCertificateOrientation"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.noTwoStateSymbolAdditiveOrder
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.noTwoStateSymbolAdditiveOrder"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.noTwoStateSymbolCertificateOrientation
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.noTwoStateSymbolCertificateOrientation"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.symbolCertificate_cancellation
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.symbolCertificate_cancellation"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.symbolCertificate_canonically_embeddable
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.symbolCertificate_canonically_embeddable"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.symbolCertificate_shape
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.symbolCertificate_shape"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.twoState_rule_equations
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.twoState_rule_equations"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.unlabelledCertificate_cancellation
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.unlabelledCertificate_cancellation"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.unlabelledCertificate_shape
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.unlabelledCertificate_shape"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.unlabelledRows_legal
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.unlabelledRows_legal"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.unlabelledRows_semantic
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.unlabelledRows_semantic"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.weightedGapSum_pos
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.weightedGapSum_pos"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.YAH.yah13_forces_ff_negative
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.YAH.yah13_forces_ff_negative"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.affineQuarterCertificate
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.affineQuarterCertificate"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.affineRecurrenceTelescope
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.affineRecurrenceTelescope"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.affineRepetitionBound
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.affineRepetitionBound"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.allPositiveConverge_of_smallerCoalescence
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.allPositiveConverge_of_smallerCoalescence"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.blockNumerator12_exact_bound
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.blockNumerator12_exact_bound"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.compatibleProduct_mod_four
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.compatibleProduct_mod_four"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.converges_iff_of_coalesces
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.converges_iff_of_coalesces"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.converges_shortcutIter_iff
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.converges_shortcutIter_iff"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.descentCriterion
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.descentCriterion"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.equalSlopeSmaller
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.equalSlopeSmaller"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.equalSlopeWitness
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.equalSlopeWitness"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.excursionBudgetDescent
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.excursionBudgetDescent"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.excursionChainEnvelope
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.excursionChainEnvelope"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.excursionChain_converges_of_smaller
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.excursionChain_converges_of_smaller"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.excursionChain_terminal_descent
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.excursionChain_terminal_descent"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.finitePaletteObstruction
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.finitePaletteObstruction"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.finitePalette_path_obstruction
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.finitePalette_path_obstruction"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.finiteRepetitionBound
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.finiteRepetitionBound"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.firstContractionQuarterGap
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.firstContractionQuarterGap"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.firstContractionThirdGap
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.firstContractionThirdGap"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.firstContractionTime
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.firstContractionTime"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.firstContraction_quarter_of_certificate
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.firstContraction_quarter_of_certificate"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.fixedRatioDivisibility
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.fixedRatioDivisibility"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.floorPower_mul
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.floorPower_mul"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.mechanicalCoarseBound
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.mechanicalCoarseBound"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.mechanicalEnvelope
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.mechanicalEnvelope"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.mechanical_fifteen_failure
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.mechanical_fifteen_failure"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.mechanical_large_bound
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.mechanical_large_bound"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.mechanical_twelve_identity
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.mechanical_twelve_identity"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.mechanical_twelve_propagation
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.mechanical_twelve_propagation"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.mersenne_prefix_nondecreasing
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.mersenne_prefix_nondecreasing"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.noInfiniteExpandingAffineBlocks
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.noInfiniteExpandingAffineBlocks"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.noInfinitePositiveRecurrence
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.noInfinitePositiveRecurrence"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.oddRun
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.oddRun"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.orbitAffine
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.orbitAffine"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.parityPrefix_dvd_sub_of_le
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.parityPrefix_dvd_sub_of_le"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.prefixCollision
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.prefixCollision"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.prefixReturnBernoulli
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.prefixReturnBernoulli"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.prefixReturnNumericalBound
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.prefixReturnNumericalBound"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.prefixSeparation
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.prefixSeparation"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.refinedChild_arithmetic
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.refinedChild_arithmetic"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.refinedChild_iter
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.refinedChild_iter"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.refinedMersenneChild_coalesces
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.refinedMersenneChild_coalesces"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.refinedParent_converges_iff_child
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.refinedParent_converges_iff_child"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.refinedParent_converges_of_smaller
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.refinedParent_converges_of_smaller"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.refinedParent_has_smaller_coalescence
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.refinedParent_has_smaller_coalescence"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.refinedParent_iter
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.refinedParent_iter"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.residueAncestor
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.residueAncestor"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.residueAncestor_factor_unit
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.residueAncestor_factor_unit"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.residueAncestor_normalized
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.residueAncestor_normalized"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.residueAncestor_of_divisibility
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.residueAncestor_of_divisibility"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.residueAncestor_prefix_one
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.residueAncestor_prefix_one"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.residueAncestor_prefix_two
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.residueAncestor_prefix_two"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.residueAncestor_refinedTail
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.residueAncestor_refinedTail"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.residueAncestor_tail11
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.residueAncestor_tail11"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.residueAncestor_tail173
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.residueAncestor_tail173"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.residueAncestor_tail38
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.residueAncestor_tail38"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.residueAncestor_tail65
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.residueAncestor_tail65"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.residueAncestor_tail92
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.residueAncestor_tail92"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.rootDescent
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.rootDescent"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.rootDescentAncestor
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.rootDescentAncestor"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.rootDescentBurst
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.rootDescentBurst"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.rootDescent_converges_of_smaller
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.rootDescent_converges_of_smaller"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.shiftedEnvelope_compose
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.shiftedEnvelope_compose"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.shortcutIter_OOE
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.shortcutIter_OOE"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.smallerCoalescenceCriterion
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.smallerCoalescenceCriterion"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.terminalEnvelope_compose
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.terminalEnvelope_compose"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.twoBurstDescent
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.twoBurstDescent"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.twoBurst_converges_of_smaller
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.twoBurst_converges_of_smaller"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.twoBurst_power_margin
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.twoBurst_power_margin"), ("type", toJson ty.pretty)]).compress
  let ci ← getConstInfo `CollatzWork.universalMechanicalQuarterCertificate
  let ty ← Lean.Meta.ppExpr ci.type
  rows := rows.push (Json.mkObj [("name", Json.str "CollatzWork.universalMechanicalQuarterCertificate"), ("type", toJson ty.pretty)]).compress
  IO.FS.writeFile "staged-types.jsonl" (String.intercalate "\n" rows.toList)
