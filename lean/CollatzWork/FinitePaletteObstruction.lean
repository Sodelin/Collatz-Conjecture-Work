import CollatzWork.FinitePaletteObstructionStatement
import Std.Tactic

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

private theorem boundedStrictAnti (x : Nat → Nat) (N : Nat)
    (hs : ∀ k, k < N → x (k + 1) < x k) :
    ∀ i j, i < j → j ≤ N → x j < x i := by
  intro i j
  induction j with
  | zero => omega
  | succ j ih =>
      intro hij hj
      by_cases hi : i < j
      · exact Nat.lt_trans (hs j (by omega)) (ih hi (by omega))
      · have : i = j := by omega
        subst i
        exact hs j (by omega)

/-- A nondecreasing path cannot carry `r` consecutive strict rank decreases
when every rank is selected from `r` nondecreasing functions. -/
theorem finitePalette_path_obstruction
    (r B : Nat) (V : Nat → Nat) (f : Fin r → Nat → Nat)
    (selector : Nat → Fin r) (x : Nat → Nat)
    (hf : ∀ i a b, B ≤ a → a ≤ b → f i a ≤ f i b)
    (hV : ∀ n, B ≤ n → V n = f (selector n) n)
    (hB : B ≤ x 0)
    (hx : ∀ k, k < r → x k ≤ x (k + 1))
    (hdec : ∀ k, k < r → V (x (k + 1)) < V (x k)) : False := by
  let colors := (List.range (r + 1)).map (fun k => (selector (x k)).val)
  have hdistinct : ∀ i j, i < j → j ≤ r →
      (selector (x i)).val ≠ (selector (x j)).val := by
    intro i j hij hj heq
    have hxi : B ≤ x i := Nat.le_trans hB
      (boundedMono x r hx 0 i (by omega) (by omega))
    have hxj : B ≤ x j := Nat.le_trans hxi
      (boundedMono x r hx i j (by omega) hj)
    have hsel : selector (x i) = selector (x j) := Fin.ext heq
    have hle := hf (selector (x i)) (x i) (x j) hxi
      (boundedMono x r hx i j (by omega) hj)
    have hlt := boundedStrictAnti (fun k => V (x k)) r hdec i j hij hj
    rw [hV (x i) hxi, hV (x j) hxj, ← hsel] at hlt
    omega
  have hnodup : colors.Nodup := by
    apply List.pairwise_map.mpr
    exact List.pairwise_lt_range.imp_of_mem (by
      intro i j hi hj hij
      exact hdistinct i j hij (by simp only [List.mem_range] at hj; omega))
  have hsubset : colors ⊆ List.range r := by
    intro a ha
    obtain ⟨k, _, hk⟩ := List.mem_map.mp ha
    rw [← hk, List.mem_range]
    exact (selector (x k)).isLt
  have hlength := hnodup.length_le_of_subset hsubset
  simp only [colors, List.length_map, List.length_range] at hlength
  omega

private theorem mersenne_prefix (L k q : Nat) (hk : k ≤ L) (hq : 0 < q) :
    shortcutIter k (2 ^ L * q - 1) = 3 ^ k * (2 ^ (L - k) * q) - 1 := by
  have hfactor : 2 ^ L * q = 2 ^ k * (2 ^ (L - k) * q) := by
    rw [← Nat.mul_assoc, ← Nat.pow_add, Nat.add_sub_of_le hk]
  rw [hfactor]
  exact oddRun k (2 ^ (L - k) * q)
    (Nat.mul_pos (Nat.pow_pos (by omega)) hq)

/-- Arbitrarily large Mersenne-type starts have arbitrarily long
nondecreasing initial shortcut segments. -/
theorem mersenne_prefix_nondecreasing (L q : Nat) (hq : 0 < q) :
    ∀ k, k < L →
      shortcutIter k (2 ^ L * q - 1) ≤
      shortcutIter (k + 1) (2 ^ L * q - 1) := by
  intro k hk
  let b := 3 ^ k * (2 ^ (L - k - 1) * q)
  have hb : 0 < b := Nat.mul_pos (Nat.pow_pos (by omega))
    (Nat.mul_pos (Nat.pow_pos (by omega)) hq)
  have hp : 2 ^ (L - k) = 2 * 2 ^ (L - k - 1) := by
    have he : L - k = (L - k - 1) + 1 := by omega
    rw [he, Nat.pow_succ]
    have he' : L - k - 1 + 1 - 1 = L - k - 1 := by omega
    rw [he']
    exact Nat.mul_comm _ _
  have hform : shortcutIter k (2 ^ L * q - 1) = 2 * b - 1 := by
    rw [mersenne_prefix L k q (by omega) hq, hp]
    unfold b
    simp only [Nat.mul_assoc, Nat.mul_left_comm]
  rw [shortcutIter_add k 1, hform]
  simp only [shortcutIter_succ, shortcutIter_zero]
  rw [onceAccelerated_two_mul_sub_one b hb]
  omega

/-- Full finite-palette obstruction for the one-division shortcut map. -/
theorem finitePaletteObstruction : FinitePaletteObstructionStatement := by
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

#print axioms CollatzWork.finitePalette_path_obstruction
#print axioms CollatzWork.mersenne_prefix_nondecreasing
#print axioms CollatzWork.finitePaletteObstruction

end CollatzWork

/-- Exact comparison against the separately declared trusted statement. -/
example : CollatzWork.FinitePaletteObstructionStatement :=
  CollatzWork.finitePaletteObstruction
