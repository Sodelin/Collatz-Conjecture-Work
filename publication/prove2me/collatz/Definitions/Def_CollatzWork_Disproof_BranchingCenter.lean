import Std
import Init.Grind.Ordered.Module
namespace CollatzWork.Disproof.BranchingCenter

/-!
# Rigidity of the two-center, three-edge branching ansatz

This module checks the arithmetic core of one narrowly scoped attempted
divergence construction.  For accelerated odd Collatz macros

`U_j(x) = (3*x + 1) / 2^j`,

the proposed center graph has edges `A -a-> A`, `A -b-> B`, and
`B -c-> A`.  Eliminating the two rational centers gives

`2^(b+c) + 3*2^b = 2^(a+b) + 3*2^a`.

For positive labels, the theorem below proves that this equation forces
`a = b = c`.  Thus the proposed graph collapses before positive-natural
membership, guard invariance, or escape can be established.  This is only a
route obstruction; it is not a proof or disproof of the Collatz conjecture.
-/

/-- Elementary oddness, stated explicitly so the normal-form argument does
not depend on a library parity API. -/
def CenterOdd (n : Nat) : Prop := ∃ t : Nat, n = 2 * t + 1















end CollatzWork.Disproof.BranchingCenter
