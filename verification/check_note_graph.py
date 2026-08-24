"""Verify the portable Markdown knowledge graph.

This checks repository navigation only. It does not validate mathematics,
citations, anchors, or the truth of link labels.
"""

from __future__ import annotations

from collections import deque
from pathlib import Path
import re
import sys
from urllib.parse import unquote


ROOT = Path(__file__).resolve().parents[1]
ENTRY = ROOT / "README.md"
SKIP_PARTS = {".git", ".obsidian", "__pycache__"}
LINK_RE = re.compile(r"!?\[[^\]]*\]\(([^)\n]+)\)")


def markdown_files() -> list[Path]:
    return sorted(
        path.resolve()
        for path in ROOT.rglob("*.md")
        if not SKIP_PARTS.intersection(path.relative_to(ROOT).parts)
    )


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


def link_target(raw: str) -> str:
    raw = raw.strip()
    if raw.startswith("<") and ">" in raw:
        return raw[1 : raw.index(">")]
    return raw.split(maxsplit=1)[0]


def resolve_markdown_link(source: Path, raw: str) -> Path | None:
    target = unquote(link_target(raw)).replace("\\", "/")
    if not target or target.startswith("#"):
        return None
    lowered = target.lower()
    if lowered.startswith(("http://", "https://", "mailto:", "obsidian://")):
        return None

    path_part = target.split("#", 1)[0].split("?", 1)[0]
    if not path_part.lower().endswith(".md"):
        return None
    if path_part.startswith("/"):
        return (ROOT / path_part.lstrip("/")).resolve()
    return (source.parent / path_part).resolve()


def relative(path: Path) -> str:
    return path.relative_to(ROOT).as_posix()


def main() -> int:
    notes = markdown_files()
    note_set = set(notes)
    adjacency = {note: set() for note in notes}
    broken: list[tuple[Path, str, Path]] = []
    checked_links = 0

    for source in notes:
        text = strip_fenced_code(source.read_text(encoding="utf-8"))
        for match in LINK_RE.finditer(text):
            target = resolve_markdown_link(source, match.group(1))
            if target is None:
                continue
            checked_links += 1
            if target not in note_set:
                broken.append((source, match.group(1), target))
            else:
                adjacency[source].add(target)

    if ENTRY not in note_set:
        print("missing public entry point: README.md")
        return 1

    reachable = {ENTRY}
    queue: deque[Path] = deque([ENTRY])
    while queue:
        source = queue.popleft()
        for target in adjacency[source]:
            if target not in reachable:
                reachable.add(target)
                queue.append(target)

    orphans = sorted(note_set - reachable)

    print(f"markdown notes = {len(notes)}")
    print(f"local Markdown links checked = {checked_links}")
    print(f"broken local Markdown links = {len(broken)}")
    print(f"notes reachable from README.md = {len(reachable)}")
    print(f"unreachable notes = {len(orphans)}")

    for source, raw, target in broken:
        try:
            rendered_target = relative(target)
        except ValueError:
            rendered_target = str(target)
        print(f"BROKEN {relative(source)}: {raw} -> {rendered_target}")
    for orphan in orphans:
        print(f"UNREACHABLE {relative(orphan)}")

    if broken or orphans:
        return 1
    print("NOTE_GRAPH = PASS")
    return 0


if __name__ == "__main__":
    sys.exit(main())
