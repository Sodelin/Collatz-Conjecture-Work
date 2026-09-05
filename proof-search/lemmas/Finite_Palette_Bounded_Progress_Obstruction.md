---
node_id: BLIND-PALETTE-001
node_type: lemma
tags: [collatz, termination, method-obstruction, finite-palette, lean]
---

# Finite palettes cannot guarantee bounded-time ranking progress

**Verdict:** a rigorous obstruction to one proof architecture. This does not
prove or disprove the Collatz conjecture. The natural-valued main statement
has a separate trusted Lean statement and a source proof. Ordered-value and
polynomial extensions below are prose proofs with explicitly separate scope.

## Statement and map convention

Use the one-division shortcut map

\[
 U(n)=\begin{cases}n/2&n\text{ even},\\(3n+1)/2&n\text{ odd}.\end{cases}
\]

Let \(f_1,\ldots,f_r\), \(r\ge1\), be functions into a linearly ordered set,
each nondecreasing on the integers above a common threshold \(A\). Let
\(V(n)=f_{\sigma(n)}(n)\) there, where the selector \(\sigma\) is arbitrary.
It need not be periodic, residue-based, or computable.

**Theorem.** For every fixed positive integer \(H\) and every lower bound
\(B\), there is a positive integer \(n\ge B\) such that

\[
 V(U^h(n))\ge V(n)\qquad(1\le h\le H).
\]

Equivalently, such a rank cannot supply a strict decrease somewhere within
the next \(H\) shortcut steps for every sufficiently large starting integer.
Intermediate increases are allowed by the property that is ruled out.

The [trusted statement](../../lean/CollatzWork/FinitePaletteObstructionStatement.lean)
formalizes the natural-valued specialization, with separate monotonicity and
progress thresholds. It allows every natural \(H\), including the vacuous
zero-horizon boundary. The general ordered codomain is justified by the prose
proof, not by silently widening the formal theorem's type.

## Proof

For \(L\ge1\), \(m\ge1\), set \(n_0=2^L m-1\). Direct induction gives

\[
 n_j=U^j(n_0)=3^j2^{L-j}m-1\quad(0\le j\le L).
\]

For \(j<L\), \(n_j\) is odd and
\(n_{j+1}-n_j=3^j2^{L-j-1}m>0\). Thus this entire finite prefix strictly
increases. This is the classical forced-growth identity already present in
the repository's `oddRun` theorem; it is not a new infinite-orbit claim.

Take \(L=rH\) and choose \(m\) so that
\(n_0\ge\max(A,B,1)\). Starting at index \(j_0=0\), inspect the next
\(H\) ranks. If none is smaller, the current integer is the desired witness.
Otherwise choose a position \(j_1\in[j_0+1,j_0+H]\) with a smaller rank,
and repeat.

If there were \(r\) successful selections, there would be \(r+1\) selected
arguments with strictly decreasing ranks. Two selections use the same palette
function by the pigeonhole principle. Their numerical arguments increase, so
that function's nondecrease contradicts the strict rank decrease.

The procedure therefore stops after at most \(r-1\) successful selections.
Its final position is at most \((r-1)H\), so its complete last lookahead
lies within the constructed \(rH\)-step prefix. All arguments exceed both
thresholds. This proves the theorem. For computable ranks and decidable
comparisons, it also gives a witness search using at most \(rH\) comparisons.

## Polynomial corollary — prose scope

Suppose \(p_1,\ldots,p_r\) are real polynomials and the actual selected
rank \(V(n)\) is nonnegative for all sufficiently large integers, with
\(V(n)\in\{p_1(n),\ldots,p_r(n)\}\). No fixed \(H\) provides universal
bounded-time strict progress.

Every negative-leading polynomial is negative beyond some threshold and hence
cannot be selected there. Discard those pieces and any negative constants.
Every remaining nonconstant polynomial has positive leading coefficient and
is eventually increasing; constants are nondecreasing. At least one piece
remains because the actual rank is defined and nonnegative everywhere on the
tail. A common threshold exists because the palette is finite. Apply the
theorem. This permits arbitrary selection among the polynomials; requiring
each polynomial to be nonnegative everywhere would be unnecessarily strong.

This includes finite residue-dependent affine/polynomial ranks and fixed finite
lookup-table corrections to such ranks. Eventual monotonicity is essential:
the proof does not apply to every nonlinear or arithmetic ranking function.

## Exact diagnostic example

Take \(r=3\), \(H=4\), pieces \(100n,10n,n\), and selector
\(\sigma(n)=(n\bmod7)\bmod3\). A rising orbit can initially decrease the
selected rank by switching pieces:

| Shortcut position | Integer | Piece | Rank |
|---:|---:|---|---:|
| 0 | 4095 | \(100n\) | 409500 |
| 1 | 6143 | \(10n\) | 61430 |
| 3 | 13823 | \(n\) | 13823 |

At 13823, the next four ranks are 207350, 31103, 4665500, and 699830. None is
smaller than 13823. Palette switching can create some decreases during numeric
growth, but it cannot keep doing so with uniformly bounded waiting time.

The standard-library [checker](../../verification/finite_palette_obstruction.py)
independently reconstructs 384 forced-growth traces, exhausts 2,438 selector
assignments on small traces, checks 48 delayed-switch examples, and rejects four
malformed finite certificates. It also verifies the example above. These are
finite implementation diagnostics; the proof supplies the universal result.

## Exact boundary of the Lean result

The [solution](../../lean/CollatzWork/FinitePaletteObstruction.lean) reuses the
existing `shortcutIter`, `oddRun`, and standard map definition. It proves:

1. a generic finite-palette obstruction on a nondecreasing finite path;
2. a nondecreasing forced-growth shortcut prefix for arbitrary length;
3. the full natural-valued bounded-horizon obstruction with arbitrary selector.

The final type comparison checks the exported theorem against the separate
trusted proposition. The recorded axiom footprint is limited to the standard
Lean dependencies `propext`, `Classical.choice`, and `Quot.sound`. There are no
project mathematical axioms or omitted proofs. There is no independent kernel
implementation replay in this pass; a clean source build and CI replay use
the pinned Lean kernel. See the [verification record](../../verification/README.md).

This development does not formalize real polynomials, the ordered-codomain
generalization, the original two-operation Collatz map, or the odd fully
accelerated map. The formal map is exactly the stated one-division shortcut.

## Delta against existing work

The blind derivation was frozen before reading repository mathematics. It used
first-principles reasoning and exact calculations, but the agents retain
pretrained knowledge and the conversation's project summaries. This is an
independent attempt, not a claim of zero prior exposure.

The comparison used main `a3d99ab909992bf72e6e2e0907cb8d50248fa1b8` and the
inspected PR heads #1, #6, #8, #12, #13, #14, #16, and #17.

- [F008](../FAILURE_LEDGER.md#f008--finite-depth-residue-tree) already rules out
  uniformly bounded **integer** descent covers. The new result permits rank
  decreases via arbitrary switching among a finite palette.
- [PR #16](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/16) already
  has frozen-label and finite-residue return-rank obstructions. The new theorem
  needs no periodic labeling hypothesis. It does not subsume all those results:
  their hard-return edges can consume unboundedly many shortcut steps.
- [PR #17](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/17) supplies
  root-relative progress certificates and a shadow-debt recharge obstruction.
  This theorem neither replaces those certificates nor supplies the missing
  global bound.

Another blind candidate, the valuation word \((2,1^{k-1})\) with expanding
first returns to \(1\bmod4\), substantially overlapped Round 6A and PR #16.
It was retained only as an optional symbolic smoke fixture. It is not promoted
as a newly discovered Collatz mechanism.

No external literature novelty audit was performed, preserving the requested
blind-attempt scope. Repository-relative addition does not establish publication
priority or global mathematical novelty.

## Failed universal bridge and next mathematical target

The attempted bridge was to construct a proper finite piecewise-polynomial
rank with bounded waiting time for progress. The theorem closes that class.
It does not close universal termination. Useful reopening conditions include
unbounded progress horizons or functions whose arithmetic dependence is not
eventually monotone. Neither condition alone proves that a replacement works.

The next targeted question is whether an existing root-relative progress
certificate can control an **unbounded** waiting time while surviving the
documented recharge examples. A new proposal must state that deterministic
bound; random-residue average drift does not supply it.

## 11. Process-integrity assessment

Direct proof, independent hostile review, exact regression, and Lean checking
agree on the natural-valued statement. No systematic literature search was
attempted, so novelty remains unknown. The initial expansive-return candidate
was downgraded after repository comparison. PRISMA, AMSTAR-2, and trial-level
risk-of-bias scoring do not apply to this deductive artifact. The material
remaining process gaps are external specialist review and independent-kernel
replay. Process verdict: internally checked, externally unreviewed.

## 12. Inference-robustness assessment

The proof is a finite deterministic contradiction. Its validity does not depend
on empirical effect sizes, random-orbit assumptions, or how many examples were
tested. Statistical heterogeneity and meta-analysis are inapplicable. The
conclusion depends on a finite palette, eventual nondecrease of its pieces,
and a uniform finite progress horizon. Removing either finiteness or that
monotonicity assumption leaves the argument inapplicable. No claim about all
possible Lyapunov functions or Collatz truth follows. Robustness verdict:
strong within the exact theorem, no universal-termination inference.

## Connections

- **Depends on:** [refined Mersenne identity and scope](L13_Refined_Mersenne_Child_Macros.md).
- **Strengthens / specializes:** [bounded direct-descent obstruction F008](../FAILURE_LEDGER.md#f008--finite-depth-residue-tree).
- **Verified by:** [verification manifest](../../verification/README.md).
- **Formalized by / pending:** [Lean boundary](../../LEAN_TARGETS.md).
- **Parallel to:** [hard-return system](../routes/AB_hard_boundary_return_system.md).
- **Depends on:** [free math tool setup](../../docs/MATH_TOOL_SETUP.md).
