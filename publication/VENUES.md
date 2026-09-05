# Publication routes and claim boundaries

Requirements checked on **2026-09-05**. A public research archive and an accepted catalog entry are different deliverables. This project can publish its complete reproducible archive; each outside catalog controls what it accepts.

## VibeMathed

[VibeMathed](https://vibemathed.com) records previously open mathematical questions answered with substantive AI participation. Its catalog lives in a database: **a GitHub pull request cannot add or edit an entry**. Submit through the [entry form](https://vibemathed.com/submit), using Google or GitHub sign-in; a curator decides whether to publish. The limit is ten submissions per rolling 24 hours. See the [contribution instructions](https://vibemathed.com/contributing).

The form records structured text and links. It does not ingest a repository, PDF, Lean project or ZIP as a file upload. A publicly accessible repository, announcement or paper supplies the primary source; additional links can identify exact Lean statements, proofs, computation scripts and AI disclosures. A repository-hosted PDF is classified as an **announcement**; **preprint** means a manuscript on arXiv or a similar server. See the [reviewing checklist](https://github.com/mrconter1/vibemathed/blob/f2b04892c53c414b85d9446c2bddb262378966c8/docs/reviewing.md).

### What this Collatz archive may claim

The [methodology](https://vibemathed.com/methodology) admits a proved improvement on a stated open question as a **partial result**. It excludes heuristic evidence and formalizations of results already proved by humans. A new auxiliary result therefore needs evidence that it resolves a previously posed question or advances a recognized open problem; “new to this repository” does not establish mathematical novelty. A corrected proof, reconstruction of known mathematics or refutation of this project's own attempted bridge remains valuable archive material without necessarily qualifying for a catalog entry.

This workflow must preserve **Collatz remains open**. It must not label the archive a resolved Collatz proof, a candidate full solution, or a counterexample to Collatz. The result field concerns the selected statement: disproving an auxiliary implication does not disprove the conjecture. Do not aggregate every lemma into a separate submission. Select a defensible result and connect the rest as supporting material.

AI participation must be disclosed in the public primary source, with the model's concrete mathematical role. A statement only in the submission form is insufficient. Reviewers also check source access, duplication, prior open-question provenance and the correspondence between source and labels. The [reviewing checklist](https://github.com/mrconter1/vibemathed/blob/f2b04892c53c414b85d9446c2bddb262378966c8/docs/reviewing.md) explains these gates.

### Verification labels

| Value | Evidence required |
| --- | --- |
| `unreviewed` | No independent mathematical review has been recorded. Authors checking their own argument does not raise this tier. |
| `lean-checked` | The selected Lean artifact compiles without proof holes or stray axioms, with exact-commit evidence; its statement has no independent fidelity audit. |
| `lean-verified` | The Lean check plus an independent anchor showing that the formal statement matches the original problem. |
| `site-confirmed` | The site's own reproduction or acceptance by the canonical community tracker. A local build cannot award this status. |
| `expert-verified` | Named independent domain experts have endorsed the claim publicly. |

These are the site's distinctions, not promises this automation can make. Cite the build commit and audit scope, identify any literature hypotheses or `native_decide`, and state exactly which theorem is covered. The [verification ladder](https://vibemathed.com/methodology#verification) also distinguishes proof correctness from statement fidelity.

### Automated preparation and form handoff

The machine-readable snapshot is [vibemathed-schema.json](vibemathed-schema.json). It includes the current keys, choice values, required fields, limits, link kinds and source revision. Top-level text values are trimmed and normalized to Unicode NFC; their limits count Unicode code points. Link labels separately use the upstream JavaScript UTF-16 length after trimming, capped at 120 code units. Every form value is a string. `links` is itself a JSON string containing an array of `{ "label": "…", "url": "https://…", "kind": "lean-proof" }` objects, with at most sixteen extra links. Extra links cannot duplicate the primary source or each other.

| Output | Purpose |
| --- | --- |
| Validated form-value JSON | Prepares exact field values for the current form contract. |
| Readable field-by-field text | Allows copying into the signed-in form, including on a phone. |
| Public source and artifact links | Gives a reviewer the write-up, Lean source, claim boundaries, AI disclosure and reproducibility evidence. |

The first-party form currently restores a JSON object from the browser's `localStorage` key **`vibemathed:submit-draft`** on page load. This can support a user-controlled browser import followed by ordinary review of the form. It only fills a draft: it neither authenticates nor submits. It is an **observed implementation detail**, so recheck the pinned [form implementation](https://github.com/mrconter1/vibemathed/blob/f2b04892c53c414b85d9446c2bddb262378966c8/src/components/SubmitForm.tsx) against current upstream before depending on it. A generated JSON file cannot write another website's localStorage by itself.

No supported public submission POST API was found in the inspected source. Submission uses an authenticated Next.js server action; its internal transport is not a stable integration contract. This pipeline therefore does not replay internal action identifiers, bypass sign-in, set curator fields, or claim that a generated draft is submitted. The public [`/api/dataset`](https://vibemathed.com/api/dataset) route exports published entries and can support later duplicate or publication checks; it is not an intake endpoint. The relevant source is [submit-problem.ts](https://github.com/mrconter1/vibemathed/blob/f2b04892c53c414b85d9446c2bddb262378966c8/src/app/actions/submit-problem.ts).

## What “VibeMath” refers to

The name is used by separate projects. None of the routes below establishes that the user's intended second destination has been uniquely identified.

| Project | Current route and scope | Consequence for this archive |
| --- | --- | --- |
| [VibeMathed](https://vibemathed.com/contributing) | Authenticated form and curator review of qualifying AI mathematical results. Catalog entries are not added through GitHub PRs. | Prepare one properly scoped proposal; publish the complete supporting archive at its source. |
| [cyanseek/VibeMath](https://github.com/cyanseek/VibeMath) | Independent frontier aggregator with open, attempted, partial, candidate, resolved, contested and retracted states. Its current real source adapter reads VibeMathed's public dataset; static feeds and MCP are read-only. | A later successful refresh may import an accepted VibeMathed entry. A separate reviewed adapter or evidence contribution would be needed for direct archive ingestion. |
| [BlinkDL/VibeMath](https://github.com/BlinkDL/VibeMath) | Individual mathematical research repository. Its inspected README provides no public submission contract or catalog intake route. | Do not treat it as a general publication venue or promise a PR will archive another person's project. |

The cyanseek project is broader than solved results, but its [contribution policy](https://github.com/cyanseek/VibeMath/blob/6cc47bc085cd5f76a3a5bb614a06af83feae620b/CONTRIBUTING.md) welcomes source adapters and evidence corrections rather than offering an unrestricted upload service. A contribution must retain primary sources, retrieval time, license, raw upstream assertions and claim distinctions. Its [README](https://github.com/cyanseek/VibeMath/blob/6cc47bc085cd5f76a3a5bb614a06af83feae620b/README.md) explicitly identifies the sole current VibeMathed adapter and the absence of a submission or publication MCP tool. Do not promise direct PR ingestion, acceptance, comprehensive coverage or a fixed refresh time.

## Palomar follow-on for Lean artifacts

[Palomar's submission instructions](https://palomar-registry.org/how-to-submit) provide a separate route for making exact Lean results easy to inspect. This is a follow-on integration, not implemented by the present workflow. Preparation requires a public repository at an immutable 40-character commit, pinned Lean/Lake dependencies, a short independent Challenge module, a proved Solution module, Comparator configuration and `formalization.yaml` provenance and classification metadata. The Challenge may contain deliberate statement holes; proved Solution declarations may use only `propext`, `Classical.choice` and `Quot.sound`. Custom axioms, `sorryAx` and `Lean.ofReduceBool` are excluded. Conditional results should express their assumptions in theorem signatures.

Palomar has an official [agent protocol](https://submit.palomar-registry.org/llms.txt) using its HTTPS API and GitHub tag plus secret-gist proof of repository write access. Agents must use that route rather than drive its browser sign-in. The protocol separates initial submission, mechanical checking, editorial review and permanent registration. Implementing it later requires its complete current policy, a concrete eligible Lean snapshot, appropriate GitHub capabilities and the user's registration decision after the review is available. A registry entry assists auditability; it does not itself establish mathematical novelty or VibeMathed eligibility.

## Source revisions

- VibeMathed source contract: [`f2b04892c53c414b85d9446c2bddb262378966c8`](https://github.com/mrconter1/vibemathed/tree/f2b04892c53c414b85d9446c2bddb262378966c8).
- cyanseek/VibeMath route evidence: [`6cc47bc085cd5f76a3a5bb614a06af83feae620b`](https://github.com/cyanseek/VibeMath/tree/6cc47bc085cd5f76a3a5bb614a06af83feae620b).
- BlinkDL/VibeMath route evidence: [`f5fdf8eb0651088c9d00d605944c8cafb236f847`](https://github.com/BlinkDL/VibeMath/tree/f5fdf8eb0651088c9d00d605944c8cafb236f847).

Recheck venue rules before an actual external submission. Export validation establishes format compliance; it cannot decide novelty, prove an unformalized theorem, or secure a curator's acceptance.
