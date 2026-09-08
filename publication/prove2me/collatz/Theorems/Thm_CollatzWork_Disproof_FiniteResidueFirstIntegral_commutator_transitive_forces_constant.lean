import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_Disproof_FiniteResidueFirstIntegral



theorem CollatzWork.Disproof.FiniteResidueFirstIntegral.commutator_transitive_forces_constant
    {X Color : Type} (I : X → Color)
    (A Ainv B Binv : X → X)
    (hARightInverse : ∀ x, A (Ainv x) = x)
    (hBRightInverse : ∀ x, B (Binv x) = x)
    (hA : IsInvariant I A) (hB : IsInvariant I B)
    (htransitive : ∀ x y, ∃ n,
      iterate (commutator A Ainv B Binv) n x = y) :
    ∀ x y, I x = I y := by sorry

