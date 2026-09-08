import Std
import Init.Grind.Ordered.Module
/-!
# Linear blindness as a common-kernel obstruction

This file isolates the exact algebraic obstruction behind target blindness.
It uses only subtraction-preserving maps, so it does not require Mathlib's
linear-algebra hierarchy.  Every linear map between modules is an instance of
this interface after forgetting scalar multiplication.
-/

namespace NewMathDiscovery.LinearBlindness

/-- A family of subtraction-preserving observations and one
subtraction-preserving target.  `sub_eq_zero_iff` records the only cancellation
law about the codomain needed below.

The interface is deliberately weaker than a module: ordinary linear
functionals satisfy all of these fields. -/
structure System (Index State Value : Type) where
  zeroState : State
  subState : State → State → State
  zeroValue : Value
  subValue : Value → Value → Value
  observe : Index → State → Value
  target : State → Value
  observe_zero : ∀ i, observe i zeroState = zeroValue
  target_zero : target zeroState = zeroValue
  observe_sub : ∀ i x y,
    observe i (subState x y) = subValue (observe i x) (observe i y)
  target_sub : ∀ x y,
    target (subState x y) = subValue (target x) (target y)
  sub_eq_zero_iff : ∀ a b, subValue a b = zeroValue ↔ a = b

/-- The selected observations cannot distinguish two states on which the
target differs. -/
def PairBlind {Index State Value : Type} (system : System Index State Value)
    (selected : Index → Prop) : Prop :=
  ∃ x y,
    system.target x ≠ system.target y ∧
      ∀ i, selected i → system.observe i x = system.observe i y

/-- A direction lies in the common kernel of the selected observations. -/
def InObservationKernel {Index State Value : Type}
    (system : System Index State Value) (selected : Index → Prop)
    (direction : State) : Prop :=
  ∀ i, selected i → system.observe i direction = system.zeroValue

/-- A common-kernel direction on which the target is nonzero. -/
def KernelWitness {Index State Value : Type}
    (system : System Index State Value) (selected : Index → Prop) : Prop :=
  ∃ direction,
    InObservationKernel system selected direction ∧
      system.target direction ≠ system.zeroValue



/-- The selected observations determine the target on all pairs of states. -/
def DeterminesTarget {Index State Value : Type}
    (system : System Index State Value) (selected : Index → Prop) : Prop :=
  ∀ x y,
    (∀ i, selected i → system.observe i x = system.observe i y) →
      system.target x = system.target y





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

def targetRow : Int × Int := (1, 0)

def sensorRow (n : Nat) : Int × Int := (1, Int.ofNat n + 1)

def determinant (a b : Int × Int) : Int :=
  a.1 * b.2 - a.2 * b.1

def target (x : Int × Int) : Int := x.1

def observe (n : Nat) (x : Int × Int) : Int :=
  x.1 + (Int.ofNat n + 1) * x.2

def witness (n : Nat) : Int × Int :=
  (Int.ofNat n + 1, -1)




















end RankTwoInstability





end NewMathDiscovery.LinearBlindness
