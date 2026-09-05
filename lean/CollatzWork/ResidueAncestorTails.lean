import CollatzWork.RootDescent

namespace CollatzWork

/-!
# Exact refined inverse tails in the residue-20 ancestor construction

The words in the accompanying note are chronological inverse words. These
lemmas check the actual forward shortcut orbit from the constructed ancestor.
Every parameter is an arbitrary natural number; no bounded enumeration or
termination assumption is used. The final selector promises no size descent
until combined with the separate root-dependent coefficient bound.
-/

/-- The exact tail over `z = 38 mod 81`, including its affine certificate. -/
theorem residueAncestor_tail38 (a : Nat) :
    0 < 216 * a + 101 ∧
    (216 * a + 101) % 27 = 20 ∧
    shortcutIter 3 (216 * a + 101) = 81 * a + 38 ∧
    3 * (216 * a + 101) + 1 = 8 * (81 * a + 38) ∧
    216 * a + 101 ≤ 64 * (81 * a + 38) := by
  refine ⟨by omega, by omega, ?_, by omega, by omega⟩
  have h0 : onceAccelerated (216 * a + 101) = 324 * a + 152 := by
    rw [show 216 * a + 101 = 2 * (108 * a + 50) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  have h1 : onceAccelerated (324 * a + 152) = 162 * a + 76 := by
    rw [show 324 * a + 152 = 2 * (162 * a + 76) by omega,
      onceAccelerated_two_mul]
  have h2 : onceAccelerated (162 * a + 76) = 81 * a + 38 := by
    rw [show 162 * a + 76 = 2 * (81 * a + 38) by omega,
      onceAccelerated_two_mul]
  simp only [shortcutIter, h0, h1, h2]

/-- The exact tail over `z = 65 mod 81`, including its affine certificate. -/
theorem residueAncestor_tail65 (a : Nat) :
    0 < 432 * a + 344 ∧
    (432 * a + 344) % 27 = 20 ∧
    shortcutIter 4 (432 * a + 344) = 81 * a + 65 ∧
    3 * (432 * a + 344) + 8 = 16 * (81 * a + 65) ∧
    432 * a + 344 ≤ 64 * (81 * a + 65) := by
  refine ⟨by omega, by omega, ?_, by omega, by omega⟩
  have h0 : onceAccelerated (432 * a + 344) = 216 * a + 172 := by
    rw [show 432 * a + 344 = 2 * (216 * a + 172) by omega,
      onceAccelerated_two_mul]
  have h1 : onceAccelerated (216 * a + 172) = 108 * a + 86 := by
    rw [show 216 * a + 172 = 2 * (108 * a + 86) by omega,
      onceAccelerated_two_mul]
  have h2 : onceAccelerated (108 * a + 86) = 54 * a + 43 := by
    rw [show 108 * a + 86 = 2 * (54 * a + 43) by omega,
      onceAccelerated_two_mul]
  have h3 : onceAccelerated (54 * a + 43) = 81 * a + 65 := by
    rw [show 54 * a + 43 = 2 * (27 * a + 21) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  simp only [shortcutIter, h0, h1, h2, h3]

/-- The exact tail over `z = 11 mod 243`, including its affine certificate. -/
theorem residueAncestor_tail11 (a : Nat) :
    0 < 1728 * a + 74 ∧
    (1728 * a + 74) % 27 = 20 ∧
    shortcutIter 6 (1728 * a + 74) = 243 * a + 11 ∧
    9 * (1728 * a + 74) + 38 = 64 * (243 * a + 11) ∧
    1728 * a + 74 ≤ 64 * (243 * a + 11) := by
  refine ⟨by omega, by omega, ?_, by omega, by omega⟩
  have h0 : onceAccelerated (1728 * a + 74) = 864 * a + 37 := by
    rw [show 1728 * a + 74 = 2 * (864 * a + 37) by omega,
      onceAccelerated_two_mul]
  have h1 : onceAccelerated (864 * a + 37) = 1296 * a + 56 := by
    rw [show 864 * a + 37 = 2 * (432 * a + 18) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  have h2 : onceAccelerated (1296 * a + 56) = 648 * a + 28 := by
    rw [show 1296 * a + 56 = 2 * (648 * a + 28) by omega,
      onceAccelerated_two_mul]
  have h3 : onceAccelerated (648 * a + 28) = 324 * a + 14 := by
    rw [show 648 * a + 28 = 2 * (324 * a + 14) by omega,
      onceAccelerated_two_mul]
  have h4 : onceAccelerated (324 * a + 14) = 162 * a + 7 := by
    rw [show 324 * a + 14 = 2 * (162 * a + 7) by omega,
      onceAccelerated_two_mul]
  have h5 : onceAccelerated (162 * a + 7) = 243 * a + 11 := by
    rw [show 162 * a + 7 = 2 * (81 * a + 3) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  simp only [shortcutIter, h0, h1, h2, h3, h4, h5]

/-- The exact tail over `z = 92 mod 243`, including its affine certificate. -/
theorem residueAncestor_tail92 (a : Nat) :
    0 < 6912 * a + 2612 ∧
    (6912 * a + 2612) % 27 = 20 ∧
    shortcutIter 8 (6912 * a + 2612) = 243 * a + 92 ∧
    9 * (6912 * a + 2612) + 44 = 256 * (243 * a + 92) ∧
    6912 * a + 2612 ≤ 64 * (243 * a + 92) := by
  refine ⟨by omega, by omega, ?_, by omega, by omega⟩
  have h0 : onceAccelerated (6912 * a + 2612) = 3456 * a + 1306 := by
    rw [show 6912 * a + 2612 = 2 * (3456 * a + 1306) by omega,
      onceAccelerated_two_mul]
  have h1 : onceAccelerated (3456 * a + 1306) = 1728 * a + 653 := by
    rw [show 3456 * a + 1306 = 2 * (1728 * a + 653) by omega,
      onceAccelerated_two_mul]
  have h2 : onceAccelerated (1728 * a + 653) = 2592 * a + 980 := by
    rw [show 1728 * a + 653 = 2 * (864 * a + 326) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  have h3 : onceAccelerated (2592 * a + 980) = 1296 * a + 490 := by
    rw [show 2592 * a + 980 = 2 * (1296 * a + 490) by omega,
      onceAccelerated_two_mul]
  have h4 : onceAccelerated (1296 * a + 490) = 648 * a + 245 := by
    rw [show 1296 * a + 490 = 2 * (648 * a + 245) by omega,
      onceAccelerated_two_mul]
  have h5 : onceAccelerated (648 * a + 245) = 972 * a + 368 := by
    rw [show 648 * a + 245 = 2 * (324 * a + 122) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  have h6 : onceAccelerated (972 * a + 368) = 486 * a + 184 := by
    rw [show 972 * a + 368 = 2 * (486 * a + 184) by omega,
      onceAccelerated_two_mul]
  have h7 : onceAccelerated (486 * a + 184) = 243 * a + 92 := by
    rw [show 486 * a + 184 = 2 * (243 * a + 92) by omega,
      onceAccelerated_two_mul]
  simp only [shortcutIter, h0, h1, h2, h3, h4, h5, h6, h7]

/-- The exact tail over `z = 173 mod 243`, including its affine certificate. -/
theorem residueAncestor_tail173 (a : Nat) :
    0 < 864 * a + 614 ∧
    (864 * a + 614) % 27 = 20 ∧
    shortcutIter 5 (864 * a + 614) = 243 * a + 173 ∧
    9 * (864 * a + 614) + 10 = 32 * (243 * a + 173) ∧
    864 * a + 614 ≤ 64 * (243 * a + 173) := by
  refine ⟨by omega, by omega, ?_, by omega, by omega⟩
  have h0 : onceAccelerated (864 * a + 614) = 432 * a + 307 := by
    rw [show 864 * a + 614 = 2 * (432 * a + 307) by omega,
      onceAccelerated_two_mul]
  have h1 : onceAccelerated (432 * a + 307) = 648 * a + 461 := by
    rw [show 432 * a + 307 = 2 * (216 * a + 153) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  have h2 : onceAccelerated (648 * a + 461) = 972 * a + 692 := by
    rw [show 648 * a + 461 = 2 * (324 * a + 230) + 1 by omega,
      onceAccelerated_two_mul_add_one]
    omega
  have h3 : onceAccelerated (972 * a + 692) = 486 * a + 346 := by
    rw [show 972 * a + 692 = 2 * (486 * a + 346) by omega,
      onceAccelerated_two_mul]
  have h4 : onceAccelerated (486 * a + 346) = 243 * a + 173 := by
    rw [show 486 * a + 346 = 2 * (243 * a + 173) by omega,
      onceAccelerated_two_mul]
  simp only [shortcutIter, h0, h1, h2, h3, h4]

/-- The five disjoint guards cover `11 mod 27`. The coarse factor 64 is
chosen to share the uniform root-bound proof with the retained even tails. -/
theorem residueAncestor_refinedTail (z : Nat) (hz : z % 27 = 11) :
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

#print axioms CollatzWork.residueAncestor_refinedTail

end CollatzWork
