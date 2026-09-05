import CollatzWork.ConvergenceStatement

namespace CollatzWork

/-!
Trusted statements for a guarded, unbounded family of actual forward
descents. Neither a normalized inverse move nor a change of original root
appears in these statements. The guard on the post-burst value is substantive;
it is not claimed for every positive integer.
-/

/-- Every `k` repeated OOE blocks follow the exact shortcut orbit. The
parameter need not be odd: oddness is relevant only to an exact valuation
interpretation, which is not required by this identity. -/
def RootDescentBurstStatement : Prop :=
  ∀ k u : Nat, 0 < u →
    shortcutIter (3 * k) (8 ^ k * u - 5) = 9 ^ k * u - 5

/-- If the burst endpoint admits at least `k` consecutive even steps, the
result is positive and strictly below the unchanged original root. Both
the burst length and the positive parameter are unbounded. -/
def RootDescentStatement : Prop :=
  ∀ k u m : Nat, 0 < k → 0 < u → 0 < m →
    2 ^ k * m + 5 = 9 ^ k * u →
    shortcutIter (4 * k) (8 ^ k * u - 5) = m ∧
      m < 8 ^ k * u - 5

/-- An exact actual-orbit ancestor identity. The equation is an arithmetic
guard on the endpoint; this statement alone makes no size or coverage claim. -/
def RootDescentAncestorStatement : Prop :=
  ∀ e L q r : Nat, 0 < q → 3 ^ (L + 1) * q = 4 * r + 1 →
    shortcutIter (e + L + 2) (2 ^ e * (2 ^ L * q - 1)) = r

end CollatzWork
