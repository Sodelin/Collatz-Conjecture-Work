#!/usr/bin/env python3
"""Export a frozen research snapshot and a VibeMathed form draft (stdlib only).

This never submits to a venue. A release needs fresh verification from
verify_source.py. --preview creates explicitly unverified local previews.
"""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path, PurePosixPath
import re
import subprocess
import unicodedata
from urllib.parse import urlsplit
import zipfile

HERE = Path(__file__).resolve().parent
SHA = re.compile(r"[0-9a-f]{40}")


def git(root: Path, *args: str) -> bytes:
    return subprocess.check_output(["git", "-C", str(root), *args])


def read_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def encoded(value) -> bytes:
    return (json.dumps(value, ensure_ascii=False, indent=2, sort_keys=True) + "\n").encode()


def safe_path(name: str) -> bool:
    path = PurePosixPath(name)
    return bool(name) and not path.is_absolute() and ".." not in path.parts and "\\" not in name


def snapshot(root: Path, commit: str) -> dict[str, bytes]:
    if not SHA.fullmatch(commit):
        raise ValueError("A full immutable source commit is required")
    actual = git(root, "rev-parse", "HEAD").decode().strip()
    if actual != commit:
        raise ValueError(f"Source HEAD {actual} does not match metadata {commit}")
    if git(root, "status", "--porcelain", "--untracked-files=no").strip():
        raise ValueError("Tracked source files differ from the pinned commit")
    files = {}
    for row in git(root, "ls-tree", "-rz", commit).split(b"\0"):
        if not row:
            continue
        info, name = row.split(b"\t", 1)
        mode, kind, oid = info.decode().split()
        name = name.decode()
        if not safe_path(name) or mode not in {"100644", "100755"} or kind != "blob":
            raise ValueError(f"Unsupported archive entry: {name}")
        files[name] = git(root, "cat-file", "blob", oid)
    return files


def http_url(value: str) -> bool:
    if not isinstance(value, str):
        return False
    p = urlsplit(value)
    return p.scheme in {"http", "https"} and bool(p.hostname) and not p.username and not p.password


def document_key(value: str) -> str:
    value = re.sub(r"[#?].*$", "", value.strip().lower()).rstrip("/")
    value = re.sub(r"^https?://(www\.)?", "", value)
    arxiv = re.search(r"arxiv\.org/(?:abs|pdf)/(\d{4}\.\d{4,5})", value)
    return "arxiv:" + arxiv[1] if arxiv else re.sub(r"\.pdf$", "", value)


def canonical(value: str) -> str:
    """Match the upstream submission parser's trim, then NFC normalization."""
    return unicodedata.normalize("NFC", value.strip())


def validate_draft(draft: dict, schema: dict) -> None:
    specs = schema["fields"]
    if set(draft) != set(specs):
        raise ValueError("Draft keys differ from the recorded venue schema")
    for key, value in draft.items():
        spec = specs[key]
        if not isinstance(value, str):
            raise ValueError(f"{key} must be a string")
        value = canonical(value)
        if spec.get("required") and not value:
            raise ValueError(f"{key} is required")
        # First-party charLength counts code points after NFC normalization.
        if len(value) > spec.get("max_length", 1000000):
            raise ValueError(f"{key} exceeds the venue length limit")
        if spec.get("plain_text") and "$" in value:
            raise ValueError(f"{key} requires plain text")
        if value and spec.get("options") and value not in {o["value"] for o in spec["options"]}:
            raise ValueError(f"Invalid choice for {key}: {value}")
        if value and spec["kind"] == "url" and not http_url(value):
            raise ValueError(f"Invalid URL for {key}")
        if value and spec["kind"] == "number" and not re.fullmatch(r"[0-9]+", value):
            raise ValueError(f"Invalid nonnegative integer for {key}")
        if value and key == "yearPosed" and not 1000 <= int(value) <= 3000:
            raise ValueError("Year posed must be between 1000 and 3000")
    normalized = {key: canonical(value) for key, value in draft.items()}
    if not re.fullmatch(r"[0-9]{4}(-[0-9]{2}(-[0-9]{2})?)?", normalized["solveDate"]):
        raise ValueError("Invalid solve date")
    parts = [int(value) for value in normalized["solveDate"].split("-")]
    # Match upstream component ranges, which do not validate month/day combinations.
    if (not 1000 <= parts[0] <= 3000 or len(parts) > 1 and not 1 <= parts[1] <= 12
            or len(parts) > 2 and not 1 <= parts[2] <= 31):
        raise ValueError("Invalid solve date")
    links = json.loads(normalized["links"] or "[]")
    rules = schema["link_rules"]
    if not isinstance(links, list) or len(links) > rules["max_items"]:
        raise ValueError("Invalid number of supporting links")
    seen = {document_key(normalized["sourceUrl"])}
    for link in links:
        # Unlike top-level fields, upstream parseLinks still uses JS .length.
        label = link["label"].strip() if isinstance(link, dict) and isinstance(link.get("label"), str) else ""
        if (not isinstance(link, dict) or not isinstance(link.get("label"), str)
                or not 0 < len(label.encode("utf-16-le")) // 2 <= rules["label_max_length"]
                or not http_url(link.get("url", "")) or link.get("kind") not in rules["kinds"]):
            raise ValueError("Invalid supporting link")
        key = document_key(link["url"])
        if key in seen:
            raise ValueError("Duplicate source/supporting link")
        seen.add(key)
    if normalized["verification"] == "lean-checked" and not normalized["verificationNote"] and not links:
        raise ValueError("Lean-checked status requires a verification note or supporting link")
    if normalized["resolution"] != "partial" or normalized["verification"] not in {"lean-checked", "unreviewed"}:
        raise ValueError("This adapter only publishes the current partial, independently unaudited scope")


def zip_bytes(files: dict[str, bytes], target: Path) -> None:
    with zipfile.ZipFile(target, "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
        for name, data in sorted(files.items()):
            if not safe_path(name):
                raise ValueError(f"Unsafe archive path: {name}")
            info = zipfile.ZipInfo(name, date_time=(1980, 1, 1, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = 0o100644 << 16
            archive.writestr(info, data)


def make_draft(metadata: dict, schema: dict, publisher: str, preview: bool) -> tuple[dict, str]:
    source = metadata["source_commit"]
    tag = f"research-{source[:12]}-{publisher[:12]}"
    source_url = "https://github.com/" + metadata["repository"]
    context = {"source_commit": source, "source_url": source_url, "publisher_commit": publisher,
               "release_url": f"{source_url}/releases/tag/{tag}"}
    draft = {key: "" for key in schema["fields"]}
    for key, value in metadata["vibemathed"].items():
        if key not in draft:
            raise ValueError(f"Unknown venue field: {key}")
        draft[key] = canonical(value.format_map(context))
    links = [{key: canonical(value.format_map(context)) for key, value in link.items()}
             for link in metadata["links"]]
    if preview:
        links = [link for link in links if link["url"] != context["release_url"]]
        draft["verification"] = "unreviewed"
        draft["verificationNote"] = "UNVERIFIED EXPORT PREVIEW. Fresh release verification has not run. Do not submit this draft as Lean-checked. " + draft["verificationNote"]
    draft["links"] = json.dumps(links, ensure_ascii=False)
    validate_draft(draft, schema)
    return draft, tag


def verification_files(report: dict, directory: Path) -> dict[str, bytes]:
    """Retain command output and the exact generated Lean audit program."""
    names = {command["log"] for command in report.get("commands", [])}
    audit = "verification-logs/PublicationAxiomAudit.lean"
    if report.get("status") == "passed" or (directory / audit).exists():
        names.add(audit)
    files = {}
    for name in sorted(names):
        if not safe_path(name):
            raise ValueError("Unsafe verification log path")
        path = directory / name
        if path.is_symlink() or not path.is_file():
            raise ValueError(f"Verification evidence missing: {name}")
        files[name] = path.read_bytes()
    return files


def importer(draft: dict, storage_key: str) -> str:
    # Normal draft restoration only: no requests, cookies, tokens or submission.
    payload = json.dumps(draft, ensure_ascii=True)
    return f"""// Run only on https://vibemathed.com/submit. Saves a draft; does not submit.
// Convenience adapter for the recorded site version, not a supported upload API.
(() => {{
  if (location.origin !== 'https://vibemathed.com' || location.pathname !== '/submit')
    throw new Error('Open https://vibemathed.com/submit first.');
  const draft = {payload};
  const key = {json.dumps(storage_key)};
  const previous = localStorage.getItem(key);
  if (previous) localStorage.setItem(key + ':backup:' + Date.now(), previous);
  localStorage.setItem(key, JSON.stringify(draft));
  location.reload();
}})();
"""


def build(source: Path, output: Path, metadata_path: Path, verification_path: Path | None, preview=False):
    metadata = read_json(metadata_path)
    if metadata["conjecture_status"] != "unresolved":
        raise ValueError("The publication scope must keep Collatz unresolved")
    files = snapshot(source, metadata["source_commit"])
    publisher = git(HERE.parent, "rev-parse", "HEAD").decode().strip()
    if not preview and git(HERE.parent, "status", "--porcelain", "--untracked-files=no").strip():
        raise ValueError("Commit the publisher before creating a verified release")
    schema = read_json(HERE / "vibemathed-schema.json")
    claims = read_json(HERE / "claims.json")
    announcement = (HERE / "announcement.md").read_text(encoding="utf-8")
    linked_revisions = re.findall(
        r"https://github\.com/" + re.escape(metadata["repository"]) + r"/(?:blob|tree)/([0-9a-f]{40})",
        announcement,
    )
    if not linked_revisions or set(linked_revisions) != {metadata["source_commit"]}:
        raise ValueError("Announcement source links do not match the selected mathematical revision")
    for claim in claims:
        for name in claim["source_paths"]:
            if name not in files:
                raise ValueError(f"Claim {claim['id']} references absent source: {name}")
    verification = read_json(verification_path) if verification_path else None
    if not preview:
        if (not verification or verification.get("status") != "passed"
                or verification.get("source_commit") != metadata["source_commit"]
                or verification.get("repository") != metadata["repository"]
                or verification.get("headline_declaration") != metadata["headline_declaration"]):
            raise ValueError("Fresh passing verification of the exact source is required")
        if not verification.get("commands") or any(c["exit_code"] != 0 for c in verification["commands"]):
            raise ValueError("Missing or failed verification commands")
        audited = {item["declaration"]: set(item["axioms"]) for item in verification.get("axiom_audit", [])}
        required = {name for claim in claims for name in claim["lean_declarations"]}
        required.add(metadata["headline_declaration"])
        if not required <= audited.keys():
            raise ValueError("A published Lean declaration is missing from the axiom audit")
        if any(axioms - {"propext", "Classical.choice", "Quot.sound"} for axioms in audited.values()):
            raise ValueError("Publication axiom audit contains an unexpected dependency")
    draft, tag = make_draft(metadata, schema, publisher, preview)
    output.mkdir(parents=True, exist_ok=True)
    # Avoid carrying old generated files into a new manifest.
    allowed_existing = {"verification.json", "verification-logs"}
    if any(p.name not in allowed_existing for p in output.iterdir()):
        raise ValueError("Use a fresh output directory (verification files may already exist)")
    write = lambda name, data: (output / name).write_bytes(data if isinstance(data, bytes) else data.encode())
    write("announcement.md", (HERE / "announcement.md").read_bytes())
    write("claims.json", encoded(claims))
    write("vibemathed-draft.json", encoded(draft))
    write("vibemathed-import.js", importer(draft, schema["transport"]["draft_storage_key"]))
    write("vibemathed-schema.json", encoded(schema))
    lines = ["# VibeMathed submission draft", "", "Status: " + ("UNVERIFIED PREVIEW" if preview else "Prepared; not submitted"), "",
             "Sign in at https://vibemathed.com/submit. Copy these values or restore the generated draft using the optional import helper. Review the form before Submit for review. Acceptance is a curator decision.", ""]
    for key, value in draft.items():
        if value:
            lines += ["## " + schema["fields"][key]["label"], "", value, ""]
    write("vibemathed-form.md", "\n".join(lines))
    write("CITATION.cff", 'cff-version: 1.2.0\nmessage: "Please cite this versioned research archive; Collatz remains unresolved."\ntype: software\ntitle: ' + json.dumps(metadata["title"]) + '\nauthors:\n  - family-names: "Downard"\n    given-names: "Nolan"\nversion: ' + json.dumps(tag) + '\ndate-released: ' + json.dumps(metadata["date"]) + '\nrepository-code: ' + json.dumps("https://github.com/" + metadata["repository"]) + '\ncommit: ' + json.dumps(metadata["source_commit"]) + '\n')
    write("citation.bib", "@misc{downard_collatz_" + metadata["source_commit"][:12] + ",\n  author = {Downard, Nolan},\n  title = {" + metadata["title"] + "},\n  year = {2026},\n  url = {https://github.com/" + metadata["repository"] + "/tree/" + metadata["source_commit"] + "},\n  note = {AI-assisted research archive; auxiliary results only; Collatz unresolved}\n}\n")
    write("release-notes.md", "# " + metadata["title"] + "\n\nResearch preview; Collatz remains unresolved. Not peer reviewed; novelty and statement correspondence require independent review.\n\n" + f"Mathematics commit: `{metadata['source_commit']}`\n\nPublisher commit: `{publisher}`\n\n" + "Includes the full source archive, a standalone Lean source bundle, exact claim scope, verification logs, citation metadata, and a VibeMathed draft. Download `vibemathed-form.md` for the submission fields. The Git tag and GitHub automatic Source code downloads identify the publisher commit; research-source.zip contains the selected mathematics. Nothing has been sent to VibeMathed automatically.\n")
    logs = {}
    if verification:
        write("verification.json", encoded(verification))
        logs = verification_files(verification, verification_path.parent)
        zip_bytes(logs, output / "verification-logs.zip")
    source_inventory = {name: hashlib.sha256(data).hexdigest() for name, data in sorted(files.items())}
    write("source-inventory.json", encoded(source_inventory))
    # Preserve every committed research file, including historical negative results.
    zip_bytes(files, output / "research-source.zip")
    lean = {name: data for name, data in files.items() if name.startswith("lean/") or name in {"lean-toolchain", "lakefile.toml", "lake-manifest.json"}}
    zip_bytes(lean, output / "lean-source.zip")
    manifest = {"schema_version": 1, "source_commit": metadata["source_commit"],
                "publisher_commit": publisher, "repository": metadata["repository"],
                "release_tag": tag, "conjecture_status": "unresolved",
                "publication_state": "unverified-preview" if preview else "research-prerelease",
                "venue_submission_state": "not-submitted", "novelty_status": metadata["novelty_status"],
                "source_file_count": len(files), "lean_source_file_count": len(lean),
                "schema_upstream_commit": schema["upstream_commit"],
                "artifacts": {p.name: hashlib.sha256(p.read_bytes()).hexdigest() for p in sorted(output.iterdir()) if p.is_file()}}
    write("manifest.json", encoded(manifest))
    write("SHA256SUMS", "".join(f"{hashlib.sha256(p.read_bytes()).hexdigest()}  {p.name}\n" for p in sorted(output.iterdir()) if p.is_file()))
    return manifest


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--metadata", type=Path, default=HERE / "metadata.json")
    parser.add_argument("--verification", type=Path)
    parser.add_argument("--preview", action="store_true")
    args = parser.parse_args()
    try:
        manifest = build(args.source.resolve(), args.output.resolve(), args.metadata.resolve(),
                         args.verification.resolve() if args.verification else None, args.preview)
    except (ValueError, KeyError, OSError, subprocess.CalledProcessError) as exc:
        parser.exit(1, f"Publication blocked: {exc}\n")
    print(json.dumps(manifest, indent=2))


if __name__ == "__main__":
    main()
