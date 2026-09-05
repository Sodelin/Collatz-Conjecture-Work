import CollatzWork.RefinedMersenneChild

namespace CollatzWork

/-!
# Convergence, coalescence, and the unresolved universal obligation

This file proves semantic equivalences and a conditional induction rule.
It does not prove `UniversalSmallerCoalescence` or `UniversalDescent`.
The existing refined Mersenne certificate supplies one family of valid
smaller coalescing starts, not the missing universal statement.
-/

theorem converges_one : Converges 1 := ⟨0, rfl⟩

theorem converges_two : Converges 2 := ⟨1, rfl⟩

/-- Reaching `1` is preserved both forward and backward by a single step.
The zero-step case explicitly uses the `1 → 2 → 1` cycle. -/
theorem converges_onceAccelerated_iff (n : Nat) :
    Converges (onceAccelerated n) ↔ Converges n := by
  constructor
  · rintro ⟨k, hk⟩
    exact ⟨k + 1, hk⟩
  · rintro ⟨k, hk⟩
    cases k with
    | zero =>
        have hn : n = 1 := hk
        subst n
        exact converges_two
    | succ k => exact ⟨k, hk⟩

/-- Convergence is unchanged by any finite prefix of a forward orbit. -/
theorem converges_shortcutIter_iff (r n : Nat) :
    Converges (shortcutIter r n) ↔ Converges n := by
  induction r generalizing n with
  | zero => rfl
  | succ r ih =>
      rw [shortcutIter_succ, ih, converges_onceAccelerated_iff]

/-- Two starts sharing any forward orbit point either both converge or
both fail to converge. No synchrony or positivity hypothesis is needed. -/
theorem converges_iff_of_coalesces {n m r s : Nat}
    (h : shortcutIter r n = shortcutIter s m) :
    Converges n ↔ Converges m := by
  calc
    Converges n ↔ Converges (shortcutIter r n) :=
      (converges_shortcutIter_iff r n).symm
    _ ↔ Converges (shortcutIter s m) := by rw [h]
    _ ↔ Converges m := converges_shortcutIter_iff s m

/-- The strong-induction rule: a universal smaller-coalescing-start
certificate would imply convergence of every positive natural. -/
theorem allPositiveConverge_of_smallerCoalescence
    (h : UniversalSmallerCoalescence) : AllPositiveConverge := by
  intro n
  induction n using Nat.strongRecOn with
  | ind n ih =>
      intro hn
      by_cases hone : n = 1
      · subst n
        exact converges_one
      · have hgt : 1 < n := by omega
        obtain ⟨m, hm, hmn, r, s, hcoal⟩ := h n hgt
        exact (converges_iff_of_coalesces hcoal).mpr (ih m hmn hm)

/-- Convergence itself supplies the common endpoint `1` and smaller start
`1`, showing that the universal coalescence obligation is Collatz-equivalent. -/
theorem smallerCoalescence_of_allPositiveConverge
    (h : AllPositiveConverge) : UniversalSmallerCoalescence := by
  intro n hn
  obtain ⟨k, hk⟩ := h n (by omega)
  exact ⟨1, by omega, hn, k, 0, hk⟩

theorem smallerCoalescenceCriterion : SmallerCoalescenceCriterionStatement :=
  ⟨smallerCoalescence_of_allPositiveConverge,
    allPositiveConverge_of_smallerCoalescence⟩

theorem smallerCoalescence_of_descent (h : UniversalDescent) :
    UniversalSmallerCoalescence := by
  intro n hn
  obtain ⟨k, _, hpos, hlt⟩ := h n hn
  exact ⟨shortcutIter k n, hpos, hlt, k, 0, rfl⟩

theorem descent_of_allPositiveConverge (h : AllPositiveConverge) :
    UniversalDescent := by
  intro n hn
  obtain ⟨k, hk⟩ := h n (by omega)
  have hkpos : 0 < k := by
    cases k with
    | zero =>
        have hone : n = 1 := hk
        omega
    | succ k => omega
  exact ⟨k, hkpos, by rw [hk]; omega, by rw [hk]; exact hn⟩

theorem descentCriterion : DescentCriterionStatement := by
  constructor
  · exact descent_of_allPositiveConverge
  · intro h
    exact allPositiveConverge_of_smallerCoalescence
      (smallerCoalescence_of_descent h)

/-- The arithmetic certificate gives precisely the convergence equivalence
needed to use the smaller child in strong induction. -/
theorem refinedParent_converges_iff_child (L epsilon z : Nat) (hL : 2 ≤ L)
    (hepsilon : epsilon ≤ 1)
    (hparity : epsilon % 2 = L % 2) :
    Converges (refinedParent L epsilon z) ↔
      Converges (refinedChild L epsilon z) :=
  converges_iff_of_coalesces
    (refinedMersenneChild_coalesces L epsilon z hL hepsilon hparity)

/-- An explicit positive, strictly smaller coalescing witness for this family.
The compatibility assumptions remain visible in the theorem type. -/
theorem refinedParent_has_smaller_coalescence (L epsilon z : Nat)
    (hL : 2 ≤ L) (hepsilon : epsilon ≤ 1)
    (hparity : epsilon % 2 = L % 2) :
    ∃ m : Nat, 0 < m ∧ m < refinedParent L epsilon z ∧
      ∃ r s : Nat,
        shortcutIter r (refinedParent L epsilon z) = shortcutIter s m := by
  have harith := refinedChild_arithmetic L epsilon z hL
  exact ⟨refinedChild L epsilon z, harith.2.1, harith.2.2.1,
    L + 2, L, refinedMersenneChild_coalesces L epsilon z hL hepsilon hparity⟩

/-- The compatible parent converges under the ordinary strong-induction
hypothesis for smaller positive starts. -/
theorem refinedParent_converges_of_smaller (L epsilon z : Nat)
    (hL : 2 ≤ L) (hepsilon : epsilon ≤ 1)
    (hparity : epsilon % 2 = L % 2)
    (ih : ∀ m : Nat, 0 < m → m < refinedParent L epsilon z → Converges m) :
    Converges (refinedParent L epsilon z) := by
  have harith := refinedChild_arithmetic L epsilon z hL
  exact (refinedParent_converges_iff_child L epsilon z hL hepsilon hparity).mpr
    (ih (refinedChild L epsilon z) harith.2.1 harith.2.2.1)

-- These declarations mechanically check the exported headline theorem types
-- against their trusted statement definitions.
example : SmallerCoalescenceCriterionStatement := smallerCoalescenceCriterion
example : DescentCriterionStatement := descentCriterion

#print axioms CollatzWork.converges_onceAccelerated_iff
#print axioms CollatzWork.converges_shortcutIter_iff
#print axioms CollatzWork.converges_iff_of_coalesces
#print axioms CollatzWork.allPositiveConverge_of_smallerCoalescence
#print axioms CollatzWork.smallerCoalescenceCriterion
#print axioms CollatzWork.descentCriterion
#print axioms CollatzWork.refinedParent_converges_iff_child
#print axioms CollatzWork.refinedParent_has_smaller_coalescence
#print axioms CollatzWork.refinedParent_converges_of_smaller

end CollatzWork
