import Std
import Init.Grind.Ordered.Module
namespace Erdos302Kernel

def inGNat (x : Nat) : Bool :=
 x == 122 || x == 183 || x == 244 || x == 366 || x == 732

def Expected (a b c : Nat) : Prop :=
 (a = 122 ∧ b = 183 ∧ c = 366) ∨
 (a = 183 ∧ b = 244 ∧ c = 732) ∨
 (a = 244 ∧ b = 366 ∧ c = 732)
instance (a b c : Nat) : Decidable (Expected a b c) := by
 unfold Expected
 infer_instance

def quotient (a b : Nat) : Nat := a * b / (b - a)
















end Erdos302Kernel
