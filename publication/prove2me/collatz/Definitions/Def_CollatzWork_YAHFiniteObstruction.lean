import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_YAHFiniteObstructionStatement
namespace CollatzWork.YAH

/-!
# Kernel-checked YAH finite obstruction certificates

The concrete data below replay the project's 13-row unlabelled adjacent-edge
certificate and the fixed two-state 8-row symbol / 50-row edge certificates.
The exported theorems concern only these finite identities and their generic
positive-combination consequence.
-/

universe u

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule

section GenericCertificate

section OrderedCertificate

variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M]
  [IntModule M] [OrderedAdd M]







end OrderedCertificate

section LinearEvaluation

variable {M : Type u} [IntModule M]













end LinearEvaluation

end GenericCertificate

/-! ## The 13-row unlabelled adjacent-edge certificate -/

def unlabelledRows : List UnlabelledInstance := [
  ⟨.Dt, [.hat, .d2], []⟩,
  ⟨.Xf1, [.hat, .d1], [.d2, .dollar]⟩,
  ⟨.Xf1, [.hat, .d2], [.d0, .dollar]⟩,
  ⟨.Xf2, [.hat], [.d2, .dollar]⟩,
  ⟨.Xf2, [.hat, .d1], [.d2, .dollar]⟩,
  ⟨.Xt0, [.hat, .d1], [.d2, .dollar]⟩,
  ⟨.Xt0, [.hat, .d2], [.d2, .dollar]⟩,
  ⟨.Xt1, [.hat, .d2], [.d1, .dollar]⟩,
  ⟨.Xt2, [.hat, .d0], [.d2, .dollar]⟩,
  ⟨.Xt2, [.hat, .d1], [.dollar]⟩,
  ⟨.Xt2, [.hat, .d2], [.d0, .dollar]⟩,
  ⟨.Xt2, [.hat, .d2], [.d1, .dollar]⟩,
  ⟨.Xhat1, [], [.d1, .dollar]⟩
]

def unlabelledCertificate : List (Nat × UnlabelledInstance) :=
  (unlabelledRows.zip [1, 1, 1, 1, 1, 1, 1, 1, 2, 1, 1, 1, 1]).map
    fun entry => (entry.2, entry.1)

def allSymbolEdges : List (Symbol × Symbol) :=
  allSymbols.flatMap fun left => allSymbols.map fun right => (left, right)







def negativeFFCoefficient : Symbol × Symbol → Int
  | (.f, .f) => -1
  | _ => 0



section UnlabelledConsequence

variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]

def unlabelledGap (weight : Symbol × Symbol → M)
    (row : UnlabelledInstance) : M :=
  evalCoefficients allSymbolEdges weight (unlabelledEdgeDelta row)







/-- Archimedean/cofinal hypothesis used by the bounded-below part of the
13-row argument.  It holds for the intended real-valued scalar potentials;
it is not automatic for arbitrary lexicographic ordered groups. -/
def NegativeMultiplesCofinal : Prop :=
  ∀ x : M, x < 0 → ∀ bound : M, ∃ multiplicity : Nat,
    multiplicity • x < bound

def ffPumpPotential (weight : Symbol × Symbol → M) (multiplicity : Nat) : M :=
  weight (.hat, .f) + multiplicity • weight (.f, .f) +
    weight (.f, .dollar)

/-- The canonical word whose interior has `multiplicity + 1` copies of `f`.
Its adjacent-edge potential is exactly `ffPumpPotential`. -/
def ffPumpWord (multiplicity : Nat) : List Symbol :=
  [.hat] ++ List.replicate (multiplicity + 1) .f ++ [.dollar]

def edgePotential (weight : Symbol × Symbol → M)
    (word : List Symbol) : M :=
  (adjacentPairs word).foldr (fun edge total => weight edge + total) 0













end UnlabelledConsequence

/-! ## The exact fixed two-state suffix algebra -/



/-- A deterministic canonical extension for a bare labeled rule segment. -/
def canonicalLabeledInstance (name : RuleName) (tail : Bool) : LabeledInstance :=
  let r := rule name
  let left :=
    if r.lhs.head? == some .hat then none
    else some (.hat, evalWord r.lhs tail)
  let right :=
    if r.lhs.getLast? == some .dollar then none
    else if tail then some (.t, false) else some (.dollar, false)
  ⟨name, tail, left, right⟩

def symbolCertificate : List (Nat × LabeledInstance) := [
  (2, canonicalLabeledInstance .Df false),
  (3, canonicalLabeledInstance .Dt false),
  (1, canonicalLabeledInstance .Xf0 true),
  (1, canonicalLabeledInstance .Xf1 false),
  (2, canonicalLabeledInstance .Xf2 false),
  (1, canonicalLabeledInstance .Xhat0 false),
  (1, canonicalLabeledInstance .Xhat1 false),
  (1, canonicalLabeledInstance .Xhat2 false)
]









/-! ## The 50-row fixed-label adjacent-edge certificate -/

def edgeCertificate : List (Nat × LabeledInstance) := [
  (57168, ⟨.Df, false, some (.t, false), none⟩),
  (47250, ⟨.Dt, false, some (.d0, true), none⟩),
  (39639, ⟨.Dt, false, some (.d1, true), none⟩),
  (26731, ⟨.Xf0, false, some (.t, false), some (.d0, true)⟩),
  (19538, ⟨.Xf0, false, some (.d1, false), some (.f, true)⟩),
  (17360, ⟨.Xf0, false, some (.d2, false), some (.f, true)⟩),
  (11931, ⟨.Xf0, true, some (.hat, false), some (.t, true)⟩),
  (7358, ⟨.Xf0, true, some (.hat, false), some (.d1, true)⟩),
  (47250, ⟨.Xf0, true, some (.f, false), some (.d2, false)⟩),
  (10432, ⟨.Xf1, false, some (.hat, false), some (.d0, true)⟩),
  (39808, ⟨.Xf1, false, some (.f, false), some (.f, false)⟩),
  (19538, ⟨.Xf1, false, some (.d0, false), some (.d0, false)⟩),
  (10432, ⟨.Xf1, false, some (.d1, false), some (.d1, false)⟩),
  (3082, ⟨.Xf1, true, some (.t, false), some (.t, false)⟩),
  (13262, ⟨.Xf1, true, some (.d0, false), some (.t, true)⟩),
  (13891, ⟨.Xf1, true, some (.d2, false), some (.d2, false)⟩),
  (15149, ⟨.Xf2, false, some (.hat, false), some (.f, false)⟩),
  (25544, ⟨.Xf2, false, some (.f, false), some (.d1, false)⟩),
  (16379, ⟨.Xf2, false, some (.d0, false), some (.d0, false)⟩),
  (25926, ⟨.Xf2, false, some (.d1, false), some (.dollar, false)⟩),
  (31242, ⟨.Xf2, false, some (.d2, false), some (.dollar, false)⟩),
  (12298, ⟨.Xf2, true, some (.hat, false), some (.d1, true)⟩),
  (13628, ⟨.Xf2, true, some (.f, false), some (.t, true)⟩),
  (2274, ⟨.Xt0, false, some (.hat, true), some (.f, false)⟩),
  (6069, ⟨.Xt0, false, some (.t, true), some (.d0, true)⟩),
  (22528, ⟨.Xt0, false, some (.d0, true), some (.f, false)⟩),
  (16379, ⟨.Xt0, false, some (.d2, true), some (.d1, false)⟩),
  (10579, ⟨.Xt0, true, some (.f, true), some (.t, true)⟩),
  (15170, ⟨.Xt0, true, some (.t, true), some (.d1, true)⟩),
  (7725, ⟨.Xt0, true, some (.d2, true), some (.d2, true)⟩),
  (17015, ⟨.Xt1, false, some (.hat, true), some (.f, false)⟩),
  (15494, ⟨.Xt1, false, some (.f, true), some (.d1, false)⟩),
  (4529, ⟨.Xt1, true, some (.hat, true), some (.t, false)⟩),
  (25748, ⟨.Xt1, true, some (.f, true), some (.d2, false)⟩),
  (8969, ⟨.Xt1, true, some (.t, true), some (.d2, true)⟩),
  (8969, ⟨.Xt1, true, some (.d2, true), some (.t, true)⟩),
  (3082, ⟨.Xt2, false, some (.f, true), some (.f, true)⟩),
  (13875, ⟨.Xt2, false, some (.f, true), some (.dollar, false)⟩),
  (981, ⟨.Xt2, false, some (.t, true), some (.d0, false)⟩),
  (13891, ⟨.Xt2, false, some (.t, true), some (.d0, true)⟩),
  (5903, ⟨.Xt2, true, some (.hat, true), some (.d1, true)⟩),
  (7725, ⟨.Xt2, true, some (.d0, true), some (.t, false)⟩),
  (8969, ⟨.Xt2, true, some (.d1, true), some (.d2, false)⟩),
  (19289, ⟨.Xhat0, false, none, some (.f, false)⟩),
  (10432, ⟨.Xhat0, true, none, some (.t, false)⟩),
  (27447, ⟨.Xhat1, false, none, some (.f, false)⟩),
  (2274, ⟨.Xhat1, true, none, some (.t, true)⟩),
  (5698, ⟨.Xhat2, false, none, some (.d1, false)⟩),
  (15846, ⟨.Xhat2, false, none, some (.dollar, false)⟩),
  (5903, ⟨.Xhat2, true, none, some (.d1, true)⟩)
]









/-! ## Ordered-algebra consequences of the exact zero cancellations -/

section LabeledNoGo

variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]

def symbolGap (weight : Token → M) (row : LabeledInstance) : M :=
  evalCoefficients allTokens weight (labeledSymbolDelta row)

def edgeGap (weight : Token × Token → M) (row : LabeledInstance) : M :=
  evalCoefficients allTokenEdges weight (labeledEdgeDelta row)













end LabeledNoGo















end CollatzWork.YAH
