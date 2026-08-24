import Std

namespace CollatzWork

/--
Trusted auxiliary statement for the affine comparison boundary corrected in
Round-7 L5.  Equal slopes make the comparison depend exactly on the two
intercepts.
-/
def EqualSlopeSmallerStatement : Prop :=
  ∀ A B R : Nat, (∀ x : Nat, A * x + B < A * x + R) ↔ B < R

/-- The once-accelerated Collatz map used in L4-L12. -/
def onceAccelerated (n : Nat) : Nat :=
  if n % 2 = 0 then n / 2 else (3 * n + 1) / 2

/--
Trusted concrete regression statement for the equal-slope certificate omitted
by the original L5 classifier.
-/
def EqualSlopeWitnessStatement : Prop :=
  ∀ x : Nat,
    onceAccelerated (onceAccelerated (onceAccelerated (8 * x + 5))) =
        3 * x + 2 ∧
    onceAccelerated (onceAccelerated (onceAccelerated (8 * x + 4))) =
        3 * x + 2 ∧
    0 < 8 * x + 4 ∧
    8 * x + 4 < 8 * x + 5

end CollatzWork
