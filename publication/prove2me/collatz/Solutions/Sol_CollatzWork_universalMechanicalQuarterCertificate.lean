import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_QuarterGapStatement
import Definitions.Def_CollatzWork_QuarterGapUniversalStatement
import Theorems.Thm_CollatzWork_mechanical_large_bound
namespace CollatzWork















set_option maxRecDepth 100000 in
set_option maxHeartbeats 0 in
theorem smallMechanicalCertificate : SmallMechanicalCertificateStatement := by
  have hfinite : ∀ s : Fin 108, 1 ≤ s.val →
      4 * mechanicalMax s.val ≤ s.val * 2 ^ coefficientCrossingExponent s.val := by
    decide
  intro s hs hsmax
  exact hfinite ⟨s, by omega⟩ hs


















end CollatzWork



open CollatzWork in
theorem solution :
    UniversalMechanicalQuarterCertificateStatement := by
  intro s hs
  by_cases hsmall : s ≤ 15
  · exact smallMechanicalCertificate s hs (by omega)
  · have hlarge := mechanical_large_bound s (by omega)
    have hcross : 3 ^ s ≤ 2 ^ coefficientCrossingExponent s :=
      Nat.le_of_lt Nat.lt_log2_self
    exact Nat.le_trans hlarge (Nat.mul_le_mul_left s hcross)
