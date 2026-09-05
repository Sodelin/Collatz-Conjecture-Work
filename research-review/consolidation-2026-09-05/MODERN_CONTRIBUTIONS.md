# PR17 and PR20 consolidation audit — 2026-09-05

## Verdict

Both contributions can be consolidated while preserving their present proof boundaries. I found no blocking mathematical flaw in the reconstructed statements below. PR17 contributes guarded infinite families and limitations of bounded search; PR20 contributes finite Lean components and an analytic Thue–Morse realization exclusion. Neither closes universal termination. No external novelty conclusion is made by this audit.

The parent integration should retain the latest PR17 content, then merge PR20's genuine additions. Replacing PR17 by PR20's tree would silently discard the two-burst Lean proof and the four newest residual-cylinder results.

## Frozen inputs

| Input | Exact revision | Role |
|---|---|---|
| PR16 | `33922a42e86646258d227d1e19c6cf7546a2f548` | Common earlier mathematics |
| PR17 | `1f627c6e87f18c491cfd23dcd2c6847b13fd8364` | Latest guarded-descent and residual analysis |
| PR20 | `991e41b12bfe38ad1f33589a4beec0678c4f9756` | Recurrence/Thue–Morse addition |
| PR20 parent | `3d706a9463b1b95ffb7bb3b9a3475771a63b3b7c` | Older PR17 continuation, before latest four results and TwoBurst proof |

Read-only source inspection used separate detached worktrees `modern-audit-pr17` and `modern-audit-pr20`. No shared integration files were edited.

## PR17: actual mathematical delta

Let `T` denote the actual shortcut map: even inputs halve, odd inputs map to `(3n+1)/2`. Let `S20` denote positive inputs congruent to20 modulo27. All comparisons below use the unchanged starting root.

| Contribution | Verified scope | Consolidation decision |
|---|---|---|
| OOE burst descent | For positive k,u,m with `2^k*m+5=9^k*u`, actual time4k sends `8^k*u−5` to positive m below that root. Lean also proves the arbitrary burst identity and an ancestor identity with separate guard. | Retain as a formal auxiliary result. Do not fold the prose residue/CRT specialization into Lean status. |
| Refined residue20 ancestors | `3^13 | 4r+1` implies a positive m<r in S20 with an actual finite orbit reaching r. The public Lean theorem constructs factorization and covers the finite selector itself. | Supersedes uniform threshold21. Lower guarded rows and selected-table sharpness still have prose/Python status. |
| Shadow-debt recharge | A growing stronger-core path resets q from10 through7,4 to10, defeating its stated polynomial/finite-lex ranks. | Retain as a restricted-method obstruction, not a failure of every rank. |
| Two growing bursts | Positive k,l,u,v,m and equations `9^k*u+1=2^(3*l+1)*v`, `2^(k+l)*m+5=3*9^l*v` imply actual time `4*(k+l)+2` sends `2*8^k*u−5` to m below the original root. | Latest PR17 upgrades this complete guarded theorem to Lean. Keep CRT, exact valuation labels, and padding at their narrower prose scope. |
| Q2 exit | For k>=0 and e>=max(2,k+1), divisibility by `2^(e+1)` of `27*9^k*u−29` licenses `(OOE)^k OOO E^e` and strict descent. | Prose proof plus exact replay. First-return growth requires k>=1; k=0 is handled separately. |
| Complementary ancestor | Every S20 root with `v3(128r−157)>=17` has a smaller S20 ancestor; exact inverse prefix is OEOOEOE. | Prose, not Lean: reusing previously formalized tails does not formalize the different prefix. Two fixed cylinders and first-return transitions have their own scopes. |
| Finite growing spell | Exactly `floor(v2(11r+23)/4)` consecutive OOEO first returns occur, with final q equal to the valuation remainder modulo4. Every positive-time state in that spell exceeds the original root. | Retain as local itinerary termination. No rank across later excursion/re-entry follows. |
| Bounded ancestor/forward cover obstruction | At arbitrary independent finite forward/ancestor time bounds, infinitely many roots in `22619+186624s` avoid both those exact smaller-target certificates. | Retain the simultaneous CRT claim. It does not address arbitrary mixed coalescence or macros with unbounded lengths. |
| Postspell odd growth | At each fixed spell length J>=2 and q2 exit, the following exact odd-run length H>=3 is independently unbounded. | Retain. It excludes recovery bounds depending only on J and q2, not recovery depending on H/full root. |
| Postspell compensation | Actual `(OOEO)^J O^H E^e`, r>3, J>=2, H>=3 and e>=J+H reaches positive m<r. CRT supplies S20-to-S20 infinite subfamilies for each independent J,H. | Retain as guarded prose theorem. The final halving assumption has a nonempty infinite failing complement. |

The postspell margin reconstructs directly: the endpoint satisfies `m < (27/32)^J*(3/4)^H*(r+3) <= (19683/65536)*(r+3) < r`. The ancestor obstruction reconstructs by transferring the same inverse word to anchor20 or47 using a ternary perturbation divisible by27 at every inverse prefix; the nonpositive affine intercept then forces the transferred word's slope to be at least one. Neither argument assumes an orbit has universally bounded duration.

## PR20: genuine additions and duplicates

| Contribution | Exact scope | Decision |
|---|---|---|
| Descent iff convergence, growing `(1,2)` family, inverse smaller ancestors | Already represented by Convergence, RootDescent, and general inverse-word machinery. Exact odd `(1,2)` endpoint requires stronger parity guard than an OOE burst endpoint. | Preserve independent record; do not count these as separate new global theorems. |
| Prefix collision | Equal k actual shortcut parity bits imply equal residues mod2^k; distinct starts differ by at least2^k. | New project Lean module; elementary parity arithmetic, not externally novel by default. |
| Fixed affine repetition | Coprime fixed-ratio recurrence consumes powers of the denominator from a positive shifted initial height. Also proves the conditional inequality `2*32^d<27^d*(n+1) => 10*d+27<27*n`. | New project Lean module. Does not establish the same budget when the affine block changes. |
| Fixed binary Thue–Morse valuation morphism | If nonempty fixed positive valuation words B0,B1 in Thue–Morse order are realized by a positive odd start N, then N lies on a cycle. The `(1),(2)` anchor and fixed `(1^p,3)/(1^q,3)` with p,q>=3 are not positively realized. | Retain as analytic theorem with finite checks, not an end-to-end Lean theorem. Resolves the specific PR6 positive membership gate. Historical novelty remains N?. |

The recurrence proof was reconstructed rather than inferred from its tests. Equal exact odd valuation words of lengthL and valuation sumS force residues modulo `2^(S+1)` because the terminal odd state contributes the extra bit. At a distinct-state prefix return at timeJ, positivity and the height bound give `2^(S+1) < (3/2)^J*(N+1)`. Thue–Morse's balanced return identity produces L=2d and J=3d for arbitrarily large d, even when the two codewords have unequal lengths. With S>=L this gives the stated exponential inequality, impossible for fixed N at unbounded d. The cycle exception is essential: B0=B1=(2), N=1 realizes it. The two excluded subclasses have strict growth at those block boundaries, ruling out their cycle exception.

The full acceleration/valuation-to-parity bridge, height estimate, and substitution coding are analytic. The compiled `prefixReturnNumericalBound` only proves the numerical implication after its exponential premise has been supplied. This distinction must remain explicit in the consolidated abstract and VibeMathed export.

## Merge conflicts and exact integration choices

`git merge-tree --write-tree PR17 PR20` reports eight conflicting files:

1. `ATLAS.md`
2. `CONTINUATION.md`
3. `LEAN_TARGETS.md`
4. `lean/CollatzWork.lean`
5. `proof-search/APPROACH_REGISTRY.md`
6. `proof-search/CLAIM_REGISTRY.md`
7. `proof-search/FAILURE_LEDGER.md`
8. `verification/README.md`

Resolve the registries by preserving all nonduplicate rows from both branches, retaining latest PR17 TwoBurst C3/V3 status. Resolve the aggregate imports by retaining `RootDescent`, `ResidueAncestor`, `TwoBurst` and adding `PrefixCollision`, `AffineRepetition`. Combine the verification sections. Update stale literal module counts (PR17 still says twelve in one claim-registry sentence) to an exact final inventory or simply “current proof modules.” Historical progress packets should remain labeled as historical; a new consolidation checkpoint should be canonical.

The workflow merges automatically and retains both additions in the merge-tree result. Nevertheless, explicitly check its eleven PR17 checker names and the PR20 recurrence/archive commands before accepting integration.

## Fresh arithmetic replay

The following11 PR17 checkers each passed twice, once normally and once with `python3 -O -B`: `residue20_valuation_inverse_check`, `residue20_refined_ancestor_check`, `root_burst_descent_check`, `check_shadow_debt_recharge`, `q2_exit_descent_check`, `two_burst_recharge_escape_check`, `complementary_ancestor_check`, `finite_first_return_spell_check`, `bounded_ancestor_depth_check`, `postspell_odd_run_check`, `postspell_guarded_descent_check`.

PR20 `blind_word_recurrence_check` also passed normally and optimized:136000 exact repetition comparisons,120 expanding family cases,40 coding identities,24 seeded hard-prefix cases,33 noncycle returns,20 cycle controls,4 rejected false controls. All24 checker executions returned zero. These finite executions validate implementation and controls, not the infinite quantifiers.

No `lean` or `lake` executable was on this subagent's PATH. This subagent therefore makes no claim to have freshly compiled Lean. The parent should run the unchanged pinned official release on the final integration SHA. Earlier retained CI/log evidence is useful provenance but must not substitute for the final build.

## Publication integration requirements

The existing publication manifest covers only PR16. Add these modern entries, their source paths, and exact Lean declarations to the export and axiom audit. `modern-proposed-claims.json` supplies compatible suggested records. Add all12 fresh arithmetic checkers above to the publication verification command set. Compile the three archived standalone Lean derivations (`Descent.lean`, `AlternatingGrowth.lean`, `RepetitionBound.lean`) as distinct archival scope. Audit the new public declarations in RootDescent, ResidueAncestor, TwoBurst, PrefixCollision, and AffineRepetition.

A consolidated research release may honestly share all of these contributions with their exact statuses now. A venue entry must still identify a single intelligible claimed advance and preserve novelty uncertainty; assembling more correct auxiliary results does not itself prove the venue's previously-open-question requirement. The Thue–Morse exclusion is a candidate for its own focused novelty/statement review. The separate YAH obstruction should be handled independently from this audit, as requested by the user.

## Remaining mathematical obligations

The residue20 route still needs coverage of arbitrary roots, failed final-halving guards, and later re-entry measured against the original root. The recurrence route does not show all hypothetical divergent valuation words have the required long early prefix returns and does not eliminate unknown positive cycles. The quarter-gap route retains its previously documented first-contraction and global renewal/descent obligations. The consolidation should finish integration and publication packaging while recording these as research limits rather than pretending they are release-engineering failures.
