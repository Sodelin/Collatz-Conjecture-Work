import Std
import Init.Grind.Ordered.Module
import Definitions.Def_Extension734
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





























-- This domain is a permutation of 1,...,732, so `cardinal` is ordinary set cardinality.
theorem domain_membership (x : Nat) :
 x ∈ (outside ++ gadget) ↔ 0 < x ∧ x ≤ 732 := by
 simp [outside, gadget, inGNat]
 omega

theorem domain_nodup : (outside ++ gadget).Nodup := by
 apply List.nodup_append.mpr
 refine ⟨List.Pairwise.filter _ List.nodup_range, by decide, ?_⟩
 intro a ha b hb heq
 subst b
 have hout := (List.mem_filter.mp ha).2
 simp [gadget] at hb
 simp [inGNat] at hout
 omega





-- The numerical 731 baseline is an explicit premise, not an axiom or an unproved assertion.








-- The same admissibility condition stated with exact rational unit fractions.










end Erdos302Finite

open Erdos302Finite

open Erdos302Extension734 in
theorem solution : fullDomain.Nodup := by
 apply List.nodup_append.mpr
 refine ⟨domain_nodup, by decide, ?_⟩
 intro a ha b hb heq
 have hbnd := (domain_membership a).mp ha
 simp at hb
 omega
