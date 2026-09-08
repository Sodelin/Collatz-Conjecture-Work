import Std
import Init.Grind.Ordered.Module



theorem solution
    (degrees : List Nat)
    (hSum : degrees.sum = 0) :
    ∀ g ∈ degrees, g = 0 := by
  induction degrees with
  | nil => simp
  | cons a tail ih =>
      simp only [List.sum_cons] at hSum
      have ha : a = 0 := by omega
      have hTail : tail.sum = 0 := by omega
      intro g hg
      simp only [List.mem_cons] at hg
      rcases hg with rfl | hg
      · exact ha
      · exact ih hTail g hg
