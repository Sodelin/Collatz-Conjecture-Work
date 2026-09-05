import CollatzWork.RefinedMersenneChild

namespace CollatzWork

/-- No rank obtained by an arbitrary selector from finitely many eventually
nondecreasing natural-valued functions admits uniformly bounded positive-time
descent under the one-division shortcut map. This is an obstruction to a proof
architecture, not a statement that any Collatz orbit fails to terminate.

The threshold `B` is shared by the finitely many functions. `B'` is the
independently chosen threshold for the proposed descent property. -/
def FinitePaletteObstructionStatement : Prop :=
  ∀ (r B B' H : Nat) (V : Nat → Nat) (f : Fin r → Nat → Nat)
    (selector : Nat → Fin r),
    (∀ i a b, B ≤ a → a ≤ b → f i a ≤ f i b) →
    (∀ n, B ≤ n → V n = f (selector n) n) →
    ¬ (∀ n, B' ≤ n → ∃ j, 1 ≤ j ∧ j ≤ H ∧
      V (shortcutIter j n) < V n)

end CollatzWork
