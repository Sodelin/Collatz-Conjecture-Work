# Prove2Me publication client

This Python 3 standard-library client consumes a validated export package and
publishes definitions, theorem statements, and complete solutions in dependency
order. It does not create accounts or API keys. The default command is offline.
The API workflow follows Prove2Me workspace documentation version **0.9.8**.

```bash
python3 uploader.py ../collatz/manifest.json
python3 -m unittest -v test_uploader.py
```

Dry-run checks package structure, referenced bytes, hashes, identifiers and DAG
order; it reports the package's local validation status. Dry-run does **not** claim
that Lean compiled or that uploads exist. The mocked tests perform no network
requests and create temporary fixture git repositories only.

## Package schema

All package paths are relative to the manifest's parent directory. No path may
escape that directory. Each referenced file must be in `files` with its SHA-256.
`payload_file` can replace `payload`, referring to a hashed JSON file containing the
exact documented API body. Dependencies include both statement and solution
dependencies; a dependency is finished before a consuming item is submitted.

```json
{
  "schema_version": 1,
  "project_tag": "sodelin-collatz-commit-prefix",
  "source": {
    "repository": "https://github.com/Sodelin/Collatz-Conjecture-Work",
    "commit": "FULL_40_CHARACTER_SOURCE_COMMIT",
    "digests": {"CollatzWork.lean": "SOURCE_FILE_SHA256"}
  },
  "environment": {
    "toolchain": "leanprover/lean4:v4.33.1",
    "mathlib_rev": "FULL_40_CHARACTER_MATHLIB_COMMIT"
  },
  "files": {
    "Solutions/Sol_example.lean": "SHA256",
    "validation/report.json": "SHA256"
  },
  "validation": {"status": "passed", "evidence_files": ["validation/report.json"]},
  "items": [
    {
      "key": "example",
      "kind": "theorem",
      "depends_on": [],
      "payload": {
        "theorem_name": "UploadNamespace.example",
        "theorem_title": "Precise theorem title",
        "formal_statement": "theorem UploadNamespace.example : True := by sorry",
        "preamble": "",
        "natural_language_statement": "An accurate explanation of the proposition and its reuse value.",
        "source": "https://github.com/OWNER/REPO/blob/COMMIT/FILE.lean#L1-L2",
        "tags": ["sodelin-collatz-commit-prefix"]
      },
      "solution_file": "Solutions/Sol_example.lean",
      "explanation": "An accurate mathematical explanation of the completed proof."
    }
  ]
}
```

A definition item uses `kind: "definition"` and a payload with `definition_name`,
`definition_title`, `definition`, `natural_language_statement`, `source`, and
`tags`. It has no solution. The client adds explicit `env` and `private: false`.
The illustrative `True` item above documents the format; do not publish it as a
research contribution. Replace placeholders before using the manifest.

Before setting validation to `passed`, the package producer must compile the
**exact** upload text, compare elaborated source and staged theorem types, audit
source/solution axioms, and inspect semantic metadata. The client verifies the
hashes of this evidence; it does not substitute a string flag for those Lean
checks. `source.digests` must cover every original source and toolchain/dependency
pin used to produce the package. Working source bytes and the corresponding
committed blobs must both match those digests.

## Authenticated resume

Only after an existing API key has been supplied through the configured private
credentials file, run a bounded tick. The file contains the documented `api_key`
property and must have mode `0600`. Keep it outside this repository. Never put its
contents on the command line, in a manifest, in git, or in an issue/comment.

```bash
python3 uploader.py ../collatz/manifest.json --execute \
  --source-root /path/to/pinned/source-checkout \
  --credentials /private/prove2me/credentials.json \
  --state /private/prove2me/collatz.state.json \
  --max-mutations 10 --max-seconds 45
```

`--max-mutations 0` polls known jobs without creating publication/verification
jobs. It still exchanges an existing key for a short-lived token if needed.
The source checkout HEAD must be the manifest's original source commit; if later
packaging commits advance the repository, use a detached source worktree at the
pinned commit. Dry-run does not require credentials or `--source-root`.

The API origin is fixed to `https://prove2.me/api/v1`, redirects are refused, and
the key is used only at `/agent/refresh`. Access tokens stay in memory, refresh
before expiry, and are never included in state, stdout, or errors. A platform
version change or missing exact live Lean/Mathlib environment stops execution.

Each tick queues a bounded number of mutations and polls asynchronous jobs.
Run ticks through a supervised process or automation; repeat the same command to
resume. Exit **0** means complete, **2** means pending, and **1** means stopped for
review. There is no sleep loop or automatic POST retry. State is atomically
written and fsynced, including an intent before each publish/verify call and its
job/submission ID afterward. A process lock prevents concurrent copies sharing
the same state file.

**Retain the state file.** A lost state is not a reason to rerun from scratch.
The client checks exact names before creating new entries and refuses occupied
names. Source and manifest hashes are locked to the run.

## Ambiguous requests and reconciliation

If the process dies or a connection fails after a POST, the server may have
accepted it. The next tick refuses to repeat it. Read your own `/publish-jobs`
or `/submissions` history, locate the exact source/name/body and server ID, then
attach that ID to the existing state:

```bash
python3 uploader.py ../collatz/manifest.json --execute \
  --source-root /path/to/pinned/source-checkout \
  --credentials /private/prove2me/credentials.json \
  --state /private/prove2me/collatz.state.json \
  --reconcile-key example --job-id EXISTING_JOB_ID --max-mutations 0
```

Use `--submission-id EXISTING_SUBMISSION_ID` for an uncertain proof POST. The
client checks target identity and downloads the immutable submitted Lean source
to compare its bytes. Publish-job reconciliation checks the recorded code and
source. No reconciliation call creates another job. If the server cannot
establish whether the request was received, stop for manual investigation; never
delete state to force a retry. `FAILED` and `ERROR` jobs also stop for explicit
repair instead of being retried automatically.

## What completion means

HTTP `202` only means queued. `PUBLISHED` means a definition/statement exists;
it does not prove a theorem. `SKETCH_ACCEPTED` stays incomplete until its target
actually becomes `Proved`. Even `ACCEPTED` waits for the catalog to show exactly
`Proved`. A final paginated shared-tag scan checks every expected ID and rejects
remaining Open/Disproved entries; each expected ID is also fetched directly to
check its exact environment, immutable theorem text, source, and status.

Output contains actual server job, theorem and submission IDs, authenticated API
URLs, and a public page URL only when supplied by the server. It does not invent
public UI routes. The state records the source commit and completed phases.

Official references: [full-project upload](https://github.com/prove2me/prove2me_workspace/blob/main/references/upload_full_project.md),
[contribution API](https://github.com/prove2me/prove2me_workspace/blob/main/references/contribute.md),
[verification API](https://github.com/prove2me/prove2me_workspace/blob/main/references/prove.md),
[authentication](https://github.com/prove2me/prove2me_workspace/blob/main/references/setup.md).
