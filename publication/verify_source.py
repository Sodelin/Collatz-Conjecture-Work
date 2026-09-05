#!/usr/bin/env python3
"""Rebuild and audit the exact research revision selected for publication.

This verifies auxiliary results, not universal Collatz termination. Commands
and their complete output are retained alongside a machine-readable verdict.
The official Lean archive is installed and checksum-checked by the workflow.
"""

from __future__ import annotations

import argparse
import json
import os
from pathlib import Path
import re
import subprocess
import sys
import tempfile


TOOLCHAIN = "leanprover/lean4:v4.33.1"
ALLOWED_AXIOMS = frozenset({"propext", "Classical.choice", "Quot.sound"})
DECLARATION = re.compile(r"[A-Za-z_][A-Za-z_0-9']*(?:\.[A-Za-z_][A-Za-z_0-9']*)*")
SOURCE_SHA = re.compile(r"[0-9a-f]{40}")
REPOSITORY = re.compile(r"[A-Za-z0-9][A-Za-z0-9-]*/[A-Za-z0-9_.-]+")

# Kept explicit so changes to the mathematical verification gate are reviewed.
# This is the complete regression/certificate set in source .github/workflows/verify.yml.
ARITHMETIC_CHECKERS = (
    ("verification/trajectory_normal_form_regression.py", ("-B",)),
    ("verification/yah_scalar_arctic_top/verify_top_certificates.py", ("-S", "-B")),
    ("verification/check_note_graph.py", ("-B",)),
    ("verification/near_return_quarter_bound.py", ("-B",)),
    ("verification/hard_return_frozen_debt_check.py", ("-B",)),
    ("verification/three_adic_hard_return_check.py", ("-B",)),
    ("verification/primary_bridge_counterexamples.py", ("-B",)),
    ("verification/block_arithmetic_certificate.py", ("-B",)),
    ("verification/finite_residue_hard_return_check.py", ("-B",)),
    ("verification/core_residue_obstruction_check.py", ("-B",)),
    ("verification/mod27_rank_check.py", ("-B",)),
)


class VerificationError(RuntimeError):
    """A publication gate failed; its report must not be marked as passed."""


def validate_metadata(metadata: dict) -> None:
    for key, pattern in (
        ("source_commit", SOURCE_SHA),
        ("repository", REPOSITORY),
        ("headline_declaration", DECLARATION),
    ):
        value = metadata.get(key)
        if not isinstance(value, str) or not pattern.fullmatch(value):
            raise VerificationError(f"Invalid or missing metadata field: {key}")


def verification_environment() -> dict[str, str]:
    env = os.environ.copy()
    # Python arithmetic certificates use assertions. Never inherit -O behavior.
    env.pop("PYTHONOPTIMIZE", None)
    env.pop("PYTHONPATH", None)
    env["PYTHONDONTWRITEBYTECODE"] = "1"
    env["PYTHONUNBUFFERED"] = "1"
    return env


def audit_axioms(output: str, expected: set[str]) -> list[dict]:
    """Require an actual Lean result for every requested declaration."""
    pattern = re.compile(
        r"'([^'\n]+)'\s+(?:does not depend on any axioms|depends on axioms:\s*\[([^\]]*)\])"
    )
    found: dict[str, list[str]] = {}
    for match in pattern.finditer(output):
        declaration, dependencies = match.groups()
        axioms = sorted(item.strip() for item in (dependencies or "").split(",") if item.strip())
        unknown = set(axioms) - ALLOWED_AXIOMS
        if unknown:
            raise VerificationError(f"Unexpected axioms in {declaration}: {', '.join(sorted(unknown))}")
        if declaration in found and found[declaration] != axioms:
            raise VerificationError(f"Conflicting axiom output for {declaration}")
        found[declaration] = axioms
    missing = expected - found.keys()
    if missing:
        raise VerificationError(f"Missing Lean axiom audit: {', '.join(sorted(missing))}")
    return [{"declaration": name, "axioms": found[name]} for name in sorted(expected)]


def run_command(source: Path, output: Path, report: dict, label: str,
                command: list[str], timeout: int = 900) -> str:
    index = len(report["commands"]) + 1
    safe_label = re.sub(r"[^a-zA-Z0-9_.-]+", "-", label).strip("-")
    relative_log = f"verification-logs/{index:02d}-{safe_label}.log"
    log_path = output / relative_log
    log_path.parent.mkdir(parents=True, exist_ok=True)
    entry = {"label": label, "command": command, "exit_code": None, "log": relative_log}
    report["commands"].append(entry)
    print(f"Verifying: {label}", flush=True)
    try:
        result = subprocess.run(command, cwd=source, env=verification_environment(),
                                stdout=subprocess.PIPE, stderr=subprocess.STDOUT,
                                text=True, encoding="utf-8", errors="replace", timeout=timeout)
        text = result.stdout
        entry["exit_code"] = result.returncode
    except subprocess.TimeoutExpired as error:
        text = error.stdout or ""
        if isinstance(text, bytes):
            text = text.decode("utf-8", errors="replace")
        text += f"\nVerification timed out after {timeout} seconds.\n"
        entry["exit_code"] = 124
    except OSError as error:
        text = f"Unable to run command: {error}\n"
        entry["exit_code"] = 127
    log_path.write_text(text, encoding="utf-8")
    if entry["exit_code"] != 0:
        raise VerificationError(f"{label} failed (exit {entry['exit_code']}); see {relative_log}")
    # Lean accepts incomplete declarations with a warning, so exit zero alone
    # is insufficient. The explicit dependency audit below also rejects sorryAx.
    if re.search(r"declaration uses ['`]sorry['`]|depends on axioms:[^\]]*\bsorryAx\b", text):
        raise VerificationError(f"Incomplete Lean proof in {label}; see {relative_log}")
    return text


def verify(source: Path, output: Path, metadata: dict) -> dict:
    source, output = source.resolve(), output.resolve()
    if output == source or source in output.parents:
        raise VerificationError("Verification output must be outside the source checkout")
    output.mkdir(parents=True, exist_ok=True)
    report = {
        "schema_version": 1,
        "status": "failed",
        "source_commit": metadata.get("source_commit"),
        "repository": metadata.get("repository"),
        "headline_declaration": metadata.get("headline_declaration"),
        "lean_toolchain": TOOLCHAIN,
        "allowed_axioms": sorted(ALLOWED_AXIOMS),
        "commands": [],
        "axiom_audit": [],
        "scope": "Pinned auxiliary lemmas and arithmetic certificates; universal termination remains unproved.",
    }
    try:
        if not __debug__ or sys.flags.optimize:
            raise VerificationError("Verification requires assertions; do not use Python -O or -OO")
        validate_metadata(metadata)
        actual_sha = run_command(source, output, report, "source-commit", ["git", "rev-parse", "HEAD"]).strip()
        if actual_sha != metadata["source_commit"]:
            raise VerificationError(f"Source commit mismatch: expected {metadata['source_commit']}, got {actual_sha}")
        run_command(source, output, report, "source-tracked-clean", ["git", "diff", "--exit-code", "HEAD", "--"])
        if (source / "lean-toolchain").read_text(encoding="utf-8").strip() != TOOLCHAIN:
            raise VerificationError(f"The source must use unchanged pinned toolchain {TOOLCHAIN}")
        version = run_command(source, output, report, "lean-version", ["lean", "--version"]).strip()
        report["lean_version"] = version
        if not re.search(r"\bversion 4\.33\.1(?:,|\))", version):
            raise VerificationError(f"Unexpected installed Lean version: {version}")
        run_command(source, output, report, "clean-formal-build", ["lake", "clean"])
        run_command(source, output, report, "build-formal-library", ["lake", "build"])
        tracked = run_command(source, output, report, "tracked-files", ["git", "ls-files", "-z"]).split("\0")
        lean_files = sorted(path for path in tracked if path.endswith(".lean"))
        if not lean_files:
            raise VerificationError("No tracked Lean source files were found")
        declarations = {metadata["headline_declaration"]}
        imports = set()
        for relative in lean_files:
            path = source / relative
            if not relative.startswith("lean/") or path.is_symlink():
                raise VerificationError(f"Unsupported Lean source path: {relative}")
            module = relative.removeprefix("lean/").removesuffix(".lean").replace("/", ".")
            if not DECLARATION.fullmatch(module):
                raise VerificationError(f"Invalid Lean module name: {relative}")
            imports.add(module)
            text = path.read_text(encoding="utf-8")
            declarations.update(re.findall(r"(?m)^\s*#print\s+axioms\s+([A-Za-z_][A-Za-z_0-9'.]*)", text))
            run_command(source, output, report, f"module-{module}", ["lake", "env", "lean", relative])
        audit_source = "\n".join(f"import {module}" for module in sorted(imports)) + "\n\n"
        audit_source += f"#check @{metadata['headline_declaration']}\n"
        audit_source += "\n".join(f"#print axioms {name}" for name in sorted(declarations)) + "\n"
        # Keep the exact audit program for independent reproduction, outside git source.
        audit_path = output / "verification-logs" / "PublicationAxiomAudit.lean"
        audit_path.write_text(audit_source, encoding="utf-8")
        audit_output = run_command(source, output, report, "declaration-axioms",
                                   ["lake", "env", "lean", str(audit_path)])
        report["axiom_audit"] = audit_axioms(audit_output, declarations)
        for checker, flags in ARITHMETIC_CHECKERS:
            run_command(source, output, report, Path(checker).stem, [sys.executable, *flags, checker])
        run_command(source, output, report, "source-tracked-clean-after-verification",
                    ["git", "diff", "--exit-code", "HEAD", "--"])
        report["status"] = "passed"
    except (VerificationError, OSError, ValueError) as error:
        report["error"] = str(error)
    finally:
        with tempfile.NamedTemporaryFile(mode="w", encoding="utf-8", dir=output,
                                         prefix="verification-", suffix=".tmp", delete=False) as handle:
            json.dump(report, handle, indent=2, sort_keys=True)
            handle.write("\n")
            temporary = Path(handle.name)
        temporary.replace(output / "verification.json")
    return report


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, required=True)
    parser.add_argument("--output", type=Path, required=True)
    parser.add_argument("--metadata", type=Path, default=Path(__file__).with_name("metadata.json"))
    args = parser.parse_args()
    try:
        metadata = json.loads(args.metadata.read_text(encoding="utf-8"))
        report = verify(args.source, args.output, metadata)
    except (OSError, ValueError, VerificationError) as error:
        print(f"Verification failed: {error}", file=sys.stderr)
        return 1
    if report["status"] != "passed":
        print(f"Verification failed: {report.get('error', 'unknown error')}", file=sys.stderr)
        return 1
    print(f"Verified {report['source_commit']}; report: {args.output / 'verification.json'}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
