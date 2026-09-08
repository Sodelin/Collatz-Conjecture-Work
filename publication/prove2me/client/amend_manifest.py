#!/usr/bin/env python3
"""Offline, explicit amendment of a rejected publication package; dry-run by default."""
from __future__ import annotations

import argparse
import copy
import json
from pathlib import Path
import sys
import time
import uuid

import uploader as u

UNCERTAIN = {"publish_intent", "verify_intent", "needs_reconciliation"}
KNOWN = UNCERTAIN | {"new", "publish_queued", "published", "verify_queued", "accepted_pending_catalog", "sketch_accepted", "complete", "failed"}


def fingerprint(package, key):
    """Compare uploaded semantics/bytes, ignoring only local file locations."""
    item = copy.deepcopy(package.items[key])
    item.pop("payload_file", None)
    solution = item.pop("solution_file", None)
    if solution is not None:
        item["solution_sha256"] = u.digest(package.file_bytes(solution))
    return u.digest(u.canonical(item))


def validate_failed_job(package, key, record, evidence):
    if record.get("status") != "failed" or record.get("publish_status") != "FAILED":
        raise u.Stop("Repair requires a definitively FAILED publication job")
    if record.get("theorem_id") or record.get("submission_id"):
        raise u.Stop("This repair cannot reset an item with an existing published entity or proof receipt")
    job_id = u.safe_id(record.get("job_id"))
    if evidence.get("id") != job_id or evidence.get("status") != "FAILED" or evidence.get("theorem_id"):
        raise u.Stop("Saved server evidence must confirm the exact failed job and no published entity")
    item = package.items[key]
    payload = item["payload"]
    name = evidence.get("theorem_name") or evidence.get("definition_name")
    if name != item["name"] or evidence.get("source") != payload["source"]:
        raise u.Stop("Failed-job evidence does not match the rejected item name and source")
    if item["kind"] == "definition":
        matches = evidence.get("definitions") == payload["definition"]
    else:
        matches = evidence.get("formal_statement") == payload["formal_statement"] and evidence.get("definitions", "") == payload.get("preamble", "")
    if not matches:
        raise u.Stop("Failed-job evidence does not match the exact rejected Lean text")


def amendment(old, new, state, repair_key, evidence, evidence_sha256):
    """Return a validated replacement state; no file writes, auth, or network."""
    old.check_files()
    new.check_files()
    if state.get("schema_version") != 1 or state.get("manifest_sha256") != old.sha:
        raise u.Stop("State must belong to the exact old manifest bytes")
    if old.sha == new.sha:
        raise u.Stop("Repair requires a changed manifest and corrected rejected item")
    if old.data["source"] != new.data["source"] or old.env != new.env or old.tag != new.tag:
        raise u.Stop("Manifest amendment cannot change source, environment, or project tag")
    if state.get("source") != old.data["source"]:
        raise u.Stop("State source differs from the pinned original manifest")
    if set(old.items) != set(new.items) or set(state.get("items", {})) != set(old.items):
        raise u.Stop("Manifest amendment cannot add or remove publication items or receipts")
    if repair_key not in old.items:
        raise u.Stop("Explicit repair item is absent from the package")
    validation = new.data.get("validation", {})
    evidence_files = validation.get("evidence_files", [])
    if validation.get("status") != "passed" or not evidence_files:
        raise u.Stop("Corrected package needs passed validation with hashed evidence")
    for path in evidence_files:
        new.file_bytes(path)
    changes = []
    for key, record in state["items"].items():
        status = record.get("status")
        if status not in KNOWN:
            raise u.Stop("Unknown state status cannot be amended")
        if status in UNCERTAIN:
            raise u.Stop("Reconcile every uncertain POST before amending a manifest")
        if status == "new" and any(record.get(field) for field in ("job_id", "theorem_id", "submission_id", "intent_id")):
            raise u.Stop("A new item unexpectedly contains a mutation receipt or intent")
        before, after = fingerprint(old, key), fingerprint(new, key)
        if before != after:
            if status != "new" and key != repair_key:
                raise u.Stop("Amendment would change an already queued or published item")
            changes.append({"key": key, "before_sha256": before, "after_sha256": after})
        if status == "failed" and key != repair_key:
            raise u.Stop("Every failed job requires its own explicit, evidenced repair")
    record = state["items"][repair_key]
    validate_failed_job(old, repair_key, record, evidence)
    if not any(change["key"] == repair_key for change in changes):
        raise u.Stop("Rejected item must be corrected before explicit repair")
    # A changed kind/name would be a replacement project node, not a repair.
    for key in old.items:
        if old.items[key]["kind"] != new.items[key]["kind"] or old.items[key]["name"] != new.items[key]["name"]:
            raise u.Stop("Manifest amendment cannot rename or change the kind of an item")
    amended = copy.deepcopy(state)
    receipt = {"repair_id": uuid.uuid4().hex, "at": time.time(), "repair_key": repair_key,
               "old_manifest_sha256": old.sha, "new_manifest_sha256": new.sha,
               "failed_job_id": record["job_id"], "failed_job_evidence_sha256": evidence_sha256,
               "previous_record": copy.deepcopy(record), "changed_items": changes}
    amended.setdefault("manifest_amendments", []).append(receipt)
    amended["items"][repair_key] = {"status": "new", "repair_of_job_id": record["job_id"], "repair_id": receipt["repair_id"]}
    amended["manifest_sha256"] = new.sha
    amended["complete"] = False
    amended.pop("final_verification", None)
    amended.setdefault("events", []).append({"at": receipt["at"], "action": "failed_publication_explicitly_repaired",
        "key": repair_key, "repair_id": receipt["repair_id"], "job_id": record["job_id"],
        "old_manifest_sha256": old.sha, "new_manifest_sha256": new.sha,
        "failed_job_evidence_sha256": evidence_sha256})
    return amended, receipt


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("old_manifest", type=Path)
    parser.add_argument("new_manifest", type=Path)
    parser.add_argument("--state", type=Path, required=True)
    parser.add_argument("--repair-item", required=True)
    parser.add_argument("--failed-job-evidence", type=Path, required=True)
    parser.add_argument("--source-root", type=Path)
    parser.add_argument("--apply", action="store_true", help="Explicitly amend local state; creates no remote request")
    args = parser.parse_args()
    try:
        old = u.Package(args.old_manifest)
        new = u.Package(args.new_manifest, args.source_root)
        if args.apply:
            new.execution_gate()
        raw_evidence = u.read_bytes(args.failed_job_evidence)
        evidence = json.loads(raw_evidence)
        if not isinstance(evidence, dict):
            raise u.Stop("Failed-job evidence must be a saved raw server JSON object")
        with u.lock_state(args.state):
            state = json.loads(u.read_bytes(args.state))
            amended, receipt = amendment(old, new, state, args.repair_item, evidence, u.digest(raw_evidence))
            backup = None
            if args.apply:
                backup = args.state.with_name(args.state.name + ".before-repair-" + receipt["repair_id"] + ".json")
                # The immutable before-image is durable before replacing state.
                u.atomic_json(backup, state)
                amended["manifest_amendments"][-1]["state_backup"] = str(backup.resolve())
                u.atomic_json(args.state, amended)
            print(json.dumps({"mode": "applied" if args.apply else "dry-run", "network_requests": 0,
                "repair_item": args.repair_item, "failed_job_id": receipt["failed_job_id"],
                "old_manifest_sha256": old.sha, "new_manifest_sha256": new.sha,
                "changed_items": receipt["changed_items"], "state_backup": str(backup) if backup else None}, indent=2))
        return 0
    except (u.Stop, OSError, ValueError, TypeError, KeyError) as error:
        print("Stopped: " + (str(error) if isinstance(error, u.Stop) else "Invalid local package, state, or evidence"), file=sys.stderr)
        return 1


if __name__ == "__main__":
    sys.exit(main())
