import CollatzWork.PrefixCollisionStatement

namespace CollatzWork

/-!
# Actual-orbit prefix collisions

These results bound repetitions of finite parity prefixes. They neither assert
that any positive orbit descends nor exclude every infinite nonconvergent orbit.
-/

theorem sameParityPrefix_head {k n m : Nat}
    (h : SameParityPrefix (k + 1) n m) : n % 2 = m % 2 :=
  h 0 (by omega)

theorem sameParityPrefix_tail {k n m : Nat}
    (h : SameParityPrefix (k + 1) n m) :
    SameParityPrefix k (onceAccelerated n) (onceAccelerated m) := by
  intro i hi
  exact h (i + 1) (by omega)

theorem onceAccelerated_le_of_same_parity {n m : Nat}
    (hnm : n ≤ m) (hp : n % 2 = m % 2) :
    onceAccelerated n ≤ onceAccelerated m := by
  unfold onceAccelerated
  by_cases he : n % 2 = 0
  · have hm : m % 2 = 0 := by omega
    simp only [he, hm, if_true]
    omega
  · have hm : m % 2 ≠ 0 := by omega
    simp only [he, hm, if_false]
    omega

/-- Ordered subtraction retains its full integer meaning in this lemma. -/
theorem parityPrefix_dvd_sub_of_le (k n m : Nat) (hnm : n ≤ m)
    (h : SameParityPrefix k n m) : 2 ^ k ∣ m - n := by
  induction k generalizing n m with
  | zero => simp
  | succ k ih =>
      have hp := sameParityPrefix_head h
      have hstep := onceAccelerated_le_of_same_parity hnm hp
      have hd := ih (onceAccelerated n) (onceAccelerated m) hstep
        (sameParityPrefix_tail h)
      have hdouble : 2 ^ (k + 1) ∣
          2 * (onceAccelerated m - onceAccelerated n) := by
        obtain ⟨w, hw⟩ := hd
        refine ⟨w, ?_⟩
        rw [hw, Nat.pow_succ]
        ac_rfl
      by_cases he : n % 2 = 0
      · have hm : m % 2 = 0 := by omega
        have heq : 2 * (onceAccelerated m - onceAccelerated n) = m - n := by
          simp only [onceAccelerated, he, hm, if_true]
          omega
        rwa [heq] at hdouble
      · have hm : m % 2 ≠ 0 := by omega
        have heq : 2 * (onceAccelerated m - onceAccelerated n) = 3 * (m - n) := by
          simp only [onceAccelerated, he, hm, if_false]
          omega
        rw [heq] at hdouble
        exact ((show Nat.Coprime 2 3 by decide).pow_left (k + 1)).dvd_of_dvd_mul_left hdouble

theorem sameParityPrefix_symm {k n m : Nat}
    (h : SameParityPrefix k n m) : SameParityPrefix k m n :=
  fun i hi => (h i hi).symm

theorem parityPrefix_mod_eq (k n m : Nat) (h : SameParityPrefix k n m) :
    n % 2 ^ k = m % 2 ^ k := by
  by_cases hnm : n ≤ m
  · obtain ⟨w, hw⟩ := parityPrefix_dvd_sub_of_le k n m hnm h
    apply Nat.mod_eq_mod_iff.mpr
    refine ⟨w, 0, ?_⟩
    rw [Nat.mul_comm w]
    omega
  · have hmn : m ≤ n := by omega
    obtain ⟨w, hw⟩ := parityPrefix_dvd_sub_of_le k m n hmn (sameParityPrefix_symm h)
    apply Nat.mod_eq_mod_iff.mpr
    refine ⟨0, w, ?_⟩
    rw [Nat.mul_comm w]
    omega

theorem parityPrefix_separation (k n m : Nat)
    (h : SameParityPrefix k n m) (hne : n ≠ m) :
    2 ^ k ≤ prefixGap n m := by
  unfold prefixGap
  by_cases hnm : n ≤ m
  · have hd := parityPrefix_dvd_sub_of_le k n m hnm h
    have hb := Nat.le_of_dvd (show 0 < m - n by omega) hd
    omega
  · have hmn : m ≤ n := by omega
    have hd := parityPrefix_dvd_sub_of_le k m n hmn (sameParityPrefix_symm h)
    have hb := Nat.le_of_dvd (show 0 < n - m by omega) hd
    omega

theorem prefixCollision : PrefixCollisionStatement := parityPrefix_mod_eq
theorem prefixSeparation : PrefixSeparationStatement := parityPrefix_separation

example : PrefixCollisionStatement := prefixCollision
example : PrefixSeparationStatement := prefixSeparation

#print axioms CollatzWork.parityPrefix_dvd_sub_of_le
#print axioms CollatzWork.prefixCollision
#print axioms CollatzWork.prefixSeparation

end CollatzWork
