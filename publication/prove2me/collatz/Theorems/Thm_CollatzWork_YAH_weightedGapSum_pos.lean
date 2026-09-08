import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement

universe u

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule
variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M]
  [IntModule M] [OrderedAdd M]

theorem CollatzWork.YAH.weightedGapSum_pos {ρ : Type _}
    (certificate : List (Nat × ρ)) (gap : ρ → M)
    (hnonneg : ∀ entry ∈ certificate, 0 ≤ gap entry.2)
    (hstrict : ∃ entry ∈ certificate,
      0 < entry.1 ∧ 0 < gap entry.2) :
    0 < weightedGapSum certificate gap := by sorry

