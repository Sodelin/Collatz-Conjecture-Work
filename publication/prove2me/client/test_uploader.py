"""Offline integration tests for publication safety and interrupted-run recovery."""
import json
import copy
import threading
from concurrent.futures import ThreadPoolExecutor
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


class ConcurrentTransport:
    def __init__(self, package, state):
        self.package, self.state = package, state
        self.posts = []
        self.created = set()
        self.proved = set()
        self.lock = threading.Lock()
        self.before_post = lambda key: None
        self.after_receive = lambda key: None

    def row(self, key):
        item = self.package.items[key]
        return {**item["payload"], "theorem_id": "th-" + key,
                "status": "Proved" if key in self.proved else "Open",
                "mathlib_rev": self.package.env["mathlib_rev"]}

    def get(self, path):
        if path == "/environments":
            return {"environments": [self.package.env]}
        if path.startswith("/publish-jobs/"):
            key = path.split("job-", 1)[1]
            return {**self.package.items[key]["payload"], "id": "job-" + key,
                    "status": "PUBLISHED", "theorem_id": "th-" + key,
                    "definitions": ""}
        if path.startswith("/theorems/th-"):
            return self.row(path.split("th-", 1)[1])
        if path.startswith("/verify?"):
            key = path.split("sub-", 1)[1]
            return {"id": "sub-" + key, "theorem_id": "th-" + key, "status": "ACCEPTED"}
        if path.startswith("/theorems?"):
            query = u.urllib.parse.parse_qs(u.urllib.parse.urlsplit(path).query)
            rows = [self.row(key) for key in self.created]
            if "theorem_name" in query:
                rows = [row for row in rows if row["theorem_name"] == query["theorem_name"][0]]
            return {"theorems": rows}
        raise AssertionError(path)

    def post_json(self, path, payload):
        key = payload["theorem_name"].split(".")[-1]
        # Observed at the network boundary, not just an in-memory promise.
        disk = json.loads(self.state.read_text())
        assert disk["items"][key]["status"] == "publish_intent"
        for dep in self.package.items[key]["depends_on"]:
            assert disk["items"][dep]["status"] == "complete"
        self.before_post(key)
        with self.lock:
            self.posts.append(key)
            self.created.add(key)
        self.after_receive(key)
        return {"job_id": "job-" + key}

    def verify(self, theorem_id, code, explanation):
        key = theorem_id.split("th-", 1)[1]
        assert json.loads(self.state.read_text())["items"][key]["status"] == "verify_intent"
        with self.lock:
            self.posts.append("verify-" + key)
            self.proved.add(key)
        return {"submission_id": "sub-" + key}


class ParallelSafetyTests(unittest.TestCase):
    setUp = SafetyTests.setUp
    def multiple(self, dependencies=((), ())):
        original = self.f.data["items"][0]
        items = []
        for n, deps in enumerate(dependencies):
            item = copy.deepcopy(original)
            item["key"] = "item" + str(n)
            item["payload"]["theorem_name"] = "Example." + item["key"]
            item["payload"]["formal_statement"] = "theorem Example." + item["key"] + " : True := by sorry"
            item["depends_on"] = ["item" + str(dep) for dep in deps]
            items.append(item)
        self.f.data["items"] = items
        self.f.write()
        package = self.f.package()
        api = ConcurrentTransport(package, self.state)
        return u.Publisher(package, self.state, api), api

    def test_parallel_failure_drains_receipts_and_resume_never_reposts(self):
        pub, api = self.multiple()
        barrier = threading.Barrier(2)
        failure_received = threading.Event()
        api.before_post = lambda key: barrier.wait(timeout=3)

        def receive(key):
            if key == "item0":
                failure_received.set()
                raise u.Stop("Connection lost after receive")
            self.assertTrue(failure_received.wait(3))
        api.after_receive = receive
        with self.assertRaises(u.Stop):
            pub.run(workers=2)
        disk = json.loads(self.state.read_text())
        self.assertEqual(disk["items"]["item0"]["status"], "needs_reconciliation")
        self.assertEqual(disk["items"]["item1"]["job_id"], "job-item1")
        self.assertEqual(sorted(api.posts), ["item0", "item1"])
        resumed = u.Publisher(self.f.package(), self.state, api)
        with self.assertRaises(u.Stop):
            resumed.run(workers=2)
        self.assertEqual(len(api.posts), 2)
        resumed.reconcile("item0", job_id="job-item0")
        resumed.run(workers=2, max_mutations=0)
        self.assertEqual(len(api.posts), 2)
        self.assertEqual(resumed.state["items"]["item0"]["theorem_id"], "th-item0")

    def test_parallel_quota_is_global_across_workers(self):
        pub, api = self.multiple(((), (), (), ()))
        result = pub.run(workers=4, max_mutations=1)
        self.assertEqual(len(api.posts), 1)
        self.assertEqual(result["publication_mutations_this_run"], 1)

    def test_parallel_dag_waits_for_proved_parents_and_checks_all_ids(self):
        pub, api = self.multiple(((), (), (0, 1)))
        barrier = threading.Barrier(2)
        api.before_post = lambda key: barrier.wait(timeout=3) if key != "item2" else None
        result = pub.run(workers=2)
        self.assertTrue(result["complete"])
        self.assertGreater(api.posts.index("item2"), api.posts.index("verify-item0"))
        self.assertGreater(api.posts.index("item2"), api.posts.index("verify-item1"))
        self.assertEqual(len(set(api.posts)), 6)
        self.assertEqual(len(json.loads(self.state.read_text())["final_verification"]["checked"]), 3)

    def test_slow_older_state_write_cannot_replace_newer_events(self):
        pub, _ = self.multiple()
        original = u.atomic_json
        first_entered, release_first, second_started, second_entered = (threading.Event() for _ in range(4))
        writes = 0

        def delayed_write(path, value):
            nonlocal writes
            writes += 1
            if writes == 1:
                first_entered.set()
                self.assertTrue(release_first.wait(3))
            else:
                second_entered.set()
            original(path, value)

        def newer_event():
            second_started.set()
            pub.event("newer", {})

        with patch.object(u, "atomic_json", side_effect=delayed_write):
            with ThreadPoolExecutor(max_workers=2) as pool:
                old = pool.submit(pub.event, "older", {})
                self.assertTrue(first_entered.wait(3))
                new = pool.submit(newer_event)
                self.assertTrue(second_started.wait(3))
                try:
                    self.assertFalse(second_entered.wait(0.05))
                finally:
                    release_first.set()
                old.result()
                new.result()
        self.assertEqual([event["action"] for event in json.loads(self.state.read_text())["events"]], ["older", "newer"])


    def test_parallel_token_refresh_exchanges_key_only_once(self):
        credentials = self.f.root / "test-credentials.json"
        u.atomic_json(credentials, {"api_key": "p2m_offline_test_only"})
        transport = u.Transport(credentials, lambda action, fields: None)
        barrier = threading.Barrier(4)

        def worker():
            barrier.wait(timeout=3)
            transport.ensure_token()

        with patch.object(transport, "_request", return_value={"version": u.PROTOCOL_VERSION,
                "access_token": "offline_test_token", "expires_at": u.time.time() + 3600}) as request:
            with ThreadPoolExecutor(max_workers=4) as pool:
                list(pool.map(lambda _: worker(), range(4)))
            self.assertEqual(request.call_count, 1)
        self.assertFalse(self.state.exists())


if __name__ == "__main__":
    unittest.main()
