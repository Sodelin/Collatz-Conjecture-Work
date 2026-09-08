import Std
import Init.Grind.Ordered.Module
namespace BlindCollatz.AlternatingGrowth

/-- Shortcut Collatz map: one division by two on either branch. -/
def step (n : Nat) : Nat :=
  if n % 2 = 0 then n / 2 else (3 * n + 1) / 2

def block (n : Nat) : Nat := step (step (step n))

 

 

 

 

 

 

end BlindCollatz.AlternatingGrowth

namespace BlindCollatz.AlternatingGrowth

 

/-- A family that admits arbitrarily many expanding (1,2) valuation blocks. -/
def seed (m t : Nat) : Nat := 16 * (8 ^ m * t) - 5

def blocks : Nat → Nat → Nat
  | 0, n => n
  | k + 1, n => blocks k (block n)

 

 

end BlindCollatz.AlternatingGrowth

namespace BlindCollatz.AlternatingGrowth

/-- Every certified block starts in the residue class with odd exponents (1,2). -/
def goodBlocks : Nat → Nat → Prop
  | 0, _ => True
  | k + 1, n => (∃ q : Nat, n = 16 * q + 11) ∧ goodBlocks k (block n)

 

 



end BlindCollatz.AlternatingGrowth

namespace BlindCollatz.AlternatingGrowth



/-- Ordinary Collatz map: the odd branch does not include a division. -/
def ordinaryStep (n : Nat) : Nat :=
  if n % 2 = 0 then n / 2 else 3 * n + 1

def ordinarySteps : Nat → Nat → Nat
  | 0, n => n
  | k + 1, n => ordinarySteps k (ordinaryStep n)














end BlindCollatz.AlternatingGrowth
