# Blind symbolic Collatz attempt: exact repetition budget

This note was derived without consulting the repository or outside literature. It contains analytic proofs, computational checks, and the precise failure of an attempted extension to arbitrary words. These analytic arguments have not themselves been checked by Lean. They do not claim novelty or a solution of Collatz.

## Definitions

For a positive odd integer n, put U(n) = (3n+1)/2^a, where a = v₂(3n+1). Let w = (a₀,...,a_{ℓ−1}) be any finite word of positive integers, and set

- s = a₀+...+a_{ℓ−1}; B = 2^s; A = 3^ℓ;
- S₀ = 0 and Sⱼ = a₀+...+a_{j−1};
- C = Σ_{j=0}^{ℓ−1} 3^{ℓ−1−j} 2^{Sⱼ}; D = A−B.

Formal composition along the word gives F_w(n) = (An+C)/B. C and D are odd, and D is nonzero.

## Exact finite-word lemma

The actual odd Collatz orbit beginning at an odd integer n follows exactly the valuations w if and only if

    An+C ≡ B (mod 2B).

The final congruence forces every internal division to have its prescribed exact valuation: at each proper prefix j, write the final affine numerator as 3^{ℓ−j}(3^j n+C_j)+2^{S_j}C_suffix, where C_suffix is odd. Reduction modulo 2^{S_j+1} gives 3^j n+C_j ≡ 2^{S_j} modulo 2^{S_j+1}. Thus every intermediate quotient is odd. The converse follows immediately from composition.

There is consequently one odd residue class modulo 2B realizing w, and infinitely many positive integers in that class.

Let x* = −C/D, interpreted in the 2-adic integers. Because C and D are odd, x* is 2-adically odd; also Ax*+C = Bx*. The finite-word condition is equivalent to

    n ≡ x* (mod 2B),

or, entirely in ordinary integer arithmetic,

    2^{s+1} divides Dn+C.

## Exact repetition theorem

For any r ≥ 1, a positive odd integer n follows r consecutive copies of w if and only if

    v₂(Dn+C) ≥ rs+1,

with v₂(0) = +∞. Indeed F_w^r has the same fixed point x*, its denominator is B^r, and the preceding lemma applies with total valuation rs.

If Dn+C ≠ 0, the maximum number of complete copies of w is exactly

    floor((v₂(Dn+C)−1)/s).

If A>B, then Dn+C>0 for every positive n. Therefore an expanding word cannot repeat forever, and r repetitions require

    2^{rs+1} ≤ Dn+C,
    n ≥ (2^{rs+1}−C)/D,
    r ≤ (log₂(Dn+C)−1)/s.

This is a rigorous logarithmic bound in the starting integer for repetitions of each fixed expanding word. It does not bound repetitions uniformly as the starting integer or the word varies.

For w=(1), this gives v₂(n+1) ≥ r+1, so the minimum positive seed is 2^{r+1}−1. For w=(1,2), A=9, B=8, C=5, D=1, and the minimum seed for r repetitions is 2^{3r+1}−5.

## Genuine periodic cycles versus finite shadows

An infinite periodic valuation word w from a positive integer exists precisely when

    n = C/(B−A)

is a positive integer. Thus it requires B>A and divisibility B−A | C. The integer is necessarily odd, and the exact-word lemma verifies its prescribed cycle. This classifies periodic-word realizability but does not exclude all nontrivial positive cycles.

If A>B, the periodic 2-adic seed x*=−C/D is negative as a real rational number. Nevertheless every finite repetition is realized by positive integers. Their minimum sizes grow exponentially in r. Their convergence to x* is 2-adic, not convergence to a positive real integer. A compactness argument that obtains this limit does not produce a positive counterexample.

## Global closure candidate and why it currently fails

Candidate: every noncontracting path must exhaust a finite 2-adic divisibility budget, as each repeated expanding block does.

For a changing word, the relevant linear form Dn+C changes. There is no proved common decreasing budget. In fact, applying the one-copy bound to an arbitrary prefix with endpoint n_k gives the identity

    Dn+C = 2^s(n_k−n).

The exact word condition then says only that n_k−n is even. If A>B, its positive-integer size bound says only n_k≥n+2. This is automatic. The fixed-word theorem gains force from repeatedly dividing the *same* linear form, which changing words do not do.

A successful extension needs an invariant controlling those changing linear forms, or an arithmetic theorem excluding positive integers from the relevant aperiodic 2-adic addresses. Neither has been proved here. Finite-word feasibility, exponential rarity, or 2-adic compactness alone is insufficient.

## Computational verification

Exhaustively checked all words of lengths 1–4 with entries 1–4, all positive odd seeds below 200, and repetition counts 1–4: 136,000 comparisons of the exact valuation trajectory with v₂(Dn+C)≥rs+1, with no discrepancies. This checks formulas and indexing; the proof above establishes the general claim.

## Additional barrier for a one-step potential

There is no function V(n) = c log n + o(log n), c>0, that is nonincreasing on every positive odd Collatz step n>1. Let n_r = 2^{r+1}−1. Its first r valuations all equal 1 and U^r(n_r)=2·3^r−1. Hence V(U^r(n_r))−V(n_r) = cr log(3/2)+o(r)>0 for large r, contradicting telescoping nonincrease. In particular no globally bounded additive correction to log n works.

This rules out one particular global Lyapunov class. It does not rule out other potentials, descent over variable blocks, or termination itself.

## A bound that survives changing the repeated word

Suppose the valuation sequence beginning at n contains ww, where w has length ℓ and sum s. Let m=U^ℓ(n). Both n and m start with the exact word w, so

    m ≡ n (mod 2^{s+1}).

If m≠n, then |m−n|≥2^{s+1}. On the other hand, U(x)+1≤(3/2)(x+1) for every positive odd x, so

    |m−n| < (3/2)^ℓ(n+1).

As s≥ℓ, these imply

    (4/3)^ℓ < (n+1)/2.

Thus the lengths of square prefixes ww at a fixed positive seed are uniformly bounded, even if w changes, unless a first copy returns to that seed and hence gives a genuine periodic orbit. More generally r≥2 copies with m≠n imply

    (2^r/3)^ℓ < (n+1)/2.

This is a useful extension of the fixed-word result. It still does not force arbitrary aperiodic valuation sequences to contain the required long repeated prefixes.

## Conditional subword-complexity constraint

Assume all entries n_i of a positive odd trajectory are distinct. Assume also that its average valuation exists as a real number:

    α = lim_{k→∞} S_k/k.

Let p(L) be the number of distinct length-L contiguous valuation blocks anywhere in its infinite valuation sequence; allow p(L)=+∞.

Then 1≤α≤log₂3. If α<log₂3,

    liminf_{L→∞} p(L)/L ≥ α/(log₂3−α).

If α=log₂3, then p(L)/L tends to +∞.

Proof: exact multiplication gives

    log₂ n_k = log₂ n₀ + k log₂3 − S_k
               + Σ_{i<k} log₂(1+1/(3n_i)).

Because the n_i are distinct positive odd integers, sorting them gives

    Σ_{i<k} 1/n_i ≤ Σ_{j<k} 1/(2j+1) = O(log(k+1)).

Consequently the correction in the logarithmic identity is O(log(k+1)), and

    log₂ n_k = c k + o(k),  where c=log₂3−α≥0.

Fix κ>0. To justify uniformity, write e_t=S_t−αt and let E_L=max_{0≤t≤floor(κL)+L}|e_t|. For every ε>0, all sufficiently large t satisfy |e_t|≤εt; the finitely many earlier errors have a fixed finite maximum. It follows that E_L=o(L). Thus every length-L sum beginning at 0≤i≤floor(κL) is αL+e_{i+L}−e_i=αL+o(L), uniformly in i. The same argument applied to log₂ n_i−ci=o(i) shows that the maximum logarithmic height of these starting integers is at most cκL+o(L).

If two such length-L words match, the exact-word lemma makes the two distinct starting integers differ by at least 2^{αL+o(L)}. Their sizes permit a difference of at most 2^{cκL+o(L)}. When cκ<α this is impossible for large L. Thus all floor(κL)+1 words are distinct. For c>0 let κ increase to α/c; for c=0 κ is arbitrary. This proves the claims.

The theorem is conditional on existence of the valuation average. It does not prove that average exists. No general upper bound on p(L) has been established here, so the lower bound creates no universal contradiction. It also does not exclude nontrivial cycles, which are outside the distinct-orbit assumption.

## Tested global candidate: a balanced aperiodic word

A natural attempt to evade the fixed-pattern obstruction is the infinite word generated by substitution 1→12 and 2→21, beginning at 1. It is aperiodic and has average valuation α=3/2, below log₂3. Its first terms are 1221211221121221.... Every aligned pair has one 1 and one 2, so the average is 3/2.

For completeness, aperiodicity follows directly from the substitution. Subtract 1 from its letters to get t(2j)=t(j), t(2j+1)=1−t(j). An eventual even period 2p would imply eventual period p by looking at even positions. Reducing to an odd period 2p+1, comparison at even and odd positions gives t(j+p)=t(j+p+1) for all sufficiently large j. That would make the tail constant, contradicting complementary adjacent pairs. Thus there is no eventual period.

A putative Collatz orbit with this sequence has distinct entries: repetition of an entry would force an eventual cycle and hence an eventually periodic valuation sequence.

The complexity theorem rules it out as the valuation sequence of a positive integer. Indeed, at substitution level q, the word is partitioned into blocks of length 2^q of two possible types. For 2^{q−1}<L≤2^q, every length-L factor is contained in a pair of these blocks. There are at most four pair types and 2^q starting offsets, so p(L)≤4·2^q<8L. But α/(log₂3−α)≈17.6548476, which is incompatible with this upper bound.

An even more direct check: the word has a square with start t and period t whenever t=2^{q+1}, obtained by substituting repeatedly into the initial square 21|21 at zero-based position 2. Each period has valuation sum 3t/2. A putative positive nonperiodic orbit would have log₂ n_t=ct+o(t), c=log₂3−3/2≈0.0849625. The equal length-t blocks at t and 2t force |n_{2t}−n_t|≥2^{3t/2+1}, while its size is at most 2^{2ct+o(t)}. Since 3/2>2c, this is impossible. Applying the substitution to the initial square doubles its start and period, proving the claim for all such t.

This eliminates a concrete aperiodic growth candidate from first principles. It leaves high-complexity, insufficiently repetitive valuation sequences, sequences without an average, and positive cycles unresolved. No general combinatorial theorem forcing a contradiction in those remaining classes has been established here.
