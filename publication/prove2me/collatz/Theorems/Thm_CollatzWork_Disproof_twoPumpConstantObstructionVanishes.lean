import Std
import Init.Grind.Ordered.Module
import Theorems.Thm_CollatzWork_Disproof_twoPumpCoefficientDependencies



theorem CollatzWork.Disproof.twoPumpConstantObstructionVanishes
    (a b c p e q d f g h ell t : Int) :
    let dv := q - p
    let dz := t - h
    let A := dz * (d * b * dv - c * d * e) + dv * a * d * ell
    let B := dz * (c * d * e + c * f * dv) - dv * c * g * ell
    let C := dv * (a * f * dz - a * g * ell) + dz * a * d * e
    let E := dv * (a * g * ell + b * g * dz) - dz * c * g * e
    c * g * A * C - a * d * B * E = 0 := by sorry

