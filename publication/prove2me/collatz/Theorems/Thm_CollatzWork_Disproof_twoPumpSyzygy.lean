import Std
import Init.Grind.Ordered.Module



theorem CollatzWork.Disproof.twoPumpSyzygy
    (a c d g A B C E pr qr hs ts : Int)
    (hAB : a * B = c * C) (hAE : g * A = d * E) :
    let D := c * g * qr * ts - a * d * pr * hs
    let P := A * pr + B * qr
    let Q := C * hs + E * ts
    B * E * D - c * g * P * Q + c * g * C * hs * P +
      c * g * A * pr * Q = 0 := by sorry

