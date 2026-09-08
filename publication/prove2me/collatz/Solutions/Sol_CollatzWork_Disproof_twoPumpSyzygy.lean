import Std
import Init.Grind.Ordered.Module



theorem solution
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
