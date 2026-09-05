#!/usr/bin/env python3
"""Build deterministic Markdown catalog/backlink views and validate links.

This supplements ATLAS.md. It validates repository structure, not mathematics,
citations, link-label truth, anchors, novelty, or publication readiness.
"""

from __future__ import annotations

import argparse
import os
import re
import sys
from collections import defaultdict
from dataclasses import dataclass
from pathlib import Path
from typing import Iterable
from urllib.parse import unquote


ROOT = Path(__file__).resolve().parents[2]
GENERATED = ROOT / "knowledge" / "_generated"
GENERATED_NAMES = ("FILE_CATALOG.md", "BACKLINKS.md", "LINK_AUDIT.md")
SKIP_PARTS = {".git", ".obsidian", "__pycache__"}
ALLOWED_NODE_TYPES = {
    "claim",
    "lemma",
    "route",
    "failure",
    "verification",
    "formalization",
    "source",
    "prompt",
    "map",
    "standard",
    "publication",
    "archive",
}
LINK_RE = re.compile(r"!?\[[^\]]*\]\(([^)\n]+)\)")
URI_SCHEME_RE = re.compile(r"^[A-Za-z][A-Za-z0-9+.-]*:")
WINDOWS_ABSOLUTE_RE = re.compile(r"^[A-Za-z]:/")
BODY_NODE_ID_RE = re.compile(r"^\*\*Node ID:\*\*\s*`([^`]+)`\s*$", re.MULTILINE)
BODY_NODE_TYPE_RE = re.compile(r"^\*\*Node type:\*\*\s*`([^`]+)`\s*$", re.MULTILINE)
FRONT_NODE_ID_RE = re.compile(r"^node_id:\s*[\"']?([^\"'\s]+)[\"']?\s*$", re.MULTILINE)
FRONT_NODE_TYPE_RE = re.compile(r"^node_type:\s*[\"']?([^\"'\s]+)[\"']?\s*$", re.MULTILINE)
VALIDATABLE_SUFFIXES = {
    ".md",
    ".py",
    ".lean",
    ".txt",
    ".json",
    ".yaml",
    ".yml",
    ".toml",
    ".csv",
    ".png",
    ".jpg",
    ".jpeg",
    ".svg",
    ".pdf",
}


class ValidationError(RuntimeError):
    """A fail-closed structural validation error."""


@dataclass(frozen=True)
class Note:
    path: Path
    title: str
    node_id: str | None
    node_type: str | None


@dataclass
class RepositoryData:
    notes: list[Note]
    outgoing: dict[Path, set[Path]]
    incoming: dict[Path, set[Path]]
    checked_local_targets: int
    broken: list[tuple[Path, str]]
    duplicate_ids: dict[str, list[Path]]
    node_errors: list[str]


def markdown_files() -> list[Path]:
    files: list[Path] = []
    for path in ROOT.rglob("*.md"):
        relative = path.relative_to(ROOT)
        if SKIP_PARTS.intersection(relative.parts):
            continue
        if relative.parts[:2] == ("knowledge", "_generated"):
            continue
        files.append(path.resolve())
    # pathlib ordering follows the host path flavour: Windows folds case while
    # POSIX does not. Sort by the exact repository-relative POSIX spelling so
    # committed views are byte-identical across runners.
    return sorted(files, key=lambda path: path.relative_to(ROOT).as_posix())


def strip_fenced_code(text: str) -> str:
    kept: list[str] = []
    inside = False
    fence = ""
    for line in text.splitlines():
        stripped = line.lstrip()
        if not inside and (stripped.startswith("```") or stripped.startswith("~~~")):
            inside = True
            fence = stripped[:3]
            continue
        if inside and stripped.startswith(fence):
            inside = False
            fence = ""
            continue
        if not inside:
            kept.append(line)
    return "\n".join(kept)


def raw_link_target(raw: str) -> str:
    raw = raw.strip()
    if raw.startswith("<") and ">" in raw:
        return raw[1 : raw.index(">")]
    return raw.split(maxsplit=1)[0]


def normalized_local_part(raw: str) -> str | None:
    target = unquote(raw_link_target(raw)).replace("\\", "/")
    if not target or target.startswith("#"):
        return None
    if URI_SCHEME_RE.match(target) and not WINDOWS_ABSOLUTE_RE.match(target):
        return None
    return target.split("#", 1)[0].split("?", 1)[0]


def should_validate(path_part: str) -> bool:
    suffix = Path(path_part).suffix.lower()
    return bool(suffix in VALIDATABLE_SUFFIXES or "/" in path_part or path_part.startswith("."))


def resolve_local(source: Path, path_part: str) -> Path:
    if path_part.startswith("/"):
        return (ROOT / path_part.lstrip("/")).resolve()
    return (source.parent / path_part).resolve()


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


def markdown_title(text: str, path: Path) -> str:
    for line in text.splitlines():
        match = re.match(r"^#\s+(.+?)\s*$", line)
        if match:
            return match.group(1)
    return path.stem


def frontmatter(text: str) -> str:
    lines = text.splitlines()
    if not lines or lines[0] != "---":
        return ""
    try:
        end = lines.index("---", 1)
    except ValueError:
        return ""
    return "\n".join(lines[1:end])


def one_match(pattern: re.Pattern[str], text: str, label: str, path: Path) -> tuple[str | None, list[str]]:
    values = pattern.findall(text)
    unique = sorted(set(values))
    if len(unique) > 1:
        return None, [f"{path}: multiple {label} values: {unique}"]
    return (unique[0] if unique else None), []


def note_metadata(path: Path, text: str) -> tuple[Note, list[str]]:
    errors: list[str] = []
    fm = frontmatter(text)
    front_id, found = one_match(FRONT_NODE_ID_RE, fm, "frontmatter node_id", path)
    errors.extend(found)
    front_type, found = one_match(FRONT_NODE_TYPE_RE, fm, "frontmatter node_type", path)
    errors.extend(found)
    body_id, found = one_match(BODY_NODE_ID_RE, text, "body Node ID", path)
    errors.extend(found)
    body_type, found = one_match(BODY_NODE_TYPE_RE, text, "body Node type", path)
    errors.extend(found)
    if front_id and body_id and front_id != body_id:
        errors.append(f"{path}: frontmatter/body node IDs disagree")
    if front_type and body_type and front_type != body_type:
        errors.append(f"{path}: frontmatter/body node types disagree")
    node_id = front_id or body_id
    node_type = front_type or body_type
    if bool(node_id) != bool(node_type):
        errors.append(f"{path}: node_id and node_type must appear together")
    if node_type and node_type not in ALLOWED_NODE_TYPES:
        errors.append(f"{path}: unsupported node type {node_type!r}")
    return Note(path, markdown_title(text, path), node_id, node_type), errors


def collect_repository_data() -> RepositoryData:
    paths = markdown_files()
    path_set = set(paths)
    notes: list[Note] = []
    outgoing: dict[Path, set[Path]] = {path: set() for path in paths}
    incoming: dict[Path, set[Path]] = {path: set() for path in paths}
    broken: list[tuple[Path, str]] = []
    node_errors: list[str] = []
    node_paths: dict[str, list[Path]] = defaultdict(list)
    checked = 0
    expected_generated = {(GENERATED / name).resolve() for name in GENERATED_NAMES}

    for source in paths:
        text = source.read_text(encoding="utf-8")
        note, errors = note_metadata(source, text)
        notes.append(note)
        node_errors.extend(errors)
        if note.node_id:
            node_paths[note.node_id].append(source)

        visible = strip_fenced_code(text)
        is_template = "templates" in source.relative_to(ROOT).parts
        for raw in LINK_RE.findall(visible):
            path_part = normalized_local_part(raw)
            if path_part is None or not should_validate(path_part):
                continue
            checked += 1
            target = resolve_local(source, path_part)
            if target in expected_generated:
                continue
            if not exact_case_exists(target):
                if not is_template:
                    broken.append((source, raw))
                continue
            if target in path_set:
                outgoing[source].add(target)
                incoming[target].add(source)

    duplicates = {node_id: values for node_id, values in node_paths.items() if len(values) > 1}
    return RepositoryData(notes, outgoing, incoming, checked, broken, duplicates, node_errors)


def relative_link(source_directory: Path, target: Path) -> str:
    return Path(os.path.relpath(target, source_directory)).as_posix()


def generated_header(title: str) -> list[str]:
    return [
        "<!-- GENERATED by knowledge/tools/build_index.py; DO NOT EDIT. -->",
        f"# {title}",
        "",
        "> Supplement to `ATLAS.md`. Collatz remains unresolved; this is structural navigation, not mathematical evidence.",
        "",
    ]


def generate_catalog(data: RepositoryData) -> str:
    lines = generated_header("Repository-wide Markdown catalog")
    lines.extend([
        f"Indexed {len(data.notes)} human-edited Markdown files.",
        "",
    ])
    groups: dict[str, list[Note]] = defaultdict(list)
    for note in data.notes:
        relative = note.path.relative_to(ROOT)
        group = relative.parts[0] if len(relative.parts) > 1 else "repository root"
        groups[group].append(note)
    for group in sorted(groups):
        lines.extend([
            f"## `{group}`",
            "",
            "| File | Title | Node | Out | In |",
            "|---|---|---|---:|---:|",
        ])
        for note in groups[group]:
            path_text = note.path.relative_to(ROOT).as_posix()
            link = relative_link(GENERATED, note.path)
            title = note.title.replace("|", r"\|")
            node = f"`{note.node_id}` / `{note.node_type}`" if note.node_id else "—"
            lines.append(
                f"| [`{path_text}`]({link}) | {title} | {node} | "
                f"{len(data.outgoing[note.path])} | {len(data.incoming[note.path])} |"
            )
        lines.append("")
    return "\n".join(lines)


def generate_backlinks(data: RepositoryData) -> str:
    lines = generated_header("Repository-wide backlinks")
    lines.append("Incoming links are derived from ordinary local Markdown links outside fenced code.")
    lines.append("")
    for note in data.notes:
        target_link = relative_link(GENERATED, note.path)
        lines.append(f"## [{note.title}]({target_link})")
        lines.append("")
        sources = sorted(
            data.incoming[note.path],
            key=lambda path: path.relative_to(ROOT).as_posix(),
        )
        if not sources:
            lines.append("_No incoming local Markdown links._")
        else:
            for source in sources:
                source_link = relative_link(GENERATED, source)
                lines.append(f"- [{source.relative_to(ROOT).as_posix()}]({source_link})")
        lines.append("")
    return "\n".join(lines)


def generate_audit(data: RepositoryData) -> str:
    lines = generated_header("Local-link and node-ID audit")
    lines.extend([
        f"- Human-edited Markdown files: `{len(data.notes)}`",
        f"- Local file targets checked: `{data.checked_local_targets}`",
        f"- Broken or case-mismatched targets: `{len(data.broken)}`",
        f"- Duplicate optional node IDs: `{len(data.duplicate_ids)}`",
        f"- Node metadata errors: `{len(data.node_errors)}`",
        "",
        "External URLs, heading-anchor existence, and mathematical link-label semantics are outside this check. Intentional placeholder links under template directories are excluded.",
        "",
    ])
    if not data.broken and not data.duplicate_ids and not data.node_errors:
        lines.append("`KNOWLEDGE_SUPPLEMENT_AUDIT = PASS`")
    else:
        for source, raw in data.broken:
            lines.append(f"- **BROKEN:** `{source.relative_to(ROOT).as_posix()}` → `{raw}`")
        for node_id, paths in sorted(data.duplicate_ids.items()):
            rendered = ", ".join(f"`{path.relative_to(ROOT).as_posix()}`" for path in paths)
            lines.append(f"- **DUPLICATE NODE ID `{node_id}`:** {rendered}")
        for error in data.node_errors:
            lines.append(f"- **NODE ERROR:** {error}")
    return "\n".join(lines) + "\n"


def outputs(data: RepositoryData) -> dict[str, str]:
    return {
        "FILE_CATALOG.md": generate_catalog(data),
        "BACKLINKS.md": generate_backlinks(data),
        "LINK_AUDIT.md": generate_audit(data),
    }


def validation_errors(data: RepositoryData) -> list[str]:
    errors = [
        f"{source}: missing or case-mismatched local target {raw}"
        for source, raw in data.broken
    ]
    for node_id, paths in sorted(data.duplicate_ids.items()):
        errors.append(f"duplicate node ID {node_id}: {paths}")
    errors.extend(data.node_errors)
    return errors


def run_self_test() -> None:
    sample = "[visible](README.md)\n```markdown\n[ignored](missing.md)\n```\n"
    visible = strip_fenced_code(sample)
    found = LINK_RE.findall(visible)
    if found != ["README.md"]:
        raise ValidationError(f"self-test: fenced-code false control failed: {found}")
    if normalized_local_part("<../README.md#top>") != "../README.md":
        raise ValidationError("self-test: angle/anchor target normalization failed")
    if normalized_local_part("zotero://select/library/items/ABC123") is not None:
        raise ValidationError("self-test: external application URI was treated as a local path")
    if normalized_local_part("C:/absolute/path.md") != "C:/absolute/path.md":
        raise ValidationError("self-test: Windows absolute path escaped local-path validation")
    if should_validate("x") or not should_validate("README.md"):
        raise ValidationError("self-test: mathematical-call/file-link distinction failed")
    if not exact_case_exists(ROOT / "README.md"):
        raise ValidationError("self-test: canonical README path was not found")
    mixed = [ROOT / "z.md", ROOT / "A.md", ROOT / "a.md"]
    ordered = sorted(mixed, key=lambda path: path.relative_to(ROOT).as_posix())
    if [path.name for path in ordered] != ["A.md", "a.md", "z.md"]:
        raise ValidationError("self-test: platform-neutral path ordering failed")


def main(argv: Iterable[str] | None = None) -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--check", action="store_true", help="fail when generated views are stale")
    parser.add_argument("--self-test", action="store_true", help="run checker false controls")
    args = parser.parse_args(list(argv) if argv is not None else None)

    try:
        if args.self_test:
            run_self_test()
        data = collect_repository_data()
        errors = validation_errors(data)
        if errors:
            raise ValidationError("\n".join(errors))
        rendered = outputs(data)
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
        print(f"KNOWLEDGE_SUPPLEMENTS = FAIL\n{exc}", file=sys.stderr)
        return 1

    action = "CHECK" if args.check else "BUILD"
    print(f"KNOWLEDGE_SUPPLEMENTS_{action} = PASS ({len(data.notes)} notes)")
    if args.self_test:
        print("KNOWLEDGE_SUPPLEMENTS_FALSE_CONTROLS = PASS")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
