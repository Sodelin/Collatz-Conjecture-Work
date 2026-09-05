import Std.Tactic

namespace CollatzWork

/-- Twelve exact normalized dyadic floor-power terms, with coefficients
`3^(11-i)`. All constants are explicit; no real logarithms or rounding occur. -/
def blockNumerator12 (B x : Nat) : Nat :=
  177147 * (if x < 2 * B then B else 2 * B) +
  59049 * (if 3 * x < 4 * B then 2 * B else 4 * B) +
  19683 * (if 9 * x < 16 * B then 8 * B else 16 * B) +
  6561 * (if 27 * x < 32 * B then 16 * B else 32 * B) +
  2187 * (if 81 * x < 128 * B then 64 * B else 128 * B) +
  729 * (if 243 * x < 256 * B then 128 * B else 256 * B) +
  243 * (if 729 * x < 1024 * B then 512 * B else 1024 * B) +
  81 * (if 2187 * x < 4096 * B then 2048 * B else 4096 * B) +
  27 * (if 6561 * x < 8192 * B then 4096 * B else 8192 * B) +
  9 * (if 19683 * x < 32768 * B then 16384 * B else 32768 * B) +
  3 * (if 59049 * x < 65536 * B then 32768 * B else 65536 * B) +
  1 * (if 177147 * x < 262144 * B then 131072 * B else 262144 * B)

/-- A uniform twelve-step arithmetic bound on every normalized phase.
The only cases are the eleven ordered dyadic-power thresholds in `[B,2B)`. -/
theorem blockNumerator12_exact_bound {B x : Nat} (hB : 0 < B)
    (hxlo : B ≤ x) (hxhi : x < 2 * B) :
    262144 * blockNumerator12 B x ≤ 416200322061 * x := by
  by_cases h5 : 243 * x < 256 * B
  · have h10 : 59049 * x < 65536 * B := by omega
    have h3 : 27 * x < 32 * B := by omega
    have h8 : 6561 * x < 8192 * B := by omega
    have h1 : 3 * x < 4 * B := by omega
    have h6 : 729 * x < 1024 * B := by omega
    have h11 : 177147 * x < 262144 * B := by omega
    have h4 : 81 * x < 128 * B := by omega
    have h9 : 19683 * x < 32768 * B := by omega
    have h2 : 9 * x < 16 * B := by omega
    have h7 : 2187 * x < 4096 * B := by omega
    simp only [blockNumerator12, if_pos hxhi, if_pos h5, if_pos h10, if_pos h3, if_pos h8, if_pos h1, if_pos h6, if_pos h11, if_pos h4, if_pos h9, if_pos h2, if_pos h7]
    omega
  ·
    by_cases h10 : 59049 * x < 65536 * B
    · have h3 : 27 * x < 32 * B := by omega
      have h8 : 6561 * x < 8192 * B := by omega
      have h1 : 3 * x < 4 * B := by omega
      have h6 : 729 * x < 1024 * B := by omega
      have h11 : 177147 * x < 262144 * B := by omega
      have h4 : 81 * x < 128 * B := by omega
      have h9 : 19683 * x < 32768 * B := by omega
      have h2 : 9 * x < 16 * B := by omega
      have h7 : 2187 * x < 4096 * B := by omega
      simp only [blockNumerator12, if_pos hxhi, if_neg h5, if_pos h10, if_pos h3, if_pos h8, if_pos h1, if_pos h6, if_pos h11, if_pos h4, if_pos h9, if_pos h2, if_pos h7]
      omega
    ·
      by_cases h3 : 27 * x < 32 * B
      · have h8 : 6561 * x < 8192 * B := by omega
        have h1 : 3 * x < 4 * B := by omega
        have h6 : 729 * x < 1024 * B := by omega
        have h11 : 177147 * x < 262144 * B := by omega
        have h4 : 81 * x < 128 * B := by omega
        have h9 : 19683 * x < 32768 * B := by omega
        have h2 : 9 * x < 16 * B := by omega
        have h7 : 2187 * x < 4096 * B := by omega
        simp only [blockNumerator12, if_pos hxhi, if_neg h5, if_neg h10, if_pos h3, if_pos h8, if_pos h1, if_pos h6, if_pos h11, if_pos h4, if_pos h9, if_pos h2, if_pos h7]
        omega
      ·
        by_cases h8 : 6561 * x < 8192 * B
        · have h1 : 3 * x < 4 * B := by omega
          have h6 : 729 * x < 1024 * B := by omega
          have h11 : 177147 * x < 262144 * B := by omega
          have h4 : 81 * x < 128 * B := by omega
          have h9 : 19683 * x < 32768 * B := by omega
          have h2 : 9 * x < 16 * B := by omega
          have h7 : 2187 * x < 4096 * B := by omega
          simp only [blockNumerator12, if_pos hxhi, if_neg h5, if_neg h10, if_neg h3, if_pos h8, if_pos h1, if_pos h6, if_pos h11, if_pos h4, if_pos h9, if_pos h2, if_pos h7]
          omega
        ·
          by_cases h1 : 3 * x < 4 * B
          · have h6 : 729 * x < 1024 * B := by omega
            have h11 : 177147 * x < 262144 * B := by omega
            have h4 : 81 * x < 128 * B := by omega
            have h9 : 19683 * x < 32768 * B := by omega
            have h2 : 9 * x < 16 * B := by omega
            have h7 : 2187 * x < 4096 * B := by omega
            simp only [blockNumerator12, if_pos hxhi, if_neg h5, if_neg h10, if_neg h3, if_neg h8, if_pos h1, if_pos h6, if_pos h11, if_pos h4, if_pos h9, if_pos h2, if_pos h7]
            omega
          ·
            by_cases h6 : 729 * x < 1024 * B
            · have h11 : 177147 * x < 262144 * B := by omega
              have h4 : 81 * x < 128 * B := by omega
              have h9 : 19683 * x < 32768 * B := by omega
              have h2 : 9 * x < 16 * B := by omega
              have h7 : 2187 * x < 4096 * B := by omega
              simp only [blockNumerator12, if_pos hxhi, if_neg h5, if_neg h10, if_neg h3, if_neg h8, if_neg h1, if_pos h6, if_pos h11, if_pos h4, if_pos h9, if_pos h2, if_pos h7]
              omega
            ·
              by_cases h11 : 177147 * x < 262144 * B
              · have h4 : 81 * x < 128 * B := by omega
                have h9 : 19683 * x < 32768 * B := by omega
                have h2 : 9 * x < 16 * B := by omega
                have h7 : 2187 * x < 4096 * B := by omega
                simp only [blockNumerator12, if_pos hxhi, if_neg h5, if_neg h10, if_neg h3, if_neg h8, if_neg h1, if_neg h6, if_pos h11, if_pos h4, if_pos h9, if_pos h2, if_pos h7]
                omega
              ·
                by_cases h4 : 81 * x < 128 * B
                · have h9 : 19683 * x < 32768 * B := by omega
                  have h2 : 9 * x < 16 * B := by omega
                  have h7 : 2187 * x < 4096 * B := by omega
                  simp only [blockNumerator12, if_pos hxhi, if_neg h5, if_neg h10, if_neg h3, if_neg h8, if_neg h1, if_neg h6, if_neg h11, if_pos h4, if_pos h9, if_pos h2, if_pos h7]
                  omega
                ·
                  by_cases h9 : 19683 * x < 32768 * B
                  · have h2 : 9 * x < 16 * B := by omega
                    have h7 : 2187 * x < 4096 * B := by omega
                    simp only [blockNumerator12, if_pos hxhi, if_neg h5, if_neg h10, if_neg h3, if_neg h8, if_neg h1, if_neg h6, if_neg h11, if_neg h4, if_pos h9, if_pos h2, if_pos h7]
                    omega
                  ·
                    by_cases h2 : 9 * x < 16 * B
                    · have h7 : 2187 * x < 4096 * B := by omega
                      simp only [blockNumerator12, if_pos hxhi, if_neg h5, if_neg h10, if_neg h3, if_neg h8, if_neg h1, if_neg h6, if_neg h11, if_neg h4, if_neg h9, if_pos h2, if_pos h7]
                      omega
                    ·
                      by_cases h7 : 2187 * x < 4096 * B
                      · simp only [blockNumerator12, if_pos hxhi, if_neg h5, if_neg h10, if_neg h3, if_neg h8, if_neg h1, if_neg h6, if_neg h11, if_neg h4, if_neg h9, if_neg h2, if_pos h7]
                        omega
                      ·
                        simp only [blockNumerator12, if_pos hxhi, if_neg h5, if_neg h10, if_neg h3, if_neg h8, if_neg h1, if_neg h6, if_neg h11, if_neg h4, if_neg h9, if_neg h2, if_neg h7]
                        omega

/-- A strict twelve-step bound follows from the exact endpoint envelope. -/
theorem blockNumerator12_strict_bound {B x : Nat} (hB : 0 < B)
    (hxlo : B ≤ x) (hxhi : x < 2 * B) :
    4 * blockNumerator12 B x < 12 * 531441 * x := by
  have h := blockNumerator12_exact_bound hB hxlo hxhi
  omega

/-- The non-strict form used by the mechanical-remainder recurrence. -/
theorem blockNumerator12_bound {B x : Nat} (hB : 0 < B)
    (hxlo : B ≤ x) (hxhi : x < 2 * B) :
    4 * blockNumerator12 B x ≤ 12 * 531441 * x :=
  Nat.le_of_lt (blockNumerator12_strict_bound hB hxlo hxhi)

#print axioms CollatzWork.blockNumerator12_exact_bound
#print axioms CollatzWork.blockNumerator12_strict_bound
#print axioms CollatzWork.blockNumerator12_bound

end CollatzWork
