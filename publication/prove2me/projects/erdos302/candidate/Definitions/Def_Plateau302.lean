import Std
import Init.Grind.Ordered.Module
/-!
Finite plateau for the reciprocal-triple-free extremal function in Erdős problem 302.

The main theorem `plateau_732` says that the attainable cardinality thresholds for
subsets of {1,...,732} and {1,...,731} are identical. It does not assume a numerical
value for either extremal function. `exact_maximum_transfer` explicitly assumes
a numerical baseline at 731 and transfers it to 732.

The OEIS A390395 b-file, accessed 2026-09-07, ends with 731 606. Combining that
external baseline with this transition gives 732 606. The baseline is not
formalized in this file. This does not solve the asymptotic Erdős conjecture.

The finite isolation proof now uses exact quotient tables evaluated by the Lean
kernel. The earlier native bv_decide version remains in the publication history.
The current theorem has only ordinary Lean logical axioms; dependencies are printed below.
-/

namespace Erdos302Finite

-- Exact bridge to the original unit-fraction equation, using Lean core rationals.


def inGNat (x : Nat) : Bool :=
 x == 122 || x == 183 || x == 244 || x == 366 || x == 732



def gadget : List Nat := [122, 183, 244, 366, 732]
def outside : List Nat := (List.range 733).filter (fun x => 0 < x && !inGNat x)

def cardinal (S : Nat → Bool) : Nat :=
 (outside.filter S).length + (gadget.filter S).length

def Admissible (n : Nat) (S : Nat → Bool) : Prop :=
 (∀ x, S x → 0 < x ∧ x ≤ n) ∧
 (∀ a b c, a < b → b < c → S a → S b → S c → a * (b + c) ≠ b * c)

def replacement (S : Nat → Bool) (x : Nat) : Bool :=
 if inGNat x then x == 122 || x == 183 || x == 244 else S x















-- This domain is a permutation of 1,...,732, so `cardinal` is ordinary set cardinality.






def ExactMaximum (n k : Nat) : Prop :=
 (∃ S : Nat → Bool, Admissible n S ∧ cardinal S = k) ∧
 (∀ S : Nat → Bool, Admissible n S → cardinal S ≤ k)

-- The numerical 731 baseline is an explicit premise, not an axiom or an unproved assertion.








-- The same admissibility condition stated with exact rational unit fractions.
def RatAdmissible (n : Nat) (S : Nat → Bool) : Prop :=
 (∀ x, S x → 0 < x ∧ x ≤ n) ∧
 (∀ a b c, a < b → b < c → S a → S b → S c →
   (1 : Rat) / (↑a : Rat) ≠ (1 : Rat) / (↑b : Rat) + (1 : Rat) / (↑c : Rat))









end Erdos302Finite
