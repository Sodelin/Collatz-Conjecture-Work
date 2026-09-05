# Repeatable research publication

This workflow publishes a versioned **research prerelease** containing the full
Collatz archive and Lean sources, then prepares a VibeMathed submission draft.
Collatz remains unresolved. A GitHub release is not journal acceptance or a
VibeMathed catalog listing.

## One source of publication data

- `metadata.json`: the exact mathematics commit, headline theorem and form text.
- `claims.json`: scoped results and their source paths/declarations.
- [Research announcement](announcement.md): result, assumptions, limitations and provenance.
- `vibemathed-schema.json`: dated snapshot of the venue's real field contract.
- [Venue requirements](VENUES.md): checked rules and the VibeMathed / VibeMath distinction.

The mathematics source may be on an open research branch. Publishing its frozen
snapshot does not merge that branch or promote its claims. The publishing code
is maintained independently on `main` so work on PR #16 can continue separately.
All committed source files are preserved, including historical claims and
negative results; `claims.json` and the announcement specify the current scope.

## Automatic release

The **Verify and publish research** Actions workflow runs for publication changes
and can be rerun from Actions. It checks out the configured full source SHA,
installs the unchanged checksum-pinned Lean toolchain, builds formal modules,
audits axiom dependencies, reruns the mathematical checkers, and validates the
venue export. Pull requests produce downloadable review artifacts. A successful
run on `main` creates a GitHub prerelease with these assets:

| File | Purpose |
| --- | --- |
| `research-source.zip` | Every file from the exact mathematics Git tree |
| `lean-source.zip` | Lean source plus toolchain, Lake configuration and lockfile |
| `announcement.md`, `claims.json` | Human and machine-readable scope |
| `verification.json`, `verification-logs.zip` | Fresh checks and axiom output |
| `vibemathed-draft.json`, `vibemathed-form.md` | All form fields, with exact choices and limits |
| `vibemathed-import.js` | Optional same-site draft restoration helper |
| `CITATION.cff`, `citation.bib` | Versioned citations for GitHub / Zotero |
| `manifest.json`, `source-inventory.json`, `SHA256SUMS` | Full commit identities and checksums |

Release tags include both source and publisher commits, so correcting an export
produces a new version. Rerunning the same version does not overwrite its assets.
The workflow uses the repository's own `GITHUB_TOKEN`; no venue password or API
secret is stored in GitHub.

To promote later mathematics, update `source_commit`, the result descriptions,
dates, immutable source links in `announcement.md`, and `claims.json` together.
Open a publication PR. The new source must pass fresh checks before the automatic
release runs on `main`. Never advance the pointer alone while leaving older
theorem descriptions attached to it. Adding a new formal module or checker may
also require updating `verify_source.py` and the explicit declaration audit.

## Local reproduction

Run from a clean publisher checkout. Supply a separate clean checkout of the
configured mathematical source and the exact toolchain from `lean-toolchain`.

```sh
python3 -B -m unittest discover -s tests -v
python3 publication/verify_source.py --source ../source --output ../release-dist
python3 publication/build.py --source ../source --output ../release-dist --verification ../release-dist/verification.json
```

For format inspection without claiming new verification, use a fresh directory:

```sh
python3 publication/build.py --source ../source --output ../preview-dist --preview
```

Preview drafts are visibly unverified and downgrade the venue field to
`unreviewed`. They cannot be passed off as verified release output by the CI job.

## VibeMathed handoff

Open [the official submission form](https://vibemathed.com/submit), sign in, and
copy the generated fields. The optional `vibemathed-import.js` can restore the
generated draft on that exact page through the site's existing local draft
storage. It backs up a prior draft and reloads the form. It makes no requests,
reads no credentials, and never clicks Submit. This is a convenience adapter to
a dated implementation, **not an official upload API**. If draft restoration
changes, the Markdown field copy remains usable.

Send one proposal for the scoped partial result, not one per supporting lemma.
The venue's current rules still require a genuine advance on an open question;
novelty is not independently established here. Known reconstructions and bounded
experiments remain supporting archive material. `lean-checked` explicitly means
the statement has not received independent external correspondence review.

After sending, record the returned receipt and public entry URL in a separate
submission record. Do not change `not-submitted` to `published` without a real
receipt and listing. Subsequent versions should update the existing entry where
appropriate, rather than create duplicates. Review and acceptance remain under
the venue's control. VibeMath may then ingest the public VibeMathed dataset.

## Zotero and Obsidian

Import `citation.bib` into Zotero, attach `announcement.md` and the release
manifest, and use tags `Collatz`, `AI-assisted`, `formalization`, `partial-result`,
and `statement-review-needed`. This cites the project artifact; it does not claim
to replace or import the archive's source literature. Extract `research-source.zip`
into Obsidian to preserve its relative Markdown links. Keep the version in the
folder name and relate newer releases as revisions rather than replacing evidence.

The exporter grants no new license to the research or quoted source literature.
Public availability and an explicit reuse license are separate questions.
