import Std
import Init.Grind.Ordered.Module
import Definitions.Def_Extension734
import Definitions.Def_KernelEndpoints734
import Definitions.Def_Plateau302
namespace Erdos302KernelEndpoints734

set_option maxRecDepth 100000
set_option maxHeartbeats 10000000



theorem endpoint733_check : endpointCheck 733 = true := by decide +kernel
theorem endpoint734_check : endpointCheck 734 = true := by decide +kernel

theorem endpoint_impossible (a b c : Nat)
 (hb : 0 < b) (hbc : b < c) (hc : c = 733 ∨ c = 734)
 (hrel : a * (b + c) = b * c) : False := by
 have htab : endpointCheck c = true := by
  rcases hc with rfl | rfl
  · exact endpoint733_check
  · exact endpoint734_check
 have hbound : b < 735 := by omega
 have hrow := List.all_eq_true.mp htab b (List.mem_range.mpr hbound)
 have hnonzero : b * c % (b + c) ≠ 0 := by
  simpa [hb,hbc] using hrow
 have hdiv : (b + c) ∣ b * c := ⟨a, by simpa [Nat.mul_comm] using hrel.symm⟩
 exact hnonzero (Nat.mod_eq_zero_of_dvd hdiv)

theorem no_new_triples (a b c : Nat)
 (ha : 0 < a) (hab : a < b) (hbc : b < c) (hc : c ≤ 734)
 (hrel : a * (b + c) = b * c) : c ≤ 732 := by
 by_cases h : c ≤ 732
 · exact h
 · have hend : c = 733 ∨ c = 734 := by omega
   exact False.elim (endpoint_impossible a b c (by omega) hbc hend hrel)





end Erdos302KernelEndpoints734
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








-- The same admissibility condition stated with exact rational unit fractions.










end Erdos302Finite
/-! Exact maximum transfers through 734. The numerical corollaries retain an explicit external baseline. -/

namespace Erdos302Extension734
open Erdos302Finite

theorem no_new_triples (a b c : Nat)
 (ha : 0 < a) (hab : a < b) (hbc : b < c) (hc : c ≤ 734)
 (hrel : a * (b + c) = b * c) : c ≤ 732 := by
 exact Erdos302KernelEndpoints734.no_new_triples a b c ha hab hbc hc hrel











theorem base_cardinal_congr (S T : Nat → Bool)
 (h : ∀ x, 0 < x → x ≤ 732 → S x = T x) : cardinal S = cardinal T := by
 rw [cardinal_eq_domain_count, cardinal_eq_domain_count]
 apply congrArg List.length
 apply List.filter_congr
 intro x hx
 have hh := (domain_membership x).mp hx
 exact h x hh.1 hh.2


























-- These numerical conclusions have an explicit external 731 baseline premise.















theorem add734_base_cardinal (S : Nat → Bool) : cardinal (add734 S) = cardinal S := by
 apply base_cardinal_congr
 intro x _ hx
 have hh : x ≠ 734 := by omega
 simp [add734,hh]

theorem erase734_base_cardinal (S : Nat → Bool) : cardinal (erase734 S) = cardinal S := by
 apply base_cardinal_congr
 intro x _ hx
 have hh : x ≠ 734 := by omega
 simp [erase734,hh]

theorem erase734_admissible (S : Nat → Bool) (hS : Admissible 734 S) :
 Admissible 733 (erase734 S) := by
 constructor
 · intro x hx
   by_cases heq : x = 734
   · simp [erase734,heq] at hx
   · have hsx : S x := by simpa [erase734,heq] using hx
     have hh := hS.1 x hsx
     omega
 · intro a b c hab hbc ha hb hc heq
   have sub : ∀ x, erase734 S x → S x := by
    intro x hx
    by_cases h : x = 734 <;> simp_all [erase734]
   exact hS.2 a b c hab hbc (sub a ha) (sub b hb) (sub c hc) heq

theorem add734_admissible (S : Nat → Bool) (hS : Admissible 733 S) :
 Admissible 734 (add734 S) := by
 have support : ∀ x, add734 S x → 0 < x ∧ x ≤ 734 := by
  intro x hx
  by_cases h : x = 734
  · omega
  · have hsx : S x := by simpa [add734,h] using hx
    have hh := hS.1 x hsx
    omega
 refine ⟨support,?_⟩
 intro a b c hab hbc ha hb hc heq
 have hh := no_new_triples a b c (support a ha).1 hab hbc (support c hc).2 heq
 have an : a ≠ 734 := by omega
 have bn : b ≠ 734 := by omega
 have cn : c ≠ 734 := by omega
 have sa : S a := by simpa [add734,an] using ha
 have sb : S b := by simpa [add734,bn] using hb
 have sc : S c := by simpa [add734,cn] using hc
 exact hS.2 a b c hab hbc sa sb sc heq

theorem add734_cardinal (S : Nat → Bool) (hS : Admissible 733 S) :
 fullCardinal (add734 S) = fullCardinal S + 1 := by
 have hz : S 734 = false := by
  cases h : S 734
  · rfl
  · have hh := (hS.1 734 h).2
    omega
 simp [fullCardinal,add734_base_cardinal,add734,hz]

theorem erase734_cardinal (S : Nat → Bool) :
 fullCardinal S ≤ fullCardinal (erase734 S) + 1 := by
 cases hh : S 734 <;> simp [fullCardinal,erase734_base_cardinal,erase734,hh]





end Erdos302Extension734

open Erdos302Finite

open Erdos302Extension734 in
theorem solution (k : Nat) (h : FullExactMaximum 733 k) :
 FullExactMaximum 734 (k + 1) := by
 constructor
 · rcases h.1 with ⟨S,hS,hc⟩
   exact ⟨add734 S,add734_admissible S hS, by rw [add734_cardinal S hS,hc]⟩
 · intro S hS
   have h1 := h.2 (erase734 S) (erase734_admissible S hS)
   have h2 := erase734_cardinal S
   omega
