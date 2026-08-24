import Std.Tactic

namespace CollatzWork.Disproof

/-!
# Two-pump cyclic-elimination dependency

This module formalizes the coefficient provenance and the universal algebraic
dependency that defeats a proposed constant-resultant filter for accelerated
Collatz words of the form `U V^r W Z^s`.

It is a route-design obstruction. It does not prove or disprove the Collatz
conjecture and does not assert that any positive nontrivial cycle exists.
-/

/-- The two coefficient pairs obtained from the two cyclic one-pump
determinants are not independent: `a*B=c*C` and `g*A=d*E`. -/
theorem twoPumpCoefficientDependencies
    (a b c p e q d f g h ell t : Int) :
    let dv := q - p
    let dz := t - h
    let A := dz * (d * b * dv - c * d * e) + dv * a * d * ell
    let B := dz * (c * d * e + c * f * dv) - dv * c * g * ell
    let C := dv * (a * f * dz - a * g * ell) + dz * a * d * e
    let E := dv * (a * g * ell + b * g * dz) - dz * c * g * e
    a * B = c * C ∧ g * A = d * E := by
  dsimp
  constructor <;>
    simp [Int.mul_add, Int.mul_sub, Int.mul_comm, Int.mul_left_comm] <;> omega

/-- Exact expansion of the first cyclic determinant. If
`(q-p)*gr=qr-pr`, then the determinant for context `U V^r W` and pump `Z`
has coefficients `A` and `B`. -/
theorem firstRotatedDeterminantCoefficients
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

/-- Exact expansion after cyclic rotation. If `(t-h)*gs=ts-hs`, then the
determinant for context `W Z^s U` and pump `V` has coefficients `C` and `E`. -/
theorem secondRotatedDeterminantCoefficients
    (a b c p e q d f g h ell t hs ts gs : Int)
    (hgs : (t - h) * gs = ts - hs) :
    let dv := q - p
    let dz := t - h
    let alpha := a * d * hs
    let beta := a * f * hs + a * g * ell * gs + b * g * ts
    let gamma := c * g * ts
    let C := dv * (a * f * dz - a * g * ell) + dz * a * d * e
    let E := dv * (a * g * ell + b * g * dz) - dz * c * g * e
    dz * (dv * beta - (gamma - alpha) * e) = C * hs + E * ts := by
  dsimp
  have hscaled :
      (t - h) * ((q - p) * (a * g * ell * gs)) =
        (q - p) * (a * g * ell) * (ts - hs) := by
    calc
      (t - h) * ((q - p) * (a * g * ell * gs)) =
          (q - p) * (a * g * ell) * ((t - h) * gs) := by ac_rfl
      _ = (q - p) * (a * g * ell) * (ts - hs) := by rw [hgs]
  simp [Int.mul_add, Int.mul_sub, Int.mul_comm, Int.mul_left_comm] at hscaled ⊢
  omega

/-- Consequently the hoped-for constant resultant is identically zero. -/
theorem twoPumpConstantObstructionVanishes
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

/-- Exact syzygy showing that the two rotated determinant congruences do not
produce an independent condition on the total denominator `D`. -/
theorem twoPumpSyzygy
    (a c d g A B C E pr qr hs ts : Int)
    (hAB : a * B = c * C) (hAE : g * A = d * E) :
    let D := c * g * qr * ts - a * d * pr * hs
    let P := A * pr + B * qr
    let Q := C * hs + E * ts
    B * E * D - c * g * P * Q + c * g * C * hs * P +
      c * g * A * pr * Q = 0 := by
  dsimp
  calc
    B * E * (c * g * qr * ts - a * d * pr * hs) -
          c * g * (A * pr + B * qr) * (C * hs + E * ts) +
          c * g * C * hs * (A * pr + B * qr) +
          c * g * A * pr * (C * hs + E * ts) =
        (c * g * A * C - a * d * B * E) * pr * hs := by
          simp [Int.mul_add, Int.mul_sub, Int.mul_comm, Int.mul_left_comm] <;>
            omega
    _ = 0 := by
      have h1 : c * g * A * C = a * d * B * E := by
        calc
          c * g * A * C = c * d * E * C := by
            calc
              c * g * A * C = c * (g * A) * C := by
                simp [Int.mul_assoc]
              _ = c * (d * E) * C := by rw [hAE]
              _ = c * d * E * C := by simp [Int.mul_assoc]
          _ = d * E * (c * C) := by
            simp [Int.mul_comm, Int.mul_left_comm]
          _ = d * E * (a * B) := by rw [← hAB]
          _ = a * d * B * E := by
            simp [Int.mul_comm, Int.mul_left_comm]
      rw [h1]
      simp

#print axioms CollatzWork.Disproof.twoPumpCoefficientDependencies
#print axioms CollatzWork.Disproof.firstRotatedDeterminantCoefficients
#print axioms CollatzWork.Disproof.secondRotatedDeterminantCoefficients
#print axioms CollatzWork.Disproof.twoPumpConstantObstructionVanishes
#print axioms CollatzWork.Disproof.twoPumpSyzygy

end CollatzWork.Disproof
