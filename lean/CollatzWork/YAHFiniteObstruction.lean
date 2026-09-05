import CollatzWork.YAHFiniteObstructionStatement

namespace CollatzWork.YAH

/-!
# Kernel-checked YAH finite obstruction certificates

The concrete data below replay the project's 13-row unlabelled adjacent-edge
certificate and the fixed two-state 8-row symbol / 50-row edge certificates.
The exported theorems concern only these finite identities and their generic
positive-combination consequence.
-/

open Lean.Grind
open Lean.Grind.AddCommMonoid
open Lean.Grind.IntModule

section GenericCertificate

section OrderedCertificate

variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M]
  [IntModule M] [OrderedAdd M]

omit [LT M] [Std.LawfulOrderLT M] in
theorem weightedGapSum_nonneg
    (certificate : List (Nat × ρ)) (gap : ρ → M)
    (h : ∀ entry ∈ certificate, 0 ≤ gap entry.2) :
    0 ≤ weightedGapSum certificate gap := by
  induction certificate with
  | nil => exact Std.IsPreorder.le_refl 0
  | cons entry rest ih =>
      rcases entry with ⟨multiplicity, row⟩
      change 0 ≤ multiplicity • gap row + weightedGapSum rest gap
      have hrow : 0 ≤ gap row := h (multiplicity, row) (by simp)
      have htail : 0 ≤ weightedGapSum rest gap := by
        apply ih
        intro entry hentry
        exact h entry (by simp [hentry])
      have hsum := OrderedAdd.add_le_add
        (OrderedAdd.nsmul_nonneg (k := multiplicity) hrow) htail
      rw [AddCommMonoid.zero_add] at hsum
      exact hsum

theorem weightedGapSum_pos
    (certificate : List (Nat × ρ)) (gap : ρ → M)
    (hnonneg : ∀ entry ∈ certificate, 0 ≤ gap entry.2)
    (hstrict : ∃ entry ∈ certificate,
      0 < entry.1 ∧ 0 < gap entry.2) :
    0 < weightedGapSum certificate gap := by
  induction certificate with
  | nil => simp at hstrict
  | cons entry rest ih =>
      rcases entry with ⟨multiplicity, row⟩
      change 0 < multiplicity • gap row + weightedGapSum rest gap
      have hrow : 0 ≤ gap row := hnonneg (multiplicity, row) (by simp)
      have htailNonneg : 0 ≤ weightedGapSum rest gap := by
        apply weightedGapSum_nonneg
        intro entry hentry
        exact hnonneg entry (by simp [hentry])
      rcases hstrict with ⟨entry, hmem, hmult, hgap⟩
      simp only [List.mem_cons] at hmem
      rcases hmem with heq | hmem
      · cases heq
        have hheadPos : 0 < multiplicity • gap row :=
          (OrderedAdd.nsmul_pos_iff hgap).2 hmult
        have hle : multiplicity • gap row ≤
            multiplicity • gap row + weightedGapSum rest gap := by
          have raw := OrderedAdd.add_le_right
            (multiplicity • gap row) htailNonneg
          rw [AddCommMonoid.add_zero] at raw
          exact raw
        exact Preorder.lt_of_lt_of_le hheadPos hle
      · have htailPos : 0 < weightedGapSum rest gap := by
          apply ih
          · intro entry hentry
            exact hnonneg entry (by simp [hentry])
          · exact ⟨entry, hmem, hmult, hgap⟩
        have hheadNonneg : 0 ≤ multiplicity • gap row :=
          OrderedAdd.nsmul_nonneg hrow
        have hle : weightedGapSum rest gap ≤
            multiplicity • gap row + weightedGapSum rest gap := by
          have raw := OrderedAdd.add_le_left
            hheadNonneg (weightedGapSum rest gap)
          rw [AddCommMonoid.zero_add] at raw
          exact raw
        exact Preorder.lt_of_lt_of_le htailPos hle

theorem positiveCertificate_ne_zero
    (certificate : List (Nat × ρ)) (gap : ρ → M)
    (hnonneg : ∀ entry ∈ certificate, 0 ≤ gap entry.2)
    (hstrict : ∃ entry ∈ certificate,
      0 < entry.1 ∧ 0 < gap entry.2) :
    weightedGapSum certificate gap ≠ 0 := by
  have hpos := weightedGapSum_pos certificate gap hnonneg hstrict
  intro hzero
  rw [hzero] at hpos
  exact Preorder.lt_irrefl 0 hpos

end OrderedCertificate

section LinearEvaluation

variable {M : Type u} [IntModule M]

theorem evalCoefficients_zero (features : List φ) (weight : φ → M) :
    evalCoefficients features weight (fun _ => 0) = 0 := by
  induction features with
  | nil => rfl
  | cons feature rest ih =>
      change 0 • weight feature +
        evalCoefficients rest weight (fun _ => 0) = 0
      rw [IntModule.zero_zsmul, ih, AddCommMonoid.add_zero]

theorem evalCoefficients_add (features : List φ) (weight : φ → M)
    (left right : φ → Int) :
    evalCoefficients features weight (fun feature => left feature + right feature) =
      evalCoefficients features weight left +
        evalCoefficients features weight right := by
  induction features with
  | nil => simp [evalCoefficients, AddCommMonoid.add_zero]
  | cons feature rest ih =>
      change (left feature + right feature) • weight feature +
          evalCoefficients rest weight
            (fun feature => left feature + right feature) =
        (left feature • weight feature +
          evalCoefficients rest weight left) +
        (right feature • weight feature +
          evalCoefficients rest weight right)
      rw [IntModule.add_zsmul, ih]
      let a := left feature • weight feature
      let b := right feature • weight feature
      let c := evalCoefficients rest weight left
      let d := evalCoefficients rest weight right
      change (a + b) + (c + d) = (a + c) + (b + d)
      calc
        (a + b) + (c + d) = a + (b + (c + d)) :=
          AddCommMonoid.add_assoc a b (c + d)
        _ = a + (c + (b + d)) := by
          exact congrArg (fun value => a + value)
            (AddCommMonoid.add_left_comm b c d)
        _ = (a + c) + (b + d) :=
          (AddCommMonoid.add_assoc a c (b + d)).symm

theorem evalCoefficients_scale (features : List φ) (weight : φ → M)
    (multiplicity : Nat) (coeff : φ → Int) :
    evalCoefficients features weight
        (fun feature => Int.ofNat multiplicity * coeff feature) =
      multiplicity • evalCoefficients features weight coeff := by
  induction features with
  | nil => simp [evalCoefficients, NatModule.nsmul_zero]
  | cons feature rest ih =>
      change (Int.ofNat multiplicity * coeff feature) • weight feature +
          evalCoefficients rest weight
            (fun feature => Int.ofNat multiplicity * coeff feature) =
        multiplicity •
          (coeff feature • weight feature +
            evalCoefficients rest weight coeff)
      rw [IntModule.mul_zsmul, ih]
      have hcast : Int.ofNat multiplicity •
          (coeff feature • weight feature) =
          multiplicity • (coeff feature • weight feature) :=
        IntModule.zsmul_natCast_eq_nsmul multiplicity
          (coeff feature • weight feature)
      rw [hcast]
      exact (NatModule.nsmul_add multiplicity
        (coeff feature • weight feature)
        (evalCoefficients rest weight coeff)).symm

theorem evalCoefficients_weightedCoefficient
    (features : List φ) (weight : φ → M)
    (certificate : List (Nat × ρ)) (delta : ρ → φ → Int) :
    evalCoefficients features weight
        (weightedCoefficient certificate delta) =
      weightedGapSum certificate
        (fun row => evalCoefficients features weight (delta row)) := by
  induction certificate with
  | nil =>
      change evalCoefficients features weight (fun _ => 0) = 0
      exact evalCoefficients_zero features weight
  | cons entry rest ih =>
      rcases entry with ⟨multiplicity, row⟩
      change evalCoefficients features weight
          (fun feature => Int.ofNat multiplicity * delta row feature +
            weightedCoefficient rest delta feature) =
        multiplicity • evalCoefficients features weight (delta row) +
          weightedGapSum rest
            (fun row => evalCoefficients features weight (delta row))
      rw [evalCoefficients_add, evalCoefficients_scale, ih]

theorem evalCoefficients_eq_zero_of_map_eq
    (features : List φ) (weight : φ → M) (coeff : φ → Int)
    (h : features.map coeff = features.map (fun _ => 0)) :
    evalCoefficients features weight coeff = 0 := by
  induction features with
  | nil => rfl
  | cons feature rest ih =>
      simp only [List.map_cons, List.cons.injEq] at h
      rcases h with ⟨hhead, htail⟩
      change coeff feature • weight feature +
        evalCoefficients rest weight coeff = 0
      rw [hhead, IntModule.zero_zsmul, ih htail,
        AddCommMonoid.add_zero]

theorem evalCoefficients_eq_of_map_eq
    (features : List φ) (weight : φ → M) (left right : φ → Int)
    (h : features.map left = features.map right) :
    evalCoefficients features weight left =
      evalCoefficients features weight right := by
  induction features with
  | nil => rfl
  | cons feature rest ih =>
      simp only [List.map_cons, List.cons.injEq] at h
      rcases h with ⟨hhead, htail⟩
      change left feature • weight feature +
          evalCoefficients rest weight left =
        right feature • weight feature +
          evalCoefficients rest weight right
      rw [hhead, ih htail]

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

theorem unlabelledRows_legal :
    unlabelledRows.all validUnlabelledInstance = true := by decide

theorem unlabelledRows_semantic :
    unlabelledRows.all validUnlabelledSemantics = true := by decide

theorem unlabelledCertificate_shape :
    unlabelledRows.length = 13 ∧
    unlabelledCertificate.length = 13 := by decide

def negativeFFCoefficient : Symbol × Symbol → Int
  | (.f, .f) => -1
  | _ => 0

theorem unlabelledCertificate_cancellation :
    allSymbolEdges.map
        (weightedCoefficient unlabelledCertificate unlabelledEdgeDelta) =
      allSymbolEdges.map negativeFFCoefficient := by decide

section UnlabelledConsequence

variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]

def unlabelledGap (weight : Symbol × Symbol → M)
    (row : UnlabelledInstance) : M :=
  evalCoefficients allSymbolEdges weight (unlabelledEdgeDelta row)

omit [LE M] [LT M] [Std.IsPreorder M] [Std.LawfulOrderLT M]
  [OrderedAdd M] in
theorem eval_negativeFFCoefficient
    (weight : Symbol × Symbol → M) :
    evalCoefficients allSymbolEdges weight negativeFFCoefficient =
      - weight (.f, .f) := by
  simp [allSymbolEdges, allSymbols, negativeFFCoefficient,
    evalCoefficients, IntModule.zero_zsmul, IntModule.neg_zsmul,
    IntModule.one_zsmul, AddCommMonoid.add_zero]

omit [LE M] [LT M] [Std.IsPreorder M] [Std.LawfulOrderLT M]
  [OrderedAdd M] in
theorem unlabelledCertificate_weightedGap_eq_neg_ff
    (weight : Symbol × Symbol → M) :
    weightedGapSum unlabelledCertificate (unlabelledGap weight) =
      - weight (.f, .f) := by
  calc
    weightedGapSum unlabelledCertificate (unlabelledGap weight) =
        evalCoefficients allSymbolEdges weight
          (weightedCoefficient unlabelledCertificate unlabelledEdgeDelta) := by
            exact (evalCoefficients_weightedCoefficient allSymbolEdges weight
              unlabelledCertificate unlabelledEdgeDelta).symm
    _ = evalCoefficients allSymbolEdges weight negativeFFCoefficient := by
      exact evalCoefficients_eq_of_map_eq allSymbolEdges weight _ _
        unlabelledCertificate_cancellation
    _ = - weight (.f, .f) := eval_negativeFFCoefficient weight

/-- The 13 displayed rows force the repeated `ff` edge weight to be negative.
The further bounded-below contradiction uses the Archimedean/cofinal property
of the intended scalar target and is intentionally kept separate. -/
theorem yah13_forces_ff_negative (weight : Symbol × Symbol → M)
    (horients : ∀ entry ∈ unlabelledCertificate,
      if (rule entry.2.ruleName).dynamic = true
      then 0 < unlabelledGap weight entry.2
      else 0 ≤ unlabelledGap weight entry.2) :
    weight (.f, .f) < 0 := by
  have hnonneg : ∀ entry ∈ unlabelledCertificate,
      0 ≤ unlabelledGap weight entry.2 := by
    intro entry hentry
    have h := horients entry hentry
    by_cases hdynamic : (rule entry.2.ruleName).dynamic = true
    · simp [hdynamic] at h
      exact Preorder.le_of_lt h
    · simp [hdynamic] at h
      exact h
  let first : Nat × UnlabelledInstance :=
    (1, ⟨.Dt, [.hat, .d2], []⟩)
  have hfirstMem : first ∈ unlabelledCertificate := by
    simp [first, unlabelledCertificate, unlabelledRows]
  have hfirstPos : 0 < unlabelledGap weight first.2 := by
    have h := horients first hfirstMem
    simpa [first, rule] using h
  have hsumPos := weightedGapSum_pos unlabelledCertificate
    (unlabelledGap weight) hnonneg
    ⟨first, hfirstMem, by decide, hfirstPos⟩
  rw [unlabelledCertificate_weightedGap_eq_neg_ff weight] at hsumPos
  exact OrderedAdd.neg_pos_iff.mp hsumPos

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

theorem ffPumpWord_canonical (multiplicity : Nat) :
    canonical (ffPumpWord multiplicity) = true := by
  simp [ffPumpWord, canonical, isDigit]

omit [LE M] [LT M] [Std.IsPreorder M] [Std.LawfulOrderLT M]
  [OrderedAdd M] in
theorem ffTail_edgePotential
    (weight : Symbol × Symbol → M) (multiplicity : Nat) :
    edgePotential weight
        (List.replicate (multiplicity + 1) .f ++ [.dollar]) =
      multiplicity • weight (.f, .f) + weight (.f, .dollar) := by
  induction multiplicity with
  | zero =>
      simp [edgePotential, adjacentPairs, NatModule.zero_nsmul,
        AddCommMonoid.zero_add, AddCommMonoid.add_zero]
  | succ multiplicity ih =>
      have htail :
          List.foldr (fun edge total => weight edge + total) 0
              (adjacentPairs
                (.f :: (List.replicate multiplicity .f ++ [.dollar]))) =
            multiplicity • weight (.f, .f) + weight (.f, .dollar) := by
        simpa [edgePotential, List.replicate_succ] using ih
      simp [edgePotential, adjacentPairs, List.replicate_succ,
        NatModule.add_one_nsmul, htail, AddCommMonoid.add_assoc,
        AddCommMonoid.add_left_comm]

omit [LE M] [LT M] [Std.IsPreorder M] [Std.LawfulOrderLT M]
  [OrderedAdd M] in
theorem ffPumpPotential_eq_edgePotential
    (weight : Symbol × Symbol → M) (multiplicity : Nat) :
    ffPumpPotential weight multiplicity =
      edgePotential weight (ffPumpWord multiplicity) := by
  have htail := ffTail_edgePotential weight multiplicity
  simp [ffPumpPotential, ffPumpWord, edgePotential, adjacentPairs,
    List.replicate_succ] at htail ⊢
  rw [htail]
  rw [AddCommMonoid.add_assoc]

theorem negative_ff_pump_not_bounded_below
    (weight : Symbol × Symbol → M)
    (hcofinal : NegativeMultiplesCofinal (M := M))
    (hnegative : weight (.f, .f) < 0) :
    ¬ ∃ bound : M, ∀ multiplicity : Nat,
      bound ≤ ffPumpPotential weight multiplicity := by
  intro hbound
  rcases hbound with ⟨bound, hbound⟩
  let left := weight (.hat, .f)
  let middle := weight (.f, .f)
  let right := weight (.f, .dollar)
  obtain ⟨multiplicity, hsmall⟩ :=
    hcofinal middle (by simpa [middle] using hnegative)
      (bound - left - right)
  have hleft : left + multiplicity • middle <
      left + (bound - left - right) :=
    OrderedAdd.add_lt_right left hsmall
  have hboth : left + multiplicity • middle + right <
      left + (bound - left - right) + right :=
    OrderedAdd.add_lt_left hleft right
  have htarget : left + (bound - left - right) + right = bound := by
    calc
      left + (bound - left - right) + right =
          left + ((bound - left - right) + right) :=
        AddCommMonoid.add_assoc left (bound - left - right) right
      _ = left + (bound - left) := by
        rw [AddCommGroup.sub_add_cancel]
      _ = (bound - left) + left := AddCommMonoid.add_comm _ _
      _ = bound := AddCommGroup.sub_add_cancel
  rw [htarget] at hboth
  have hlower := hbound multiplicity
  change bound ≤ left + multiplicity • middle + right at hlower
  exact Preorder.not_ge_of_lt hboth hlower

theorem noBoundedBelowCanonicalFFPump
    (weight : Symbol × Symbol → M)
    (hcofinal : NegativeMultiplesCofinal (M := M))
    (horients : ∀ entry ∈ unlabelledCertificate,
      if (rule entry.2.ruleName).dynamic = true
      then 0 < unlabelledGap weight entry.2
      else 0 ≤ unlabelledGap weight entry.2) :
    ¬ ∃ bound : M, ∀ multiplicity : Nat,
      bound ≤ ffPumpPotential weight multiplicity :=
  negative_ff_pump_not_bounded_below weight hcofinal
    (yah13_forces_ff_negative weight horients)

/-- Whole-word form of the same obstruction: the actual adjacent-edge
potentials of the canonical words `^ f^(m+1) $` have no common lower bound. -/
theorem noBoundedBelowCanonicalFFPumpWords
    (weight : Symbol × Symbol → M)
    (hcofinal : NegativeMultiplesCofinal (M := M))
    (horients : ∀ entry ∈ unlabelledCertificate,
      if (rule entry.2.ruleName).dynamic = true
      then 0 < unlabelledGap weight entry.2
      else 0 ≤ unlabelledGap weight entry.2) :
    ¬ ∃ bound : M, ∀ multiplicity : Nat,
      bound ≤ edgePotential weight (ffPumpWord multiplicity) := by
  intro hbound
  apply noBoundedBelowCanonicalFFPump weight hcofinal horients
  rcases hbound with ⟨bound, hbound⟩
  refine ⟨bound, ?_⟩
  intro multiplicity
  rw [ffPumpPotential_eq_edgePotential]
  exact hbound multiplicity

end UnlabelledConsequence

/-! ## The exact fixed two-state suffix algebra -/

theorem twoState_rule_equations :
    ∀ name ∈ allRuleNames, ∀ tail : Bool,
      evalWord (rule name).lhs tail = evalWord (rule name).rhs tail := by
  intro name hname tail
  cases name <;> cases tail <;> decide

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

theorem symbolCertificate_legal :
    symbolCertificate.all (fun entry => validLabeledInstance entry.2) = true := by
  decide

theorem symbolCertificate_canonically_embeddable :
    symbolCertificate.all (fun entry =>
      canonicalLabeled (canonicalExtension entry.2.lhs) &&
      canonicalLabeled (canonicalExtension entry.2.rhs)) = true := by decide

theorem symbolCertificate_shape :
    symbolCertificate.length = 8 ∧
    (symbolCertificate.filter fun entry => (rule entry.2.ruleName).dynamic).foldr
      (fun entry total => entry.1 + total) 0 = 5 := by decide

theorem symbolCertificate_cancellation :
    allTokens.map
        (weightedCoefficient symbolCertificate labeledSymbolDelta) =
      allTokens.map (fun _ => 0) := by decide

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

theorem edgeCertificate_legal :
    edgeCertificate.all (fun entry => validLabeledInstance entry.2) = true := by
  decide

set_option maxRecDepth 100000 in
theorem edgeCertificate_canonically_embeddable :
    edgeCertificate.all (fun entry =>
      canonicalLabeled (canonicalExtension entry.2.lhs) &&
      canonicalLabeled (canonicalExtension entry.2.rhs)) = true := by decide

theorem edgeCertificate_shape :
    edgeCertificate.length = 50 ∧
    (edgeCertificate.filter fun entry => (rule entry.2.ruleName).dynamic).foldr
      (fun entry total => entry.1 + total) 0 = 144057 := by decide

set_option maxRecDepth 100000 in
theorem edgeCertificate_cancellation :
    allTokenEdges.map
        (weightedCoefficient edgeCertificate labeledEdgeDelta) =
      allTokenEdges.map (fun _ => 0) := by decide

/-! ## Ordered-algebra consequences of the exact zero cancellations -/

section LabeledNoGo

variable {M : Type u} [LE M] [LT M] [Std.IsPreorder M]
  [Std.LawfulOrderLT M] [IntModule M] [OrderedAdd M]

def symbolGap (weight : Token → M) (row : LabeledInstance) : M :=
  evalCoefficients allTokens weight (labeledSymbolDelta row)

def edgeGap (weight : Token × Token → M) (row : LabeledInstance) : M :=
  evalCoefficients allTokenEdges weight (labeledEdgeDelta row)

omit [LE M] [LT M] [Std.IsPreorder M] [Std.LawfulOrderLT M]
  [OrderedAdd M] in
theorem symbolCertificate_weightedGap_zero (weight : Token → M) :
    weightedGapSum symbolCertificate (symbolGap weight) = 0 := by
  calc
    weightedGapSum symbolCertificate (symbolGap weight) =
        evalCoefficients allTokens weight
          (weightedCoefficient symbolCertificate labeledSymbolDelta) := by
            exact (evalCoefficients_weightedCoefficient allTokens weight
              symbolCertificate labeledSymbolDelta).symm
    _ = 0 := evalCoefficients_eq_zero_of_map_eq allTokens weight _
      symbolCertificate_cancellation

omit [LE M] [LT M] [Std.IsPreorder M] [Std.LawfulOrderLT M]
  [OrderedAdd M] in
theorem edgeCertificate_weightedGap_zero (weight : Token × Token → M) :
    weightedGapSum edgeCertificate (edgeGap weight) = 0 := by
  calc
    weightedGapSum edgeCertificate (edgeGap weight) =
        evalCoefficients allTokenEdges weight
          (weightedCoefficient edgeCertificate labeledEdgeDelta) := by
            exact (evalCoefficients_weightedCoefficient allTokenEdges weight
              edgeCertificate labeledEdgeDelta).symm
    _ = 0 := evalCoefficients_eq_zero_of_map_eq allTokenEdges weight _
      edgeCertificate_cancellation

/-- The 8-row identity forbids weak orientation of its auxiliary rows and
strict orientation of its displayed dynamic rows in any compatible ordered
additive group. -/
theorem noTwoStateSymbolCertificateOrientation (weight : Token → M) :
    ¬ (∀ entry ∈ symbolCertificate,
      if (rule entry.2.ruleName).dynamic = true
      then 0 < symbolGap weight entry.2
      else 0 ≤ symbolGap weight entry.2) := by
  intro horients
  have hnonneg : ∀ entry ∈ symbolCertificate,
      0 ≤ symbolGap weight entry.2 := by
    intro entry hentry
    have h := horients entry hentry
    by_cases hdynamic : (rule entry.2.ruleName).dynamic = true
    · simp [hdynamic] at h
      exact Preorder.le_of_lt h
    · simp [hdynamic] at h
      exact h
  let first : Nat × LabeledInstance :=
    (2, canonicalLabeledInstance .Df false)
  have hfirstMem : first ∈ symbolCertificate := by
    simp [first, symbolCertificate]
  have hfirstPos : 0 < symbolGap weight first.2 := by
    have h := horients first hfirstMem
    simpa [first, canonicalLabeledInstance, rule] using h
  have hne := positiveCertificate_ne_zero symbolCertificate
    (symbolGap weight) hnonneg
    ⟨first, hfirstMem, by decide, hfirstPos⟩
  exact hne (symbolCertificate_weightedGap_zero weight)

/-- The 50-row identity gives the analogous adjacent-edge obstruction. -/
theorem noTwoStateEdgeCertificateOrientation
    (weight : Token × Token → M) :
    ¬ (∀ entry ∈ edgeCertificate,
      if (rule entry.2.ruleName).dynamic = true
      then 0 < edgeGap weight entry.2
      else 0 ≤ edgeGap weight entry.2) := by
  intro horients
  have hnonneg : ∀ entry ∈ edgeCertificate,
      0 ≤ edgeGap weight entry.2 := by
    intro entry hentry
    have h := horients entry hentry
    by_cases hdynamic : (rule entry.2.ruleName).dynamic = true
    · simp [hdynamic] at h
      exact Preorder.le_of_lt h
    · simp [hdynamic] at h
      exact h
  let first : Nat × LabeledInstance :=
    (57168, ⟨.Df, false, some (.t, false), none⟩)
  have hfirstMem : first ∈ edgeCertificate := by
    simp [first, edgeCertificate]
  have hfirstPos : 0 < edgeGap weight first.2 := by
    have h := horients first hfirstMem
    simpa [first, rule] using h
  have hne := positiveCertificate_ne_zero edgeCertificate
    (edgeGap weight) hnonneg
    ⟨first, hfirstMem, by decide, hfirstPos⟩
  exact hne (edgeCertificate_weightedGap_zero weight)

/-- Public wrapper: no weight function can orient every locally legal row of
the fixed two-state labeling in the named symbol-additive class. -/
theorem noTwoStateSymbolAdditiveOrder (weight : Token → M) :
    ¬ (∀ row : LabeledInstance, validLabeledInstance row = true →
      if (rule row.ruleName).dynamic = true
      then 0 < symbolGap weight row
      else 0 ≤ symbolGap weight row) := by
  intro hall
  apply noTwoStateSymbolCertificateOrientation weight
  intro entry hentry
  exact hall entry.2
    ((List.all_eq_true.mp symbolCertificate_legal) entry hentry)

/-- Public wrapper for adjacent-edge-additive weights in the same fixed
two-state labeling. -/
theorem noTwoStateEdgeAdditiveOrder (weight : Token × Token → M) :
    ¬ (∀ row : LabeledInstance, validLabeledInstance row = true →
      if (rule row.ruleName).dynamic = true
      then 0 < edgeGap weight row
      else 0 ≤ edgeGap weight row) := by
  intro hall
  apply noTwoStateEdgeCertificateOrientation weight
  intro entry hentry
  exact hall entry.2
    ((List.all_eq_true.mp edgeCertificate_legal) entry hentry)

end LabeledNoGo

#print axioms CollatzWork.YAH.twoState_rule_equations
#print axioms CollatzWork.YAH.unlabelledCertificate_cancellation
#print axioms CollatzWork.YAH.yah13_forces_ff_negative
#print axioms CollatzWork.YAH.ffPumpWord_canonical
#print axioms CollatzWork.YAH.ffPumpPotential_eq_edgePotential
#print axioms CollatzWork.YAH.noBoundedBelowCanonicalFFPump
#print axioms CollatzWork.YAH.noBoundedBelowCanonicalFFPumpWords
#print axioms CollatzWork.YAH.symbolCertificate_cancellation
#print axioms CollatzWork.YAH.edgeCertificate_cancellation
#print axioms CollatzWork.YAH.noTwoStateSymbolCertificateOrientation
#print axioms CollatzWork.YAH.noTwoStateEdgeCertificateOrientation
#print axioms CollatzWork.YAH.noTwoStateSymbolAdditiveOrder
#print axioms CollatzWork.YAH.noTwoStateEdgeAdditiveOrder

end CollatzWork.YAH
