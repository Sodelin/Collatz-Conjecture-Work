import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement



open CollatzWork in
theorem solution : EqualSlopeSmallerStatement := by
  intro A B R
  constructor
  · intro h
    simpa using h 0
  · intro h x
    exact Nat.add_lt_add_left h (A * x)
