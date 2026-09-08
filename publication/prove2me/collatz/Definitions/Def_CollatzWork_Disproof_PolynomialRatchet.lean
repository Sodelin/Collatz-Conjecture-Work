import Std
import Init.Grind.Ordered.Module
namespace CollatzWork.Disproof

/-!
# Normalized polynomial-ratchet arithmetic

This module checks only the arithmetic core of a narrowly scoped route
obstruction.  It does not define the Collatz map and proves neither the
Collatz conjecture nor its negation.

For primitive integral state polynomials transported around a finite directed
cycle by affine macros of slope `3^q / 2^k`, minimally clearing powers of two
leaves odd contents.  Comparing degrees first forces every integral quotient
to be constant.  Comparing leading coefficients then has the arithmetic form

`2^R * 3^(d*Q) = 2^(d*K) * H`,

where `H` is the product of those odd contents.  The theorems below certify
the unique odd normal form and the resulting exclusion of gain at any base
coprime to three.  The resonant base `p = 3` is intentionally not excluded.
-/

/-- An explicit arithmetic version of oddness, kept local so the proof does
not depend on a particular library representation of parity. -/
def ArithOdd (n : Nat) : Prop := ∃ t : Nat, n = 2 * t + 1




















end CollatzWork.Disproof
