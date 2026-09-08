import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_LinearBlindness
/-!
# Linear blindness as a common-kernel obstruction

This file isolates the exact algebraic obstruction behind target blindness.
It uses only subtraction-preserving maps, so it does not require Mathlib's
linear-algebra hierarchy.  Every linear map between modules is an instance of
this interface after forgetting scalar multiplication.
-/

namespace NewMathDiscovery.LinearBlindness

















/-!
## A rank-two degeneration that defeats a naive robustness score

The covectors below are

* target row `q = (1, 0)`;
* sensor row `r_n = (1, n + 1)`.

Every pair of distinct rows has nonzero determinant, so every finite prefix
represents the same uniform rank-two matroid.  Nevertheless, the kernel of
`r_n` contains `(n + 1, -1)`.  After fixing the second coordinate to `-1`,
the target coordinate is unbounded.  Projectively, these blind directions
approach the target axis while the represented matroid stays unchanged.

This exact integer family is a falsifier for robustness objectives that reward
only the target's size on one blind kernel and ignore margins to *all* matroid
incidences.  It deliberately makes no claim about a repaired condition number.
-/
namespace RankTwoInstability

















theorem witness_in_sensor_kernel (n : Nat) :
    observe n (witness n) = 0 := by
  simp [observe, witness]
  omega














end RankTwoInstability





end NewMathDiscovery.LinearBlindness



open NewMathDiscovery.LinearBlindness.RankTwoInstability in
theorem solution (offset index : Nat) :
    observe (offset + index) (witness (offset + index)) = 0 ∧
    (witness (offset + index)).2 = -1 ∧
    target (witness (offset + index)) > Int.ofNat offset := by
  refine ⟨witness_in_sensor_kernel (offset + index), rfl, ?_⟩
  simp [target, witness]
  omega
