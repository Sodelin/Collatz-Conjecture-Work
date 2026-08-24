# Linked research notebook

This directory is an additive navigation layer over the canonical Collatz
research archive. It makes claims, routes, failures, sources, and verification
artifacts visible as a graph without moving or duplicating their mathematical
statements.

> **Global verdict:** Collatz remains unresolved. A graph edge is navigation
> metadata; it is never evidence that an implication has been proved.

## Start here

- [Notebook home](mocs/CW-MOC-HOME.md)
- [All indexed notes](_generated/INDEX.md)
- [Route, claim, and failure graph](_generated/GRAPH.md)
- [Claim status matrix](_generated/STATUS_MATRIX.md)
- [Verification crosswalk](_generated/VERIFICATION_MATRIX.md)
- [Reverse links](_generated/BACKLINKS.md)
- [Repository-wide Markdown catalog](_generated/FILE_CATALOG.md)
- [Local-link audit](_generated/LINK_AUDIT.md)
- [Schema and relation rules](SCHEMA.md)

The project registries remain authoritative:

- [claim and evidence registry](../proof-search/CLAIM_REGISTRY.md);
- [approach registry](../proof-search/APPROACH_REGISTRY.md);
- [failure ledger](../proof-search/FAILURE_LEDGER.md);
- [verification manifest](../verification/README.md).

Notebook cards contain stable identifiers, ratings, scope guards, and links to
those canonical files. They do not contain second editable copies of proofs.

## GitHub and Obsidian

No plugin is required. The notebook uses ordinary relative Markdown links, so
GitHub renders every note and Obsidian's built-in backlinks and graph view see
the same connections. The generated Mermaid graph supplies a useful GitHub
view. Plugin-only wikilinks, queries, block embeds, and `obsidian://` links are
deliberately excluded.

Open the repository root as an Obsidian vault if desired. Do not commit a
personal `.obsidian/` workspace or third-party plugin state; the portable
Markdown corpus is the shared artifact.

## Rebuild and validate

From the repository root:

```powershell
python -B knowledge\tools\build_index.py --self-test
python -B knowledge\tools\build_index.py
python -B knowledge\tools\build_index.py --check
```

The validator is dependency-free and fail-closed. It checks card metadata,
controlled terms, stable filenames, full baseline hashes, canonical claim
ratings, typed relations, and repository-local file links. It also catalogs
every Markdown source file. `--check` fails if a generated view is stale. The
checker uses explicit exceptions and exit codes rather than Python
`assert`, so `python -O` cannot silently disable validation.

This first migration is intentionally a pilot. Existing files are not renamed,
and the generated graph is not yet a complete model of every historical note.
