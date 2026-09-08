import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_QuarterGapStatement
import Definitions.Def_CollatzWork_QuarterGapUniversalStatement
import Theorems.Thm_CollatzWork_mechanical_twelve_propagation
namespace CollatzWork





set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
theorem mechanical_large_base : ∀ s : Fin 28, 16 ≤ s.val →
    4 * mechanicalMax s.val ≤ s.val * 3 ^ s.val := by
  decide






















end CollatzWork



open CollatzWork in
theorem solution : MechanicalSixteenEnvelopeStatement := by
  intro s
  induction s using Nat.strongRecOn with
  | ind s ih =>
      intro hs
      by_cases hsmall : s < 28
      · exact mechanical_large_base ⟨s, hsmall⟩ hs
      · have hprior : 16 ≤ s - 12 := by omega
        have hlt : s - 12 < s := by omega
        have hrec := mechanical_twelve_propagation (s - 12) (ih (s - 12) hlt hprior)
        have heq : s - 12 + 12 = s := by omega
        simpa only [heq] using hrec
