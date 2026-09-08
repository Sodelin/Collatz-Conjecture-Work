import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
namespace CollatzWork

/-!
# Refined Mersenne child identity

This file formalizes one isolated arithmetic certificate for the one-division
shortcut map `onceAccelerated`.  It does not assert termination or route
closure.
-/

@[simp] theorem shortcutIter_zero (n : Nat) : shortcutIter 0 n = n := rfl

@[simp] theorem shortcutIter_succ (k n : Nat) :
    shortcutIter (k + 1) n = shortcutIter k (onceAccelerated n) := rfl





@[simp] theorem onceAccelerated_two_mul (b : Nat) :
    onceAccelerated (2 * b) = b := by
  rw [onceAccelerated]
  simp





/-- The parameter used by the two residue children. -/
def refinedA (epsilon z : Nat) : Nat := 4 * z + 2 * epsilon + 1

/-- The exact-valuation Mersenne parent after splitting its odd parameter
modulo four. -/
def refinedParent (L epsilon z : Nat) : Nat :=
  2 ^ L * refinedA epsilon z - 1

/-- The smaller coalescing child on the parity-compatible branch. -/
def refinedChild (L epsilon z : Nat) : Nat :=
  3 * 2 ^ (L - 2) * refinedA epsilon z - 1
























end CollatzWork
