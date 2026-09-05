---
node_id: RECHARGE-ESCAPE-PROGRESS-2026-09-05
node_type: archive
routes: [B, AB]
tags: [collatz, recharge, guarded-escape, ancestor-formalization]
---

# Mathematical continuation through recharge

This is the historical packet through source3d706a9463b1b95ffb7bb3b9a3475771a63b3b7c.
The [next original-root bridge pass](ORIGINAL_ROOT_BRIDGE_PROGRESS_2026-09-05.md)
updates two-burst formal verification and the residual-cylinder analysis.

## 0. Outcome

The complete uniform residue20 ancestor theorem is now Lean-checked. Three additional prose results give new infinite guarded families: actual descent through an unbounded larger recharge, descent after the q2 exit, and smaller ancestors using a second ternary-depth coordinate. **Universal termination remains unproved.**

This continues [PR17](https://github.com/Sodelin/Collatz-Conjecture-Work/pull/17) from `f2b7fb85298a29869eaaac6b97250d47cb92df1e`, without modifying PR16 or performing publication/upload work. The [previous packet](ROOT_RELATIVE_PROGRESS_2026-09-05.md) remains an explicitly historical snapshot. Canonical claim grades and route states are maintained in their registries.

## 1. Exact map and original-root obligation

Use T(n)=n/2 for even n and (3n+1)/2 for odd n. Let S20={n>0:n≡20 mod27}, and q(n)=v2(n+5). An OOE block is an actual three-step shortcut path. Its formula G(n)=(9n+5)/8 is used only on its legitimate parity cylinder.

Every positive result supplies either a smaller S20 value reached from the original root, or a smaller S20 ancestor whose actual orbit reaches that root. The comparison remains with the initial root throughout. A decrease from a larger intermediate state is insufficient unless the final value is proved smaller than the original root.

## 2. Complete public ancestor theorem, now in Lean

The public theorem is

    ∀r : Nat, 3^13 ∣ (4r+1) →
      ∃m,b : Nat, 0<m ∧ m<r ∧ m%27=20 ∧ T^b(m)=r.

[The trusted statement](lean/CollatzWork/ResidueAncestorStatement.lean) contains no factorization-existence hypothesis or universal termination assumption. [The main proof](lean/CollatzWork/ResidueAncestor.lean) constructs the positive ternary unit factorization, proves the arbitrary-length prefix, selects all residue branches, and proves strict order. [The finite tails](lean/CollatzWork/ResidueAncestorTails.lean) verify actual forward parity semantics and target membership over arbitrary parameters.

The exact arithmetic bound192·2^v<3^v for v≥13 supplies the common margin. Kernel acceptance is [commit eac4dad7](verification/residue_ancestor_ci_2026-09-05.txt), [CI33975504271](https://github.com/Sodelin/Collatz-Conjecture-Work/actions/runs/33975504271), with22 Lake tasks and only propext/Quot.sound in the six new aggregate/headline axiom outputs. Later integrated commits repeat CI.

This promotion concerns the complete uniform ≥13 theorem. The sharper individually guarded lower rows and selected-table sharpness remain separate prose/Python results. It does not provide the guard for arbitrary positive roots.

## 3. New escape through two growing bursts and larger recharge

The [two-burst theorem](proof-search/lemmas/Two_Burst_Recharge_Escape.md) assumes positive k,l,u,v, K=k+l, and

    9^k u+1=2^(3l+1)v, v odd,
    2^K ∣ (3·9^l v−5).

Starting at n=2·8^k u−5, the actual word

    (OOE)^k OE (OOE)^l E^K

reaches m=(3·9^l v−5)/2^K<n in4K+2 steps. The proof compares directly with n by an exact positive margin. It does not infer m<n merely because the last burst descends from its own larger start.

A CRT slice takes k=3+j,l=4+17j. The first recharge raises q from10+3j to12+51j, so both depths and the amount of added recharge are unbounded. The first recharge endpoint and the second burst endpoint exceed n; the forced final even run produces the first crossing below n. Both n and m lie in S20. Bounded extra even padding gives further guarded families at every initial depth q=3k+1, k≥1.

One exact example is:

| Shortcut time | Value | Comparison with original n |
|---:|---:|---|
|0|218,205,150,203|Original root; q=10|
|11|233,014,972,411|Larger; q=12 after recharge|
|23|373,244,930,176|Larger, after the second burst|
|30|2,915,976,017|Strictly smaller, still in S20|

This source is outside the previous single-burst and refined-ancestor guards. Infinitely many CRT translates share that additional coverage. The q10→7→4→10 obstruction remains valid outside the new recharge hypothesis.

## 4. A guarded escape at every q2 depth

The [q2 theorem](proof-search/lemmas/Q2_Exit_Descent.md) assumes k≥0,u≥1,e≥max(2,k+1), and

    2^(e+1) ∣ (27·9^k u−29).

It proves

    r=4·8^k u−5,
    T^(3k+3+e)(r)=(27·9^k u−29)/2^(e+1)<r.

The word is (OOE)^k OOO E^e. The guard forces u≡7 mod8, giving exactly three odd steps at the exit. The k0 positivity/descent boundary is proved separately.

Choosing e≡2 mod18 with bounded padding and imposing an explicit CRT condition gives infinitely many roots r≡20 mod729 and smaller endpoints in S20 at every q=3k+2. Every source is outside the complete earlier selected ancestor guards and the q0 burst family. This covers a guarded family at each depth, not every root with that depth.

For k=1, the exact example is r=115,931, its first return T^4(r)=195,635>r, and the later return T^8(r)=110,045<r. First-return growth is asserted only for k≥1; the k0 family already descends at its first return.

## 5. Another unbounded ancestor family in the other residual branch

The [second-coordinate construction](proof-search/lemmas/Complementary_Ancestor_Cylinders.md) proves that every positive r∈S20 with

    v3(128r−157)≥17

has an explicit positive smaller ancestor in S20. These roots all satisfy v3(r+7)=4 and v3(4r+1)=3, so the whole family is outside the old ancestor selector, including its lower rows.

The new legal inverse prefix is OEOOEOE. It is proved independently; only the finite tail table is reused from the old selector. With the new valuation v and unit u, the prefix followed by odd inverses gives x_h=2^(v−h−4)3^h u−1. The final coefficient is bounded by768(2/3)^v, with a negative intercept. The exact inequality768·2^17<3^17 proves uniform strict order.

For example, m=680,263,616 is a smaller S20 ancestor of r=872,705,009, with T^25(m)=r. Two additional fixed inverse-word cylinders, r≡4529 mod19683 and r≡17813 mod59049, give smaller ancestors in the same residual branch and permit arbitrarily large prescribed q.

The complete new-prefix theorem is not yet Lean-formalized. Reusing a verified finite tail table does not automatically verify a different prefix.

## 6. The exact growing first-return structure

For any r∈S20 with q=q(r)≥4, the first return is at time4, with parities OOEO and residues20,17,26,13,20. Its value y=(27r+23)/16 exceeds r and always satisfies y≡20 mod243, irrespective of the root's original ternary labels.

Writing r+5=2^q u with u odd gives y+5=27·2^(q−4)u−2, hence:

| Initial q | Return depth q(y) |
|---:|---|
|4|0|
|5|1+v2(27u−1), unbounded|
|≥6|1|

This is a proved transition formula, not a ranking function. The q5 boundary is exactly where unbounded recharge remains visible.

## 7. A concrete remaining target

The next source cylinder is

    r=22619+186624s, s≥0,
    r+5=32(707+5832s),
    y=T^4(r)=38171+314928s,
    q(r)=5, q(y)=4+v2(2386+19683s).

The final valuation is unbounded because19683 is odd. Its source has refined-ancestor state(v,theta)=(4,4), so that selected certificate misses it. At k1 the q2 theorem requires u7 mod8; this cylinder has u3 mod8. The q1 and q0 families also do not supply the displayed source guards. This identifies missing coverage, not irreducibility under all possible certificates.

A useful next result would give an actual smaller S20 target or coalescing ancestor on a specified unbounded subcylinder, measured against r before the growing first return. A blanket claim that every residual root eventually escapes would still be the missing global bridge.

## 8. Negative controls and limits

The original q10 growing recharge family remains a control, since its recharged depth is not divisible by3. A separate source can have the correct new recharge depth but fail final exit divisibility; the checker rejects it. The second-coordinate selector has an exact v16 witness where its orbit identity holds but its selected target exceeds the root. These failures prevent dropping the stated guards.

No theorem proves that every residual root enters one of these families. No universal rank, stopping-existence theorem, renewal theorem or cycle exclusion has been added. Root425 remains outside the displayed selectors; that is not a claim that its known finite orbit is problematic.

## 9. Verification ledger

| Result | Accepted evidence |
|---|---|
|Uniform3^13-divisibility ancestor theorem|Complete Lean kernel proof, official pinned-toolchain CI, explicit axiom audit|
|Two-burst recharge escape|Uniform prose proof, independent hostile reconstruction,43 growing+75 general+24 padded replays|
|Q2 exit descent|Uniform prose proof, independent hostile reconstruction,514 CRT+279 general replays|
|Second-coordinate ancestors and first-return structure|Uniform prose proof, independent actual-map checks:2004 fixed-cylinder+581 new-coordinate+3800 first-return and70 exact residual-recharge replays|

Every new checker runs normally and with Python -O using explicit failure checks. The samples test implementation; the prose proofs establish the infinite quantifiers. The [manifest](verification/README.md) links exact commands and retained output. The final integrated head requires its own successful CI run.

## 10. Source and priority scope

These are elementary specializations of classical affine/parity-word, inverse-word and CRT machinery. The earlier [primary-source audit](proof-search/sources/Sufficiency_Rank_Audit_2026-09-05.md) provides background; this continuation did not perform an exhaustive external novelty search. New claims retain N1, with no assertion of priority or peer-reviewed status.

## 11. Process assessment

Constructive derivations, semantic replay, and skeptical review were assigned separately. The main reviews checked exact branch guards, original-root comparison, the k0 boundary, target congruences, and claims of disjointness from earlier selectors. Review corrected an overbroad opening about first-return growth at k0 before integration. Official CI exposed one associative normalization goal in the first formal candidate; the corrected complete public theorem then passed unchanged-toolchain CI.

## 12. Robustness assessment

The proofs permit unbounded numerical parameters, burst lengths and, in the two-burst slice, unbounded larger recharge. They remain conditional family theorems. Successful handling of one recharge mechanism does not invalidate a counterexample to a different rank architecture, nor does accumulating cylinders establish exhaustion. The verified source and full theorem type are retained so formal and prose claims can be reviewed separately.

## 13. Next mathematical and formal targets

The mathematical priority is the explicit q5 recharge cylinder in Section7. The bounded formalization priority is the two-burst original-root margin and its actual orbit composition, followed by the target-set CRT specialization. These have distinct objectives: new coverage versus stronger verification of accepted guarded coverage.

## 14. Handoff

The claim registry owns grades; the approach registry retains global route status; the continuation checkpoint names the exact remaining cylinder. No PR has been merged and no publication action is part of this packet.

## Connections

- **Depends on:** [previous root-relative packet](ROOT_RELATIVE_PROGRESS_2026-09-05.md) and [classical inverse-word semantics](proof-search/lemmas/L4_General_Inverse_Word_Coalescence.md).
- **Strengthens / specializes:** [uniform ancestor proof](proof-search/lemmas/Residue20_Refined_Ancestor.md), now formalized end to end.
- **Verified by:** [formal scope](LEAN_TARGETS.md), [CI evidence](verification/residue_ancestor_ci_2026-09-05.txt), and [verification manifest](verification/README.md).
- **Parallel to:** [scoped recharge obstruction](proof-search/routes/AC_shadow_debt_recharge.md).
- **Next:** [continuation checkpoint](CONTINUATION.md).
