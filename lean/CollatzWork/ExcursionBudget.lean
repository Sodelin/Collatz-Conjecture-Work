import CollatzWork.ExcursionBudgetStatement
import CollatzWork.Convergence

namespace CollatzWork

/-!
An arbitrary finite list of actual-orbit envelopes composes relative to the
unchanged root. A terminal strict envelope plus an explicit half-margin budget
implies descent. The OOEO power inequalities, parity-word/CRT construction,
ancestor cancellation, and all-root coverage are NOT formalized by this file.
-/

theorem shiftedEnvelope_compose (root k l A B D E : Nat)
    (hfirst : D * (shortcutIter k root + 3) ≤ A * (root + 3))
    (hsecond : E * (shortcutIter l (shortcutIter k root) + 3) ≤
      B * (shortcutIter k root + 3)) :
    (D * E) * (shortcutIter (k + l) root + 3) ≤
      (A * B) * (root + 3) := by
  rw [shortcutIter_add]
  calc
    (D * E) * (shortcutIter l (shortcutIter k root) + 3) =
        D * (E * (shortcutIter l (shortcutIter k root) + 3)) := by ac_rfl
    _ ≤ D * (B * (shortcutIter k root + 3)) := Nat.mul_le_mul_left D hsecond
    _ = B * (D * (shortcutIter k root + 3)) := by ac_rfl
    _ ≤ B * (A * (root + 3)) := Nat.mul_le_mul_left B hfirst
    _ = (A * B) * (root + 3) := by ac_rfl

/-- No uniform bound on the number or lengths of the segments is assumed. -/
theorem excursionChainEnvelope : ExcursionChainEnvelopeStatement := by
  intro segments
  induction segments with
  | nil =>
      intro root h
      simp [excursionDenominator, excursionNumerator, excursionSteps, shortcutIter]
  | cons s rest ih =>
      intro root h
      obtain ⟨hpos, hlocal, htail⟩ := h
      obtain ⟨htailBound, htailPos⟩ := ih (shortcutIter s.steps root) htail
      constructor
      · exact shiftedEnvelope_compose root s.steps (excursionSteps rest)
          s.numerator (excursionNumerator rest) s.denominator
          (excursionDenominator rest) hlocal htailBound
      · exact Nat.mul_pos hpos htailPos

/-- Append a terminal unshifted strict bound to a shifted prefix ledger. -/
theorem terminalEnvelope_compose (root k l A B D E : Nat) (hD : 0 < D)
    (hprefix : D * (shortcutIter k root + 3) ≤ A * (root + 3))
    (hterminal : E * shortcutIter l (shortcutIter k root) <
      B * (shortcutIter k root + 3)) :
    (D * E) * shortcutIter (k + l) root < (A * B) * (root + 3) := by
  rw [shortcutIter_add]
  calc
    (D * E) * shortcutIter l (shortcutIter k root) =
        D * (E * shortcutIter l (shortcutIter k root)) := by ac_rfl
    _ < D * (B * (shortcutIter k root + 3)) :=
      Nat.mul_lt_mul_of_pos_left hterminal hD
    _ = B * (D * (shortcutIter k root + 3)) := by ac_rfl
    _ ≤ B * (A * (root + 3)) := Nat.mul_le_mul_left B hprefix
    _ = (A * B) * (root + 3) := by ac_rfl

/-- The slack is paid against the original root, not the last return. -/
theorem excursionBudgetDescent : ExcursionBudgetDescentStatement := by
  intro root steps A D hroot henvelope hbudget
  have hshift : root + 3 ≤ 2 * root := by omega
  have hcompare : D * shortcutIter steps root < D * root := by
    calc
      D * shortcutIter steps root < A * (root + 3) := henvelope
      _ ≤ A * (2 * root) := Nat.mul_le_mul_left A hshift
      _ = (2 * A) * root := by ac_rfl
      _ ≤ D * root := Nat.mul_le_mul_right root hbudget
  exact Nat.lt_of_mul_lt_mul_left hcompare

theorem excursionChain_terminal_descent (segments : List ExcursionSegment)
    (root steps B E : Nat) (hroot : 3 ≤ root)
    (hchain : ExcursionChain root segments)
    (hterminal : E * shortcutIter steps (shortcutIter (excursionSteps segments) root) <
      B * (shortcutIter (excursionSteps segments) root + 3))
    (hbudget : 2 * (excursionNumerator segments * B) ≤
      excursionDenominator segments * E) :
    shortcutIter (excursionSteps segments + steps) root < root := by
  obtain ⟨hprefix, hD⟩ := excursionChainEnvelope segments root hchain
  exact excursionBudgetDescent root (excursionSteps segments + steps)
    (excursionNumerator segments * B) (excursionDenominator segments * E) hroot
    (terminalEnvelope_compose root (excursionSteps segments) steps
      (excursionNumerator segments) B (excursionDenominator segments) E
      hD hprefix hterminal) hbudget

private theorem excursion_positive_step (n : Nat) (hn : 0 < n) :
    0 < onceAccelerated n := by
  unfold onceAccelerated
  split <;> omega

private theorem excursion_positive_iter (steps root : Nat) (hroot : 0 < root) :
    0 < shortcutIter steps root := by
  induction steps generalizing root with
  | zero => exact hroot
  | succ steps ih => exact ih (onceAccelerated root) (excursion_positive_step root hroot)

/-- This is conditional strong-induction transfer, not universal convergence. -/
theorem excursionChain_converges_of_smaller (segments : List ExcursionSegment)
    (root steps B E : Nat) (hroot : 3 ≤ root)
    (hchain : ExcursionChain root segments)
    (hterminal : E * shortcutIter steps (shortcutIter (excursionSteps segments) root) <
      B * (shortcutIter (excursionSteps segments) root + 3))
    (hbudget : 2 * (excursionNumerator segments * B) ≤
      excursionDenominator segments * E)
    (ih : ∀ m : Nat, 0 < m → m < root → Converges m) : Converges root := by
  have hsmall := excursionChain_terminal_descent segments root steps B E
    hroot hchain hterminal hbudget
  exact (converges_shortcutIter_iff (excursionSteps segments + steps) root).mp
    (ih _ (excursion_positive_iter _ root (by omega)) hsmall)

example : ExcursionChainEnvelopeStatement := excursionChainEnvelope
example : ExcursionBudgetDescentStatement := excursionBudgetDescent

#print axioms CollatzWork.shiftedEnvelope_compose
#print axioms CollatzWork.excursionChainEnvelope
#print axioms CollatzWork.terminalEnvelope_compose
#print axioms CollatzWork.excursionBudgetDescent
#print axioms CollatzWork.excursionChain_terminal_descent
#print axioms CollatzWork.excursionChain_converges_of_smaller

end CollatzWork
