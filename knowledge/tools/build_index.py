#!/usr/bin/env python3
"""Validate linked research cards and build deterministic Markdown views.

The checker intentionally uses no third-party packages and no ``assert``
statements. Every failed invariant produces a nonzero exit code even under
``python -O``.
"""

from __future__ import annotations

import argparse
import os
import re
import sys
import tempfile
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable


ROOT = Path(__file__).resolve().parents[2]
KNOWLEDGE = ROOT / "knowledge"
GENERATED = KNOWLEDGE / "_generated"
CARD_DIRECTORIES = (
    "claims",
    "routes",
    "failures",
    "sources",
    "artifacts",
    "experiments",
    "releases",
    "concepts",
    "mocs",
)
GENERATED_NAMES = (
    "INDEX.md",
    "BACKLINKS.md",
    "STATUS_MATRIX.md",
    "VERIFICATION_MATRIX.md",
    "GRAPH.md",
    "FILE_CATALOG.md",
    "LINK_AUDIT.md",
)

STATUSES = {"draft", "provisional", "accepted", "rejected", "superseded", "historical"}
PROOF_STATUSES = {
    "open",
    "provisional",
    "scoped-proved",
    "scoped-refuted",
    "conditional",
    "equivalent-open",
    "bounded-only",
    "archive-status",
}
NOTE_TYPES = {"claim", "route", "failure", "source", "artifact", "experiment", "release", "concept", "moc"}
RELATIONS = {
    "depends-on",
    "implies",
    "equivalent-to",
    "refutes",
    "narrows",
    "blocks-route",
    "derived-from",
    "verified-by",
    "formalized-by",
    "tested-by",
    "supersedes",
    "related-to",
}
RELATION_TARGET_TYPES = {
    "implies": {"claim"},
    "equivalent-to": {"claim"},
    "refutes": {"claim"},
    "narrows": {"route"},
    "blocks-route": {"route"},
    "verified-by": {"artifact"},
    "formalized-by": {"artifact"},
    "tested-by": {"artifact"},
}
ROUTE_STATUSES = {"ACTIVE", "ACTIVE_LOW_COST", "BLOCKED_NO_MECHANISM", "BLOCKED_EQUIVALENT"}
GATE_VALUES = {"pass", "fail", "pending", "not-applicable"}
DATE_RE = re.compile(r"^\d{4}-\d{2}-\d{2}$")
HASH_RE = re.compile(r"^[0-9a-f]{40}$")
ID_RE = re.compile(r"^CW-(CLM|RTE|FLR|SRC|ART|CON|EXP|REL|MOC)-[A-Z0-9-]+$")
RELATION_RE = re.compile(r"^\s*-\s+\*\*([a-z-]+):\*\*\s+\[[^]]+\]\(([^)]+)\)", re.MULTILINE)
LINK_RE = re.compile(r"(?<!!)\[[^]]+\]\(([^)]+)\)")
REGISTRY_RATING_RE = re.compile(
    r"^\|\s*`([^`]+)`\s*\|.*?\|\s*`(C[0-4])\s+(V[0-4])\s+(I[0-4])\s+(N(?:[0-4]|\?))\s+(R[0-4])`\s*\|"
)


class ValidationError(RuntimeError):
    """A fail-closed notebook validation error."""


@dataclass(frozen=True)
class Relation:
    name: str
    target_text: str
    target_path: Path


@dataclass
class Card:
    path: Path
    metadata: dict[str, object]
    body: str
    relations: list[Relation]

    @property
    def id(self) -> str:
        return str(self.metadata.get("id", ""))

    @property
    def type(self) -> str:
        return str(self.metadata.get("type", ""))

    @property
    def title(self) -> str:
        return str(self.metadata.get("title", ""))


def _scalar(value: str) -> object:
    value = value.strip()
    if value == "[]":
        return []
    if len(value) >= 2 and value[0] == value[-1] and value[0] in {"'", '"'}:
        return value[1:-1]
    return value


def parse_card(path: Path) -> Card:
    text = path.read_text(encoding="utf-8")
    lines = text.splitlines()
    if not lines or lines[0] != "---":
        raise ValidationError(f"{path}: missing opening frontmatter delimiter")
    try:
        closing = lines.index("---", 1)
    except ValueError as exc:
        raise ValidationError(f"{path}: missing closing frontmatter delimiter") from exc

    metadata: dict[str, object] = {}
    index = 1
    while index < closing:
        line = lines[index]
        if not line.strip() or line.lstrip().startswith("#"):
            index += 1
            continue
        if line.startswith((" ", "\t")) or ":" not in line:
            raise ValidationError(f"{path}:{index + 1}: unsupported nested frontmatter")
        key, raw = line.split(":", 1)
        key = key.strip()
        if key in metadata:
            raise ValidationError(f"{path}:{index + 1}: duplicate key {key}")
        if raw.strip():
            metadata[key] = _scalar(raw)
            index += 1
            continue
        values: list[str] = []
        index += 1
        while index < closing and lines[index].startswith("  - "):
            values.append(str(_scalar(lines[index][4:])))
            index += 1
        metadata[key] = values

    body = "\n".join(lines[closing + 1 :]).lstrip("\n") + "\n"
    relations: list[Relation] = []
    for match in RELATION_RE.finditer(body):
        relations.append(
            Relation(
                name=match.group(1),
                target_text=match.group(2),
                target_path=resolve_local_target(path, match.group(2)),
            )
        )
    return Card(path=path, metadata=metadata, body=body, relations=relations)


def resolve_local_target(source: Path, target: str) -> Path:
    clean = target.strip().strip("<>").split("#", 1)[0]
    if not clean:
        return source
    return (source.parent / clean).resolve()


def scan_cards() -> list[Card]:
    cards: list[Card] = []
    for directory in CARD_DIRECTORIES:
        base = KNOWLEDGE / directory
        if not base.exists():
            continue
        for path in sorted(base.glob("*.md")):
            cards.append(parse_card(path))
    return cards


def registry_ratings() -> dict[str, tuple[str, str, str, str, str]]:
    result: dict[str, tuple[str, str, str, str, str]] = {}
    registry = ROOT / "proof-search" / "CLAIM_REGISTRY.md"
    for line in registry.read_text(encoding="utf-8").splitlines():
        match = REGISTRY_RATING_RE.match(line)
        if match:
            result[match.group(1)] = tuple(match.groups()[1:])  # type: ignore[assignment]
    return result


def exact_case_exists(path: Path) -> bool:
    try:
        relative = path.resolve().relative_to(ROOT.resolve())
    except ValueError:
        return False
    current = ROOT.resolve()
    for part in relative.parts:
        if not current.is_dir():
            return False
        names = {entry.name for entry in current.iterdir()}
        if part not in names:
            return False
        current = current / part
    return current.exists()


def markdown_link_targets(text: str) -> list[str]:
    """Extract Markdown targets outside fenced code and display-math blocks."""
    visible: list[str] = []
    in_fence = False
    in_math = False
    for line in text.splitlines():
        stripped = line.strip()
        if stripped.startswith(("```", "~~~")):
            in_fence = not in_fence
            continue
        if stripped == "$$":
            in_math = not in_math
            continue
        if stripped == r"\[":
            in_math = True
            continue
        if stripped == r"\]" and in_math:
            in_math = False
            continue
        if not in_fence and not in_math:
            visible.append(line)
    return LINK_RE.findall("\n".join(visible))


def repository_markdown_files() -> list[Path]:
    files: list[Path] = []
    for path in ROOT.rglob("*.md"):
        relative = path.relative_to(ROOT)
        if ".git" in relative.parts:
            continue
        if relative.parts[:2] == ("knowledge", "_generated"):
            continue
        files.append(path.resolve())
    return sorted(files)


def repository_link_data() -> tuple[list[Path], dict[Path, set[Path]], dict[Path, set[Path]], list[tuple[Path, str]]]:
    files = repository_markdown_files()
    file_set = set(files)
    outgoing: dict[Path, set[Path]] = {path: set() for path in files}
    incoming: dict[Path, set[Path]] = {path: set() for path in files}
    broken: list[tuple[Path, str]] = []
    expected_generated = {(GENERATED / name).resolve() for name in GENERATED_NAMES}

    for source in files:
        text = source.read_text(encoding="utf-8")
        is_template = "templates" in source.relative_to(ROOT).parts
        for target_text in markdown_link_targets(text):
            if re.match(r"^(?:https?://|mailto:|obsidian://)", target_text):
                continue
            clean = target_text.strip().strip("<>").split("#", 1)[0]
            if not clean:
                continue
            target = resolve_local_target(source, target_text)
            if target in expected_generated:
                continue
            if not exact_case_exists(target):
                if not is_template:
                    broken.append((source, target_text))
                continue
            if target in file_set:
                outgoing[source].add(target)
                incoming[target].add(source)
    return files, outgoing, incoming, broken


def _require_list(card: Card, key: str, errors: list[str]) -> list[str]:
    value = card.metadata.get(key)
    if not isinstance(value, list):
        errors.append(f"{card.path}: {key} must be a YAML list")
        return []
    return [str(item) for item in value]


def release_promotion_allowed(release_status: str, gate_values: Iterable[str]) -> bool:
    """Return whether the independent gates permit the requested release state."""
    values = list(gate_values)
    if release_status not in {"submission-ready", "released"}:
        return True
    return bool(values) and all(value == "pass" for value in values)


def validate_cards(cards: list[Card]) -> list[str]:
    errors: list[str] = []
    ids: dict[str, Card] = {}
    paths = {card.path.resolve(): card for card in cards}
    ratings = registry_ratings()
    expected_generated = {(GENERATED / name).resolve() for name in GENERATED_NAMES}
    required = {"schema_version", "id", "type", "title", "status", "baseline", "created", "updated", "tags", "aliases"}

    for card in cards:
        missing = sorted(required - set(card.metadata))
        if missing:
            errors.append(f"{card.path}: missing fields {', '.join(missing)}")
        if card.metadata.get("schema_version") != "1":
            errors.append(f"{card.path}: schema_version must be 1")
        if card.id in ids:
            errors.append(f"{card.path}: duplicate id {card.id} also in {ids[card.id].path}")
        else:
            ids[card.id] = card
        if card.path.stem != card.id:
            errors.append(f"{card.path}: filename must equal id {card.id}.md")
        if not ID_RE.fullmatch(card.id):
            errors.append(f"{card.path}: invalid stable id {card.id!r}")
        if card.type not in NOTE_TYPES:
            errors.append(f"{card.path}: invalid type {card.type!r}")
        if str(card.metadata.get("status", "")) not in STATUSES:
            errors.append(f"{card.path}: invalid status {card.metadata.get('status')!r}")
        if not HASH_RE.fullmatch(str(card.metadata.get("baseline", ""))):
            errors.append(f"{card.path}: baseline must be a full lowercase Git hash")
        for key in ("created", "updated"):
            if not DATE_RE.fullmatch(str(card.metadata.get(key, ""))):
                errors.append(f"{card.path}: {key} must be YYYY-MM-DD")
        _require_list(card, "tags", errors)
        _require_list(card, "aliases", errors)

        if card.type == "claim":
            proof_status = str(card.metadata.get("proof_status", ""))
            if proof_status not in PROOF_STATUSES:
                errors.append(f"{card.path}: invalid proof_status {proof_status!r}")
            if card.metadata.get("global_effect") != "none":
                errors.append(f"{card.path}: pilot cards require global_effect: none")
            claim_ids = _require_list(card, "claim_ids", errors)
            if len(claim_ids) != 1:
                errors.append(f"{card.path}: pilot claim card must name exactly one claim_id")
            if claim_ids:
                expected = ratings.get(claim_ids[0])
                actual = tuple(str(card.metadata.get(key, "")) for key in ("rating_c", "rating_v", "rating_i", "rating_n", "rating_r"))
                if expected is None:
                    errors.append(f"{card.path}: claim_id {claim_ids[0]} has no rated canonical registry row")
                elif actual != expected:
                    errors.append(f"{card.path}: ratings {actual} differ from canonical {expected}")
        if card.type == "route" and str(card.metadata.get("route_status", "")) not in ROUTE_STATUSES:
            errors.append(f"{card.path}: invalid route_status {card.metadata.get('route_status')!r}")
        if card.type == "artifact":
            level = str(card.metadata.get("verification_level", ""))
            if not re.fullmatch(r"V[0-4]", level):
                errors.append(f"{card.path}: invalid verification_level {level!r}")
            for key in ("command", "expected", "artifact_kind"):
                if not str(card.metadata.get(key, "")).strip():
                    errors.append(f"{card.path}: artifact requires {key}")
        if card.type == "release":
            release_status = str(card.metadata.get("release_status", ""))
            if release_status not in {"hold", "submission-ready", "released"}:
                errors.append(f"{card.path}: invalid release_status {release_status!r}")
            gate_keys = (
                "gate_correctness",
                "gate_priority",
                "gate_dependency_closure",
                "gate_reproducibility",
                "gate_source_integrity",
                "gate_attribution",
                "gate_reporting",
                "gate_review",
            )
            gate_values = [str(card.metadata.get(key, "")) for key in gate_keys]
            for key, value in zip(gate_keys, gate_values):
                if value not in GATE_VALUES:
                    errors.append(f"{card.path}: invalid {key} value {value!r}")
            if not release_promotion_allowed(release_status, gate_values):
                errors.append(f"{card.path}: release promotion requires every gate to pass")

        for relation in card.relations:
            if relation.name not in RELATIONS:
                errors.append(f"{card.path}: unknown relation {relation.name!r}")
            target_card = paths.get(relation.target_path)
            if target_card is None:
                errors.append(f"{card.path}: typed relation target is not a card: {relation.target_text}")
            else:
                allowed_targets = RELATION_TARGET_TYPES.get(relation.name)
                if allowed_targets is not None and target_card.type not in allowed_targets:
                    errors.append(
                        f"{card.path}: relation {relation.name!r} requires target type "
                        f"{sorted(allowed_targets)}, got {target_card.type!r}"
                    )

        for target_text in LINK_RE.findall(card.body):
            if re.match(r"^(?:https?://|mailto:|obsidian://)", target_text):
                continue
            target_path = resolve_local_target(card.path, target_text)
            if target_path == card.path and target_text.startswith("#"):
                continue
            if target_path in expected_generated:
                continue
            if not exact_case_exists(target_path):
                errors.append(f"{card.path}: missing or case-mismatched local link {target_text}")

    return errors


def validate_repository_links() -> list[str]:
    _, _, _, broken = repository_link_data()
    return [
        f"{source}: missing or case-mismatched repository-local link {target}"
        for source, target in broken
    ]


def relative_link(source_directory: Path, target: Path) -> str:
    return Path(os.path.relpath(target, source_directory)).as_posix()


def generated_header(title: str) -> list[str]:
    return [
        "<!-- GENERATED by knowledge/tools/build_index.py; DO NOT EDIT. -->",
        f"# {title}",
        "",
        "> Collatz remains unresolved. This view is navigation metadata, not a proof graph.",
        "",
    ]


def generate_index(cards: list[Card]) -> str:
    lines = generated_header("Notebook index")
    lines.extend(["| ID | Type | Title | Status | Proof status |", "|---|---|---|---|---|"])
    for card in sorted(cards, key=lambda item: item.id):
        link = relative_link(GENERATED, card.path)
        lines.append(
            f"| [`{card.id}`]({link}) | `{card.type}` | {card.title} | `{card.metadata.get('status', '')}` | `{card.metadata.get('proof_status', 'n/a')}` |"
        )
    return "\n".join(lines) + "\n"


def generate_backlinks(cards: list[Card]) -> str:
    by_path = {card.path.resolve(): card for card in cards}
    incoming: dict[str, list[tuple[str, Card]]] = {card.id: [] for card in cards}
    for source in cards:
        for relation in source.relations:
            target = by_path.get(relation.target_path)
            if target:
                incoming[target.id].append((relation.name, source))
    lines = generated_header("Typed backlinks")
    for target in sorted(cards, key=lambda item: item.id):
        link = relative_link(GENERATED, target.path)
        lines.append(f"## [`{target.id}` — {target.title}]({link})")
        lines.append("")
        entries = sorted(incoming[target.id], key=lambda item: (item[0], item[1].id))
        if not entries:
            lines.append("_No typed incoming links in the pilot graph._")
        else:
            for relation, source in entries:
                source_link = relative_link(GENERATED, source.path)
                lines.append(f"- **{relation}:** [`{source.id}`]({source_link})")
        lines.append("")
    return "\n".join(lines)


def generate_status(cards: list[Card]) -> str:
    lines = generated_header("Route, claim, and failure status matrix")
    lines.extend(["| ID | Kind | Canonical/pilot status | Proof or route status | Ratings |", "|---|---|---|---|---|"])
    for card in sorted((item for item in cards if item.type in {"claim", "route", "failure"}), key=lambda item: (item.type, item.id)):
        link = relative_link(GENERATED, card.path)
        exact = card.metadata.get("proof_status", card.metadata.get("route_status", "n/a"))
        ratings = " ".join(str(card.metadata.get(key, "")) for key in ("rating_c", "rating_v", "rating_i", "rating_n", "rating_r")).strip() or "n/a"
        lines.append(f"| [`{card.id}`]({link}) | `{card.type}` | `{card.metadata.get('status', '')}` | `{exact}` | `{ratings}` |")
    return "\n".join(lines) + "\n"


def generate_verification(cards: list[Card]) -> str:
    by_path = {card.path.resolve(): card for card in cards}
    lines = generated_header("Verification matrix")
    lines.extend(["| Claim | Relation | Artifact | Artifact level |", "|---|---|---|---|"])
    rows = 0
    for claim in sorted((item for item in cards if item.type == "claim"), key=lambda item: item.id):
        for relation in claim.relations:
            if relation.name not in {"verified-by", "formalized-by", "tested-by"}:
                continue
            artifact = by_path.get(relation.target_path)
            if not artifact:
                continue
            claim_link = relative_link(GENERATED, claim.path)
            artifact_link = relative_link(GENERATED, artifact.path)
            level = artifact.metadata.get("verification_level", "n/a")
            lines.append(f"| [`{claim.id}`]({claim_link}) | `{relation.name}` | [`{artifact.id}`]({artifact_link}) | `{level}` |")
            rows += 1
    if rows == 0:
        lines.append("| _none_ |  |  |  |")
    lines.extend([
        "",
        "`tested-by` is bounded evidence. `verified-by` checks the full scoped claim. `formalized-by` requires exact proof-assistant declarations and axiom scope.",
    ])
    return "\n".join(lines) + "\n"


def mermaid_id(card_id: str) -> str:
    return "N_" + re.sub(r"[^A-Za-z0-9_]", "_", card_id)


def generate_graph(cards: list[Card]) -> str:
    selected_types = {"claim", "route", "failure", "source", "artifact", "experiment", "release"}
    selected = [item for item in cards if item.type in selected_types]
    selected_paths = {item.path.resolve(): item for item in selected}
    lines = generated_header("Route, claim, failure, and artifact graph")
    lines.extend(["```mermaid", "flowchart LR"])
    for card in sorted(selected, key=lambda item: item.id):
        label = f"{card.id}\\n{card.title}".replace('"', "'")
        lines.append(f"    {mermaid_id(card.id)}[\"{label}\"]:::{card.type}")
    for source in sorted(selected, key=lambda item: item.id):
        for relation in source.relations:
            target = selected_paths.get(relation.target_path)
            if target:
                lines.append(f"    {mermaid_id(source.id)} -- \"{relation.name}\" --> {mermaid_id(target.id)}")
    lines.extend([
        "    classDef claim fill:#dbeafe,stroke:#1d4ed8,color:#172554",
        "    classDef route fill:#dcfce7,stroke:#15803d,color:#052e16",
        "    classDef failure fill:#fee2e2,stroke:#b91c1c,color:#450a0a",
        "    classDef artifact fill:#f3e8ff,stroke:#7e22ce,color:#3b0764",
        "    classDef source fill:#fef3c7,stroke:#b45309,color:#451a03",
        "    classDef experiment fill:#f1f5f9,stroke:#475569,color:#0f172a",
        "    classDef release fill:#ffedd5,stroke:#c2410c,color:#431407",
    ])
    lines.extend([
        "```",
        "",
        "For every edge's exact scope, open the source card and then its canonical target.",
    ])
    return "\n".join(lines) + "\n"


def markdown_title(path: Path) -> str:
    for line in path.read_text(encoding="utf-8").splitlines():
        match = re.match(r"^#\s+(.+?)\s*$", line)
        if match:
            return match.group(1)
    return path.stem


def generate_file_catalog() -> str:
    files, outgoing, incoming, _ = repository_link_data()
    lines = generated_header("Repository-wide Markdown catalog")
    lines.extend([
        f"This view indexes {len(files)} human-edited Markdown files. Counts include ordinary local Markdown links outside code and display-math blocks.",
        "",
    ])
    groups: dict[str, list[Path]] = {}
    for path in files:
        relative = path.relative_to(ROOT)
        group = relative.parts[0] if len(relative.parts) > 1 else "repository root"
        groups.setdefault(group, []).append(path)
    for group in sorted(groups):
        lines.extend([
            f"## `{group}`",
            "",
            "| File | Title | Outgoing | Incoming |",
            "|---|---|---:|---:|",
        ])
        for path in groups[group]:
            link = relative_link(GENERATED, path)
            display = path.relative_to(ROOT).as_posix()
            title = markdown_title(path).replace("|", r"\|")
            lines.append(f"| [`{display}`]({link}) | {title} | {len(outgoing[path])} | {len(incoming[path])} |")
        lines.append("")
    return "\n".join(lines)


def generate_link_audit() -> str:
    files, _, _, broken = repository_link_data()
    lines = generated_header("Repository-local Markdown link audit")
    lines.extend([
        f"Checked {len(files)} human-edited Markdown files. External URLs, anchor existence, and intentional placeholder targets under template directories are outside this structural check; other local file targets are case-checked.",
        "",
    ])
    if not broken:
        lines.append("`BROKEN_LOCAL_FILE_TARGETS = 0`")
    else:
        lines.extend(["| Source | Target |", "|---|---|"])
        for source, target in broken:
            lines.append(f"| `{source.relative_to(ROOT).as_posix()}` | `{target}` |")
    return "\n".join(lines) + "\n"


def outputs(cards: list[Card]) -> dict[str, str]:
    return {
        "INDEX.md": generate_index(cards),
        "BACKLINKS.md": generate_backlinks(cards),
        "STATUS_MATRIX.md": generate_status(cards),
        "VERIFICATION_MATRIX.md": generate_verification(cards),
        "GRAPH.md": generate_graph(cards),
        "FILE_CATALOG.md": generate_file_catalog(),
        "LINK_AUDIT.md": generate_link_audit(),
    }


def run_self_test() -> None:
    with tempfile.TemporaryDirectory(prefix="cw-notebook-") as directory:
        root = Path(directory)
        valid = root / "CW-CON-TEST.md"
        valid.write_text(
            "---\nschema_version: 1\nid: CW-CON-TEST\ntype: concept\n"
            "title: Test\nstatus: draft\nbaseline: " + "0" * 40 + "\n"
            "created: 2026-08-24\nupdated: 2026-08-24\ntags:\n  - kind/test\n"
            "aliases: []\n---\n\n# Test\n",
            encoding="utf-8",
        )
        parsed = parse_card(valid)
        if parsed.id != "CW-CON-TEST":
            raise ValidationError("self-test: valid card was not parsed")

        malformed = root / "malformed.md"
        malformed.write_text("---\nid: broken\n", encoding="utf-8")
        rejected = False
        try:
            parse_card(malformed)
        except ValidationError:
            rejected = True
        if not rejected:
            raise ValidationError("self-test: missing delimiter false control was accepted")

        unknown = "- **invented-edge:** [x](x.md)\n"
        names = [match.group(1) for match in RELATION_RE.finditer(unknown)]
        if not names or all(name in RELATIONS for name in names):
            raise ValidationError("self-test: unknown-relation false control was not detected")

        if release_promotion_allowed("submission-ready", ["pass", "pending"]):
            raise ValidationError("self-test: pending release gate incorrectly permitted promotion")
        if not release_promotion_allowed("submission-ready", ["pass", "pass"]):
            raise ValidationError("self-test: all-pass release gate was incorrectly rejected")


def main(argv: Iterable[str] | None = None) -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true", help="fail when generated views are stale")
    parser.add_argument("--self-test", action="store_true", help="run checker false controls before validation")
    args = parser.parse_args(list(argv) if argv is not None else None)

    try:
        if args.self_test:
            run_self_test()
        cards = scan_cards()
        if not cards:
            raise ValidationError("no notebook cards found")
        errors = validate_cards(cards)
        errors.extend(validate_repository_links())
        if errors:
            raise ValidationError("\n".join(errors))
        rendered = outputs(cards)
        if args.check:
            stale: list[str] = []
            for name, content in rendered.items():
                path = GENERATED / name
                if not path.exists() or path.read_text(encoding="utf-8") != content:
                    stale.append(str(path.relative_to(ROOT)))
            if stale:
                raise ValidationError("stale generated views: " + ", ".join(stale))
        else:
            GENERATED.mkdir(parents=True, exist_ok=True)
            for name, content in rendered.items():
                (GENERATED / name).write_text(content, encoding="utf-8", newline="\n")
    except (OSError, ValidationError) as exc:
        print(f"KNOWLEDGE_NOTEBOOK = FAIL\n{exc}", file=sys.stderr)
        return 1

    action = "CHECK" if args.check else "BUILD"
    print(f"KNOWLEDGE_NOTEBOOK_{action} = PASS ({len(cards)} cards)")
    if args.self_test:
        print("KNOWLEDGE_NOTEBOOK_FALSE_CONTROLS = PASS")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
