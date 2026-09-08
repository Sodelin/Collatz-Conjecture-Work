import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_QuarterGapStatement
import Theorems.Thm_CollatzWork_orbitAffine
import Theorems.Thm_CollatzWork_mechanicalEnvelope
import Theorems.Thm_CollatzWork_affineQuarterCertificate



open CollatzWork in
theorem solution {n k d : Nat}
    (hn : 0 < n) (hfirst : FirstCoefficientContraction n k)
    (hreturn : shortcutIter k n = n + d)
    (hcert : 4 * mechanicalMax (orbitOddCount n k) ≤
      orbitOddCount n k * 2 ^ coefficientCrossingExponent (orbitOddCount n k)) :
    4 * d < orbitOddCount n k := by
  have henv := mechanicalEnvelope n k hfirst.2.2
  have haffine := orbitAffine n k
  rw [hreturn] at haffine
  have hp : 3 ^ orbitOddCount n k ≠ 0 := Nat.ne_of_gt (Nat.pow_pos (by decide))
  have hlog : Nat.log2 (3 ^ orbitOddCount n k) < k :=
    (Nat.log2_lt hp).mpr hfirst.2.1
  have htime : coefficientCrossingExponent (orbitOddCount n k) ≤ k := by
    unfold coefficientCrossingExponent
    omega
  have hpower := Nat.pow_le_pow_right (n := 2) (by decide) htime
  have hsmall : 4 * orbitRemainder n k ≤ orbitOddCount n k * 2 ^ k :=
    Nat.le_trans (Nat.mul_le_mul_left 4 henv)
      (Nat.le_trans hcert (Nat.mul_le_mul_left _ hpower))
  exact affineQuarterCertificate n d (3 ^ orbitOddCount n k) (2 ^ k)
    (orbitRemainder n k) (orbitOddCount n k) hn hfirst.2.1 haffine hsmall
