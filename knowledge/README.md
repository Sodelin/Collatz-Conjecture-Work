# Generated notebook supplements

**Node ID:** `Collatz-Conjecture-Work:KNOWLEDGE-SUPPLEMENTS`

**Node type:** `map`

The repository's hand-curated [research atlas](../ATLAS.md) is the canonical
map of content. This directory adds deterministic search and audit views over
the same ordinary Markdown corpus:

- [repository-wide file catalog](_generated/FILE_CATALOG.md);
- [repository-wide backlinks](_generated/BACKLINKS.md);
- [local-link and node-ID audit](_generated/LINK_AUDIT.md).

These views do not define claim confidence, route status, verification scope,
or publication readiness. The canonical hierarchy in the
[note-graph standard](../methodology/NOTE_GRAPH_STANDARD.md) always wins.

## GitHub and Obsidian

No plugin is required. GitHub and Obsidian's built-in Graph, Backlinks,
Outgoing links, Search, and Tags all use the same ordinary relative Markdown
links. Do not commit personal `.obsidian/` workspace, cache, or plugin state.

## Rebuild and validate

From the repository root:

```powershell
python -B verification\check_note_graph.py
python -B knowledge\tools\build_index.py --self-test
python -B knowledge\tools\build_index.py --check
python -O -B knowledge\tools\build_index.py --self-test --check
```

The generator is dependency-free and fail-closed. It checks local file targets
with exact path casing, duplicate optional node IDs, controlled node types,
and stale generated views. It uses explicit exceptions and exit codes rather
than Python `assert`, so optimization cannot disable validation.

## Connections

- **Depends on:** [portable note-graph standard](../methodology/NOTE_GRAPH_STANDARD.md)
- **Parallel to:** [hand-curated research atlas](../ATLAS.md)
- **Verified by:** [repository note-graph checker](../verification/check_note_graph.py)
