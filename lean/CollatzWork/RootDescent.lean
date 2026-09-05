import CollatzWork.RootDescentStatement
import CollatzWork.Convergence

namespace CollatzWork

/-!
# Root-relative forward descent after an unbounded OOE burst

The proof uses the actual one-division Collatz map throughout. The divisibility
guard is explicit and is not a universal coverage claim. In particular, the
theorem does not prove the Collatz conjecture.
-/

/-- A complete odd, odd, even block on its exact residue class. -/
theorem shortcutIter_OOE (z : Nat) :
    shortcutIter 3 (8 * z + 3) = 9 * z + 4 := by
  have hfirst : onceAccelerated (8 * z + 3) = 12 * z + 5 := by
    unfold onceAccelerated
    have hodd : (8 * z + 3) % 2 ≠ 0 := by omega
    simp only [hodd, ↓reduceIte]
    omega
  have hsecond : onceAccelerated (12 * z + 5) = 18 * z + 8 := by
    unfold onceAccelerated
    have hodd : (12 * z + 5) % 2 ≠ 0 := by omega
    simp only [hodd, ↓reduceIte]
    omega
  have hthird : onceAccelerated (18 * z + 8) = 9 * z + 4 := by
    rw [show 18 * z + 8 = 2 * (9 * z + 4) by omega]
    exact onceAccelerated_two_mul _
  simp only [shortcutIter, hfirst, hsecond, hthird]

theorem shortcutIter_OOE_shifted (w : Nat) (hw : 0 < w) :
    shortcutIter 3 (8 * w - 5) = 9 * w - 5 := by
  have hinput : 8 * w - 5 = 8 * (w - 1) + 3 := by omega
  rw [hinput, shortcutIter_OOE]
  omega

theorem rootDescentBurst : RootDescentBurstStatement := by
  intro k
  induction k with
  | zero => intro u hu; simp [shortcutIter]
  | succ k ih =>
      intro u hu
      have hw : 0 < 8 ^ k * u := Nat.mul_pos (Nat.pow_pos (by omega)) hu
      rw [show 3 * (k + 1) = 3 + 3 * k by omega, shortcutIter_add]
      rw [show 8 ^ (k + 1) * u = 8 * (8 ^ k * u) by
        simp [Nat.pow_succ, Nat.mul_comm, Nat.mul_left_comm]]
      rw [shortcutIter_OOE_shifted _ hw]
      rw [show 9 * (8 ^ k * u) = 8 ^ k * (9 * u) by
        simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]]
      rw [ih (9 * u) (by omega)]
      simp [Nat.pow_succ, Nat.mul_assoc, Nat.mul_comm]

/-- An exact forward even run, including the zero-length case. -/
theorem shortcutIter_evenRun (k m : Nat) :
    shortcutIter k (2 ^ k * m) = m := by
  induction k with
  | zero => simp
  | succ k ih =>
      rw [show 2 ^ (k + 1) * m = 2 * (2 ^ k * m) by
        simp [Nat.pow_succ, Nat.mul_comm, Nat.mul_left_comm]]
      rw [shortcutIter_succ, onceAccelerated_two_mul, ih]

/-- The coefficient margin exceeds the entire additive subtraction loss. -/
theorem rootDescent_power_margin (j : Nat) :
    9 ^ (j + 1) + 5 * 2 ^ (j + 1) < 16 ^ (j + 1) + 5 := by
  induction j with
  | zero => decide
  | succ j ih =>
      change 9 ^ (j + 1) * 9 + 5 * (2 ^ (j + 1) * 2) <
        16 ^ (j + 1) * 16 + 5
      have htwo : 0 < 2 ^ (j + 1) := Nat.pow_pos (by omega)
      have hsixteen : 0 < 16 ^ (j + 1) := Nat.pow_pos (by omega)
      omega

theorem rootDescent_scaled_margin (k u : Nat) (hk : 0 < k) (hu : 0 < u) :
    9 ^ k * u + 5 * 2 ^ k < 16 ^ k * u + 5 := by
  have hmargin : 9 ^ k + 5 * 2 ^ k < 16 ^ k + 5 := by
    cases k with
    | zero => omega
    | succ j => exact rootDescent_power_margin j
  have htwo : 0 < 2 ^ k := Nat.pow_pos (by omega)
  have hcoeff : 9 ^ k ≤ 16 ^ k := by omega
  have hdiff : 9 ^ k + (16 ^ k - 9 ^ k) = 16 ^ k := by omega
  have hscale : 16 ^ k - 9 ^ k ≤ (16 ^ k - 9 ^ k) * u := by
    simpa using Nat.mul_le_mul_left (16 ^ k - 9 ^ k) hu
  have hproduct : 16 ^ k * u = 9 ^ k * u + (16 ^ k - 9 ^ k) * u := by
    calc
      16 ^ k * u = (9 ^ k + (16 ^ k - 9 ^ k)) * u :=
        congrArg (fun a => a * u) hdiff.symm
      _ = 9 ^ k * u + (16 ^ k - 9 ^ k) * u := Nat.add_mul _ _ _
  omega

theorem rootDescent : RootDescentStatement := by
  intro k u m hk hu hm hguard
  have hburst := rootDescentBurst k u hu
  have hendpoint : 9 ^ k * u - 5 = 2 ^ k * m := by omega
  have hiter : shortcutIter (4 * k) (8 ^ k * u - 5) = m := by
    rw [show 4 * k = 3 * k + k by omega, shortcutIter_add,
      hburst, hendpoint, shortcutIter_evenRun]
  have height : 8 ≤ 8 ^ k := by
    cases k with
    | zero => omega
    | succ j =>
        have hp : 0 < 8 ^ j := Nat.pow_pos (by omega)
        rw [Nat.pow_succ]
        omega
  have hrootlarge : 5 ≤ 8 ^ k * u := by
    have hp : 8 ^ k ≤ 8 ^ k * u := by
      simpa using Nat.mul_le_mul_left (8 ^ k) hu
    omega
  have hroot : (8 ^ k * u - 5) + 5 = 8 ^ k * u := by omega
  have hscaled := congrArg (fun n => 2 ^ k * n) hroot
  have hpowers : 2 ^ k * 8 ^ k = 16 ^ k := (Nat.mul_pow 2 8 k).symm
  simp only [Nat.mul_add, ← Nat.mul_assoc, hpowers] at hscaled
  have hmargin := rootDescent_scaled_margin k u hk hu
  have hcompare : 2 ^ k * m < 2 ^ k * (8 ^ k * u - 5) := by
    omega
  exact ⟨hiter, Nat.lt_of_mul_lt_mul_left hcompare⟩

/-- This guarded family discharges the usual fixed-root induction obligation. -/
theorem rootDescent_converges_of_smaller (k u m : Nat)
    (hk : 0 < k) (hu : 0 < u) (hm : 0 < m)
    (hguard : 2 ^ k * m + 5 = 9 ^ k * u)
    (ih : ∀ a : Nat, 0 < a → a < 8 ^ k * u - 5 → Converges a) :
    Converges (8 ^ k * u - 5) := by
  obtain ⟨hiter, hlt⟩ := rootDescent k u m hk hu hm hguard
  exact (converges_shortcutIter_iff (4 * k) (8 ^ k * u - 5)).mp
    (by rw [hiter]; exact ih m hm hlt)

/-- The guarded final even, odd block of an ancestor word. -/
theorem shortcutIter_EO_of_affine_guard (x r : Nat)
    (hguard : 3 * x + 2 = 4 * r) : shortcutIter 2 x = r := by
  have heven : x % 2 = 0 := by omega
  have hodd : (x / 2) % 2 ≠ 0 := by omega
  have hfirst : onceAccelerated x = x / 2 := by
    simp [onceAccelerated, heven]
  change onceAccelerated (onceAccelerated x) = r
  rw [hfirst]
  simp only [onceAccelerated, hodd, ↓reduceIte]
  omega

/-- Leading even steps, an arbitrary odd run, then E,O reach the guarded
original root. This lemma supplies orbit semantics for separate size bounds. -/
theorem rootDescentAncestor : RootDescentAncestorStatement := by
  intro e L q r hq hguard
  rw [shortcutIter_add (e + L) 2, shortcutIter_add e L,
    shortcutIter_evenRun, oddRun L q hq]
  apply shortcutIter_EO_of_affine_guard
  have hp : 0 < 3 ^ L * q := Nat.mul_pos (Nat.pow_pos (by omega)) hq
  have hpower : 3 ^ (L + 1) * q = 3 * (3 ^ L * q) := by
    simp [Nat.pow_succ, Nat.mul_comm, Nat.mul_left_comm]
  rw [hpower] at hguard
  omega

example : RootDescentBurstStatement := rootDescentBurst
example : RootDescentStatement := rootDescent
example : RootDescentAncestorStatement := rootDescentAncestor

#print axioms CollatzWork.rootDescentBurst
#print axioms CollatzWork.rootDescent_power_margin
#print axioms CollatzWork.rootDescent
#print axioms CollatzWork.rootDescent_converges_of_smaller
#print axioms CollatzWork.rootDescentAncestor

end CollatzWork
