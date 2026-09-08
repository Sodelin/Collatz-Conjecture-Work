import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Theorems.Thm_CollatzWork_residueAncestor_tail38
import Theorems.Thm_CollatzWork_residueAncestor_tail65
import Theorems.Thm_CollatzWork_residueAncestor_tail11
import Theorems.Thm_CollatzWork_residueAncestor_tail92
import Theorems.Thm_CollatzWork_residueAncestor_tail173



open CollatzWork in
theorem solution (z : Nat) (hz : z % 27 = 11) :
    ∃ m b : Nat, 0 < m ∧ m % 27 = 20 ∧
      shortcutIter b m = z ∧ m ≤ 64 * z := by
  have hcases : z % 81 = 11 ∨ z % 81 = 38 ∨ z % 81 = 65 := by omega
  rcases hcases with h11 | h38 | h65
  · have hsub : z % 243 = 11 ∨ z % 243 = 92 ∨ z % 243 = 173 := by omega
    rcases hsub with hsub | hsub | hsub
    · have hform : z = 243 * (z / 243) + 11 := by omega
      obtain ⟨hm, hr, ho, _, hb⟩ := residueAncestor_tail11 (z / 243)
      exact ⟨1728 * (z / 243) + 74, 6, hm, hr, ho.trans hform.symm, by omega⟩
    · have hform : z = 243 * (z / 243) + 92 := by omega
      obtain ⟨hm, hr, ho, _, hb⟩ := residueAncestor_tail92 (z / 243)
      exact ⟨6912 * (z / 243) + 2612, 8, hm, hr, ho.trans hform.symm, by omega⟩
    · have hform : z = 243 * (z / 243) + 173 := by omega
      obtain ⟨hm, hr, ho, _, hb⟩ := residueAncestor_tail173 (z / 243)
      exact ⟨864 * (z / 243) + 614, 5, hm, hr, ho.trans hform.symm, by omega⟩
  · have hform : z = 81 * (z / 81) + 38 := by omega
    obtain ⟨hm, hr, ho, _, hb⟩ := residueAncestor_tail38 (z / 81)
    exact ⟨216 * (z / 81) + 101, 3, hm, hr, ho.trans hform.symm, by omega⟩
  · have hform : z = 81 * (z / 81) + 65 := by omega
    obtain ⟨hm, hr, ho, _, hb⟩ := residueAncestor_tail65 (z / 81)
    exact ⟨432 * (z / 81) + 344, 4, hm, hr, ho.trans hform.symm, by omega⟩
