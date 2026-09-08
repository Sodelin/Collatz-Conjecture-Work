import Std
import Init.Grind.Ordered.Module



theorem CollatzWork.Disproof.secondRotatedDeterminantCoefficients
    (a b c p e q d f g h ell t hs ts gs : Int)
    (hgs : (t - h) * gs = ts - hs) :
    let dv := q - p
    let dz := t - h
    let alpha := a * d * hs
    let beta := a * f * hs + a * g * ell * gs + b * g * ts
    let gamma := c * g * ts
    let C := dv * (a * f * dz - a * g * ell) + dz * a * d * e
    let E := dv * (a * g * ell + b * g * dz) - dz * c * g * e
    dz * (dv * beta - (gamma - alpha) * e) = C * hs + E * ts := by sorry

