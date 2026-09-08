import Std

namespace BlindCollatz.AlternatingGrowth

/-- Shortcut Collatz map: one division by two on either branch. -/
def step (n : Nat) : Nat :=
  if n % 2 = 0 then n / 2 else (3 * n + 1) / 2

def block (n : Nat) : Nat := step (step (step n))

 theorem first_step (q : Nat) : step (16 * q + 11) = 24 * q + 17 := by
  simp only [step, show (16 * q + 11) % 2 ≠ 0 by omega, if_false]
  omega

 theorem second_step (q : Nat) : step (24 * q + 17) = 36 * q + 26 := by
  simp only [step, show (24 * q + 17) % 2 ≠ 0 by omega, if_false]
  omega

 theorem third_step (q : Nat) : step (36 * q + 26) = 18 * q + 13 := by
  simp only [step, show (36 * q + 26) % 2 = 0 by omega, if_true]
  omega

 theorem block_formula (q : Nat) : block (16 * q + 11) = 18 * q + 13 := by
  simp [block, first_step, second_step, third_step]

 theorem block_grows (q : Nat) : 16 * q + 11 < block (16 * q + 11) := by
  rw [block_formula]
  omega

 theorem odd_exponents_one_two (q : Nat) :
    (3 * (16 * q + 11) + 1) % 4 = 2 ∧
    (3 * (24 * q + 17) + 1) % 8 = 4 := by
  constructor <;> omega

end BlindCollatz.AlternatingGrowth

namespace BlindCollatz.AlternatingGrowth

 theorem block_scaled (x : Nat) (hx : 0 < x) :
    block (16 * x - 5) = 18 * x - 5 := by
  have h : 16 * x - 5 = 16 * (x - 1) + 11 := by omega
  rw [h, block_formula]
  omega

/-- A family that admits arbitrarily many expanding (1,2) valuation blocks. -/
def seed (m t : Nat) : Nat := 16 * (8 ^ m * t) - 5

def blocks : Nat → Nat → Nat
  | 0, n => n
  | k + 1, n => blocks k (block n)

 theorem block_seed_succ (m t : Nat) (ht : 0 < t) :
    block (seed (m + 1) t) = seed m (9 * t) := by
  simp only [seed]
  rw [block_scaled _ (Nat.mul_pos (Nat.pow_pos (by decide)) ht)]
  have h₁ : 8 ^ (m + 1) * t = 8 * (8 ^ m * t) := by
    rw [Nat.pow_succ]
    ac_rfl
  have h₂ : 8 ^ m * (9 * t) = 9 * (8 ^ m * t) := by ac_rfl
  rw [h₁, h₂]
  omega

 theorem iterated_seed (m t : Nat) (ht : 0 < t) :
    blocks m (seed m t) = 16 * (9 ^ m * t) - 5 := by
  induction m generalizing t with
  | zero => simp [blocks, seed]
  | succ m ih =>
    rw [blocks, block_seed_succ m t ht, ih (9 * t) (by omega)]
    have h : 9 ^ m * (9 * t) = 9 ^ (m + 1) * t := by
      rw [Nat.pow_succ]
      ac_rfl
    rw [h]

end BlindCollatz.AlternatingGrowth

namespace BlindCollatz.AlternatingGrowth

/-- Every certified block starts in the residue class with odd exponents (1,2). -/
def goodBlocks : Nat → Nat → Prop
  | 0, _ => True
  | k + 1, n => (∃ q : Nat, n = 16 * q + 11) ∧ goodBlocks k (block n)

 theorem seed_good_blocks (m t : Nat) (ht : 0 < t) :
    goodBlocks m (seed m t) := by
  induction m generalizing t with
  | zero => trivial
  | succ m ih =>
    constructor
    · refine ⟨8 ^ (m + 1) * t - 1, ?_⟩
      have hpos : 0 < 8 ^ (m + 1) * t := Nat.mul_pos (Nat.pow_pos (by decide : 0 < 8)) ht
      simp only [seed]
      omega
    · rw [block_seed_succ m t ht]
      exact ih (9 * t) (by omega)

 theorem iterated_seed_grows (m t : Nat) (hm : 0 < m) (ht : 0 < t) :
    seed m t < blocks m (seed m t) := by
  rw [iterated_seed m t ht]
  simp only [seed]
  have hp := Nat.pow_lt_pow_left (by decide : 8 < 9) (by omega : m ≠ 0)
  have hh := Nat.mul_lt_mul_of_pos_right hp ht
  have hpos : 0 < 8 ^ m * t := Nat.mul_pos (Nat.pow_pos (by decide : 0 < 8)) ht
  omega

/-- An arbitrarily long finite string of these expanding blocks exists in ℕ. -/
 theorem arbitrarily_long_expansion (m : Nat) (hm : 0 < m) :
    ∃ n : Nat, goodBlocks m n ∧ n < blocks m n := by
  exact ⟨seed m 1, seed_good_blocks m 1 (by decide),
    iterated_seed_grows m 1 hm (by decide)⟩

end BlindCollatz.AlternatingGrowth

namespace BlindCollatz.AlternatingGrowth

/-- Each successive certified block endpoint is strictly larger. -/
theorem goodBlocks_each_block_grows (m n : Nat) (hgood : goodBlocks m n) :
    ∀ j : Nat, j < m → blocks j n < blocks (j + 1) n := by
  induction m generalizing n with
  | zero => intro j hj; omega
  | succ m ih =>
    intro j hj
    obtain ⟨⟨q, rfl⟩, hnext⟩ := hgood
    cases j with
    | zero => simpa [blocks] using block_grows q
    | succ j =>
      simpa [blocks] using ih (block (16 * q + 11)) hnext j (by omega)

/-- Ordinary Collatz map: the odd branch does not include a division. -/
def ordinaryStep (n : Nat) : Nat :=
  if n % 2 = 0 then n / 2 else 3 * n + 1

def ordinarySteps : Nat → Nat → Nat
  | 0, n => n
  | k + 1, n => ordinarySteps k (ordinaryStep n)

/-- One (1,2) block is two accelerated odd steps, three shortcut steps,
    and five ordinary Collatz steps. -/
theorem ordinary_five (q : Nat) :
    ordinarySteps 5 (16 * q + 11) = 18 * q + 13 := by
  have h₁ : ordinaryStep (16 * q + 11) = 48 * q + 34 := by
    simp only [ordinaryStep, show (16 * q + 11) % 2 ≠ 0 by omega, if_false]
    omega
  have h₂ : ordinaryStep (48 * q + 34) = 24 * q + 17 := by
    simp only [ordinaryStep, show (48 * q + 34) % 2 = 0 by omega, if_true]
    omega
  have h₃ : ordinaryStep (24 * q + 17) = 72 * q + 52 := by
    simp only [ordinaryStep, show (24 * q + 17) % 2 ≠ 0 by omega, if_false]
    omega
  have h₄ : ordinaryStep (72 * q + 52) = 36 * q + 26 := by
    simp only [ordinaryStep, show (72 * q + 52) % 2 = 0 by omega, if_true]
    omega
  have h₅ : ordinaryStep (36 * q + 26) = 18 * q + 13 := by
    simp only [ordinaryStep, show (36 * q + 26) % 2 = 0 by omega, if_true]
    omega
  simp [ordinarySteps, h₁, h₂, h₃, h₄, h₅]

theorem shortcut_three_eq_ordinary_five (q : Nat) :
    block (16 * q + 11) = ordinarySteps 5 (16 * q + 11) := by
  rw [block_formula, ordinary_five]

#print axioms block_grows
#print axioms odd_exponents_one_two
#print axioms iterated_seed
#print axioms seed_good_blocks
#print axioms arbitrarily_long_expansion
#print axioms goodBlocks_each_block_grows
#print axioms ordinary_five
#print axioms shortcut_three_eq_ordinary_five

end BlindCollatz.AlternatingGrowth
