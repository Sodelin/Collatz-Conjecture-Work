import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_FinitePaletteObstructionStatement
import Definitions.Def_CollatzWork_InverseWordBoundaryStatement
import Definitions.Def_CollatzWork_RefinedMersenneChild
import Theorems.Thm_CollatzWork_finitePalette_path_obstruction
import Theorems.Thm_CollatzWork_mersenne_prefix_nondecreasing
namespace CollatzWork

private theorem boundedMono (x : Nat → Nat) (N : Nat)
    (hs : ∀ k, k < N → x k ≤ x (k + 1)) :
    ∀ i j, i ≤ j → j ≤ N → x i ≤ x j := by
  intro i j
  induction j with
  | zero =>
      intro hij _
      have : i = 0 := by omega
      subst i
      exact Nat.le_refl _
  | succ j ih =>
      intro hij hj
      by_cases hi : i ≤ j
      · exact Nat.le_trans (ih hi (by omega)) (hs j (by omega))
      · have : i = j + 1 := by omega
        subst i
        exact Nat.le_refl _















end CollatzWork


namespace CollatzWork

/-!
# Refined Mersenne child identity

This file formalizes one isolated arithmetic certificate for the one-division
shortcut map `onceAccelerated`.  It does not assert termination or route
closure.
-/





theorem shortcutIter_add (r s n : Nat) :
    shortcutIter (r + s) n = shortcutIter s (shortcutIter r n) := by
  induction r generalizing n with
  | zero => simp
  | succ r ih =>
      simp [Nat.succ_add, ih]






































end CollatzWork



open CollatzWork in
theorem solution : FinitePaletteObstructionStatement := by
  classical
  intro r B B' H V f selector hf hV hdes
  let L := r * H
  let q := B + B' + 2
  let n := 2 ^ L * q - 1
  have hq : 0 < q := by omega
  have hnq : q - 1 ≤ n := by
    have hpow : 1 ≤ 2 ^ L := Nat.one_le_pow L 2 (by omega)
    have hm := Nat.mul_le_mul_right q hpow
    simp only [Nat.one_mul] at hm
    exact Nat.sub_le_sub_right hm 1
  have hnB : B ≤ n := by omega
  have hnB' : B' ≤ n := by omega
  have hmono : ∀ k, k < L → shortcutIter k n ≤ shortcutIter (k + 1) n :=
    mersenne_prefix_nondecreasing L q hq
  let jump := fun a : Nat => Classical.choose (hdes (max a B') (Nat.le_max_right a B'))
  have hjump : ∀ a, 1 ≤ jump a ∧ jump a ≤ H ∧
      V (shortcutIter (jump a) (max a B')) < V (max a B') := by
    intro a
    exact Classical.choose_spec (hdes (max a B') (Nat.le_max_right a B'))
  let times : Nat → Nat := Nat.rec 0 (fun _ t => t + jump (shortcutIter t n))
  have ht0 : times 0 = 0 := rfl
  have hts : ∀ k, times (k + 1) = times k + jump (shortcutIter (times k) n) :=
    fun _ => rfl
  have htb : ∀ k, times k ≤ k * H := by
    intro k
    induction k with
    | zero => simp [ht0]
    | succ k ih =>
        rw [hts, Nat.succ_mul]
        exact Nat.add_le_add ih (hjump (shortcutIter (times k) n)).2.1
  have htL : ∀ k, k ≤ r → times k ≤ L := by
    intro k hk
    exact Nat.le_trans (htb k) (Nat.mul_le_mul_right H hk)
  have hbase : ∀ k, k ≤ r → n ≤ shortcutIter (times k) n := by
    intro k hk
    exact boundedMono (fun j => shortcutIter j n) L hmono 0 (times k)
      (Nat.zero_le _) (htL k hk)
  apply finitePalette_path_obstruction r B V f selector
    (fun k => shortcutIter (times k) n) hf hV
  · simpa only [ht0, shortcutIter_zero] using hnB
  · intro k hk
    apply boundedMono (fun j => shortcutIter j n) L hmono
      (times k) (times (k + 1))
    · rw [hts]
      exact Nat.le_add_right _ _
    · exact htL (k + 1) (by omega)
  · intro k hk
    have hBk : B' ≤ shortcutIter (times k) n :=
      Nat.le_trans hnB' (hbase k (by omega))
    have hd := (hjump (shortcutIter (times k) n)).2.2
    rw [Nat.max_eq_left hBk] at hd
    rw [hts, shortcutIter_add]
    exact hd
