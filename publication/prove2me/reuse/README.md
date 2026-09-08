# Community Collatz facts prepared for reuse

Fetched read-only from Prove2Me on 2026-09-08. These files preserve public community work with attribution; they are **not incorporated into our Lean library or the active upload packages**. The server reports both theorems `Proved`, with the saved solutions `ACCEPTED`. No local Mathlib rebuild or new bridge proof was performed for this preparation.

The environment is Lean v4.33.1 and Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`. `FETCH_MANIFEST.json` records retrieval time and SHA-256 hashes of each downloaded record and exact code file. The `.solution.json` files preserve the API's exact `content` and storage-path fields; the corresponding `.lean` files contain that content without edits. Storage-path fields are provenance, not download URLs.

## Sources and attribution

The definition and both earliest accepted solutions were contributed by **Zexuan Liu**, as recorded in the saved catalog and submission records. Their original source citations and explanations remain in those JSON records. No new license is assigned here.

| Item | Platform record | Accepted solution / saved code |
| --- | --- | --- |
| Ordinary Collatz map | [`collatzStepMap`](https://prove2.me/theorems/985d110f-b6e9-4e8f-b4e8-421b6c4af77a), status `Definition` | `Def_collatzStepMap.lean` |
| Repeated halving | [`collatz_iterate_halving`](https://prove2.me/theorems/29fec3ff-8c6b-4264-9525-f1dc50fb00b8), status `Proved` | `5d93e18a-9523-407f-9ce9-96084d5e5ef5.lean`, status `ACCEPTED` |
| Even descent | [`collatz_descent_even`](https://prove2.me/theorems/2721a59b-a3df-45ca-9136-efec5b2360be), status `Proved` | `2b65e288-efd1-4314-a038-c72bb759229f.lean`, status `ACCEPTED` |

The exact accepted theorem types are:

```lean
(k x : ℕ) (h : 2 ^ k ∣ x) : collatzStep^[k] x = x / 2 ^ k
(n : ℕ) (hn : 0 < n) (he : Even n) : collatzStep n < n
```

Each downloaded solution declares `theorem solution`, so these files must be compiled separately or adapted with attribution in a future checked integration. The catalog name is `collatzStepMap`; the import path adds the prefix to become `Definitions.Def_collatzStepMap`. Searching the catalog for `Def_collatzStepMap` correctly returned no entries; that unsuccessful response is preserved too.

The theorem-detail records contain `sorry` in interface stubs. The accepted source files themselves contain complete proof bodies. Both theorem records and the definition have empty human-audit histories at retrieval; remote acceptance does not establish novelty or a human review.

## Map definitions and the required bridge

Our comparison is against Collatz source commit `026aa4ad4be6453a005ab950b160a9f2204c5271`.

| Map | Even input n | Odd input n | Iteration convention |
| --- | --- | --- | --- |
| Public `collatzStep` | n / 2 | 3n + 1 | `Function.iterate` |
| Our `CollatzWork.onceAccelerated` | n / 2 | (3n + 1) / 2 | `CollatzWork.shortcutIter` |

`onceAccelerated` is defined in `lean/CollatzWork/InverseWordBoundaryStatement.lean`. `shortcutIter` is defined in `lean/CollatzWork/ConvergenceStatement.lean` by zero steps returning n and k+1 steps recursively iterating k times after the first shortcut step. It is the one-division shortcut map, not the odd-only map that removes every factor of two.

The concrete bridge obligations for a future Lean change are:

1. Prove the equivalence between the parity guards `Even n` and `n % 2 = 0`.
2. Prove that one shortcut step is one ordinary step on even n and two ordinary steps on odd n. These are mathematical expectations from the displayed definitions, not newly checked Lean theorems in this directory.
3. Lift this relation to iteration using a cumulative ordinary-step count: add one for each even shortcut state and two for each odd shortcut state. The two iteration counters cannot generally be equated.
4. Transfer the public halving lemma along the checked map relation. Its divisibility hypothesis permits x = 0; the even-descent lemma separately requires positivity.
5. Before transferring convergence/coalescence criteria, check the existential step witnesses and boundary cases. Our shortcut map has the cycle 1 → 2 → 1; the ordinary map has 1 → 4 → 2 → 1. Neither definition makes 1 an absorbing state.

For example, ordinary iteration starts 3 → 10 → 5, while one shortcut step sends 3 → 5. The discrepancy is in step counting and must remain explicit when reusing a residue or stopping-time certificate.

These elementary community lemmas can support that bridge and reduce duplicate work. They do not discharge the unresolved universal convergence, universal smaller-coalescence, or universal descent obligations in our source project. No mission contribution, rating, upload, or other write was performed during this retrieval.
