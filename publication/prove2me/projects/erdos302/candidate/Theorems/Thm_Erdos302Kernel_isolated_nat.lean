import Std
import Init.Grind.Ordered.Module
import Definitions.Def_KernelIsolation



theorem Erdos302Kernel.isolated_nat (a b c : Nat)
 (ha : 0 < a) (hab : a < b) (hbc : b < c) (hc : c ≤ 732)
 (hrel : a * (b + c) = b * c)
 (hG : inGNat a || inGNat b || inGNat c) :
 (a = 122 ∧ b = 183 ∧ c = 366) ∨
 (a = 183 ∧ b = 244 ∧ c = 732) ∨
 (a = 244 ∧ b = 366 ∧ c = 732) := by sorry

