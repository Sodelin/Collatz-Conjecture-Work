import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_FirstContractionStatement
import Definitions.Def_CollatzWork_QuarterGapStatement
import Theorems.Thm_CollatzWork_mechanicalCoarseBound
import Theorems.Thm_CollatzWork_orbitAffine
import Theorems.Thm_CollatzWork_mechanicalEnvelope
namespace CollatzWork











theorem affine_gap_strict {n d a b C : Nat} (hn : 0 < n) (hab : a < b)
    (haffine : b * (n + d) = a * n + C) : b * d < C := by
  have hscale : a * n < b * n := Nat.mul_lt_mul_of_pos_right hab hn
  rw [Nat.mul_add] at haffine
  omega






















end CollatzWork



open CollatzWork in
theorem solution : FirstContractionThirdGapStatement := by
  intro n k d hn hfirst hreturn
  have henv := mechanicalEnvelope n k hfirst.2.2
  have haffine := orbitAffine n k
  rw [hreturn] at haffine
  have hgap := affine_gap_strict hn hfirst.2.1 haffine
  have hcoarse := mechanicalCoarseBound (orbitOddCount n k)
  have hcert : 3 * orbitRemainder n k ≤ orbitOddCount n k * 2 ^ k :=
    Nat.le_trans (Nat.mul_le_mul_left 3 henv)
      (Nat.le_trans hcoarse
        (Nat.mul_le_mul_left (orbitOddCount n k) (Nat.le_of_lt hfirst.2.1)))
  have hscaled := Nat.mul_lt_mul_of_pos_left hgap (by decide : 0 < 3)
  have hprod : (3 * d) * 2 ^ k < orbitOddCount n k * 2 ^ k := by
    have : 3 * (2 ^ k * d) = (3 * d) * 2 ^ k := by
      simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
    omega
  have hthird := Nat.lt_of_mul_lt_mul_right hprod
  exact ⟨hthird, by omega⟩
