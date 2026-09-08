import Std
import Init.Grind.Ordered.Module
import Definitions.Def_Plateau302
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



















theorem local_cardinal_bound (S : Nat → Bool) (hS : Admissible 732 S) :
 (gadget.filter S).length ≤ 3 := by
 have h1 : ¬(S 122 = true ∧ S 183 = true ∧ S 366 = true) := by
  intro ⟨ha,hb,hc⟩
  exact hS.2 122 183 366 (by decide) (by decide) ha hb hc (by decide)
 have h2 : ¬(S 183 = true ∧ S 244 = true ∧ S 732 = true) := by
  intro ⟨ha,hb,hc⟩
  exact hS.2 183 244 732 (by decide) (by decide) ha hb hc (by decide)
 have h3 : ¬(S 244 = true ∧ S 366 = true ∧ S 732 = true) := by
  intro ⟨ha,hb,hc⟩
  exact hS.2 244 366 732 (by decide) (by decide) ha hb hc (by decide)
 cases ha : S 122 <;> cases hb : S 183 <;> cases hc : S 244 <;>
  cases hd : S 366 <;> cases he : S 732 <;> simp_all [gadget]









-- This domain is a permutation of 1,...,732, so `cardinal` is ordinary set cardinality.








-- The numerical 731 baseline is an explicit premise, not an axiom or an unproved assertion.








-- The same admissibility condition stated with exact rational unit fractions.










end Erdos302Finite



open Erdos302Finite in
theorem solution (S : Nat → Bool) (hS : Admissible 732 S) :
 cardinal S ≤ cardinal (replacement S) := by
 have hs : outside.filter S = outside.filter (replacement S) := by
  apply List.filter_congr
  intro x hx
  have hxg : inGNat x = false := by
   have h := (List.mem_filter.mp hx).2
   simp_all [outside]
  simp [replacement, hxg]
 have hg : (gadget.filter (replacement S)).length = 3 := by
  simp [gadget, replacement, inGNat]
 have hb := local_cardinal_bound S hS
 unfold cardinal
 rw [← hs, hg]
 omega
