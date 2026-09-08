import Std
import Init.Grind.Ordered.Module
import Definitions.Def_EgyptianFractions_Certificate



theorem EgyptianFractions.exists_minimum_of_representation {lower terms : Nat}
    (hRepresentation : HasRepresentation lower terms) :
    ∃ minimum, IsMinimumLength lower minimum := by sorry

