"""Offline repair tests exercise retained receipts and rejection boundaries."""
import copy
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest

import amend_manifest as a
import uploader as u
from test_uploader import Fixture


class RepairTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.f = Fixture(self.tmp.name)
        self.state_path = self.f.root / "state.json"
        target = self.f.data["items"][0]
        definition = {"key": "rejected", "kind": "definition", "depends_on": [], "payload": {
            "definition_name": "Example_defs", "definition_title": "Definitions",
            "definition": "def testNumber : Nat := 1", "natural_language_statement": "The test number.",
            "source": target["payload"]["source"], "tags": [self.f.data["project_tag"]]}}
        pending = copy.deepcopy(target)
        pending["key"] = "pending"
        pending["payload"]["theorem_name"] = "Example.pending"
        pending["payload"]["formal_statement"] = "theorem Example.pending : True := by sorry"
        self.f.data["items"] = [definition, target, pending]
        self.f.write()
        self.old = self.f.package()
        self.new_dir = self.f.root / "corrected"
        self.new_dir.mkdir()
        for path in self.f.data["files"]:
            (self.new_dir / path).write_bytes((self.f.root / path).read_bytes())
        self.new_data = copy.deepcopy(self.f.data)
        self.new_data["items"][0]["payload"]["definition"] = "def testNumber : Nat := 2"
        self.new_path = self.new_dir / "manifest.json"
        self.state = {"schema_version": 1, "manifest_sha256": self.old.sha, "source": self.f.data["source"],
            "items": {"rejected": {"status": "failed", "publish_status": "FAILED", "job_id": "failed-job", "intent_id": "original-intent"},
                "target": {"status": "complete", "job_id": "accepted-job", "theorem_id": "accepted-theorem", "submission_id": "accepted-proof", "remote_status": "Proved"},
                "pending": {"status": "new"}},
            "events": [{"action": "prior_event", "job_id": "failed-job"}], "complete": False}
        self.evidence = {"id": "failed-job", "status": "FAILED", "theorem_id": None,
            "theorem_name": "Example_defs", "source": definition["payload"]["source"], "definitions": definition["payload"]["definition"]}

    def package(self):
        self.new_path.write_text(json.dumps(self.new_data))
        return u.Package(self.new_path, self.f.source)

    def amend(self):
        return a.amendment(self.old, self.package(), self.state, "rejected", self.evidence, u.digest(u.canonical(self.evidence)))

    def test_repair_preserves_accepted_receipts_and_rejected_history(self):
        before = copy.deepcopy(self.state)
        self.new_data["items"][2]["payload"]["theorem_title"] = "Improved pending metadata"
        amended, receipt = self.amend()
        self.assertEqual(self.state, before)
        self.assertEqual(amended["items"]["target"], before["items"]["target"])
        self.assertEqual(receipt["previous_record"], before["items"]["rejected"])
        self.assertEqual(amended["events"][0], before["events"][0])
        self.assertEqual(amended["items"]["rejected"]["repair_of_job_id"], "failed-job")
        self.assertEqual(amended["items"]["rejected"]["status"], "new")
        self.assertEqual(amended["manifest_sha256"], self.package().sha)
        self.assertEqual({row["key"] for row in receipt["changed_items"]}, {"rejected", "pending"})

    def test_queued_and_accepted_items_cannot_change(self):
        for status in ("publish_queued", "published", "verify_queued", "complete"):
            with self.subTest(status=status):
                self.state["items"]["target"]["status"] = status
                self.new_data["items"][1]["payload"]["theorem_title"] = "Changed accepted metadata"
                with self.assertRaisesRegex(u.Stop, "already queued or published"):
                    self.amend()

    def test_changed_accepted_solution_bytes_are_rejected(self):
        path = self.new_dir / "solution.lean"
        path.write_text("theorem solution : True := True.intro\n")
        self.new_data["files"]["solution.lean"] = u.digest(path.read_bytes())
        with self.assertRaisesRegex(u.Stop, "already queued or published"):
            self.amend()

    def test_wrong_failed_job_id_or_code_is_rejected(self):
        original = copy.deepcopy(self.evidence)
        for field, value in (("id", "other-job"), ("status", "PENDING"), ("definitions", "other code")):
            with self.subTest(field=field):
                self.evidence = {**original, field: value}
                with self.assertRaises(u.Stop):
                    self.amend()

    def test_uncertain_post_anywhere_blocks_amendment(self):
        for status in a.UNCERTAIN:
            with self.subTest(status=status):
                self.state["items"]["pending"]["status"] = status
                with self.assertRaisesRegex(u.Stop, "uncertain POST"):
                    self.amend()

    def test_source_environment_and_manifest_identity_cannot_change(self):
        self.state["manifest_sha256"] = "f" * 64
        with self.assertRaisesRegex(u.Stop, "exact old manifest"):
            self.amend()
        self.state["manifest_sha256"] = self.old.sha
        self.new_data["environment"]["mathlib_rev"] = "b" * 40
        with self.assertRaisesRegex(u.Stop, "source, environment"):
            self.amend()

    def test_existing_entity_and_nonfinal_failure_cannot_be_reset(self):
        self.state["items"]["rejected"]["theorem_id"] = "already-created"
        with self.assertRaisesRegex(u.Stop, "existing published entity"):
            self.amend()
        del self.state["items"]["rejected"]["theorem_id"]
        self.state["items"]["rejected"]["publish_status"] = "ERROR"
        with self.assertRaisesRegex(u.Stop, "definitively FAILED"):
            self.amend()

    def test_cli_dry_run_and_explicit_apply_preserve_before_image(self):
        self.package()
        u.atomic_json(self.state_path, self.state)
        evidence_path = self.f.root / "failed-job.json"
        u.atomic_json(evidence_path, self.evidence)
        command = [sys.executable, str(Path(a.__file__)), str(self.old.path), str(self.new_path),
            "--state", str(self.state_path), "--repair-item", "rejected", "--failed-job-evidence", str(evidence_path),
            "--source-root", str(self.f.source)]
        before = self.state_path.read_bytes()
        dry = subprocess.run(command, capture_output=True, text=True, check=True)
        self.assertEqual(json.loads(dry.stdout)["network_requests"], 0)
        self.assertEqual(self.state_path.read_bytes(), before)
        applied = subprocess.run(command + ["--apply"], capture_output=True, text=True, check=True)
        output = json.loads(applied.stdout)
        self.assertEqual(output["mode"], "applied")
        self.assertEqual(json.loads(Path(output["state_backup"]).read_text()), self.state)
        amended = json.loads(self.state_path.read_text())
        self.assertEqual(amended["items"]["target"], self.state["items"]["target"])
        self.assertEqual(amended["manifest_sha256"], self.package().sha)
        # Applying an old-manifest amendment twice cannot silently reset again.
        repeated = subprocess.run(command + ["--apply"], capture_output=True, text=True)
        self.assertEqual(repeated.returncode, 1)


if __name__ == "__main__":
    unittest.main()
