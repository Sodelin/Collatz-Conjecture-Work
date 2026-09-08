import Std
import Init.Grind.Ordered.Module



theorem CollatzWork.finitePalette_path_obstruction
    (r B : Nat) (V : Nat → Nat) (f : Fin r → Nat → Nat)
    (selector : Nat → Fin r) (x : Nat → Nat)
    (hf : ∀ i a b, B ≤ a → a ≤ b → f i a ≤ f i b)
    (hV : ∀ n, B ≤ n → V n = f (selector n) n)
    (hB : B ≤ x 0)
    (hx : ∀ k, k < r → x k ≤ x (k + 1))
    (hdec : ∀ k, k < r → V (x (k + 1)) < V (x k)) : False := by sorry

