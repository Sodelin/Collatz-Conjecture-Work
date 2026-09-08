import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_ConvergenceStatement
import Definitions.Def_CollatzWork_QuarterGapStatement



open CollatzWork in
theorem solution : MechanicalEnvelopeStatement := by
  intro n k
  induction k with
  | zero => simp [orbitRemainder, orbitOddCount, mechanicalMax]
  | succ k ih =>
      intro hbarrier
      have hprev := ih (fun j hj => hbarrier j (by omega))
      by_cases h : shortcutIter k n % 2 = 0
      · simpa only [orbitRemainder, orbitOddCount, if_pos h, Nat.add_zero] using hprev
      · have hp : 3 ^ orbitOddCount n k ≠ 0 := Nat.ne_of_gt (Nat.pow_pos (by decide))
        have hlog : k ≤ Nat.log2 (3 ^ orbitOddCount n k) :=
          (Nat.le_log2 hp).mpr (hbarrier k (by omega))
        have hpower := Nat.pow_le_pow_right (n := 2) (by decide) hlog
        have htriple := Nat.mul_le_mul_left 3 hprev
        simpa only [orbitRemainder, orbitOddCount, if_neg h, mechanicalMax] using
          Nat.add_le_add htriple hpower
