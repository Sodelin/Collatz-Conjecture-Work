import Std
import Init.Grind.Ordered.Module
import Definitions.Def_Plateau302
import Theorems.Thm_Erdos302Kernel_isolated_nat
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




theorem isolated_nat (a b c : Nat)
 (ha : 0 < a) (hab : a < b) (hbc : b < c) (hc : c ≤ 732)
 (hrel : a * (b + c) = b * c)
 (hG : inGNat a || inGNat b || inGNat c) :
 (a = 122 ∧ b = 183 ∧ c = 366) ∨
 (a = 183 ∧ b = 244 ∧ c = 732) ∨
 (a = 244 ∧ b = 366 ∧ c = 732) := by
 exact Erdos302Kernel.isolated_nat a b c ha hab hbc hc hrel hG










theorem replacement_bound (S : Nat → Bool) (hS : Admissible 732 S) :
 ∀ x, replacement S x → 0 < x ∧ x ≤ 731 := by
 intro x hx
 by_cases hG : inGNat x = true
 · simp [replacement, hG] at hx
   omega
 · have hnot : inGNat x = false := by cases h : inGNat x <;> simp_all
   have hsx : S x := by simpa [replacement, hnot] using hx
   have hb := hS.1 x hsx
   have : x ≠ 732 := by intro he; subst x; simp [inGNat] at hnot
   omega













-- This domain is a permutation of 1,...,732, so `cardinal` is ordinary set cardinality.








-- The numerical 731 baseline is an explicit premise, not an axiom or an unproved assertion.








-- The same admissibility condition stated with exact rational unit fractions.










end Erdos302Finite



open Erdos302Finite in
theorem solution (S : Nat → Bool) (hS : Admissible 732 S) :
 Admissible 731 (replacement S) := by
 have hbound := replacement_bound S hS
 refine ⟨hbound, ?_⟩
 intro a b c hab hbc ha hb hc heq
 have haa := (hbound a ha).1
 have hcc : c ≤ 732 := by have := (hbound c hc).2; omega
 by_cases hG : (inGNat a || inGNat b || inGNat c) = true
 · have hg := isolated_nat a b c haa hab hbc hcc heq hG
   rcases hg with ⟨rfl,rfl,rfl⟩ | ⟨rfl,rfl,rfl⟩ | ⟨rfl,rfl,rfl⟩
   all_goals simp [replacement, inGNat] at ha hb hc
 · have hz : inGNat a = false ∧ inGNat b = false ∧ inGNat c = false := by
    simpa [and_assoc] using hG
   have sa : S a := by simpa [replacement, hz.1] using ha
   have sb : S b := by simpa [replacement, hz.2.1] using hb
   have sc : S c := by simpa [replacement, hz.2.2] using hc
   exact hS.2 a b c hab hbc sa sb sc heq
