import Std
import Init.Grind.Ordered.Module
import Theorems.Thm_CollatzWork_Disproof_twoPumpCoefficientDependencies



open CollatzWork.Disproof in
theorem solution
    (a b c p e q d f g h ell t : Int) :
    let dv := q - p
    let dz := t - h
    let A := dz * (d * b * dv - c * d * e) + dv * a * d * ell
    let B := dz * (c * d * e + c * f * dv) - dv * c * g * ell
    let C := dv * (a * f * dz - a * g * ell) + dz * a * d * e
    let E := dv * (a * g * ell + b * g * dz) - dz * c * g * e
    c * g * A * C - a * d * B * E = 0 := by
  dsimp
  obtain ⟨hAB, hAE⟩ :=
    twoPumpCoefficientDependencies a b c p e q d f g h ell t
  have hprod :
      c * g *
          ((t - h) * (d * b * (q - p) - c * d * e) +
            (q - p) * a * d * ell) *
          ((q - p) * (a * f * (t - h) - a * g * ell) +
            (t - h) * a * d * e) =
        a * d *
          ((t - h) * (c * d * e + c * f * (q - p)) -
            (q - p) * c * g * ell) *
          ((q - p) * (a * g * ell + b * g * (t - h)) -
            (t - h) * c * g * e) := by
    calc
      c * g *
            ((t - h) * (d * b * (q - p) - c * d * e) +
              (q - p) * a * d * ell) *
            ((q - p) * (a * f * (t - h) - a * g * ell) +
              (t - h) * a * d * e) =
          c * (g *
            ((t - h) * (d * b * (q - p) - c * d * e) +
              (q - p) * a * d * ell)) *
            ((q - p) * (a * f * (t - h) - a * g * ell) +
              (t - h) * a * d * e) := by simp [Int.mul_assoc]
      _ = c * (d *
            ((q - p) * (a * g * ell + b * g * (t - h)) -
              (t - h) * c * g * e)) *
            ((q - p) * (a * f * (t - h) - a * g * ell) +
              (t - h) * a * d * e) := by rw [hAE]
      _ = d *
            ((q - p) * (a * g * ell + b * g * (t - h)) -
              (t - h) * c * g * e) *
            (c * ((q - p) * (a * f * (t - h) - a * g * ell) +
              (t - h) * a * d * e)) := by ac_rfl
      _ = d *
            ((q - p) * (a * g * ell + b * g * (t - h)) -
              (t - h) * c * g * e) *
            (a * ((t - h) * (c * d * e + c * f * (q - p)) -
              (q - p) * c * g * ell)) := by rw [← hAB]
      _ = a * d *
            ((t - h) * (c * d * e + c * f * (q - p)) -
              (q - p) * c * g * ell) *
            ((q - p) * (a * g * ell + b * g * (t - h)) -
              (t - h) * c * g * e) := by ac_rfl
  rw [hprod]
  simp
