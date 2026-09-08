import Std
import Init.Grind.Ordered.Module
/-!
# Exact certificates for distinct Egyptian fractions

All sums use Lean's standard exact rational number type `Rat`. A certificate is
a proposition about actual rational addition and division, not an unconnected
Boolean or a floating-point computation. `decide +kernel` checks closed finite
instances by reduction in Lean's kernel; no native evaluation axiom is needed.
-/

namespace EgyptianFractions

/-- The ordinary sum of the unit fractions with the supplied denominators. -/
def reciprocalSum (denominators : List Nat) : Rat :=
  (denominators.map fun (d : Nat) => (1 : Rat) / (↑d : Rat)).sum

/-- Distinct positive denominators, each at least `lower`, summing to one. -/
def IsRepresentation (lower : Nat) (denominators : List Nat) : Prop :=
  denominators.Nodup ∧
  (∀ d ∈ denominators, 0 < d ∧ lower ≤ d) ∧
  reciprocalSum denominators = 1

instance (lower : Nat) (denominators : List Nat) :
    Decidable (IsRepresentation lower denominators) := by
  unfold IsRepresentation
  infer_instance

/-- Existence of a representation containing exactly `terms` fractions. -/
def HasRepresentation (lower terms : Nat) : Prop :=
  ∃ denominators : List Nat,
    denominators.length = terms ∧ IsRepresentation lower denominators

/-- The usual meaning of a minimum representation length, without an
unproved assumption that a minimum exists for every possible lower bound. -/
def IsMinimumLength (lower terms : Nat) : Prop :=
  HasRepresentation lower terms ∧
  ∀ other, HasRepresentation lower other → terms ≤ other







end EgyptianFractions
