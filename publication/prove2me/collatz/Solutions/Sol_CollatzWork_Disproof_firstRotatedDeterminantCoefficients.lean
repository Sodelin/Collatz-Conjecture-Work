import Std
import Init.Grind.Ordered.Module



theorem solution
    (a b c p e q d f g h ell t pr qr gr : Int)
    (hgr : (q - p) * gr = qr - pr) :
    let dv := q - p
    let dz := t - h
    let alpha := a * d * pr
    let beta := d * b * pr + c * d * e * gr + c * f * qr
    let gamma := c * g * qr
    let A := dz * (d * b * dv - c * d * e) + dv * a * d * ell
    let B := dz * (c * d * e + c * f * dv) - dv * c * g * ell
    dv * (dz * beta - (gamma - alpha) * ell) = A * pr + B * qr := by
  dsimp
  have hscaled :
      (q - p) * ((t - h) * (c * d * e * gr)) =
        (t - h) * (c * d * e) * (qr - pr) := by
    calc
      (q - p) * ((t - h) * (c * d * e * gr)) =
          (t - h) * (c * d * e) * ((q - p) * gr) := by ac_rfl
      _ = (t - h) * (c * d * e) * (qr - pr) := by rw [hgr]
  simp [Int.mul_add, Int.mul_sub, Int.mul_comm, Int.mul_left_comm] at hscaled ⊢
  omega
