import CollatzWork.ResidueAncestorStatement
import CollatzWork.ResidueAncestorTails

namespace CollatzWork

/-!
# Complete guarded uniform residue-20 ancestor construction

The variable prefix, five refined inverse tails, exhaustive selector,
positive size comparison, and actual orbit composition are all proved here.
All comparisons retain the unchanged original root. Coverage remains guarded
by the displayed factorization with valuation at least 13.
-/

/-- The strict common slope bound holds uniformly above the exact base 13. -/
theorem residueAncestor_powerBound_shifted (j : Nat) :
    192 * 2 ^ (j + 13) < 3 ^ (j + 13) := by
  induction j with
  | zero => decide
  | succ j ih =>
      change 192 * (2 ^ (j + 13) * 2) < 3 ^ (j + 13) * 3
      have hp : 0 < 2 ^ (j + 13) := Nat.pow_pos (by omega)
      omega

theorem residueAncestor_powerBound (v : Nat) (hv : 13 ≤ v) :
    192 * 2 ^ v < 3 ^ v := by
  have h := residueAncestor_powerBound_shifted (v - 13)
  have hi : v - 13 + 13 = v := by omega
  simpa only [hi] using h

theorem residueAncestor_twoPow_unit (k : Nat) : 2 ^ k % 3 ≠ 0 := by
  induction k with
  | zero => decide
  | succ k ih =>
      rw [Nat.pow_succ, Nat.mul_mod]
      have hb : 2 ^ k % 3 < 3 := Nat.mod_lt _ (by omega)
      omega

theorem residueAncestor_product_unit (k u : Nat) (hu : u % 3 ≠ 0) :
    (2 ^ k * u) % 3 ≠ 0 := by
  have hp := residueAncestor_twoPow_unit k
  have hb : 2 ^ k % 3 < 3 := Nat.mod_lt _ (by omega)
  have hub : u % 3 < 3 := Nat.mod_lt _ (by omega)
  have hpCases : 2 ^ k % 3 = 1 ∨ 2 ^ k % 3 = 2 := by omega
  have huCases : u % 3 = 1 ∨ u % 3 = 2 := by omega
  rcases hpCases with hp1 | hp2 <;> rcases huCases with hu1 | hu2
  · simp [Nat.mul_mod, hp1, hu1]
  · simp [Nat.mul_mod, hp1, hu2]
  · simp [Nat.mul_mod, hp2, hu1]
  · simp [Nat.mul_mod, hp2, hu2]

/-- The h=1 variable prefix, expressed using x=2^k u. -/
theorem residueAncestor_prefix_one (k u r : Nat) (hu : 0 < u)
    (hguard : 3 ^ (k + 3) * u = 4 * r + 1) :
    shortcutIter (k + 3) (6 * (2 ^ k * u) - 1) = r := by
  have hc : 3 ^ ((k + 1) + 1) * (3 * u) = 4 * r + 1 := by
    calc
      _ = 3 ^ (((k + 1) + 1) + 1) * u := by
        rw [Nat.pow_succ 3 ((k + 1) + 1)]
        simp only [Nat.mul_assoc]
      _ = 3 ^ (k + 3) * u := by rw [show ((k + 1) + 1) + 1 = k + 3 by omega]
      _ = 4 * r + 1 := hguard
  have h := rootDescentAncestor 0 (k + 1) (3 * u) r (by omega) hc
  have hz : 2 ^ (k + 1) * (3 * u) = 6 * (2 ^ k * u) := by
    rw [Nat.pow_succ, Nat.mul_assoc, ← Nat.mul_assoc 2 3 u]
    exact Nat.mul_left_comm (2 ^ k) 6 u
  simpa only [Nat.zero_add, Nat.pow_zero, Nat.one_mul, hz,
    show k + 1 + 2 = k + 3 by omega] using h

/-- The h=2 variable prefix, with the same original root. -/
theorem residueAncestor_prefix_two (k u r : Nat) (hu : 0 < u)
    (hguard : 3 ^ (k + 3) * u = 4 * r + 1) :
    shortcutIter (k + 2) (9 * (2 ^ k * u) - 1) = r := by
  have hc : 3 ^ (k + 1) * (9 * u) = 4 * r + 1 := by
    calc
      _ = 3 ^ ((k + 1) + 2) * u := by
        rw [Nat.pow_add 3 (k + 1) 2]
        simp [Nat.mul_assoc]
      _ = 3 ^ (k + 3) * u := by rw [show (k + 1) + 2 = k + 3 by omega]
      _ = 4 * r + 1 := hguard
  have h := rootDescentAncestor 0 k (9 * u) r (by omega) hc
  have hz : 2 ^ k * (9 * u) = 9 * (2 ^ k * u) := by
    simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
  simpa only [Nat.zero_add, Nat.pow_zero, Nat.one_mul, hz] using h

theorem residueAncestor_even_tail (e b z r : Nat)
    (h : shortcutIter b z = r) : shortcutIter (e + b) (2 ^ e * z) = r := by
  rw [shortcutIter_add, shortcutIter_evenRun, h]

/-- Uniform construction after factoring the valuation as k+3. -/
theorem residueAncestor_normalized (k u r : Nat) (hk : 10 ≤ k)
    (hu : 0 < u) (hunit : u % 3 ≠ 0)
    (hguard : 3 ^ (k + 3) * u = 4 * r + 1) :
    ∃ m b : Nat, 0 < m ∧ m < r ∧ m % 27 = 20 ∧ shortcutIter b m = r := by
  let x := 2 ^ k * u
  have hx : 0 < x := Nat.mul_pos (Nat.pow_pos (by omega)) hu
  have hxu : x % 3 ≠ 0 := residueAncestor_product_unit k u hunit
  have hpow := residueAncestor_powerBound (k + 3) (by omega)
  have hscaled := Nat.mul_lt_mul_of_pos_right hpow hu
  have htwo : 2 ^ (k + 3) = 8 * 2 ^ k := by
    simp [Nat.pow_add, Nat.mul_comm]
  rw [htwo, hguard] at hscaled
  have hglobal : 1536 * x < 4 * r + 1 := by
    simpa [x, ← Nat.mul_assoc] using hscaled
  have hp1 : shortcutIter (k + 3) (6 * x - 1) = r :=
    residueAncestor_prefix_one k u r hu hguard
  have hp2 : shortcutIter (k + 2) (9 * x - 1) = r :=
    residueAncestor_prefix_two k u r hu hguard
  have hclasses : x % 9 = 1 ∨ x % 9 = 2 ∨ x % 9 = 4 ∨
      x % 9 = 5 ∨ x % 9 = 7 ∨ x % 9 = 8 := by omega
  rcases hclasses with h1 | h2 | h4 | h5 | h7 | h8
  · refine ⟨4 * (6 * x - 1), 2 + (k + 3), by omega, by omega, by omega, ?_⟩
    exact residueAncestor_even_tail 2 (k + 3) (6 * x - 1) r hp1
  · have hz : (6 * x - 1) % 27 = 11 := by omega
    obtain ⟨m, b, hm, hres, htail, hbound⟩ := residueAncestor_refinedTail (6 * x - 1) hz
    refine ⟨m, b + (k + 3), hm, by omega, hres, ?_⟩
    rw [shortcutIter_add, htail, hp1]
  · refine ⟨16 * (9 * x - 1), 4 + (k + 2), by omega, by omega, by omega, ?_⟩
    exact residueAncestor_even_tail 4 (k + 2) (9 * x - 1) r hp2
  · refine ⟨64 * (6 * x - 1), 6 + (k + 3), by omega, by omega, by omega, ?_⟩
    exact residueAncestor_even_tail 6 (k + 3) (6 * x - 1) r hp1
  · refine ⟨16 * (9 * x - 1), 4 + (k + 2), by omega, by omega, by omega, ?_⟩
    exact residueAncestor_even_tail 4 (k + 2) (9 * x - 1) r hp2
  · exact ⟨6 * x - 1, k + 3, by omega, by omega, by omega, hp1⟩

theorem residueAncestor : ResidueAncestorStatement := by
  intro v u r hv hu hunit hguard
  have hvform : v = (v - 3) + 3 := by omega
  rw [hvform] at hguard
  exact residueAncestor_normalized (v - 3) u r (by omega) hu hunit hguard

/-- Every positive integer has a finite power-of-three factor and a positive
unit. The recursion divides only when divisible, and strictly decreases. -/
theorem residueAncestor_factor_unit (n : Nat) :
    0 < n → ∃ e u : Nat, 0 < u ∧ u % 3 ≠ 0 ∧ 3 ^ e * u = n := by
  induction n using Nat.strongRecOn with
  | ind n ih =>
      intro hn
      by_cases hd : n % 3 = 0
      · have hqpos : 0 < n / 3 := by omega
        have hqlt : n / 3 < n := by omega
        obtain ⟨e, u, hu, hunit, he⟩ := ih (n / 3) hqlt hqpos
        refine ⟨e + 1, u, hu, hunit, ?_⟩
        rw [Nat.pow_succ, Nat.mul_comm (3 ^ e) 3, Nat.mul_assoc, he]
        omega
      · exact ⟨0, n, hn, hd, by simp⟩

/-- The full public criterion needs only divisibility by 3^13. Its
factorization is constructed above, not assumed as an unproved bridge. -/
theorem residueAncestor_of_divisibility : ResidueAncestorDivisibilityStatement := by
  intro r hdiv
  obtain ⟨a, ha⟩ := hdiv
  have ha0 : a ≠ 0 := by
    intro hzero
    rw [hzero, Nat.mul_zero] at ha
    omega
  obtain ⟨e, u, hu, hunit, he⟩ :=
    residueAncestor_factor_unit a (Nat.pos_of_ne_zero ha0)
  apply residueAncestor (13 + e) u r (by omega) hu hunit
  rw [Nat.pow_add, Nat.mul_assoc, he]
  exact ha.symm

example : ResidueAncestorStatement := residueAncestor
example : ResidueAncestorDivisibilityStatement := residueAncestor_of_divisibility

#print axioms CollatzWork.residueAncestor_powerBound
#print axioms CollatzWork.residueAncestor_normalized
#print axioms CollatzWork.residueAncestor
#print axioms CollatzWork.residueAncestor_factor_unit
#print axioms CollatzWork.residueAncestor_of_divisibility

end CollatzWork
