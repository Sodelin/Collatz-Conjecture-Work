# Prove2Me collaboration entry points

Observed 2026-09-08 through the signed-in Prove2Me interface. These are candidate dependencies and research targets, not claims that our code already imports them.

## Existing Collatz mission

https://prove2.me/missions/Collatz%20Conjecture

The mission explicitly welcomes supporting lemmas and finite certificates. Its universal Collatz goal remains open. Its visible frontier included:

- `CollatzMission.no_eventual_cycle_counterexamples`
- `CollatzMission.no_divergent_counterexamples`
- `syracuse_descent_twentyseven_mod_thirtytwo`
- `syracuse_descent_seven_mod_thirtytwo`
- `syracuse_descent_fifteen_mod_sixteen`

These were displayed as open leaves. They must not be imported as established facts or described as solved.

## Candidate reusable facts

| Declaration | Observed status and environment | Statement and role |
| --- | --- | --- |
| [`collatz_iterate_halving`](https://prove2.me/theorems/29fec3ff-8c6b-4264-9525-f1dc50fb00b8) | Proved; Lean v4.33.1, Mathlib `0df444a360eaa60ab8c11dca51a86af692955474`; author Zexuan Liu | For natural numbers k and x, divisibility of x by 2^k implies that k ordinary Collatz steps send x to x / 2^k. Candidate bridge from ordinary iteration to runs of halving steps. |
| [`collatz_descent_even`](https://prove2.me/theorems/2721a59b-a3df-45ca-9136-efec5b2360be) | Proved; same environment and author | A positive even natural decreases under one ordinary Collatz step. Positivity is part of the theorem. |

Both pages import `Definitions.Def_collatzStepMap`. The theorem pages display placeholder statement bodies ending in `sorry`; those are interface stubs, not the accepted solution source. Before reuse, fetch the accepted solution and definition through the documented API, verify their current status and environment, and record their IDs and attribution.

## Integration work

The local Collatz library uses `onceAccelerated` and `shortcutIter` in its convergence results, whereas these existing platform facts use the ordinary `collatzStep`. A name match or similar prose is insufficient: establish the relevant map/iterate bridge before replacing a local lemma or using the public fact in a new argument. Preserve source theorem hypotheses and distinguish ordinary, shortcut, and fully accelerated iteration.

Publication and reuse are separate operations. Upload the existing checked source results faithfully first; adapt them to the mission's definitions in separately checked bridge lemmas. No mission comments or messages have been posted as part of this preparation.
