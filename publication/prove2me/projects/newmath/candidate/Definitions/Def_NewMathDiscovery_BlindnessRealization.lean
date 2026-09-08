import Std
import Init.Grind.Ordered.Module
namespace NewMathDiscovery.BlindnessRealization

/-- One target-false base state and one target-true state for each generator. -/
inductive State (J : Type) where
  | base
  | face (j : J)
  deriving DecidableEq

namespace State

def target {J : Type} : State J → Bool
  | .base => false
  | .face _ => true

/-- The base state reports `false`. A face state reports `false` exactly on
coordinates belonging to that face. -/
def observe {I J : Type} (F : J → I → Bool) (i : I) : State J → Bool
  | .base => false
  | .face j => !(F j i)

end State

/-- Two states are observationally indistinguishable to coalition `S`. -/
def AgreeOn {I X : Type} (S : I → Prop) (r : I → X → Bool)
    (x y : X) : Prop :=
  ∀ i, S i → r i x = r i y

/-- A coalition is target-blind if it cannot distinguish two states with
opposite Boolean targets. -/
def Blind {I X : Type} (S : I → Prop) (r : I → X → Bool)
    (q : X → Bool) : Prop :=
  ∃ x y, q x ≠ q y ∧ AgreeOn S r x y








end NewMathDiscovery.BlindnessRealization
