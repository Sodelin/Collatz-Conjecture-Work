import Std
import Init.Grind.Ordered.Module
import Definitions.Def_CollatzWork_BlockArithmetic



open CollatzWork in
theorem solution {B x : Nat} (hB : 0 < B)
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
