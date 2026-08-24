# Portable proof-note graph standard

**Node ID:** `Collatz-Conjecture-Work:NOTE-GRAPH-STANDARD`

**Node type:** `standard`

This standard makes a research repository usable as a GitHub knowledge base
and as an optional Obsidian vault. It governs navigation and dependency
recording; it does not change mathematical confidence or route status.

## 1. Portability rule

Ordinary relative Markdown links are authoritative:

```markdown
[L14 trajectory normal form](../proof-search/lemmas/L14_ThreeNMinusOne_Trajectory_Normal_Form.md)
```

Use forward slashes, stable repository paths, and descriptive labels. Do not
make bare `[[wikilinks]]`, `obsidian://` URIs, Dataview queries, or a community
plugin necessary to navigate or verify the archive. They may be local
conveniences only.

For cross-repository prose, name both the repository and the stable node ID,
for example `Collatz-Conjecture-Work:L14-3M1-NF`. Do not use a bare filename:
the shared repositories contain duplicate names such as `README.md` and
`LATEST.md`.

## 2. Canonical truth hierarchy

Navigation must not create a competing status system.

1. `proof-search/CLAIM_REGISTRY.md` owns claim confidence, evidence, importance,
   novelty, and release readiness.
2. `proof-search/APPROACH_REGISTRY.md` owns route status and reopening
   conditions.
3. `proof-search/FAILURE_LEDGER.md` owns killed and superseded mechanisms.
4. `verification/README.md` and `LEAN_TARGETS.md` own executable and formal
   scope.
5. `ATLAS.md` owns discovery and typed navigation only.

If a summary disagrees with a canonical file, update the summary; do not copy
dynamic grades into multiple notes.

## 3. Stable node identity

Use the existing claim or route ID whenever one exists. A new durable note
should have one primary stable note ID and one primary type. A note may also
list several claim IDs when it carries several registry claims:

`claim | lemma | route | failure | verification | formalization | source | prompt | map | standard | archive`

For new or materially revised promoted notes, optional YAML frontmatter may
record static discovery metadata:

```yaml
---
node_id: A-YAH-AN1-001
node_type: route
routes: [A]
aliases: [YAH scalar-arctic no-start]
tags: [collatz, yah, termination, method-obstruction]
---
```

Do not put mutable confidence grades, route status, or accepted Git heads in
frontmatter. Existing notes need not be mass-migrated merely for appearance.

## 4. Typed connections

A new promoted note, or an existing promoted note undergoing a material edit,
should end with a `## Connections` section using only the relevant predicates:

```markdown
## Connections

- **Depends on:** [source or lemma](relative/path.md)
- **Strengthens / specializes:** [related claim](relative/path.md)
- **Blocks / blocked by:** [route or failure](relative/path.md)
- **Verified by:** [checker manifest](relative/path.md)
- **Formalized by / pending:** [Lean boundary](relative/path.md)
- **Prior art:** [source integration](relative/path.md)
- **Parallel to:** [non-implication relationship](relative/path.md)
- **Supersedes / superseded by:** [replacement](relative/path.md)
```

Use mathematical implication words only when that implication is proved.
“Related to” should be replaced by a more precise predicate. Add a reciprocal
link for a load-bearing dependency so a local graph remains intelligible.

## 5. Maps of content

The root `ATLAS.md` is the global map. A directory may gain a smaller map only
when it has enough independent nodes to justify one. A map should include:

- the unresolved or accepted boundary;
- typed routes and dependency order;
- verification/formalization links;
- blocked mechanisms and exact reopen conditions;
- historical nodes clearly labeled as historical.

Mermaid may visualize the map on GitHub and in Obsidian, but every Mermaid
edge that matters must also be represented by an ordinary Markdown link.
Obsidian's graph is file-level and is not a proof checker.

## 6. Artifact workflow

Before starting a research pass:

1. locate its route and claim nodes in `ATLAS.md`;
2. read the canonical registry row and failure-ledger blockers;
3. state which existing edge the proposed mechanism changes.

Before committing a material result:

1. give the artifact a stable ID;
2. add typed links to inputs, evidence, and affected route/failure nodes;
3. update canonical status files once, not every summary;
4. update the atlas only when topology changes;
5. run the mathematical checks and the note-graph checker;
6. include new node IDs and edges in the handoff packet.

This turns a handoff into a graph delta rather than a transcript dump.

## 7. Automated QA

From the repository root, run:

```powershell
python -B verification\check_note_graph.py
```

The dependency-free checker verifies that every local Markdown target exists
and every Markdown note is reachable from `README.md`. It checks repository
structure, not theorem validity, heading semantics, or novelty.

## 8. Optional Obsidian use

Open the repository root as a vault. Obsidian's built-in Graph view, Backlinks,
Outgoing links, Search, and Tags are sufficient; no Better Notes or community
plugin is required. For maximum interoperability, keep ordinary Markdown links
as the default. Generated cache and workspace-state directories should remain
local and untracked.

GitHub remains the public, reviewable source of truth. Obsidian is a viewer and
editor for the same files, not a separate database.

Mathematical notation follows the
[portable Markdown math style](MARKDOWN_MATH_STYLE.md): `$...$` inline and
standalone `$$` delimiters for display math. This shared form renders on both
GitHub and Obsidian and is checked independently of theorem validity.

## 9. Platform references

- [Obsidian internal links](https://obsidian.md/help/links)
- [Obsidian Graph view](https://obsidian.md/help/plugins/graph)
- [Obsidian Backlinks](https://obsidian.md/help/plugins/backlinks)
- [GitHub relative links in README files](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes)
- [GitHub Mermaid diagrams](https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/creating-diagrams)
