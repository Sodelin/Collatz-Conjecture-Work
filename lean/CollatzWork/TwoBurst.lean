import CollatzWork.TwoBurstStatement
import CollatzWork.RootDescent

namespace CollatzWork

/-!
# Two-burst recharge followed by descent below the original root

Only the ordinary shortcut Collatz map is iterated. All arithmetic guards
are explicit. This does not prove that every start has these guards, or
that every recharge eventually produces such an escape.
-/

/-- A legitimate odd, even connector. -/
theorem shortcutIter_OE (z : Nat) :
    shortcutIter 2 (4 * z + 1) = 3 * z + 1 := by
  have hfirst : onceAccelerated (4 * z + 1) = 6 * z + 2 := by
    unfold onceAccelerated
    have hodd : (4 * z + 1) % 2 ≠ 0 := by omega
    simp only [hodd, ↓reduceIte]
    omega
  have hsecond : onceAccelerated (6 * z + 2) = 3 * z + 1 := by
    rw [show 6 * z + 2 = 2 * (3 * z + 1) by omega]
    exact onceAccelerated_two_mul _
  simp only [shortcutIter, hfirst, hsecond]

theorem twoBurst_connector (a w : Nat) (hw : 2 ≤ w)
    (hguard : a + 1 = 2 * w) :
    shortcutIter 2 (2 * a - 5) = 3 * w - 5 := by
  rw [show 2 * a - 5 = 4 * (w - 2) + 1 by omega, shortcutIter_OE]
  omega

private theorem nine_power_le_sixteen (l : Nat) : 9 ^ l ≤ 16 ^ l := by
  induction l with
  | zero => decide
  | succ l ih =>
      simp only [Nat.pow_succ]
      omega

/-- A deliberately loose coefficient margin that absorbs the entire
subtraction loss, uniformly in both burst lengths. -/
theorem twoBurst_power_margin (j l : Nat) :
    3 * 9 ^ (j + l + 1) + 3 * 9 ^ l +
        10 * 8 ^ l * 2 ^ (j + l + 1) < 4 * 16 ^ (j + l + 1) := by
  induction j with
  | zero =>
      have hle := nine_power_le_sixteen l
      have hpos : 0 < 16 ^ l := Nat.pow_pos (by omega)
      have hpowers : 8 ^ l * 2 ^ l = 16 ^ l :=
        (Nat.mul_pow 8 2 l).symm
      simp only [Nat.zero_add, Nat.pow_succ]
      have hterm : 10 * 8 ^ l * (2 ^ l * 2) = 20 * 16 ^ l := by
        calc
          10 * 8 ^ l * (2 ^ l * 2) = 20 * (8 ^ l * 2 ^ l) := by
            simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
          _ = 20 * 16 ^ l := by rw [hpowers]
      rw [hterm]
      omega
  | succ j ih =>
      rw [show j + 1 + l + 1 = (j + l + 1) + 1 by omega]
      change 3 * (9 ^ (j + l + 1) * 9) + 3 * 9 ^ l +
        10 * 8 ^ l * (2 ^ (j + l + 1) * 2) <
          4 * (16 ^ (j + l + 1) * 16)
      have hterm : 10 * 8 ^ l * (2 ^ (j + l + 1) * 2) =
          2 * (10 * 8 ^ l * 2 ^ (j + l + 1)) := by
        simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
      rw [hterm]
      omega

theorem twoBurst_scaled_margin (k l u : Nat) (hk : 0 < k) (hu : 0 < u) :
    3 * 9 ^ (k + l) * u + 3 * 9 ^ l +
        10 * 8 ^ l * 2 ^ (k + l) < 4 * 16 ^ (k + l) * u := by
  have hmargin : 3 * 9 ^ (k + l) +
      (3 * 9 ^ l + 10 * 8 ^ l * 2 ^ (k + l)) < 4 * 16 ^ (k + l) := by
    cases k with
    | zero => omega
    | succ j =>
        have h := twoBurst_power_margin j l
        rw [show j + 1 + l = j + l + 1 by omega]
        omega
  have hscaled := Nat.mul_lt_mul_of_pos_right hmargin hu
  have hconstant : 3 * 9 ^ l + 10 * 8 ^ l * 2 ^ (k + l) ≤
      (3 * 9 ^ l + 10 * 8 ^ l * 2 ^ (k + l)) * u := by
    simpa using Nat.mul_le_mul_left
      (3 * 9 ^ l + 10 * 8 ^ l * 2 ^ (k + l)) hu
  simp only [Nat.add_mul] at hscaled hconstant
  omega

private theorem eight_power_positive_exponent (k : Nat) (hk : 0 < k) :
    8 ≤ 8 ^ k := by
  cases k with
  | zero => omega
  | succ j =>
      have hp : 0 < 8 ^ j := Nat.pow_pos (by omega)
      rw [Nat.pow_succ]
      omega

theorem twoBurstDescent : TwoBurstDescentStatement := by
  intro k l u v m hk hl hu hv _hm hrecharge hexit
  have hpower : 2 ^ (3 * l + 1) = 2 * 8 ^ l := by
    rw [Nat.pow_add, Nat.pow_mul]
    simp [Nat.mul_comm]
  rw [hpower] at hrecharge
  have h8l := eight_power_positive_exponent l hl
  have hw : 2 ≤ 8 ^ l * v := by
    have hmul : 8 ^ l ≤ 8 ^ l * v := by
      simpa using Nat.mul_le_mul_left (8 ^ l) hv
    omega
  have hconnector : shortcutIter 2 (2 * 9 ^ k * u - 5) = 3 * 8 ^ l * v - 5 := by
    have h := twoBurst_connector (9 ^ k * u) (8 ^ l * v) hw
      (by simpa [Nat.mul_assoc] using hrecharge)
    simpa [Nat.mul_assoc] using h
  have hfirst : shortcutIter (3 * k) (2 * 8 ^ k * u - 5) =
      2 * 9 ^ k * u - 5 := by
    simpa [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using
      rootDescentBurst k (2 * u) (by omega)
  have hsecond : shortcutIter (3 * l) (3 * 8 ^ l * v - 5) =
      3 * 9 ^ l * v - 5 := by
    simpa [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using
      rootDescentBurst l (3 * v) (by omega)
  have hend : 3 * 9 ^ l * v - 5 = 2 ^ (k + l) * m := by omega
  have hiter : shortcutIter (4 * (k + l) + 2) (2 * 8 ^ k * u - 5) = m := by
    rw [show 4 * (k + l) + 2 = 3 * k + (2 + (3 * l + (k + l))) by omega,
      shortcutIter_add, hfirst, shortcutIter_add, hconnector,
      shortcutIter_add, hsecond, hend, shortcutIter_evenRun]
  have h8k := eight_power_positive_exponent k hk
  have hroot : (2 * 8 ^ k * u - 5) + 5 = 2 * 8 ^ k * u := by
    have hmul : 2 * 8 ^ k ≤ 2 * 8 ^ k * u := by
      simpa using Nat.mul_le_mul_left (2 * 8 ^ k) hu
    omega
  have htotal : (2 * 8 ^ l * 2 ^ (k + l)) * (2 * 8 ^ k * u) =
      4 * 16 ^ (k + l) * u := by
    calc
      (2 * 8 ^ l * 2 ^ (k + l)) * (2 * 8 ^ k * u) =
          4 * (2 ^ (k + l) * (8 ^ k * 8 ^ l)) * u := by
        simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
      _ = 4 * (2 ^ (k + l) * 8 ^ (k + l)) * u := by rw [Nat.pow_add 8]
      _ = 4 * 16 ^ (k + l) * u := by rw [← Nat.mul_pow]
  have hrootScaled := congrArg (fun a => (2 * 8 ^ l * 2 ^ (k + l)) * a) hroot
  rw [Nat.mul_add, htotal] at hrootScaled
  have hrootLoss : (2 * 8 ^ l * 2 ^ (k + l)) * 5 =
      10 * 8 ^ l * 2 ^ (k + l) := by
    simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
  rw [hrootLoss] at hrootScaled
  have hlink : 3 * 9 ^ (k + l) * u + 3 * 9 ^ l =
      2 * 8 ^ l * (2 ^ (k + l) * m + 5) := by
    calc
      3 * 9 ^ (k + l) * u + 3 * 9 ^ l =
          3 * 9 ^ l * (9 ^ k * u + 1) := by
        simp [Nat.pow_add, Nat.mul_add, Nat.mul_assoc, Nat.mul_comm,
          Nat.mul_left_comm]
      _ = 3 * 9 ^ l * (2 * 8 ^ l * v) := by rw [hrecharge]
      _ = 2 * 8 ^ l * (3 * 9 ^ l * v) := by
        simp [Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm]
      _ = 2 * 8 ^ l * (2 ^ (k + l) * m + 5) := by rw [hexit]
  have hendpointScaled : (2 * 8 ^ l * 2 ^ (k + l)) * m + 10 * 8 ^ l =
      3 * 9 ^ (k + l) * u + 3 * 9 ^ l := by
    simpa [Nat.mul_add, Nat.mul_assoc, Nat.mul_comm, Nat.mul_left_comm] using hlink.symm
  have hmargin := twoBurst_scaled_margin k l u hk hu
  have hcompare : (2 * 8 ^ l * 2 ^ (k + l)) * m <
      (2 * 8 ^ l * 2 ^ (k + l)) * (2 * 8 ^ k * u - 5) := by omega
  exact ⟨hiter, Nat.lt_of_mul_lt_mul_left hcompare⟩

/-- This result discharges a guarded original-root induction obligation. -/
theorem twoBurst_converges_of_smaller (k l u v m : Nat)
    (hk : 0 < k) (hl : 0 < l) (hu : 0 < u) (hv : 0 < v) (hm : 0 < m)
    (hrecharge : 9 ^ k * u + 1 = 2 ^ (3 * l + 1) * v)
    (hexit : 2 ^ (k + l) * m + 5 = 3 * 9 ^ l * v)
    (ih : ∀ a : Nat, 0 < a → a < 2 * 8 ^ k * u - 5 → Converges a) :
    Converges (2 * 8 ^ k * u - 5) := by
  obtain ⟨hiter, hlt⟩ := twoBurstDescent k l u v m hk hl hu hv hm hrecharge hexit
  exact (converges_shortcutIter_iff (4 * (k + l) + 2) (2 * 8 ^ k * u - 5)).mp
    (by rw [hiter]; exact ih m hm hlt)

example : TwoBurstDescentStatement := twoBurstDescent

#print axioms CollatzWork.twoBurst_power_margin
#print axioms CollatzWork.twoBurstDescent
#print axioms CollatzWork.twoBurst_converges_of_smaller

end CollatzWork
