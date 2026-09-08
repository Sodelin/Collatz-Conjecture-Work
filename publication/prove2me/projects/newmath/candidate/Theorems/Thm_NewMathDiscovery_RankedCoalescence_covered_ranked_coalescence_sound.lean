import Std
import Init.Grind.Ordered.Module
import Definitions.Def_NewMathDiscovery_RankedCoalescenceSound



theorem NewMathDiscovery.RankedCoalescence.covered_ranked_coalescence_sound
    {α C W : Type}
    (f : α → α)
    (one : α)
    (decode : C → α)
    (rank : C → W)
    (lt : W → W → Prop)
    (edge : C → Nat → Nat → C → Prop)
    (Entry : C → Prop)
    (Domain : α → Prop)
    (hfix : f one = one)
    (hwf : WellFounded (fun c' c => lt (rank c') (rank c)))
    (hprogress : ∀ c, decode c ≠ one → ∃ a b c', edge c a b c')
    (hexact : ∀ {c a b c'}, edge c a b c' →
      iterate f a (decode c) = iterate f b (decode c'))
    (hdecrease : ∀ {c a b c'}, edge c a b c' →
      lt (rank c') (rank c))
    (hcoverage : ∀ x, Domain x → ∃ c, Entry c ∧ decode c = x) :
    ∀ x, Domain x → Reaches f one x := by sorry

