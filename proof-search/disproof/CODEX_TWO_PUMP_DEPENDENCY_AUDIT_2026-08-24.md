# Two-pump cyclic-elimination dependency audit

**Status: exact route-design obstruction; not a proof or disproof of the
Collatz conjecture. No positive nontrivial cycle or divergent positive orbit is
produced.**

Date: 2026-08-24 (America/Los_Angeles)

## 1. Macro convention

Write four fixed nonempty accelerated-Collatz word macros as

    F_U(x) = (a x+b)/c,       F_V(x) = (p x+e)/q,
    F_W(x) = (d x+f)/g,       F_Z(x) = (h x+ell)/t,

where execution is left to right. For genuine valuation words, the letter
multipliers `a,p,d,h` are powers of three and the denominators `c,q,g,t` are
powers of two. The algebra below is proved over arbitrary integers, so it does
not rely on positivity or Collatz-specific specializations.

Set

    dv = q-p,      dz = t-h,
    G_r = (q^r-p^r)/dv,      H_s = (t^s-h^s)/dz.

The divisions are exact geometric sums because the macros are nonempty and a
power of two cannot equal a positive power of three.

## 2. First determinant coefficient pair

The context `U V^r W` has exact affine data

    alpha_r = a d p^r,
    beta_r  = d b p^r + c d e G_r + c f q^r,
    gamma_r = c g q^r.

Treating `Z` as the repeated final pump gives the standard one-pump
fixed-point determinant

    K_r = dz beta_r - (gamma_r-alpha_r) ell.

Multiplying by `dv` and substituting `dv G_r=q^r-p^r` gives, term by term,

    dv K_r = A p^r+B q^r,

where

    A = dz(d b dv-c d e)+dv a d ell,
    B = dz(c d e+c f dv)-dv c g ell.                  (1)

This is theorem `firstRotatedDeterminantCoefficients` in the Lean module.

## 3. Rotated determinant coefficient pair

Cyclically rotate the same word to `W Z^s U V^r`. The context before the
final `V^r` has

    alpha_s = a d h^s,
    beta_s  = a f h^s + a g ell H_s + b g t^s,
    gamma_s = c g t^s.

Its one-pump determinant is

    L_s = dv beta_s - (gamma_s-alpha_s)e.

Multiplying by `dz` and substituting `dz H_s=t^s-h^s` gives

    dz L_s = C h^s+E t^s,

where

    C = dv(a f dz-a g ell)+dz a d e,
    E = dv(a g ell+b g dz)-dz c g e.                  (2)

This is theorem `secondRotatedDeterminantCoefficients` in Lean. Thus the
committed `A,B,C,E` are proved to be exactly the two rotated determinant
coefficient pairs; they are not merely definitions chosen after the fact.

## 4. Why the hoped constant obstruction vanishes

The total fixed-point denominator for `U V^r W Z^s` is

    D = c g q^r t^s-a d p^r h^s.

If a positive integral cycle candidate exists, the ordinary one-pump identity
and the facts `gcd(D,p)=gcd(D,h)=1` imply the necessary congruences

    D | P_r := A p^r+B q^r,
    D | Q_s := C h^s+E t^s.

The proposed elimination was to combine these with `D` and obtain the constant

    O = c g A C-a d B E.

However, direct expansion of (1) and (2) gives the stronger universal
dependencies

    a B = c C,             g A = d E.                 (3)

For clarity, both identities can be seen without a full polynomial expansion.
With

    S = dz(d e+f dv)-dv g ell,
    T = dz(b dv-c e)+dv a ell,

the four coefficients factor as

    B=cS,   C=aS,   A=dT,   E=gT.

Therefore

    c g A C = (gA)(cC) = (dE)(aB) = a d B E,

and hence

    O = 0                                                        (4)

for every integer choice of the macro coefficients.

The exact syzygy formalized in Lean is

    B E D-c g P_r Q_s+c g C h^s P_r+c g A p^r Q_s = 0.          (5)

Equation (5) shows that the attempted resultant is an algebraic dependency
among `D,P_r,Q_s`, not an additional constraint. Cyclic rotation alone cannot
turn the two-pump integrality condition into a nonzero constant divisor.

## 5. Concrete checks and scope

The actual macros

    U=(3,1,2),   V=W=(3,1,4),   Z=(3,1,8)

give

    (A,B,C,E)=(-6,32,48,-8),

so `aB=cC`, `gA=dE`, and `O=0` exactly.

The stronger tautology family `U=V=W=Z=(3,1,4)` has
`A=B=C=E=0`, while

    D = 4^(r+s+2)-3^(r+s+2) > 0

is unbounded. Its cycle candidate is only the trivial fixed point `x=1`, but
it proves that no bound on `D` can be recovered from these rotations.

This audit kills only the proposed cyclic constant-resultant mechanism. It
does not decide `D | N_{r,s}` by exponent-specific arithmetic, does not exclude
all two-counter word languages, and is not evidence for or against the Collatz
conjecture itself.

## 6. Prior-art classification

No novelty claim is made. The fixed-word affine equation is classical
Böhm–Sontacchi algebra, and Trümper explicitly develops concatenation, powers,
cycle functions, and commutator identities in the Collatz-word semigroup.
The present identity is best classified as an implementation-specific route
audit and an elementary specialization of that established algebra.

Primary-source checkpoints:

- C. Böhm and G. Sontacchi, fixed branch-schedule cycle equations:
  https://www.bdim.eu/item?id=RLINA_1978_8_64_3_260_0
- M. Trümper, *The Collatz Problem in the Light of an Infinite Free
  Semigroup*, DOI 10.1155/2014/756917:
  https://doi.org/10.1155/2014/756917
- J. L. Simons, nonexistence of positive two-local-minimum cycles:
  https://doi.org/10.1090/S0025-5718-04-01728-4
- T. Brox, finiteness for cycles with sufficiently few descents:
  https://doi.org/10.4064/aa-92-2-181-188
- C. Hercher, exclusion of nontrivial `m`-cycles for `m<=91`:
  https://cs.uwaterloo.ca/journals/JIS/VOL26/Hercher/hercher5.html

These sources also show why homogeneous one- and two-run pump families, or
families with few local minima, must not be presented as new search spaces.

## 7. Reproduction

From the repository root with Lean 4.33.1:

    C:\Users\Owner\.elan\bin\lake.exe env lean lean/CollatzWork/Disproof/TwoPumpDependency.lean
    C:\Users\Owner\.elan\bin\lake.exe build

The module prints the axiom dependencies of all five theorems. None uses
`sorryAx`; only Lean's standard `propext` and `Quot.sound` appear.

## Connections

- **Blocks:** cyclic-rotation-only two-pump elimination in the [failure ledger](../FAILURE_LEDGER.md).
- **Formalized by:** the two-pump module listed in [Lean targets](../../LEAN_TARGETS.md).
- **Verified by:** [reproduction manifest](../../verification/README.md).
- **Does not close:** the positive-cycle lane in the [approach registry](../APPROACH_REGISTRY.md).
