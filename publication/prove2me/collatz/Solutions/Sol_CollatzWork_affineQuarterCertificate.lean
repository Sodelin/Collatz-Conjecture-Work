import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_QuarterGapStatement
namespace CollatzWork











theorem affine_gap_strict {n d a b C : Nat} (hn : 0 < n) (hab : a < b)
    (haffine : b * (n + d) = a * n + C) : b * d < C := by
  have hscale : a * n < b * n := Nat.mul_lt_mul_of_pos_right hab hn
  rw [Nat.mul_add] at haffine
  omega






















end CollatzWork



open CollatzWork in
theorem solution : AffineQuarterCertificateStatement := by
  intro n d a b C s hn hab haffine hcert
  have hgap := affine_gap_strict hn hab haffine
  have hscaled := Nat.mul_lt_mul_of_pos_left hgap (by decide : 0 < 4)
  have hresult : (4 * d) * b < s * b := by
    have : 4 * (b * d) = (4 * d) * b := by
      simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
    omega
  exact Nat.lt_of_mul_lt_mul_right hresult
