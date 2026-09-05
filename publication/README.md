# Repeatable research publication

The workflow publishes the complete, versioned Collatz research archive and all tracked Lean source, then prepares a schema-validated VibeMathed entry. Collatz remains unresolved. A research release, a submission awaiting review, and a published catalog entry are separate states.

## Current publication decision

The5September consolidation covers eight research PRs, all eight open issues and eleven comments. The [consolidation review](../research-review/consolidation-2026-09-05/REPORT.md) supersedes the earlier quarter-gap rehearsal hold. The selected entry is the restricted YAH scalar-arctic full/top obstruction, presented as an Unreviewed partial result with exact certificates and a complete internal semantic/prior-art packet. Its own theorem is not Lean-formalized. The many separate Lean developments are included and audited in the same release.

Read the [YAH manuscript](yah-obstruction.md), [full research announcement](announcement.md), and [claim manifest](claims.json). The final receipt records whether the form was submitted and the response actually observed. Nothing in the package asserts curator acceptance.

## One source of publication data

| File | Controls |
|---|---|
| metadata.json | Exact mathematical source SHA, repository, formal audit anchor and venue fields |
| claims.json | Published scope, source paths and exact formal declarations |
| announcement.md | Human-readable synthesis of all contributions |
| yah-obstruction.md | Primary manuscript for the focused venue entry |
| vibemathed-schema.json | Dated real field contract, choices, limits and link rules |
| verify_source.py | Explicit Lean, axiom, arithmetic, certificate and documentation gates |
| build.py | Deterministic source/Lean archives, citations, checksums and form export |
| publish_release.py | Draft staging, all-asset verification and public prerelease promotion |

The metadata field headline_declaration remains the established quarter-gap declaration as a formal audit anchor. It does not confer Lean status on the selected YAH certificate theorem.

## Automatic release

The Verify and publish research Actions workflow runs for publication changes and by manual dispatch. It checks out the selected full mathematical SHA separately, installs the checksum-pinned Lean4.33.1 release, rebuilds the library, compiles every tracked Lean module and explicitly approved standalone archive, audits declarations, and runs the expanded exact-checker suite. Pull requests retain review artifacts. Passing runs on main publish an immutable GitHub research prerelease.

The release includes research-source.zip, lean-source.zip, announcement.md, yah-obstruction.md, claims.json, verification.json, verification-logs.zip, vibemathed-draft.json, vibemathed-form.md, vibemathed-import.js, vibemathed-schema.json, CITATION.cff, citation.bib, manifest.json, source-inventory.json and SHA256SUMS. The release notes explain the source and publisher identities.

Every file in the selected Git tree is retained in the source archive, including historical negative results and provisional notes. Every tracked .lean file is retained in the Lean archive, including the three separately compiled archival derivations. Inclusion does not upgrade a historical claim's verification status.

Tags include source and publisher SHAs. Repeating the same version checks existing bytes rather than overwriting them. The tag and GitHub's automatic Source code downloads represent the publisher commit; research-source.zip represents the selected mathematics. Fresh verification output includes both the actual source identity and complete logs.

## Publishing a later consolidation

1. Reconcile the incoming research branches and issues, update current statuses, and preserve every unique artifact. Review new mathematical statements at their actual scope.
2. Commit that source, pin its full SHA in metadata.json, and update announcement source links to the same SHA. Update claims and the explicit verification list for new proof artifacts.
3. Open the publication change for review. The workflow rejects missing files, failed checks, mismatched SHAs, unknown axioms, incomplete proofs and malformed venue fields.
4. Merge a passing revision to main. The workflow creates the verified public package automatically.
5. Use the generated VibeMathed fields in the signed-in form and inspect them before submission. Record the observed receipt. Curator approval cannot be automated by the repository.

To reproduce locally:

```bash
python3 -B publication/verify_source.py --source /path/to/frozen-source --output /path/to/fresh-package
python3 -B publication/build.py --source /path/to/frozen-source --output /path/to/fresh-package --verification /path/to/fresh-package/verification.json
```

The publisher and mathematical checkout must be committed and clean. A preview flag can validate exports without asserting a passed release; it cannot publish an unverified package.

## Venue handling

[VibeMathed](https://vibemathed.com/contributing) accepts a reviewed form submission with a public primary source. Its catalog is a database; a repository pull request cannot add an entry. The export follows the observed first-party form contract, not an invented public submission API. The optional same-site draft-restoration helper prepares a draft; it does not click Submit.

VibeMath's public aggregator consumes accepted VibeMathed records. There is no separate direct intake to port the repository into. The [venue notes](VENUES.md) record the checked interfaces and the distinction from the Palomar formal-artifact registry.

Future automation should rebuild and package the selected reviewed source. It should not silently promote every new branch, equate a successful Lean build with novelty, submit duplicate catalog entries, or label an internal review as independent expert verification.
