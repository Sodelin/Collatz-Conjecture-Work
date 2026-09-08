# Egyptian Fractions — Erdős #295

**Research in progress. No new solution or priority claim is established.**

This project searches for shorter exact representations of 1 as a sum of
distinct positive unit fractions whose denominators are at least 18. A Lean
4.33.1 proof currently verifies the existing **35-term** construction. The
published report leaves the finite gap **33 ≤ k(18) ≤ 35**; its lower bound is
reported prior work, not a theorem proved by this repository.

The immediate target is a 33- or 34-term construction, or a genuinely complete
lower-bound proof. The general Erdős #295 conjecture asks whether

\[
k(N)-(e-1)N\longrightarrow+\infty.
\]

A finite improvement at 18 would not resolve that asymptotic conjecture.

## Check the proof

Install Lean using [the official instructions](https://lean-lang.org/install/),
then run:

```sh
lake build
lake env lean EgyptianFractions/Baseline18.lean
```

The checked statement is `HasRepresentation 18 35`: there is a list of exactly
35 distinct positive natural-number denominators, each at least 18, whose
reciprocals sum to 1 in Lean's standard exact rational type `Rat`.

The proof uses kernel reduction. Its printed axiom dependencies are only
`propext`, `Classical.choice`, and `Quot.sound`. It does not use `sorry`, an
assumed conjecture, or `native_decide`. The CI workflow rebuilds with the
official pinned toolchain and checks the compiled environment.

## Research record

- [Exact definitions](EgyptianFractions/Certificate.lean)
- [Known 35-term certificate](EgyptianFractions/Baseline18.lean)
- [Search and novelty record](docs/research-record.md)
- [Submission and reward status](docs/submission-status.md)
- [Other candidate projects](docs/target-shortlist.md)
- [Bounded construction searches](probes/)

## Credit

Research initiated and directed by **Nolan Downard**, with proof development,
computation, and literature checks by OpenAI's assistant in this session.
AI involvement is disclosed; no independent human expert review is claimed.
The baseline construction belongs to prior work by **Patrick White and Claude**
as disclosed on [their August 11, 2026 report](https://erdosproblemaday.com/day/295-k17-exact).
Formalizing that existing result does not establish a first solution.

All status claims are dated **September 7, 2026**. The repository name describes
the research subject, not a claim that the conjecture has been solved.
