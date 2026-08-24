# Notebook schema

Notebook files are atomic navigation cards. Their filename must equal their
immutable `id`, followed by `.md`. Titles may change; identifiers may not.

## Stable IDs

| Type | Pattern | Example |
|---|---|---|
| claim | `CW-CLM-{claim-id}` | `CW-CLM-A-YAH-AN1-001` |
| route | `CW-RTE-{route-id}` | `CW-RTE-AB` |
| failure | `CW-FLR-{failure-id}` | `CW-FLR-F019` |
| source | `CW-SRC-{author-key}-{year}` | `CW-SRC-GARCIA-TAL-1999` |
| artifact | `CW-ART-{claim-id}-{kind}` | `CW-ART-A-YAH-AN1-FULL-CHECKER` |
| concept | `CW-CON-{short-key}` | `CW-CON-ACCELERATED-ODD-MAP` |
| experiment | `CW-EXP-{UTC timestamp}` | `CW-EXP-20260824T143213Z` |
| release | `CW-REL-{short-key}` | `CW-REL-YAH-SCALAR-ARCTIC` |
| map of content | `CW-MOC-{topic}` | `CW-MOC-VERIFICATION` |

Retired notes remain as tombstones with `status: superseded`; identifiers are
never reused.

## Controlled fields

`status`:

```text
draft | provisional | accepted | rejected | superseded | historical
```

`proof_status` for claim cards:

```text
open | provisional | scoped-proved | scoped-refuted | conditional |
equivalent-open | bounded-only | archive-status
```

Formalization is separate from proof status. A claim is Lean-backed only when
its canonical rating is `V3` and a `formalized-by` edge points to the exact
module/declarations and axiom footprint. A checker-backed claim normally uses
`verified-by`; bounded evidence uses `tested-by`.

`global_effect` is currently required to be `none`. Changing it to `proof` or
`disproof` requires the complete repository publication gate and is outside a
notebook-only migration.

## Typed links

Typed links use this portable Markdown form:

```markdown
- **depends-on:** [Prerequisite](../claims/CW-CLM-PREREQUISITE.md)
```

Allowed predicates, directed from the current note to its target, are:

```text
depends-on | implies | equivalent-to | refutes | narrows | blocks-route |
derived-from | verified-by | formalized-by | tested-by | supersedes |
related-to
```

- `implies` and `equivalent-to` are logical edges and require matching scope.
- `refutes` targets an exact claim; `blocks-route` targets a method class.
- `verified-by` means the artifact checks the full scoped claim.
- `tested-by` means evidence is bounded or diagnostic.
- `formalized-by` names an exact proof-assistant artifact, not merely a build.
- `related-to` carries no inference and should be used sparingly.

Backlinks and overview pages are generated. Human-edited cards must not contain
generated backlink sections.

## Migration invariants

1. The registries remain authoritative during the pilot.
2. A card links to the canonical theorem; it does not copy the theorem body.
3. Ratings must match the canonical claim-registry row.
4. A graph edge cannot promote confidence, novelty, or release readiness.
5. Every artifact states the exact scope it checks and the bridge it omits.
6. Generated files are reproducible and must pass the stale-view check.
7. Paths are ASCII, case-correct, and ordinary relative Markdown.
8. Every accepted card pins a full Git object and preserves the provenance
   rules in [PROVENANCE.md](../PROVENANCE.md).
