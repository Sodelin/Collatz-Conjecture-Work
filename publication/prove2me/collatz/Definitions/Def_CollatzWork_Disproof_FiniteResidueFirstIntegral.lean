import Std
import Init.Grind.Ordered.Module
namespace CollatzWork.Disproof.FiniteResidueFirstIntegral

/-!
# Finite-permutation core for residue-only Collatz first integrals

The accompanying shot proves on paper that every finite-modulus coloring
preserved by every positive step of the full Collatz map is constant.  After
the factors `2` and `3` have been removed from the modulus, the decisive core
uses the affine permutations `A(x)=2x` and `B(x)=3x+1`.  Their commutator is a
unit translation, hence transitive.

This module formalizes the group-action implication independently of any
finite-modulus enumeration: invariance under two permutations implies
invariance under their commutator, and a transitive commutator forces the
coloring to be constant.  The arithmetic lift/factor-descent bridge and the
calculation of the affine commutator in `Z/mZ` are stated exactly in the
accompanying note, not encoded here.
-/

/-- A coloring `I` is invariant under a self-map `f`. -/
def IsInvariant {X Color : Type} (I : X → Color) (f : X → X) : Prop :=
  ∀ x, I (f x) = I x



/-- Functional convention for the commutator used in the residue argument:
`B⁻¹ A⁻¹ B A`, applied from right to left. -/
def commutator {X : Type}
    (A Ainv B Binv : X → X) (x : X) : X :=
  Binv (Ainv (B (A x)))



/-- A local iterate definition used to keep the transitivity proof independent
of any external iteration API. -/
def iterate {X : Type} (f : X → X) : Nat → X → X
  | 0, x => x
  | n + 1, x => f (iterate f n x)













end CollatzWork.Disproof.FiniteResidueFirstIntegral
