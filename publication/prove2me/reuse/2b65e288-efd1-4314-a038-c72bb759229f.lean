import Mathlib
import Definitions.Def_collatzStepMap

theorem solution (n : ℕ) (hn : 0 < n) (he : Even n) : collatzStep n < n := by
  have h : collatzStep n = n / 2 := by simp [collatzStep, he]
  rw [h]
  omega
