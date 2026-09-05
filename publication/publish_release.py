#!/usr/bin/env python3
"""Publish only a complete, verified research archive, staging uploads as a draft.

An existing release is accepted only after its identity and downloaded bytes match
this job's immutable artifacts. Fresh verification logs may vary on retries.
Incomplete or different releases are never overwritten.
"""
from __future__ import annotations

import argparse
import hashlib
import json
import os
from pathlib import Path
import re
import subprocess
import tempfile

SHA = re.compile(r"[0-9a-f]{40}")
DIGEST = re.compile(r"[0-9a-f]{64}")
ASSET_NAME = re.compile(r"[A-Za-z0-9][A-Za-z0-9._-]*")
REQUIRED_ASSETS = {
    "release-notes.md", "verification.json", "verification-logs.zip",
    "research-source.zip", "lean-source.zip", "source-inventory.json",
    "claims.json", "vibemathed-draft.json", "vibemathed-form.md",
    "vibemathed-import.js", "vibemathed-schema.json", "CITATION.cff",
    "citation.bib", "announcement.md", "yah-obstruction.md",
}


class PublicationError(ValueError):
    """Publication must stop without replacing any existing release assets."""


def digest(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def load_json(path: Path):
    return json.loads(path.read_text(encoding="utf-8"))


def validate_package(root: Path, environment: dict) -> tuple[dict, dict[str, str]]:
    """Bind every local asset to the manifest, checksum index and job outputs."""
    repository = environment["GH_REPO"]
    source = environment["SOURCE_COMMIT"]
    publisher = environment["PUBLISHER_COMMIT"]
    tag = environment["RELEASE_TAG"]
    if not re.fullmatch(r"[A-Za-z0-9_.-]+/[A-Za-z0-9_.-]+", repository):
        raise PublicationError("Invalid repository identity")
    if not SHA.fullmatch(source) or not SHA.fullmatch(publisher):
        raise PublicationError("Full immutable source and publisher commits are required")
    if tag != f"research-{source[:12]}-{publisher[:12]}":
        raise PublicationError("Release tag does not encode the job's source and publisher")
    manifest = load_json(root / "manifest.json")
    for key, expected in {
        "repository": repository, "source_commit": source,
        "publisher_commit": publisher, "release_tag": tag,
        "publication_state": "research-prerelease",
        "venue_submission_state": "not-submitted", "conjecture_status": "unresolved",
    }.items():
        if manifest.get(key) != expected:
            raise PublicationError(f"Manifest {key} does not match verified publication scope")
    artifacts = manifest.get("artifacts")
    if not isinstance(artifacts, dict) or not REQUIRED_ASSETS <= artifacts.keys():
        raise PublicationError("Manifest is missing required publication assets")
    for name, checksum in artifacts.items():
        if (not ASSET_NAME.fullmatch(name) or name in {"manifest.json", "SHA256SUMS"}
                or not isinstance(checksum, str) or not DIGEST.fullmatch(checksum)):
            raise PublicationError(f"Invalid manifest artifact: {name}")
    expected_names = set(artifacts) | {"manifest.json", "SHA256SUMS"}
    files = {}
    for path in root.iterdir():
        if path.is_symlink():
            raise PublicationError(f"Symlink is not a release asset: {path.name}")
        if path.is_dir() and path.name == "verification-logs":
            continue  # The complete log archive is included and checksummed.
        if not path.is_file() or path.name not in expected_names:
            raise PublicationError(f"Unexpected publication entry: {path.name}")
        files[path.name] = digest(path)
    if set(files) != expected_names:
        raise PublicationError("Local publication assets are incomplete")
    if any(files[name] != checksum for name, checksum in artifacts.items()):
        raise PublicationError("Local asset hash differs from manifest.artifacts")
    checksums = {}
    for line in (root / "SHA256SUMS").read_text(encoding="utf-8").splitlines():
        match = re.fullmatch(r"([0-9a-f]{64})  ([A-Za-z0-9][A-Za-z0-9._-]*)", line)
        if not match or match[2] in checksums:
            raise PublicationError("Malformed or duplicate SHA256SUMS entry")
        checksums[match[2]] = match[1]
    if checksums != {name: value for name, value in files.items() if name != "SHA256SUMS"}:
        raise PublicationError("SHA256SUMS does not match the complete local package")
    report = load_json(root / "verification.json")
    if (report.get("status") != "passed" or report.get("source_commit") != source
            or report.get("repository") != repository or not report.get("commands")
            or any(command.get("exit_code") != 0 for command in report["commands"])):
        raise PublicationError("Successful exact-source verification is required")
    draft = load_json(root / "vibemathed-draft.json")
    if draft.get("verification") not in {"lean-checked", "unreviewed"} or draft.get("resolution") != "partial":
        raise PublicationError("Venue draft must preserve partial, independently unaudited research scope")
    return manifest, files


class GitHub:
    def __init__(self, repository: str):
        self.repository = repository

    def run(self, *arguments: str):
        result = subprocess.run(["gh", *arguments], capture_output=True, text=True)
        if result.returncode:
            raise PublicationError(f"gh command failed: {result.stderr.strip() or result.stdout.strip()}")
        return result.stdout

    def api(self, route: str, allow_missing=False):
        result = subprocess.run(["gh", "api", f"repos/{self.repository}/{route}"],
                                capture_output=True, text=True)
        if result.returncode:
            if allow_missing and "(HTTP 404)" in result.stderr:
                return None
            raise PublicationError(f"GitHub API failed: {result.stderr.strip()}")
        return json.loads(result.stdout)

    def release(self, tag: str):
        published = self.api(f"releases/tags/{tag}", allow_missing=True)
        if published is not None:
            return published
        # The by-tag endpoint returns published releases only. A draft must be
        # found through the authenticated release collection, across all pages.
        pages = json.loads(self.run("api", "--paginate", "--slurp",
                                    f"repos/{self.repository}/releases"))
        matches = [release for page in pages for release in page if release.get("tag_name") == tag]
        if len(matches) > 1:
            raise PublicationError("Multiple releases use the expected tag")
        return matches[0] if matches else None

    def tag_commit(self, tag: str):
        ref = self.api(f"git/ref/tags/{tag}", allow_missing=True)
        if ref is None:
            return None
        obj = ref["object"]
        seen = set()
        while obj["type"] == "tag":
            if obj["sha"] in seen or len(seen) >= 10:
                raise PublicationError("Cyclic or excessively nested annotated release tag")
            seen.add(obj["sha"])
            obj = self.api(f"git/tags/{obj['sha']}")["object"]
        if obj["type"] != "commit":
            raise PublicationError("Release tag does not identify a commit")
        return obj["sha"]

    def assets(self, release_id: int):
        pages = json.loads(self.run("api", "--paginate", "--slurp",
                                    f"repos/{self.repository}/releases/{release_id}/assets"))
        return [asset for page in pages for asset in page]


def verify_remote(gh: GitHub, release: dict, root: Path, manifest: dict,
                  hashes: dict[str, str], allow_fresh_verification=False) -> None:
    """Check both remote metadata and actual downloaded bytes before acceptance."""
    tag, target = manifest["release_tag"], manifest["publisher_commit"]
    source = manifest["source_commit"]
    if (release.get("tag_name") != tag or release.get("target_commitish") != target
            or release.get("prerelease") is not True):
        raise PublicationError("Existing release identity/target/prerelease scope differs; not overwritten")
    actual_commit = gh.tag_commit(tag)
    # GitHub may defer creation of a draft's tag until publication.
    if actual_commit != target and not (actual_commit is None and release.get("draft") is True):
        raise PublicationError("Release tag points to a different or missing publisher commit")
    assets = gh.assets(release["id"])
    names = [asset["name"] for asset in assets]
    if (len(names) != len(set(names)) or set(names) != set(hashes)
            or any(asset.get("state") != "uploaded" for asset in assets)):
        raise PublicationError("Existing release assets are incomplete or different; not overwritten")
    with tempfile.TemporaryDirectory(prefix="collatz-release-check-") as directory:
        downloaded = Path(directory)
        gh.run("release", "download", tag, "--repo", gh.repository, "--dir", str(downloaded))
        paths = list(downloaded.iterdir())
        if (any(not path.is_file() or path.is_symlink() for path in paths)
                or {path.name for path in paths} != set(hashes)):
            raise PublicationError("Downloaded release asset inventory does not match")
        remote_manifest, remote_hashes = validate_package(downloaded, {
            "GH_REPO": gh.repository, "SOURCE_COMMIT": source,
            "PUBLISHER_COMMIT": manifest["publisher_commit"], "RELEASE_TAG": tag,
        })
        # A fresh verification run can have different timings/temp paths. Existing
        # releases must be internally complete, with all non-log artifacts identical.
        variable = {"verification.json", "verification-logs.zip", "manifest.json", "SHA256SUMS"}
        if any(remote_hashes[name] != checksum for name, checksum in hashes.items()
               if not allow_fresh_verification or name not in variable):
            raise PublicationError("Downloaded release hashes differ from the verified local package")
        if ({key: value for key, value in remote_manifest.items() if key != "artifacts"}
                != {key: value for key, value in manifest.items() if key != "artifacts"}):
            raise PublicationError("Remote manifest identity differs from the verified local manifest")
        local_report = load_json(root / "verification.json")
        remote_report = load_json(downloaded / "verification.json")
        if remote_report.get("headline_declaration") != local_report.get("headline_declaration"):
            raise PublicationError("Remote verification headline differs from this verified source")


def publish(root: Path, environment: dict, gh: GitHub) -> str:
    root = root.resolve()
    manifest, hashes = validate_package(root, environment)
    tag, source = manifest["release_tag"], manifest["source_commit"]
    target = manifest["publisher_commit"]
    existing_tag = gh.tag_commit(tag)
    if existing_tag not in {None, target}:
        raise PublicationError("Existing tag points to another publisher commit; not overwritten")
    release = gh.release(tag)
    allow_fresh_verification = release is not None
    if release is None:
        gh.run("release", "create", tag, *(str(root / name) for name in sorted(hashes)),
               "--repo", gh.repository, "--target", target, "--draft", "--prerelease",
               "--latest=false", "--title", f"Collatz auxiliary research {source[:12]}",
               "--notes-file", str(root / "release-notes.md"))
        release = gh.release(tag)
        if release is None or release.get("draft") is not True:
            raise PublicationError("New release was not successfully staged as a draft")
    verify_remote(gh, release, root, manifest, hashes, allow_fresh_verification)
    if release.get("draft") is True:
        gh.run("release", "edit", tag, "--repo", gh.repository,
               "--draft=false", "--prerelease", "--latest=false")
        release = gh.release(tag)
        if release is None or release.get("draft") is not False:
            raise PublicationError("Release did not become public after verified draft publication")
        verify_remote(gh, release, root, manifest, hashes, allow_fresh_verification)
    return f"https://github.com/{gh.repository}/releases/tag/{tag}"


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--package", type=Path, required=True)
    args = parser.parse_args()
    try:
        publisher = subprocess.check_output(["git", "rev-parse", "HEAD"], text=True).strip()
        if publisher != os.environ["PUBLISHER_COMMIT"]:
            raise PublicationError("Publisher checkout does not match the verified job output")
        url = publish(args.package, os.environ, GitHub(os.environ["GH_REPO"]))
    except (PublicationError, KeyError, TypeError, OSError, json.JSONDecodeError,
            subprocess.CalledProcessError) as exc:
        parser.exit(1, f"Publication blocked: {exc}\nExisting assets were not overwritten; an incomplete draft may require inspection.\n")
    print(f"Complete research prerelease verified: {url}")


if __name__ == "__main__":
    main()
