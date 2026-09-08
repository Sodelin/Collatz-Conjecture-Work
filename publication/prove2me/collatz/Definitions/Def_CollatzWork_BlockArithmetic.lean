import Std
import Init.Grind.Ordered.Module
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











end CollatzWork
