import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_QuarterGapStatement
import Theorems.Thm_CollatzWork_orbitAffine
import Theorems.Thm_CollatzWork_mechanicalEnvelope
import Theorems.Thm_CollatzWork_affineQuarterCertificate



theorem CollatzWork.firstContraction_quarter_of_certificate {n k d : Nat}
    (hn : 0 < n) (hfirst : FirstCoefficientContraction n k)
    (hreturn : shortcutIter k n = n + d)
    (hcert : 4 * mechanicalMax (orbitOddCount n k) ≤
      orbitOddCount n k * 2 ^ coefficientCrossingExponent (orbitOddCount n k)) :
    4 * d < orbitOddCount n k := by sorry

