import Std
import Init.Grind.Ordered.Module
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













end CollatzWork





open CollatzWork in
theorem solution
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
