import Std
import Init.Grind.Ordered.Module
import Definitions.Def_Plateau302
import Theorems.Thm_Erdos302Finite_replacement_admissible
import Theorems.Thm_Erdos302Finite_replacement_cardinal
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
theorem unit_fraction_equivalence (a b c : Nat) (ha : 0 < a) (hb : 0 < b) (hc : 0 < c) :
   (1 : Rat) / (↑a : Rat) = (1 : Rat) / (↑b : Rat) + (1 : Rat) / (↑c : Rat) ↔
   a * (b + c) = b * c := by
  have ha0 : a ≠ 0 := by omega
  have hb0 : b ≠ 0 := by omega
  have hc0 : c ≠ 0 := by omega
  change ((↑(1 : Int) : Rat) / (↑a : Rat) = (↑(1 : Int) : Rat) / (↑b : Rat) + (↑(1 : Int) : Rat) / (↑c : Rat)) ↔ _
  rw [← Rat.mkRat_eq_div, ← Rat.mkRat_eq_div, ← Rat.mkRat_eq_div]
  rw [Rat.mkRat_add_mkRat 1 1 hb0 hc0]
  rw [Rat.mkRat_eq_iff ha0 (Nat.mul_ne_zero hb0 hc0)]
  simp only [Int.one_mul]
  simp only [← Int.natCast_add, ← Int.natCast_mul, Int.ofNat_inj]
  simp [Nat.add_comm, Nat.mul_comm, eq_comm]






















theorem plateau_732 (k : Nat) :
 (∃ S : Nat → Bool, Admissible 732 S ∧ k ≤ cardinal S) ↔
 (∃ S : Nat → Bool, Admissible 731 S ∧ k ≤ cardinal S) := by
 constructor
 · rintro ⟨S,hS,hk⟩
   exact ⟨replacement S, replacement_admissible S hS,
      Nat.le_trans hk (replacement_cardinal S hS)⟩
 · rintro ⟨S,hS,hk⟩
   refine ⟨S, ⟨?_,hS.2⟩,hk⟩
   intro x hx
   have hb := hS.1 x hx
   omega





-- This domain is a permutation of 1,...,732, so `cardinal` is ordinary set cardinality.








-- The numerical 731 baseline is an explicit premise, not an axiom or an unproved assertion.








-- The same admissibility condition stated with exact rational unit fractions.


theorem admissible_iff_rat (n : Nat) (S : Nat → Bool) :
 Admissible n S ↔ RatAdmissible n S := by
 constructor
 · intro h
   refine ⟨h.1, ?_⟩
   intro a b c hab hbc ha hb hc hrel
   exact h.2 a b c hab hbc ha hb hc
     ((unit_fraction_equivalence a b c (h.1 a ha).1 (h.1 b hb).1 (h.1 c hc).1).mp hrel)
 · intro h
   refine ⟨h.1, ?_⟩
   intro a b c hab hbc ha hb hc hrel
   exact h.2 a b c hab hbc ha hb hc
     ((unit_fraction_equivalence a b c (h.1 a ha).1 (h.1 b hb).1 (h.1 c hc).1).mpr hrel)







end Erdos302Finite



open Erdos302Finite in
theorem solution (k : Nat) :
 (∃ S : Nat → Bool, RatAdmissible 732 S ∧ k ≤ cardinal S) ↔
 (∃ S : Nat → Bool, RatAdmissible 731 S ∧ k ≤ cardinal S) := by
 simp only [← admissible_iff_rat]
 exact plateau_732 k
