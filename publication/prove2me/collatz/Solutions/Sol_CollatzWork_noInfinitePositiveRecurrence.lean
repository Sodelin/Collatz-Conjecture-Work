import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_AffineRepetitionStatement
import Theorems.Thm_CollatzWork_finiteRepetitionBound



open CollatzWork in
theorem solution : NoInfinitePositiveRecurrenceStatement := by
  intro a b hab hb y hpos h
  have hbound := finiteRepetitionBound a b hab y hpos (y 0) (fun i _ => h i)
  have hlarge : y 0 < b ^ (y 0) := Nat.lt_pow_self hb
  omega
