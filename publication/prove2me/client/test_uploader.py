"""Offline integration tests for publication safety and interrupted-run recovery."""
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch
import uploader as u


class Fixture:
    def __init__(self, root):
        self.root = Path(root)
        self.source = self.root / "source"
        self.source.mkdir()
        (self.source / "Original.lean").write_text("theorem original : True := by trivial\n")
        for args in (["init", "-q"], ["add", "Original.lean"], ["-c", "user.email=test@example.invalid", "-c", "user.name=Test", "commit", "-qm", "fixture"]):
            subprocess.run(["git", "-C", str(self.source), *args], check=True, capture_output=True)
        commit = subprocess.check_output(["git", "-C", str(self.source), "rev-parse", "HEAD"]).decode().strip()
        self.manifest = self.root / "manifest.json"
        (self.root / "solution.lean").write_text("theorem solution : True := by trivial\n")
        (self.root / "validation.json").write_text('{"fixture":true}\n')
        self.data = {"schema_version": 1, "project_tag": "test-project", "source": {"repository": "https://github.com/example/test", "commit": commit,
            "digests": {"Original.lean": u.digest((self.source / "Original.lean").read_bytes())}},
            "environment": {"toolchain": u.TOOLCHAIN, "mathlib_rev": "a" * 40},
            "files": {p: u.digest((self.root / p).read_bytes()) for p in ("solution.lean", "validation.json")},
            "validation": {"status": "passed", "evidence_files": ["validation.json"]},
            "items": [{"key": "target", "kind": "theorem", "depends_on": [], "solution_file": "solution.lean", "explanation": "Truth holds by its constructor.",
                "payload": {"theorem_name": "Example.target", "theorem_title": "A true statement", "natural_language_statement": "The proposition True holds.",
                            "formal_statement": "theorem Example.target : True := by sorry", "preamble": "", "source": "https://github.com/example/test/blob/" + commit + "/Original.lean#L1", "tags": ["test-project"]}}]}
        self.write()

    def write(self):
        self.manifest.write_text(json.dumps(self.data))

    def package(self):
        return u.Package(self.manifest, self.source)


class FakeTransport:
    def __init__(self, package, publish="PENDING", verdict="PENDING", remote="Open", lose_post=False):
        self.package, self.publish, self.verdict, self.remote = package, publish, verdict, remote
        self.lose_post, self.posts, self.gets = lose_post, [], []
        self.created = False

    def row(self):
        payload = self.package.items["target"]["payload"]
        return {**payload, "theorem_id": "theorem-1", "status": self.remote, "mathlib_rev": self.package.env["mathlib_rev"]}

    def get(self, path):
        self.gets.append(path)
        if path == "/environments":
            return {"environments": [self.package.env]}
        if path.startswith("/publish-jobs/"):
            return {"id": "job-1", "status": self.publish, "theorem_id": "theorem-1", "theorem_name": "Example.target", **self.package.items["target"]["payload"], "definitions": ""}
        if path.startswith("/verify?"):
            return {"id": "submission-1", "theorem_id": "theorem-1", "status": self.verdict}
        if path.startswith("/submissions/"):
            return {"content": self.package.file_bytes("solution.lean").decode()}
        if path == "/theorems/theorem-1":
            return self.row()
        if path.startswith("/theorems?"):
            return {"theorems": [self.row()] if self.created else []}
        raise AssertionError(path)

    def post_json(self, path, payload):
        self.posts.append((path, payload))
        self.created = True
        if self.lose_post:
            raise u.Stop("Connection lost after server received POST")
        return {"jobs": [{"job_id": "job-1", "name": "Example.target"}], "errors": []}

    def verify(self, theorem_id, code, explanation):
        self.posts.append(("/verify", theorem_id))
        return {"submission_id": "submission-1", "status": "PENDING"}


class SafetyTests(unittest.TestCase):
    def setUp(self):
        self.tmp = tempfile.TemporaryDirectory()
        self.addCleanup(self.tmp.cleanup)
        self.f = Fixture(self.tmp.name)
        self.state = self.f.root / "upload.state.json"

    def publisher(self, **kwargs):
        package = self.f.package()
        transport = FakeTransport(package, **kwargs)
        return u.Publisher(package, self.state, transport), transport

    def test_dry_run_is_credential_and_network_free(self):
        with patch.object(u.Transport, "_request", side_effect=AssertionError("network forbidden")):
            result = self.f.package().summary()
        self.assertEqual(result["network_requests"], 0)
        self.assertEqual(result["theorems"], 1)
        self.assertFalse(self.state.exists())

    def test_source_mutation_blocks_before_network(self):
        pub, api = self.publisher()
        (self.f.source / "Original.lean").write_text("changed")
        with self.assertRaises(u.Stop):
            pub.run()
        self.assertFalse(api.posts)
        self.assertFalse(api.gets)

    def test_package_digest_mutation_is_detected(self):
        (self.f.root / "solution.lean").write_text("changed")
        with self.assertRaises(u.Stop):
            self.f.package()

    def test_missing_validation_blocks_execute(self):
        self.f.data["validation"]["status"] = "pending"
        self.f.write()
        pub, api = self.publisher()
        with self.assertRaises(u.Stop):
            pub.run()
        self.assertFalse(api.gets)

    def test_null_environment_pin_is_a_clear_stop(self):
        self.f.data["environment"]["mathlib_rev"] = None
        self.f.write()
        with self.assertRaisesRegex(u.Stop, "exact Mathlib commit"):
            self.f.package()

    def test_malformed_commit_is_a_clear_stop(self):
        self.f.data["source"]["commit"] = None
        self.f.write()
        with self.assertRaisesRegex(u.Stop, "exact commit"):
            self.f.package()

    def test_202_is_only_queued_and_resume_does_not_duplicate(self):
        pub, api = self.publisher()
        result = pub.run()
        self.assertFalse(result["complete"])
        self.assertEqual(result["items"]["target"]["status"], "publish_queued")
        u.Publisher(self.f.package(), self.state, api).run()
        self.assertEqual(len(api.posts), 1)
        actions = [e["action"] for e in json.loads(self.state.read_text())["events"]]
        self.assertLess(actions.index("publish_before"), actions.index("publish_after"))

    def test_uncertain_post_stops_and_reconciles_without_retry(self):
        pub, api = self.publisher(lose_post=True)
        with self.assertRaises(u.Stop):
            pub.run()
        self.assertEqual(json.loads(self.state.read_text())["items"]["target"]["status"], "needs_reconciliation")
        resumed = u.Publisher(self.f.package(), self.state, api)
        with self.assertRaises(u.Stop):
            resumed.run()
        self.assertEqual(len(api.posts), 1)
        resumed.reconcile("target", job_id="job-1")
        resumed.run(max_mutations=0)
        self.assertEqual(len(api.posts), 1)

    def test_pending_verify_resume_polls_same_submission(self):
        pub, api = self.publisher(publish="PUBLISHED")
        result = pub.run()
        self.assertEqual(result["items"]["target"]["submission_id"], "submission-1")
        self.assertEqual(result["items"]["target"]["status"], "verify_queued")
        u.Publisher(self.f.package(), self.state, api).run()
        self.assertEqual(len(api.posts), 2)

    def test_sketch_accepted_and_open_is_not_complete(self):
        pub, api = self.publisher(publish="PUBLISHED", verdict="SKETCH_ACCEPTED")
        result = pub.run()
        self.assertFalse(result["complete"])
        self.assertEqual(result["items"]["target"]["status"], "sketch_accepted")

    def test_accepted_without_proved_is_not_complete(self):
        pub, api = self.publisher(publish="PUBLISHED", verdict="ACCEPTED")
        self.assertFalse(pub.run()["complete"])

    def test_complete_requires_accepted_and_exact_proved_catalog(self):
        pub, api = self.publisher(publish="PUBLISHED", verdict="ACCEPTED", remote="Proved")
        result = pub.run()
        self.assertTrue(result["complete"])
        self.assertEqual(result["items"]["target"]["api_url"], u.BASE + "/theorems/theorem-1")

    def test_live_environment_mismatch_blocks_mutations(self):
        pub, api = self.publisher()
        original_get = api.get
        api.get = lambda path: {"environments": []} if path == "/environments" else original_get(path)
        with self.assertRaises(u.Stop):
            pub.run()
        self.assertFalse(api.posts)

    def test_state_cannot_be_reused_for_changed_manifest(self):
        pub, api = self.publisher()
        pub.run()
        self.f.data["items"][0]["explanation"] = "Changed explanation"
        self.f.write()
        with self.assertRaises(u.Stop):
            u.Publisher(self.f.package(), self.state, api)

    def test_same_existing_name_is_not_uploaded_again(self):
        pub, api = self.publisher()
        api.created = True
        with self.assertRaises(u.Stop):
            pub.run()
        self.assertFalse(api.posts)


if __name__ == "__main__":
    unittest.main()
