import Std
import Init.Grind.Ordered.Module



theorem CollatzWork.Disproof.firstRotatedDeterminantCoefficients
    (a b c p e q d f g h ell t pr qr gr : Int)
    (hgr : (q - p) * gr = qr - pr) :
    let dv := q - p
    let dz := t - h
    let alpha := a * d * pr
    let beta := d * b * pr + c * d * e * gr + c * f * qr
    let gamma := c * g * qr
    let A := dz * (d * b * dv - c * d * e) + dv * a * d * ell
    let B := dz * (c * d * e + c * f * dv) - dv * c * g * ell
    dv * (dz * beta - (gamma - alpha) * ell) = A * pr + B * qr := by sorry

