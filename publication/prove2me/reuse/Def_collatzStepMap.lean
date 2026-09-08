import Mathlib.Algebra.Group.Nat.Even

/-- One step of the Collatz map: an even number is halved, an odd number `n` is sent to
`3 * n + 1`.  Natural-number division is used on the even branch, so the definition is total;
`collatzStep 0 = 0`. -/
def collatzStep (n : ℕ) : ℕ :=
  if Even n then n / 2 else 3 * n + 1
