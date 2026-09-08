#!/usr/bin/env python3
"""Build an idempotent public browse index from exported receipts only; no network."""
from __future__ import annotations

import argparse
from datetime import datetime, timezone
import json
import os
from pathlib import Path
import re
import tempfile
from urllib.parse import urlsplit

PROJECTS = (
    ("collatz", "Collatz auxiliary results"),
    ("erdos302", "Erdős 302 finite certificates"),
    ("egyptian295", "Egyptian fractions / Erdős 295"),
    ("newmath", "Abstract discovery results"),
)
IDENTIFIER = re.compile(r"^[A-Za-z0-9_-]{1,200}$")
NAME = re.compile(r"^[A-Za-z_][A-Za-z0-9_.]*$")
SHA = re.compile(r"^[a-f0-9]{40}$")
SECRET_FIELDS = {"api_key", "access_token", "refresh_token", "password", "authorization"}
STAGES = {
    "new": "Not submitted", "publish_intent": "Publication outcome unknown",
    "verify_intent": "Proof outcome unknown", "needs_reconciliation": "Needs reconciliation",
    "publish_queued": "Publication queued", "published": "Awaiting proof submission",
    "verify_queued": "Proof queued", "accepted_pending_catalog": "Accepted; catalog pending",
    "sketch_accepted": "Sketch accepted", "complete": "Complete", "failed": "Failed",
}


def reject_credentials(value):
    if isinstance(value, dict):
        if any(str(key).lower() in SECRET_FIELDS for key in value):
            raise ValueError("Receipt contains a credential field; refusing index generation")
        for child in value.values():
            reject_credentials(child)
    elif isinstance(value, list):
        for child in value:
            reject_credentials(child)


def public_url(record):
    """The public theorem route also displays definition entities."""
    entity_id = record.get("theorem_id")
    if not entity_id:
        return None
    if not isinstance(entity_id, str) or not IDENTIFIER.fullmatch(entity_id):
        raise ValueError("Invalid entity identifier in receipt")
    canonical = "https://prove2.me/theorems/" + entity_id
    # Do not copy arbitrary URL fields, query strings, or credentials to Markdown.
    return canonical


def source_url(source):
    repository, commit = source.get("repository", ""), source.get("commit", "")
    parsed = urlsplit(repository)
    if parsed.scheme != "https" or parsed.netloc != "github.com" or parsed.query or parsed.fragment:
        raise ValueError("Receipt source must be an ordinary HTTPS GitHub repository")
    if not re.fullmatch(r"/[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+/?", parsed.path) or not SHA.fullmatch(commit):
        raise ValueError("Receipt source repository or commit is invalid")
    return repository.rstrip("/") + "/tree/" + commit, commit


def render(receipts_dir, output_dir):
    projects = []
    all_times = []
    for slug, title in PROJECTS:
        path = receipts_dir / (slug + ".json")
        receipt = json.loads(path.read_text())
        reject_credentials(receipt)
        if receipt.get("schema_version") != 1 or not isinstance(receipt.get("items"), dict):
            raise ValueError("Missing or unsupported receipt schema")
        rows = []
        for key, record in sorted(receipt["items"].items()):
            prefix, separator, name = key.partition(":")
            if separator != ":" or prefix not in {"def", "thm"} or not NAME.fullmatch(name):
                raise ValueError("Unknown declaration key in receipt")
            stage = record.get("status")
            if stage not in STAGES:
                raise ValueError("Unknown publication stage in receipt")
            remote = record.get("remote_status")
            if remote is not None and remote not in {"Definition", "Proved", "Open", "Disproved"}:
                raise ValueError("Unknown remote catalog status in receipt")
            rows.append({"name": name, "kind": "Definition" if prefix == "def" else "Theorem",
                         "stage": stage, "remote": remote, "url": public_url(record)})
        counts = {kind: sum(row["kind"] == kind for row in rows) for kind in ("Theorem", "Definition")}
        proved = sum(row["kind"] == "Theorem" and row["stage"] == "complete" and row["remote"] == "Proved" for row in rows)
        definitions = sum(row["kind"] == "Definition" and row["stage"] == "complete" and row["remote"] == "Definition" for row in rows)
        final_passed = receipt.get("complete") is True
        if final_passed and (not rows or proved + definitions != len(rows)):
            raise ValueError("Receipt claims completion without required per-item statuses")
        times = [event["at"] for event in receipt.get("events", []) if isinstance(event, dict) and isinstance(event.get("at"), (int, float))]
        all_times.extend(times)
        source, commit = source_url(receipt.get("source", {}))
        relative_receipt = Path(os.path.relpath(path, output_dir)).as_posix()
        if re.search(r"[\s()\[\]]", relative_receipt):
            raise ValueError("Receipt path must be Markdown-safe")
        projects.append({"slug": slug, "title": title, "rows": rows, "counts": counts,
                         "proved": proved, "definitions": definitions, "final": final_passed,
                         "source": source, "commit": commit, "receipt": relative_receipt})
    total_proved = sum(project["proved"] for project in projects)
    total_theorems = sum(project["counts"]["Theorem"] for project in projects)
    total_definitions = sum(project["definitions"] for project in projects)
    expected_definitions = sum(project["counts"]["Definition"] for project in projects)
    complete = all(project["final"] for project in projects)
    timestamp = datetime.fromtimestamp(max(all_times), timezone.utc).isoformat() if all_times else "No server activity recorded"
    lines = ["# Prove2Me public results", "",
        f"**{total_proved}/{total_theorems} theorems Proved; {total_definitions}/{expected_definitions} definitions published.** "
        + ("Every project passed final catalog verification." if complete else "Publication or final catalog verification remains in progress."), "",
        "This index reflects saved publication receipts. The links use Prove2Me's public entity route and recorded server IDs; generating this file does not recheck the live website.", "",
        f"Latest recorded activity (UTC): {timestamp}.", "",
        "## Projects", "",
        "| Project | Proved theorems | Published definitions | Final catalog verification | Receipts |",
        "| --- | ---: | ---: | --- | --- |"]
    for project in projects:
        lines.append(f"| [{project['title']}](#{project['slug']}) | {project['proved']}/{project['counts']['Theorem']} | {project['definitions']}/{project['counts']['Definition']} | {'Passed' if project['final'] else 'Pending'} | [JSON]({project['receipt']}) |")
    lines += ["", "Theorems are counted as Proved only when the receipt records both the completed upload stage and the exact Proved catalog status. Definition entries provide supporting interfaces. These counts do not assert that a conjecture is settled or a result is novel.", ""]
    for project in projects:
        lines += [f"## {project['slug']}", "", f"**{project['title']}** · [Source at {project['commit'][:12]}]({project['source']}) · [Full receipts]({project['receipt']})", "",
                  "| Declaration / module | Kind | Recorded catalog status | Upload stage |",
                  "| --- | --- | --- | --- |"]
        for row in sorted(project["rows"], key=lambda row: (row["kind"] != "Theorem", row["name"])):
            label = "`" + row["name"] + "`"
            linked = f"[{label}]({row['url']})" if row["url"] else label
            lines.append(f"| {linked} | {row['kind']} | {row['remote'] or 'Not recorded'} | {STAGES[row['stage']]} |")
        lines.append("")
    return "\n".join(lines), {"complete": complete, "proved_theorems": total_proved, "published_definitions": total_definitions}


def main():
    base = Path(__file__).resolve().parent
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--receipts-dir", type=Path, default=base / "receipts")
    parser.add_argument("--output", type=Path, default=base / "PUBLIC_RESULTS.md")
    args = parser.parse_args()
    try:
        output = args.output.resolve()
        content, counts = render(args.receipts_dir.resolve(), output.parent)
        data = content.encode()
        changed = not output.exists() or output.read_bytes() != data
        if changed:
            output.parent.mkdir(parents=True, exist_ok=True)
            descriptor, temporary = tempfile.mkstemp(prefix=output.name + ".", dir=output.parent)
            try:
                with os.fdopen(descriptor, "wb") as stream:
                    stream.write(data)
                    stream.flush()
                    os.fsync(stream.fileno())
                os.replace(temporary, output)
            finally:
                if os.path.exists(temporary):
                    os.unlink(temporary)
        print(json.dumps({"output": str(output), "changed": changed, "network_requests": 0, **counts}))
        return 0
    except (OSError, ValueError, TypeError, KeyError):
        parser.exit(1, "Unable to build public results: invalid or unreadable exported receipts.\n")


if __name__ == "__main__":
    raise SystemExit(main())
