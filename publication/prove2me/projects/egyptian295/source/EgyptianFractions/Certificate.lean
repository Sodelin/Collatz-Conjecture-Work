import Std
import Init.Data.Rat

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

/-- An exact finite certificate supplies a genuine mathematical witness. -/
theorem hasRepresentation_of_certificate {lower terms : Nat}
    {denominators : List Nat} (hLength : denominators.length = terms)
    (hRepresentation : IsRepresentation lower denominators) :
    HasRepresentation lower terms :=
  ⟨denominators, hLength, hRepresentation⟩

/-- Every minimum is at most the length of a verified certificate. -/
theorem minimum_le_of_certificate {lower minimum terms : Nat}
    {denominators : List Nat}
    (hMinimum : IsMinimumLength lower minimum)
    (hLength : denominators.length = terms)
    (hRepresentation : IsRepresentation lower denominators) :
    minimum ≤ terms :=
  hMinimum.2 terms (hasRepresentation_of_certificate hLength hRepresentation)

/-- Once a representation is supplied, well-ordering gives an actual minimum.
This does not assume existence of representations at unsupplied lower bounds. -/
theorem exists_minimum_of_representation {lower terms : Nat}
    (hRepresentation : HasRepresentation lower terms) :
    ∃ minimum, IsMinimumLength lower minimum := by
  classical
  have least : ∀ n, HasRepresentation lower n →
      ∃ minimum, IsMinimumLength lower minimum := by
    intro n
    induction n using Nat.strongRecOn with
    | ind n ih =>
      intro hCurrent
      by_cases hSmaller : ∃ m, m < n ∧ HasRepresentation lower m
      · obtain ⟨m, hLess, hRep⟩ := hSmaller
        exact ih m hLess hRep
      · refine ⟨n, hCurrent, ?_⟩
        intro m hRep
        exact Nat.le_of_not_gt (fun hLess => hSmaller ⟨m, hLess, hRep⟩)
  exact least terms hRepresentation

end EgyptianFractions
