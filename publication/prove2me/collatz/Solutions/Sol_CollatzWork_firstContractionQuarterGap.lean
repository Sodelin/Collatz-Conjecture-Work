import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_QuarterGapStatement
import Definitions.Def_CollatzWork_QuarterGapUniversalStatement
import Theorems.Thm_CollatzWork_firstContractionThirdGap
import Theorems.Thm_CollatzWork_firstContraction_quarter_of_certificate
import Theorems.Thm_CollatzWork_universalMechanicalQuarterCertificate



open CollatzWork in
theorem solution : FirstContractionQuarterGapStatement := by
  intro n k d hn hfirst hreturn
  have hthird := firstContractionThirdGap n k d hn hfirst hreturn
  have hs : 1 ≤ orbitOddCount n k := by omega
  have hquarter := firstContraction_quarter_of_certificate hn hfirst hreturn
    (universalMechanicalQuarterCertificate (orbitOddCount n k) hs)
  exact ⟨hquarter, by omega⟩
