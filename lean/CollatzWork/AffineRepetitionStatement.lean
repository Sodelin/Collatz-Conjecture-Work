import Std

namespace CollatzWork

/-- Exact repetition of a coprime rational multiplier consumes divisibility
    already present in its initial value. -/
def FixedRatioDivisibilityStatement : Prop :=
  ∀ (a b : Nat), b.Coprime a → ∀ (y : Nat → Nat) (k : Nat),
    (∀ i, i < k → b * y (i + 1) = a * y i) → b ^ k ∣ y 0

/-- A finite-prefix bound for a positive initial shifted value. -/
def FiniteRepetitionBoundStatement : Prop :=
  ∀ (a b : Nat), b.Coprime a → ∀ (y : Nat → Nat), 0 < y 0 →
    ∀ k : Nat, (∀ i, i < k → b * y (i + 1) = a * y i) → b ^ k ≤ y 0

/-- A denominator greater than one cannot keep consuming initial divisibility
    indefinitely. This does not constrain changing multipliers. -/
def NoInfinitePositiveRecurrenceStatement : Prop :=
  ∀ (a b : Nat), b.Coprime a → 1 < b → ∀ (y : Nat → Nat), 0 < y 0 →
    ¬ (∀ i, b * y (i + 1) = a * y i)

/-- An expanding affine block has numerator b+d with d>0; the statement
    also covers any degenerate case satisfying the explicit assumptions. -/
def AffineRepetitionBoundStatement : Prop :=
  ∀ (b d c : Nat), b.Coprime (b + d) → ∀ (x : Nat → Nat),
    0 < d * x 0 + c → ∀ k : Nat,
    (∀ i, i < k → b * x (i + 1) = (b + d) * x i + c) →
    b ^ k ≤ d * x 0 + c

/-- This excludes an indefinitely repeated fixed affine block, not an
    arbitrary Collatz orbit or a sequence of different blocks. -/
def NoInfiniteExpandingAffineBlocksStatement : Prop :=
  ∀ (b d c : Nat), b.Coprime (b + d) → 1 < b → ∀ (x : Nat → Nat),
    0 < d * x 0 + c →
    ¬ (∀ i, b * x (i + 1) = (b + d) * x i + c)

/-- A purely numerical conditional bound. Any application to prefix returns
    must separately establish the displayed exponential inequality. -/
def PrefixReturnNumericalBoundStatement : Prop :=
  ∀ n d : Nat, 2 * 32 ^ d < 27 ^ d * (n + 1) →
    10 * d + 27 < 27 * n ∧ d ≤ (27 * n - 28) / 10

end CollatzWork
