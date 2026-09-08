import Std
import Init.Grind.Ordered.Module
import Definitions.Def_Extension734
import Definitions.Def_Plateau302
import Theorems.Thm_Erdos302Extension734_lift_admissible
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





























-- This domain is a permutation of 1,...,732, so `cardinal` is ordinary set cardinality.
theorem domain_membership (x : Nat) :
 x ∈ (outside ++ gadget) ↔ 0 < x ∧ x ≤ 732 := by
 simp [outside, gadget, inGNat]
 omega



theorem cardinal_eq_domain_count (S : Nat → Bool) :
 cardinal S = ((outside ++ gadget).filter S).length := by
 simp [cardinal]



-- The numerical 731 baseline is an explicit premise, not an axiom or an unproved assertion.
theorem exact_maximum_transfer (k : Nat) (h : ExactMaximum 731 k) :
 ExactMaximum 732 k := by
 refine ⟨?_, ?_⟩
 · rcases h.1 with ⟨S,hS,hcard⟩
   refine ⟨S, ⟨?_,hS.2⟩,hcard⟩
   intro x hx
   have hb := hS.1 x hx
   omega
 · intro S hS
   exact Nat.le_trans (replacement_cardinal S hS)
     (h.2 (replacement S) (replacement_admissible S hS))







-- The same admissibility condition stated with exact rational unit fractions.










end Erdos302Finite
/-! Exact maximum transfers through 734. The numerical corollaries retain an explicit external baseline. -/

namespace Erdos302Extension734
open Erdos302Finite













theorem base_cardinal_congr (S T : Nat → Bool)
 (h : ∀ x, 0 < x → x ≤ 732 → S x = T x) : cardinal S = cardinal T := by
 rw [cardinal_eq_domain_count, cardinal_eq_domain_count]
 apply congrArg List.length
 apply List.filter_congr
 intro x hx
 have hh := (domain_membership x).mp hx
 exact h x hh.1 hh.2




theorem trim_cardinal (S : Nat → Bool) : cardinal (trim S) = cardinal S := by
 apply base_cardinal_congr
 intro x _ hx
 simp [trim, hx]

theorem lift_cardinal (S : Nat → Bool) (n : Nat) :
 cardinal (liftTo S n) = cardinal S := by
 apply base_cardinal_congr
 intro x _ hx
 simp [liftTo, hx]

theorem trim_admissible (S : Nat → Bool) (n : Nat) (hS : Admissible n S) :
 Admissible 732 (trim S) := by
 constructor
 · intro x hx
   simp [trim] at hx
   exact ⟨(hS.1 x hx.1).1,hx.2⟩
 · intro a b c hab hbc ha hb hc heq
   simp [trim] at ha hb hc
   exact hS.2 a b c hab hbc ha.1 hb.1 hc.1 heq





theorem full_lift_734 (S : Nat → Bool) :
 fullCardinal (liftTo S 734) = cardinal S + 2 := by
 simp [fullCardinal, lift_cardinal, liftTo]



theorem upper_full_734 (S : Nat → Bool) : fullCardinal S ≤ cardinal S + 2 := by
 cases h733 : S 733 <;> cases h734 : S 734 <;> simp [fullCardinal, h733, h734] <;> omega





theorem exact_maximum_734_transfer (k : Nat) (h : ExactMaximum 732 k) :
 FullExactMaximum 734 (k + 2) := by
 constructor
 · rcases h.1 with ⟨S,hS,hcard⟩
   exact ⟨liftTo S 734, lift_admissible S 734 (by decide) (by decide) hS,
    by rw [full_lift_734,hcard]⟩
 · intro S hS
   have hh := h.2 (trim S) (trim_admissible S 734 hS)
   rw [trim_cardinal] at hh
   have hu := upper_full_734 S
   omega

-- These numerical conclusions have an explicit external 731 baseline premise.































end Erdos302Extension734

open Erdos302Finite

open Erdos302Extension734 in
theorem solution (h : ExactMaximum 731 606) :
 FullExactMaximum 734 608 :=
 exact_maximum_734_transfer 606 (exact_maximum_transfer 606 h)
