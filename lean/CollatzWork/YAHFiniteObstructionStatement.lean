import Std.Tactic
import Init.Grind.Ordered.Module

namespace CollatzWork.YAH

/-!
# Trusted statement layer for finite YAH obstruction certificates

This file fixes the exact eleven-rule mixed-base string-rewriting system used
by Yolcu--Aaronson--Heule (YAH), the project's two-state suffix algebra, and
the generic finite-certificate predicates.  It contains no concrete
cancellation certificate.

The intended scope is deliberately narrow: additive symbol or adjacent-edge
potentials for the exact data below.  Nothing in this file asserts termination
of the rewrite system or the Collatz conjecture.

Upstream provenance: `emreyolcu/rewriting-collatz` commit
`8a4dfda60f97a6d33ff0a24fdfa7a172d4bec340`, file `rules/collatz-T.srs`,
SHA-256 `e4777832e5cf8148a54299dffa48cf10254629680961006f2c15bcb6c55aa9d2`.
The ASCII source mapping is `a=f`, `b=t`, `c=^`, `d=$`, `e=0`, `f=1`,
`g=2`.
-/

open Lean.Grind

/-- The seven symbols of the exact YAH mixed binary/ternary system. -/
inductive Symbol where
  | f | t | d0 | d1 | d2 | hat | dollar
  deriving DecidableEq, BEq, Repr

/-- Stable names for the two dynamic and nine auxiliary YAH rules. -/
inductive RuleName where
  | Df | Dt
  | Xf0 | Xf1 | Xf2 | Xt0 | Xt1 | Xt2
  | Xhat0 | Xhat1 | Xhat2
  deriving DecidableEq, BEq, Repr

/-- One unlabelled string-rewriting rule. -/
structure Rule where
  name : RuleName
  lhs : List Symbol
  rhs : List Symbol
  dynamic : Bool
  deriving DecidableEq, BEq, Repr

/-- The exact eleven rules, with `true` marking the two Collatz-dynamic rows. -/
def rule : RuleName → Rule
  | .Df => ⟨.Df, [.f, .dollar], [.dollar], true⟩
  | .Dt => ⟨.Dt, [.t, .dollar], [.d2, .dollar], true⟩
  | .Xf0 => ⟨.Xf0, [.f, .d0], [.d0, .f], false⟩
  | .Xf1 => ⟨.Xf1, [.f, .d1], [.d0, .t], false⟩
  | .Xf2 => ⟨.Xf2, [.f, .d2], [.d1, .f], false⟩
  | .Xt0 => ⟨.Xt0, [.t, .d0], [.d1, .t], false⟩
  | .Xt1 => ⟨.Xt1, [.t, .d1], [.d2, .f], false⟩
  | .Xt2 => ⟨.Xt2, [.t, .d2], [.d2, .t], false⟩
  | .Xhat0 => ⟨.Xhat0, [.hat, .d0], [.hat, .t], false⟩
  | .Xhat1 => ⟨.Xhat1, [.hat, .d1], [.hat, .f, .f], false⟩
  | .Xhat2 => ⟨.Xhat2, [.hat, .d2], [.hat, .f, .t], false⟩

def allRuleNames : List RuleName :=
  [.Df, .Dt, .Xf0, .Xf1, .Xf2, .Xt0, .Xt1, .Xt2,
    .Xhat0, .Xhat1, .Xhat2]

def isDigit : Symbol → Bool
  | .f | .t | .d0 | .d1 | .d2 => true
  | .hat | .dollar => false

/-- Canonical syntactic words are exactly `^w$` with digit-only interior. -/
def canonical : List Symbol → Bool
  | .hat :: rest =>
      match rest.reverse with
      | .dollar :: middleRev => middleRev.all isDigit
      | _ => false
  | _ => false

/-- A chosen unlabelled rewrite occurrence, represented by its exterior. -/
structure UnlabelledInstance where
  ruleName : RuleName
  pre : List Symbol
  post : List Symbol
  deriving DecidableEq, BEq, Repr

def UnlabelledInstance.lhs (row : UnlabelledInstance) : List Symbol :=
  row.pre ++ (rule row.ruleName).lhs ++ row.post

def UnlabelledInstance.rhs (row : UnlabelledInstance) : List Symbol :=
  row.pre ++ (rule row.ruleName).rhs ++ row.post

/-- Executable legality check for a displayed canonical-context instance. -/
def validUnlabelledInstance (row : UnlabelledInstance) : Bool :=
  canonical row.lhs && canonical row.rhs

/-- Integer interpretation of a complete canonical YAH word. -/
def symbolValueStep (value : Nat) : Symbol → Nat
  | .f => 2 * value
  | .t => 2 * value + 1
  | .d0 => 3 * value
  | .d1 => 3 * value + 1
  | .d2 => 3 * value + 2
  | .hat | .dollar => value

def wordValue (word : List Symbol) : Nat :=
  word.foldl symbolValueStep 1

/-- The one-division shortcut map implemented by the two dynamic rules. -/
def shortcut (value : Nat) : Nat :=
  if value % 2 = 0 then value / 2 else (3 * value + 1) / 2

/-- Executable semantic check for a chosen canonical rewrite instance. -/
def validUnlabelledSemantics (row : UnlabelledInstance) : Bool :=
  if (rule row.ruleName).dynamic then
    wordValue row.rhs == shortcut (wordValue row.lhs)
  else
    wordValue row.rhs == wordValue row.lhs

/-- The fixed two-state suffix algebra used by `A-YAH-2STATE-001`. -/
def algebra : Symbol → Bool → Bool
  | .f, _ | .d0, _ | .hat, _ | .dollar, _ => false
  | .t, _ | .d2, _ => true
  | .d1, value => value

/-- Evaluate a word as a composition of unary algebra maps. -/
def evalWord : List Symbol → Bool → Bool
  | [], tail => tail
  | symbol :: rest, tail => algebra symbol (evalWord rest tail)

/-- A symbol paired with the value of its strict suffix. -/
abbrev Token := Symbol × Bool

/-- Deterministic right-to-left suffix labeling. -/
def labelWord : List Symbol → Bool → List Token
  | [], _ => []
  | symbol :: rest, tail =>
      (symbol, evalWord rest tail) :: labelWord rest tail

/-- One exact labeled row with at most one immediate neighbor on each side. -/
structure LabeledInstance where
  ruleName : RuleName
  tail : Bool
  left : Option Token
  right : Option Token
  deriving DecidableEq, BEq, Repr

def LabeledInstance.coreLhs (row : LabeledInstance) : List Token :=
  labelWord (rule row.ruleName).lhs row.tail

def LabeledInstance.coreRhs (row : LabeledInstance) : List Token :=
  labelWord (rule row.ruleName).rhs row.tail

def addContext (left : Option Token) (core : List Token)
    (right : Option Token) : List Token :=
  left.toList ++ core ++ right.toList

def LabeledInstance.lhs (row : LabeledInstance) : List Token :=
  addContext row.left row.coreLhs row.right

def LabeledInstance.rhs (row : LabeledInstance) : List Token :=
  addContext row.left row.coreRhs row.right

def validLeftContext (r : Rule) (tail : Bool) : Option Token → Bool
  | none => r.lhs.head? == some .hat
  | some (symbol, state) =>
      r.lhs.head? != some .hat &&
      (symbol == .hat || isDigit symbol) &&
      state == evalWord r.lhs tail

def validRightContext (r : Rule) (tail : Bool) : Option Token → Bool
  | none => r.lhs.getLast? == some .dollar && tail == false
  | some (symbol, state) =>
      r.lhs.getLast? != some .dollar &&
      ((isDigit symbol && algebra symbol state == tail) ||
        (symbol == .dollar && state == false && tail == false))

/-- Exact local-context legality for the fixed-terminal suffix labeling. -/
def validLabeledInstance (row : LabeledInstance) : Bool :=
  let r := rule row.ruleName
  evalWord r.lhs row.tail == evalWord r.rhs row.tail &&
  validLeftContext r row.tail row.left &&
  validRightContext r row.tail row.right

def labelsConsistent : List Token → Bool
  | [] | [_] => true
  | (_, leftState) :: (rightSymbol, rightState) :: rest =>
      leftState == algebra rightSymbol rightState &&
        labelsConsistent ((rightSymbol, rightState) :: rest)

/-- A full fixed-terminal canonical labeled word. -/
def canonicalLabeled (tokens : List Token) : Bool :=
  canonical (tokens.map Prod.fst) &&
    tokens.getLast? == some (.dollar, false) &&
    labelsConsistent tokens

/-- Deterministically embed a legal local labeled segment in a complete
fixed-terminal canonical word. -/
def canonicalExtension (tokens : List Token) : List Token :=
  let withLeft :=
    match tokens.head? with
    | some (.hat, _) => tokens
    | some (symbol, state) => (.hat, algebra symbol state) :: tokens
    | none => []
  match withLeft.getLast? with
  | some (.dollar, false) => withLeft
  | some (_, true) => withLeft ++ [(.t, false), (.dollar, false)]
  | some (_, false) => withLeft ++ [(.dollar, false)]
  | none => []

def allSymbols : List Symbol :=
  [.f, .t, .d0, .d1, .d2, .hat, .dollar]

def allTokens : List Token :=
  allSymbols.flatMap fun symbol => [(symbol, false), (symbol, true)]

def adjacentPairs : List α → List (α × α)
  | [] => []
  | _ :: [] => []
  | first :: second :: rest =>
      (first, second) :: adjacentPairs (second :: rest)

def allTokenEdges : List (Token × Token) :=
  allTokens.flatMap fun left => allTokens.map fun right => (left, right)

def countDelta [BEq α] (lhs rhs : List α) (feature : α) : Int :=
  Int.ofNat (lhs.count feature) - Int.ofNat (rhs.count feature)

def unlabelledEdgeDelta (row : UnlabelledInstance)
    (edge : Symbol × Symbol) : Int :=
  countDelta (adjacentPairs row.lhs) (adjacentPairs row.rhs) edge

def labeledSymbolDelta (row : LabeledInstance) (token : Token) : Int :=
  countDelta row.lhs row.rhs token

def labeledEdgeDelta (row : LabeledInstance) (edge : Token × Token) : Int :=
  countDelta (adjacentPairs row.lhs) (adjacentPairs row.rhs) edge

/-- Pointwise integer sum of a positive-multiplier row certificate. -/
def weightedCoefficient (certificate : List (Nat × ρ))
    (delta : ρ → φ → Int) (feature : φ) : Int :=
  certificate.foldr
    (fun entry total => Int.ofNat entry.1 * delta entry.2 feature + total) 0

/-- Weighted sum of row gaps in an abstract additive ordered target. -/
def weightedGapSum {M : Type u} [NatModule M]
    (certificate : List (Nat × ρ)) (gap : ρ → M) : M :=
  certificate.foldr (fun entry total => entry.1 • gap entry.2 + total) 0

/-- Evaluation of a finite integer feature vector in an additive group. -/
def evalCoefficients {M : Type u} [IntModule M]
    (features : List φ) (weight : φ → M) (coeff : φ → Int) : M :=
  features.foldr (fun feature total => coeff feature • weight feature + total) 0

end CollatzWork.YAH
