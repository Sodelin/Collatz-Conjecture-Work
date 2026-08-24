"""Check and mechanically normalize Markdown math delimiters.

The shared rendering contract is `$...$` for inline math and standalone `$$`
lines for display math. The fixer changes only legacy `\\(...\\)` pairs and
standalone `\\[` / `\\]` lines outside code. It does not rewrite TeX bodies.
"""

from __future__ import annotations

import argparse
import re
import sys
from dataclasses import dataclass
from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]
SKIP_PARTS = {".git", ".obsidian", "__pycache__"}
FENCE_RE = re.compile(r"^ {0,3}(`{3,}|~{3,})")
BLOCKQUOTE_FENCE_RE = re.compile(r"^ {0,3}(?:>\s*)+(`{3,}|~{3,})")
INLINE_OPEN = re.compile(r"(?<!\\)\\\(")
INLINE_CLOSE = re.compile(r"(?<!\\)\\\)")
LEGACY_DISPLAY = re.compile(r"(?<!\\)\\[\[\]]")
UNESCAPED_DOLLAR = re.compile(r"(?<!\\)\$")
RAW_TEX_COMMAND = re.compile(r"(?<!\\)\\[A-Za-z]+")
RAW_HTML_CODE = re.compile(r"</?(?:code|pre)(?:\s|>)", re.IGNORECASE)
RAW_HTML_LINK = re.compile(r"<(?:a|area|img|source)\b", re.IGNORECASE)
REFERENCE_DEFINITION = re.compile(r"^\s*\[[^\]\n]+\]:")
MARKDOWN_LINK = re.compile(r"!?\[[^\]\n]*\]\((?P<destination>(?:\\.|[^)\n])*)\)")
AUTOLINK = re.compile(r"<(?:https?://|mailto:)[^>\n]+>", re.IGNORECASE)
LITERAL_DOLLAR_SPAN = re.compile(r"<span>\$</span>", re.IGNORECASE)


@dataclass
class Result:
    text: str
    display_pairs: int = 0
    inline_pairs: int = 0
    changed: bool = False
    errors: list[str] | None = None


def split_ending(line: str) -> tuple[str, str]:
    if line.endswith("\r\n"):
        return line[:-2], "\r\n"
    if line.endswith("\n") or line.endswith("\r"):
        return line[:-1], line[-1]
    return line, ""


def mask_link_destinations(text: str) -> str:
    pieces: list[str] = []
    position = 0
    for match in MARKDOWN_LINK.finditer(text):
        destination_start, destination_end = match.span("destination")
        pieces.append(text[position:destination_start])
        pieces.append("LINK_DESTINATION")
        position = destination_end
    pieces.append(text[position:])
    masked = "".join(pieces)
    return AUTOLINK.sub("AUTOLINK", masked)


def transform_plain_segment(segment: str, *, fix: bool, label: str, line_number: int) -> tuple[str, int, list[str]]:
    output: list[str] = []
    position = 0
    pairs = 0
    errors: list[str] = []
    if LEGACY_DISPLAY.search(segment):
        errors.append(f"{label}:{line_number}: legacy display delimiter must be standalone")
        return segment, pairs, errors
    if RAW_HTML_CODE.search(segment):
        errors.append(f"{label}:{line_number}: raw HTML code/pre container is unsupported")
        return segment, pairs, errors
    has_legacy_inline = INLINE_OPEN.search(segment) or INLINE_CLOSE.search(segment)
    if has_legacy_inline and (
        "](" in segment or REFERENCE_DEFINITION.search(segment) or RAW_HTML_LINK.search(segment)
    ):
        errors.append(f"{label}:{line_number}: legacy math near a link requires manual review")
        return segment, pairs, errors
    for link in [*MARKDOWN_LINK.finditer(segment), *AUTOLINK.finditer(segment)]:
        destination = link.groupdict().get("destination", link.group(0))
        if INLINE_OPEN.search(destination) or INLINE_CLOSE.search(destination) or LEGACY_DISPLAY.search(destination):
            errors.append(f"{label}:{line_number}: legacy math delimiter inside link destination")
            return segment, pairs, errors
    while True:
        opening = INLINE_OPEN.search(segment, position)
        closing_before = INLINE_CLOSE.search(segment, position)
        if opening is None:
            if closing_before is not None:
                errors.append(f"{label}:{line_number}: unmatched inline closing delimiter")
            output.append(segment[position:])
            break
        if closing_before is not None and closing_before.start() < opening.start():
            errors.append(f"{label}:{line_number}: inline closing delimiter precedes opening")
            output.append(segment[position:])
            break
        closing = INLINE_CLOSE.search(segment, opening.end())
        if closing is None:
            errors.append(f"{label}:{line_number}: unmatched inline opening delimiter")
            output.append(segment[position:])
            break
        nested = INLINE_OPEN.search(segment, opening.end(), closing.start())
        if nested is not None:
            errors.append(f"{label}:{line_number}: nested inline delimiter")
            output.append(segment[position:])
            break
        body = segment[opening.end() : closing.start()]
        if re.search(r"(?<!\\)\$", body):
            errors.append(f"{label}:{line_number}: unescaped dollar inside legacy inline math")
            output.append(segment[position:])
            break
        output.append(segment[position : opening.start()])
        output.append(f"${body}$" if fix else segment[opening.start() : closing.end()])
        position = closing.end()
        pairs += 1
    rendered = "".join(output)
    if errors or (pairs and not fix):
        return rendered, pairs, errors
    validation_text = mask_link_destinations(LITERAL_DOLLAR_SPAN.sub("LITERAL_DOLLAR", rendered))
    dollar_positions = [match.start() for match in UNESCAPED_DOLLAR.finditer(validation_text)]
    if any(right == left + 1 for left, right in zip(dollar_positions, dollar_positions[1:])):
        errors.append(f"{label}:{line_number}: display dollars must be on standalone lines")
        return rendered, pairs, errors
    if len(dollar_positions) % 2:
        errors.append(f"{label}:{line_number}: unmatched inline dollar delimiter")
        return rendered, pairs, errors
    boundaries = [-1, *dollar_positions, len(validation_text)]
    for index in range(0, len(boundaries) - 1, 2):
        plain_text = validation_text[boundaries[index] + 1 : boundaries[index + 1]]
        command = RAW_TEX_COMMAND.search(plain_text)
        if command:
            errors.append(
                f"{label}:{line_number}: raw TeX command outside math: {command.group(0)}"
            )
            return rendered, pairs, errors
    return rendered, pairs, errors


def transform_inline_code_aware(line: str, *, fix: bool, label: str, line_number: int) -> tuple[str, int, list[str]]:
    output: list[str] = []
    position = 0
    pairs = 0
    errors: list[str] = []
    while position < len(line):
        tick = line.find("`", position)
        if tick < 0:
            rendered, count, found = transform_plain_segment(
                line[position:], fix=fix, label=label, line_number=line_number
            )
            output.append(rendered)
            pairs += count
            errors.extend(found)
            break
        rendered, count, found = transform_plain_segment(
            line[position:tick], fix=fix, label=label, line_number=line_number
        )
        output.append(rendered)
        pairs += count
        errors.extend(found)
        run = 1
        while tick + run < len(line) and line[tick + run] == "`":
            run += 1
        marker = "`" * run
        closing = line.find(marker, tick + run)
        if closing < 0:
            errors.append(f"{label}:{line_number}: multiline inline-code span is unsupported")
            output.append(line[tick:])
            break
        output.append(line[tick : closing + run])
        position = closing + run
    return "".join(output), pairs, errors


def transform_text(text: str, *, fix: bool, label: str) -> Result:
    lines = text.splitlines(keepends=True)
    output: list[str] = []
    errors: list[str] = []
    in_fence = False
    fence_character = ""
    fence_length = 0
    in_legacy_display = False
    in_dollar_display = False
    in_frontmatter = False
    display_pairs = 0
    inline_pairs = 0

    for line_number, full_line in enumerate(lines, start=1):
        line, ending = split_ending(full_line)
        if line_number == 1 and line.strip() == "---":
            in_frontmatter = True
            output.append(full_line)
            continue
        if in_frontmatter:
            output.append(full_line)
            if line.strip() == "---":
                in_frontmatter = False
            continue
        if not in_fence and line.startswith(("    ", "\t")):
            output.append(full_line)
            continue
        if BLOCKQUOTE_FENCE_RE.match(line):
            errors.append(f"{label}:{line_number}: blockquoted fenced code is unsupported")
            output.append(full_line)
            continue
        fence = FENCE_RE.match(line)
        if fence:
            marker = fence.group(1)
            if not in_fence:
                in_fence = True
                fence_character = marker[0]
                fence_length = len(marker)
            elif (
                marker[0] == fence_character
                and len(marker) >= fence_length
                and not line[fence.end() :].strip()
            ):
                in_fence = False
                fence_character = ""
                fence_length = 0
            output.append(full_line)
            continue
        if in_fence:
            output.append(full_line)
            continue

        stripped = line.strip()
        indentation = line[: len(line) - len(line.lstrip())]
        if stripped == r"\[":
            if in_legacy_display or in_dollar_display:
                errors.append(f"{label}:{line_number}: nested display opening delimiter")
            in_legacy_display = True
            output.append((indentation + "$$" if fix else line) + ending)
            continue
        if stripped == r"\]":
            if not in_legacy_display:
                errors.append(f"{label}:{line_number}: unmatched display closing delimiter")
            else:
                display_pairs += 1
            in_legacy_display = False
            output.append((indentation + "$$" if fix else line) + ending)
            continue
        if stripped == "$$":
            in_dollar_display = not in_dollar_display
            output.append(full_line)
            continue
        if in_legacy_display or in_dollar_display:
            output.append(full_line)
            continue
        rendered, count, found = transform_inline_code_aware(
            line, fix=fix, label=label, line_number=line_number
        )
        output.append(rendered + ending)
        inline_pairs += count
        errors.extend(found)

    if in_fence:
        errors.append(f"{label}: unclosed fenced code block")
    if in_frontmatter:
        errors.append(f"{label}: unclosed YAML frontmatter")
    if in_legacy_display:
        errors.append(f"{label}: unclosed legacy display delimiter")
    if in_dollar_display:
        errors.append(f"{label}: unclosed dollar display delimiter")
    rendered_text = "".join(output)
    return Result(
        text=rendered_text,
        display_pairs=display_pairs,
        inline_pairs=inline_pairs,
        changed=rendered_text != text,
        errors=errors,
    )


def markdown_files() -> list[Path]:
    return sorted(
        path
        for path in ROOT.rglob("*.md")
        if not SKIP_PARTS.intersection(path.relative_to(ROOT).parts)
    )


def run_self_test() -> None:
    sample = """Text with \\(x+1\\) and `\\(code\\)`.
\\[
\\begin{aligned}
a&=b\\\\[1mm]
\\end{aligned}
\\]
```md
\\[not math here\\]
```
"""
    result = transform_text(sample, fix=True, label="self-test")
    if result.errors:
        raise RuntimeError("self-test valid sample failed: " + "; ".join(result.errors))
    if result.inline_pairs != 1 or result.display_pairs != 1:
        raise RuntimeError("self-test delimiter counts failed")
    if "$x+1$" not in result.text or "`\\(code\\)`" not in result.text:
        raise RuntimeError("self-test inline conversion or code preservation failed")
    if "$$\n\\begin{aligned}" not in result.text or "\\\\[1mm]" not in result.text:
        raise RuntimeError("self-test display conversion changed TeX content")
    hostile_fence = transform_text(
        "```md\n```not-a-close\n\\(BODY\\)\n```\n", fix=True, label="fence-control"
    )
    if hostile_fence.errors or hostile_fence.changed or "\\(BODY\\)" not in hostile_fence.text:
        raise RuntimeError("self-test fenced-code hostile control failed")
    multiline_code = transform_text("`code\n\\(BODY\\)\ncode`\n", fix=True, label="span-control")
    if not multiline_code.errors:
        raise RuntimeError("self-test multiline-code false control was accepted")
    quoted_fence = transform_text("> ```md\n> \\(BODY\\)\n> ```\n", fix=True, label="quote-control")
    if not quoted_fence.errors:
        raise RuntimeError("self-test blockquoted-fence false control was accepted")
    valid_dollars = transform_text("Text with $x+1$ and `literal $`.\n", fix=False, label="dollar-control")
    if valid_dollars.errors:
        raise RuntimeError("self-test valid inline dollars failed")
    invalid_dollars = transform_text("Text with $unclosed.\n", fix=False, label="dollar-false-control")
    if not invalid_dollars.errors:
        raise RuntimeError("self-test unmatched-dollar false control was accepted")
    raw_tex = transform_text("Text with \\frac{x}{2}.\n", fix=False, label="tex-false-control")
    if not raw_tex.errors:
        raise RuntimeError("self-test raw-TeX false control was accepted")
    html_code = transform_text("<code>\\(BODY\\)</code>\n", fix=True, label="html-false-control")
    if not html_code.errors or html_code.changed:
        raise RuntimeError("self-test HTML-code false control was accepted")
    linked_tex = transform_text(
        "[literal](https://example/\\(BODY\\))\n", fix=True, label="link-false-control"
    )
    if not linked_tex.errors or linked_tex.changed:
        raise RuntimeError("self-test link-destination false control was accepted")
    balanced_link = transform_text(
        "[literal](https://example/a(b)/\\(BODY\\))\n",
        fix=True,
        label="balanced-link-false-control",
    )
    if not balanced_link.errors or balanced_link.changed:
        raise RuntimeError("self-test balanced-link false control was accepted")
    reference_link = transform_text(
        "[id]: https://example/\\(BODY\\)\n", fix=True, label="reference-link-false-control"
    )
    if not reference_link.errors or reference_link.changed:
        raise RuntimeError("self-test reference-link false control was accepted")
    html_link = transform_text(
        '<a href="https://example/\\(BODY\\)">link</a>\n',
        fix=True,
        label="html-link-false-control",
    )
    if not html_link.errors or html_link.changed:
        raise RuntimeError("self-test HTML-link false control was accepted")
    literal_dollar = transform_text(
        "The symbol <span>$</span> differs from $x$.\n", fix=False, label="literal-dollar-control"
    )
    if literal_dollar.errors:
        raise RuntimeError("self-test literal-dollar span failed")
    broken = transform_text("Text \\(unclosed\n", fix=False, label="false-control")
    if not broken.errors:
        raise RuntimeError("self-test unmatched-delimiter false control was accepted")


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--fix", action="store_true", help="replace supported legacy delimiters in place")
    parser.add_argument("--self-test", action="store_true")
    args = parser.parse_args()

    try:
        if args.self_test:
            run_self_test()
        files = markdown_files()
        changed = 0
        display_pairs = 0
        inline_pairs = 0
        errors: list[str] = []
        pending_writes: list[tuple[Path, str]] = []
        for path in files:
            relative = path.relative_to(ROOT).as_posix()
            with path.open("r", encoding="utf-8", newline="") as handle:
                original = handle.read()
            result = transform_text(original, fix=args.fix, label=relative)
            display_pairs += result.display_pairs
            inline_pairs += result.inline_pairs
            errors.extend(result.errors or [])
            if not args.fix and result.display_pairs:
                errors.append(f"{relative}: {result.display_pairs} legacy display pair(s) remain")
            if not args.fix and result.inline_pairs:
                errors.append(f"{relative}: {result.inline_pairs} legacy inline pair(s) remain")
            if args.fix and result.changed:
                pending_writes.append((path, result.text))
                changed += 1
        if errors:
            raise RuntimeError("\n".join(errors))
        for path, rendered_text in pending_writes:
            with path.open("w", encoding="utf-8", newline="") as handle:
                handle.write(rendered_text)
    except (OSError, RuntimeError) as exc:
        print(f"MARKDOWN_MATH = FAIL\n{exc}", file=sys.stderr)
        return 1

    mode = "FIX" if args.fix else "CHECK"
    print(f"MARKDOWN_MATH_{mode} = PASS")
    print(f"markdown files = {len(files)}")
    print(f"legacy display pairs = {display_pairs}")
    print(f"legacy inline pairs = {inline_pairs}")
    print(f"files changed = {changed}")
    if args.self_test:
        print("MARKDOWN_MATH_FALSE_CONTROLS = PASS")
    return 0


if __name__ == "__main__":
    sys.exit(main())
