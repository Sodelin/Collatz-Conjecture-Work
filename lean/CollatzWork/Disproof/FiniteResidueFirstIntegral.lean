import Std.Tactic

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

/-- Invariance under a bijection also gives invariance under a chosen inverse.
Only the displayed right-inverse law is needed for this direction. -/
theorem invariant_inverse
    {X Color : Type} (I : X → Color) (f finv : X → X)
    (hRightInverse : ∀ x, f (finv x) = x)
    (hf : IsInvariant I f) :
    IsInvariant I finv := by
  intro x
  have h := hf (finv x)
  rw [hRightInverse x] at h
  exact h.symm

/-- Functional convention for the commutator used in the residue argument:
`B⁻¹ A⁻¹ B A`, applied from right to left. -/
def commutator {X : Type}
    (A Ainv B Binv : X → X) (x : X) : X :=
  Binv (Ainv (B (A x)))

/-- A coloring invariant under `A` and `B` is invariant under
`B⁻¹ A⁻¹ B A`. -/
theorem invariant_commutator
    {X Color : Type} (I : X → Color)
    (A Ainv B Binv : X → X)
    (hARightInverse : ∀ x, A (Ainv x) = x)
    (hBRightInverse : ∀ x, B (Binv x) = x)
    (hA : IsInvariant I A) (hB : IsInvariant I B) :
    IsInvariant I (commutator A Ainv B Binv) := by
  intro x
  calc
    I (commutator A Ainv B Binv x) = I (Ainv (B (A x))) :=
      invariant_inverse I B Binv hBRightInverse hB (Ainv (B (A x)))
    _ = I (B (A x)) :=
      invariant_inverse I A Ainv hARightInverse hA (B (A x))
    _ = I (A x) := hB (A x)
    _ = I x := hA x

/-- A local iterate definition used to keep the transitivity proof independent
of any external iteration API. -/
def iterate {X : Type} (f : X → X) : Nat → X → X
  | 0, x => x
  | n + 1, x => f (iterate f n x)

theorem invariant_iterate
    {X Color : Type} (I : X → Color) (f : X → X)
    (hf : IsInvariant I f) :
    ∀ n x, I (iterate f n x) = I x := by
  intro n
  induction n with
  | zero =>
      intro x
      rfl
  | succ n ih =>
      intro x
      calc
        I (iterate f (n + 1) x) = I (iterate f n x) := hf (iterate f n x)
        _ = I x := ih x

/-- If every point can be reached from every other by iterating a map, every
coloring invariant under that map is constant. -/
theorem transitive_invariant_constant
    {X Color : Type} (I : X → Color) (f : X → X)
    (hf : IsInvariant I f)
    (htransitive : ∀ x y, ∃ n, iterate f n x = y) :
    ∀ x y, I x = I y := by
  intro x y
  obtain ⟨n, hn⟩ := htransitive x y
  calc
    I x = I (iterate f n x) := (invariant_iterate I f hf n x).symm
    _ = I y := congrArg I hn

/-- Decisive finite-group core: if the commutator of two permutations is
transitive, a coloring invariant under both permutations is constant. -/
theorem commutator_transitive_forces_constant
    {X Color : Type} (I : X → Color)
    (A Ainv B Binv : X → X)
    (hARightInverse : ∀ x, A (Ainv x) = x)
    (hBRightInverse : ∀ x, B (Binv x) = x)
    (hA : IsInvariant I A) (hB : IsInvariant I B)
    (htransitive : ∀ x y, ∃ n,
      iterate (commutator A Ainv B Binv) n x = y) :
    ∀ x y, I x = I y := by
  exact transitive_invariant_constant I (commutator A Ainv B Binv)
    (invariant_commutator I A Ainv B Binv hARightInverse hBRightInverse hA hB)
    htransitive

#print axioms CollatzWork.Disproof.FiniteResidueFirstIntegral.invariant_inverse
#print axioms CollatzWork.Disproof.FiniteResidueFirstIntegral.invariant_commutator
#print axioms CollatzWork.Disproof.FiniteResidueFirstIntegral.invariant_iterate
#print axioms CollatzWork.Disproof.FiniteResidueFirstIntegral.transitive_invariant_constant
#print axioms CollatzWork.Disproof.FiniteResidueFirstIntegral.commutator_transitive_forces_constant

end CollatzWork.Disproof.FiniteResidueFirstIntegral
