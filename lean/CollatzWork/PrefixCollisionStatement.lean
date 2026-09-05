import CollatzWork.ConvergenceStatement

namespace CollatzWork

/-!
# Trusted finite-prefix collision statements

The parity bits below are those of the repository's actual shortcut orbit.
No convergence assumption or abstract symbolic itinerary is substituted.
-/

/-- The first `k` parity bits of the two actual shortcut orbits agree. -/
def SameParityPrefix (k n m : Nat) : Prop :=
  ∀ i : Nat, i < k → shortcutIter i n % 2 = shortcutIter i m % 2

/-- Natural absolute difference, written using truncated subtraction. -/
def prefixGap (n m : Nat) : Nat := (n - m) + (m - n)

/-- Equal parity prefixes force equal residues modulo the prefix modulus. -/
def PrefixCollisionStatement : Prop :=
  ∀ k n m : Nat, SameParityPrefix k n m → n % 2 ^ k = m % 2 ^ k

/-- Distinct starts sharing a prefix must be at least its modulus apart. -/
def PrefixSeparationStatement : Prop :=
  ∀ k n m : Nat, SameParityPrefix k n m → n ≠ m → 2 ^ k ≤ prefixGap n m

end CollatzWork
