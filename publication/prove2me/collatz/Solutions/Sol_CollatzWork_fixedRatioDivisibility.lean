import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_AffineRepetitionStatement
import Theorems.Thm_CollatzWork_affineRecurrenceTelescope



open CollatzWork in
theorem solution : FixedRatioDivisibilityStatement := by
  intro a b hab y k h
  have hmul : b ^ k ∣ a ^ k * y 0 :=
    ⟨y k, (affineRecurrenceTelescope a b y k h).symm⟩
  exact ((hab.pow_left k).pow_right k).dvd_of_dvd_mul_left hmul
