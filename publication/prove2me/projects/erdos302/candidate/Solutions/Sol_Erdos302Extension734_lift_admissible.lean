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
/-! Exact maximum transfers through 734. The numerical corollaries retain an explicit external baseline. -/

namespace Erdos302Extension734
open Erdos302Finite

theorem no_new_triples (a b c : Nat)
 (ha : 0 < a) (hab : a < b) (hbc : b < c) (hc : c ≤ 734)
 (hrel : a * (b + c) = b * c) : c ≤ 732 := by
 exact Erdos302KernelEndpoints734.no_new_triples a b c ha hab hbc hc hrel






































-- These numerical conclusions have an explicit external 731 baseline premise.































end Erdos302Extension734

open Erdos302Finite

open Erdos302Extension734 in
theorem solution (S : Nat → Bool) (n : Nat)
 (hnlo : 732 ≤ n) (hnhi : n ≤ 734) (hS : Admissible 732 S) :
 Admissible n (liftTo S n) := by
 have support : ∀ x, liftTo S n x → 0 < x ∧ x ≤ n := by
  intro x hx
  by_cases h : x ≤ 732
  · have hsx : S x := by simpa [liftTo, h] using hx
    have hh := hS.1 x hsx
    omega
  · simp [liftTo, h] at hx
    omega
 refine ⟨support, ?_⟩
 intro a b c hab hbc ha hb hc heq
 have ca : 0 < a := (support a ha).1
 have cc : c ≤ 734 := by have hh := (support c hc).2; omega
 have cb := no_new_triples a b c ca hab hbc cc heq
 have ab : a ≤ 732 := by omega
 have bb : b ≤ 732 := by omega
 have sa : S a := by simpa [liftTo, ab] using ha
 have sb : S b := by simpa [liftTo, bb] using hb
 have sc : S c := by simpa [liftTo, cb] using hc
 exact hS.2 a b c hab hbc sa sb sc heq
