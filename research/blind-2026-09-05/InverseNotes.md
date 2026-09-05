# Blind inverse-tree derivation

This note was derived without consulting the existing repository or external sources. These are elementary results established in this session; historical novelty has not been checked. No complete proof of the Collatz conjecture results.

## Definition

For a positive odd integer x, let F(x) = (3x + 1) / 2^v₂(3x + 1). In particular F(1) = 1. A counterexample means a positive odd integer whose F-orbit never reaches 1. If there are any counterexamples, their least element exists.

Define partial inverse operations

- P₂(x) = (4x − 1)/3, when this is an integer;
- P₁(x) = (2x − 1)/3, when this is an integer.

When x is positive and odd and the indicated inverse is integral, its output is positive and odd, and F(P₂(x)) = x or F(P₁(x)) = x, respectively. The valuations are exactly 2 and 1 because 3P₂(x)+1 = 4x and 3P₁(x)+1 = 2x.

## A countable family of inverse descent certificates

Let q,r be nonnegative integers satisfying

    4^q 2^r < 3^(q+r).

This implies r ≥ 1. Let n be positive and odd, and assume

    4^q(n − 1) + 2·3^q ≡ 0 (mod 3^(q+r)).             (1)

Equivalently, since 4 is invertible modulo powers of 3,

    n ≡ 1 − 2·3^q·4^(−q) (mod 3^(q+r)).

Then q applications of P₂ followed by r applications of P₁ are all integral, positive, and odd. Their final output is

    m = [2^r 4^q(n − 1) + 2^(r+1)3^q − 3^(q+r)] / 3^(q+r).

Moreover m < n and F^(q+r)(m) = n. Consequently a least counterexample cannot satisfy (1).

### Proof of intermediate integrality

Write H = 4^q(n−1) + 2·3^q. Condition (1) implies 3^q divides n−1. After i applications of P₂, for 0 ≤ i ≤ q, the value is

    x_i = 1 + 4^i(n−1)/3^i.

Thus every x_i is an integer. Each is odd: n−1 is even, and division by an odd power of 3 preserves that factor of 2. Also x_i ≥ 1.

At i=q, x_q+1 = H/3^q is divisible by 3^r. After t applications of P₁, for 0 ≤ t ≤ r, the value is

    y_t = 2^t(x_q+1)/3^t − 1.

Therefore each y_t is integral and odd. Positivity also follows inductively: P₁(x) > 0 for any positive x ≥ 1, so an integral P₁ output remains positive. The same argument applies to P₂. Taking t=r gives the asserted formula for m.

### Proof of strict descent

Put α = 4^q 2^r / 3^(q+r) and t = (2/3)^r. The output satisfies

    m = α(n−1) + 2t − 1,
    m−n = (α−1)(n−1) + 2(t−1).

Here α<1, n−1≥0, and t<1, so m−n<0. The exact inverse identities show F^(q+r)(m)=n. If n never reaches 1, neither can m; this contradicts the defining minimality of n.

### Examples

| q | r | Excluded residue for a least counterexample | Smaller ancestor | Example |
|---|---|---|---|---|
| 0 | 1 | n ≡ 2 mod 3 | (2n−1)/3 | 5 ← 3 |
| 1 | 1 | n ≡ 4 mod 9 | (8n−5)/9 | 31 ← 41 ← 27 |
| 2 | 2 | n ≡ 10 mod 81 | (64n−73)/81 | 91 ← 121 ← 161 ← 107 ← 71 |

In the examples, each left arrow means that the value on its right maps to the value on its left under F.

This family provides infinitely many explicit certificates. It does not prove that every positive odd integer has such a certificate. In particular, a multiple of 3 has no odd inverse at all. The residue classes above do not cover those integers.

## A maximum-growth prefix shields against shorter merging branches

Suppose the first j accelerated valuations of n are all 1. Equivalently, for j≥1, n ≡ −1 mod 2^(j+1). Then

    F^j(n) + 1 = (3/2)^j(n+1).

For every positive odd x, F(x) ≤ (3x+1)/2. Induction therefore gives

    F^l(m)+1 ≤ (3/2)^l(m+1).

If F^l(m) = F^j(n), it follows that

    m+1 ≥ (3/2)^(j−l)(n+1).

In particular, when l≤j, m≥n. Thus a smaller ancestor merging into such a maximum-growth prefix must take strictly more accelerated steps to reach the merging point than the prefix itself took. This is an exact obstruction to one kind of short inverse detour, not a global obstruction to descent.

## Rejected CRT proof attempt

An attempted argument considered starts satisfying n ≡ −1 modulo a large power of 2 and n ≡ 0 modulo a large power of 3. It tried to prove that every bounded forward/inverse detour had affine slope at least 1, using a projection obtained by substituting n=−1.

That proof is rejected. Its crucial integrality assertion is false: the projected values can become negative rationals with denominators divisible by 3. For n divisible by 3 and satisfying n ≡ 3 mod 4, the following are valid eventual-merging relations:

    F(n) = (3n+1)/2 = F(4n+1),
    F(16n/3 + 1) = 4n+1.

The congruence n ≡ 3 mod 4 gives exact valuation 1 for F(n), and it holds for the proposed CRT starts whenever their power-of-2 modulus is divisible by 4. The last equality has exact valuation 2. Substituting n=−1 into its ancestor gives −13/3, rather than a negative integer. Therefore the proposed restriction on denominators, and the resulting slope bound, do not follow. This invalidates the proof attempt; it does not establish that the proposed CRT obstruction is itself false.

## Remaining mathematical gap

The inverse certificates exclude particular congruence classes for a hypothetical least counterexample. The maximum-growth bound explains why some natural detours cannot descend. Neither establishes that every remaining integer admits a smaller forward iterate or smaller ancestor. A universal descent or component-connectivity result is still required.
