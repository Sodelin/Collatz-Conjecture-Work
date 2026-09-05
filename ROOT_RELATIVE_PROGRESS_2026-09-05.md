---
node_id: ROOT-RELATIVE-PROGRESS-2026-09-05
node_type: archive
routes: [B, AB]
tags: [collatz, constructive-families, exact-descent, formalization]
---

# Root-relative mathematical continuation

## 0. Outcome

Two complementary infinite families now have explicit strict certificates against the original root. A third result proves that simply adding OOE shadow depth does not rescue the audited polynomial rank. **Universal termination remains unproved.**

This packet continues PR16 at `33922a42e86646258d227d1e19c6cf7546a2f548` on the isolated branch `astra/root-relative-progress-2026-09-05`, [PR17](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/17). The original PR16 branch was not changed. Publication/upload work is outside this mathematical packet.

## 1. Map and logical obligation

Use the positive shortcut map T(n)=n/2 for even n and (3n+1)/2 for odd n. Let S20 be the positive integers congruent to20 modulo27. In a least-nonconvergent-S20 argument, either of the following discharges a particular root r:

- a positive m<r in S20 reached by a finite actual orbit from r; or
- a positive m<r in S20 whose finite actual orbit reaches r.

Both transfer convergence from a smaller S20 value. The comparison must be with r itself. Returning from a larger intermediate value to r is not strict progress. Here S20 denotes a set; the letter S in the recharge note denotes the earlier stronger-core return map, a different object.

## 2. New positive family: smaller ancestors at high ternary valuation

Every positive r in S20 with v3(4r+1)≥13 has an explicit m in S20 satisfying

    0<m<r,  T^b(m)=r.

The [complete refined proof](proof-search/lemmas/Residue20_Refined_Ancestor.md) first consumes a variable-length exact inverse prefix, then chooses a short tail from an exhaustive residue table. Writing v=v3(4r+1), the largest coefficient is bounded by192(2/3)^v. The exact inequality192·2^13<3^13, together with a negative affine offset, gives the uniform strict comparison for unbounded v and unbounded positive unit parameter. No finite replay cutoff appears in this proof.

All these roots have v3(r+7)=3, so the older internal c-normalizer does not already remove them. For example,

    r=41,053,817,  m=2,531,324,  T^15(m)=r.

The old first-return/c-normalization composition sends this r back to itself. The new certificate compares a separate smaller ancestor directly with r.

The [simpler six-row construction](proof-search/lemmas/Residue20_Valuation_Ancestor.md) is retained with its uniform valuation21 threshold. The refinement repairs its exact failing v20 selector by changing the inverse tail.

## 3. Complementary positive family: a later return after a growing burst

Lean proves, for all positive k,u,m with2^k m+5=9^k u,

    T^(4k)(8^k u−5)=m<8^k u−5.

The actual path is k OOE blocks followed by k even steps. The [CRT specialization](proof-search/lemmas/Root_Relative_Burst_Descent.md) takes k=7+18j and chooses positive u with

    u≡5·(9^k)^(-1) mod2^k,
    u≡25·(8^k)^(-1) mod243.

It yields infinitely many roots n≡20 mod243 and smaller endpoints m≡20 mod27 for every such k. These roots have exactly v3(4n+1)=4 and v3(n+7)=3. Thus this adds low-valuation coverage; it does not merely repackage the high-valuation theorem.

For k=7,u=749,

    n=1,570,766,843,  m=27,987,842,  T^28(n)=m<n.

This n is outside the full guarded refined ancestor table. Its first return to S20 is at time4 and is larger than n. The later return at time28 decreases below n. Both burst length and parameter size are unbounded in the theorem.

## 4. Negative result: shadow depth can recharge while the root grows

The exact depth q(n)=v2(n+5) falls by three on each legitimate OOE macro. This does not make it a global rank. For every t≥0, set u=6807+12288t. Then the specified stronger-core return map satisfies

    n=1024u−5,
    S^3(n)=T^11(n)=(2187u−7)/2>n,
    q: 10 → 7 → 4 → 10.

The [proof and independent replay](proof-search/routes/AC_shadow_debt_recharge.md) retain the exact endpoint labels and rule priority. This excludes the stated lower-bounded label-dependent polynomial size/bitlength ranks, including coordinatewise lower-bounded finite lex tuples, even with q added to those labels. It does not exclude arbitrary additional valuations, history, nonpolynomial ranks, or smaller-target strategies.

## 5. Exact formalization boundary

| Result | Evidence accepted | Not included in that evidence |
|---|---|---|
| Arbitrary OOE burst identity and guarded strict descent | Lean kernel, with explicit trusted statements | Universal existence of the divisibility guard |
| Generic ancestor orbit identity | Lean kernel | Residue selector, target size and full finite inverse-tail proof |
| Refined valuation13 and simple valuation21 families | Uniform prose proofs, independent hostile review, exact Python replay | Full Lean formalization or external specialist review |
| CRT residue20 specialization | Prose CRT/congruence proof and actual forward replay | Lean CRT specialization |
| Recharge family and polynomial consequence | Prose proof and independent exact core-map replay | General no-go for all possible ranks |

Initial exact-head commit54cb390bf7a0887a3613a1cc6d2a0ed9663f2fd4 passed [run33973663173](https://github.com/Sodelin/Collatz-Conjecture-Work/actions/runs/33973663173), all19 Lake tasks, using the unchanged official Lean4.33.1 release. [Retained axiom evidence](verification/root_descent_ci_initial_2026-09-05.txt) lists only propext, Quot.sound, and where used Classical.choice. There is no sorryAx or project-specific axiom in the new theorem dependencies. Subsequent packet commits repeat the exact-head workflow; inspect the PR's current run for final revision status.

## 6. What remains unproved

A hypothetical least nonconvergent S20 root must satisfy

    v3(r+7)∈{3,4},  v3(4r+1)≤12,

and avoid individually covered lower-valuation rows and the guarded burst families. This is still an infinite set. There is no theorem that all its roots eventually reach one of the new families, no total return rank, no universal root-relative coalescence certificate, and no proof eliminating infinite coefficient stopping or the zero-gap cycle branch.

Root425 is deliberately left uncertified by the displayed ancestor selector. Its exclusion from that selector is not a claim that it lacks every smaller certificate or fails to converge.

## 7. Counterexamples retained as acceptance tests

- At v12,u13, the prescribed refined selector produces2,555,840>1,727,183 while its orbit identity remains correct. Threshold13 is sharp for this selector, not every inverse strategy.
- The old auxiliary return/c loop remains an exact loop on its stated infinite family; the new certificate bypasses it only for covered members.
- The growing q10→7→4→10 core family blocks an unjustified monotonicity claim.
- Increasing first returns occur within the successful burst family; first-return descent cannot be assumed even there.

## 8. Source and novelty boundary

The constructions use classical parity-word, inverse-word and Mersenne-prefix machinery. [The existing primary-source sufficiency audit](proof-search/sources/Sufficiency_Rank_Audit_2026-09-05.md) and [claim registry](proof-search/CLAIM_REGISTRY.md) retain source roles. These exact project specializations are graded N1, not claimed as externally novel. This pass was a constructive proof/replay audit, not an exhaustive literature or priority search.

## 9. Changed proof-search direction

The work moves from naming an additional coordinate to constructing a smaller target with full path semantics. The high-valuation selector consumes unbounded ternary structure, and the burst theorem tolerates an arbitrarily long growing excursion before a proved descent. The negative result identifies where an apparently decreasing coordinate fails across the exit. No universal route status changes.

## 10. Reproduction

Run `lake build` and the four commands in the [verification manifest](verification/README.md). The workflow also executes the four new Python checks under optimization so assertions cannot silently erase their acceptance conditions. Independent replayers compute actual T steps rather than importing the candidate affine or baseline core-map implementation.

## 11. Process assessment

Separate reviewers reconstructed the high-valuation selector, inverse-word orientation, unchanged-root inequality, least-bad-root implication, CRT membership and recharge semantics. The initial Lean acceptance came from the standard CI runner. A scratch-only local path diagnostic was not used as acceptance and is absent from this repository. The formal statements and prose scope were checked separately.

## 12. Robustness assessment

The universal claims in this packet concern guarded infinite families and follow from algebraic proofs. Samples stress the implementation at large valuations and large integer parameters; they do not prove the infinite quantifiers. Every removed guard has a retained boundary or a stated missing obligation. The valuation13 theorem is the strongest current ancestor-selector claim; valuation21 is its simpler predecessor.

## 13. Highest-value next target

Prove a recharge-or-escape lemma on a growing-return cylinder within the remaining c-normal, bounded-ternary-valuation class. A useful result must either produce a smaller S20 coalescing target relative to the original root, or prove decrease of a justified unbounded measure across the complete excursion. It should handle a new infinite cylinder rather than enlarge a replay bound. The successful burst family and the q-recharge obstruction provide positive and negative controls.

Formalizing the finite refined tail table is a bounded verification task in parallel. It would strengthen confidence in the new family theorem while leaving the residual mathematical bridge open.

## 14. Handoff

The canonical claim registry and continuation checkpoint carry the new scope and next proof obligations.

## Connections

- **Depends on:** [inverse-word semantics](proof-search/lemmas/L4_General_Inverse_Word_Coalescence.md) and [convergence/coalescence criteria](lean/CollatzWork/Convergence.lean).
- **Strengthens / specializes:** [previous core/return audit](proof-search/routes/AB_ternary_normalized_core_residue_obstruction.md).
- **Verified by:** [manifest](verification/README.md), [formal targets](LEAN_TARGETS.md), and [initial exact CI evidence](verification/root_descent_ci_initial_2026-09-05.txt).
- **Blocked by:** [remaining route obligations](proof-search/APPROACH_REGISTRY.md) and [recharge obstruction](proof-search/routes/AC_shadow_debt_recharge.md).
- **Next:** [continuation checkpoint](CONTINUATION.md).
