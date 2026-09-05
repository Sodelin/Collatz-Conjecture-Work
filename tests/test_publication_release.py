"""A release is public only after exact identity and remote bytes are verified."""
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from publication import publish_release as publisher


class FakeGitHub:
    repository = "Sodelin/Collatz-Conjecture-Work"

    def __init__(self, root, environment, existing=False, draft=False):
        self.root, self.environment = root, environment
        self.calls = []
        self.remote = {p.name: p.read_bytes() for p in root.iterdir() if p.is_file()}
        self.current = self._release(draft) if existing else None
        self.commit = environment["PUBLISHER_COMMIT"] if existing and not draft else None

    def _release(self, draft):
        return {"id": 42, "tag_name": self.environment["RELEASE_TAG"],
                "target_commitish": self.environment["PUBLISHER_COMMIT"],
                "prerelease": True, "draft": draft}

    def tag_commit(self, tag):
        return self.commit

    def release(self, tag):
        return self.current

    def assets(self, release_id):
        return [{"name": name, "state": "uploaded"} for name in self.remote]

    def run(self, *args):
        self.calls.append(args)
        if args[:2] == ("release", "create"):
            self.current = self._release(True)
        elif args[:2] == ("release", "download"):
            destination = Path(args[args.index("--dir") + 1])
            for name, data in self.remote.items():
                (destination / name).write_bytes(data)
        elif args[:2] == ("release", "edit"):
            self.current = self._release(False)
            self.commit = self.environment["PUBLISHER_COMMIT"]
        else:
            raise AssertionError(args)


class PublicationReleaseTests(unittest.TestCase):
    def setUp(self):
        self.temp = tempfile.TemporaryDirectory()
        self.addCleanup(self.temp.cleanup)
        self.root = Path(self.temp.name)
        source, commit = "a" * 40, "b" * 40
        self.env = {"GH_REPO": FakeGitHub.repository, "SOURCE_COMMIT": source,
                    "PUBLISHER_COMMIT": commit,
                    "RELEASE_TAG": f"research-{source[:12]}-{commit[:12]}"}
        for name in publisher.REQUIRED_ASSETS:
            (self.root / name).write_text(f"fixture: {name}\n")
        self.write_json("verification.json", {"status": "passed", "source_commit": source,
                        "repository": self.env["GH_REPO"], "headline_declaration": "CollatzWork.headline",
                        "commands": [{"exit_code": 0}]})
        self.write_json("vibemathed-draft.json", {"verification": "lean-checked", "resolution": "partial"})
        self.manifest = {"repository": self.env["GH_REPO"], "source_commit": source,
                         "publisher_commit": commit, "release_tag": self.env["RELEASE_TAG"],
                         "publication_state": "research-prerelease",
                         "venue_submission_state": "not-submitted", "conjecture_status": "unresolved"}
        self.seal()

    def write_json(self, name, value):
        (self.root / name).write_text(json.dumps(value, sort_keys=True) + "\n")

    def seal(self):
        self.manifest["artifacts"] = {p.name: publisher.digest(p) for p in self.root.iterdir()
                                      if p.name not in {"manifest.json", "SHA256SUMS"}}
        self.write_json("manifest.json", self.manifest)
        (self.root / "SHA256SUMS").write_text("".join(
            f"{publisher.digest(p)}  {p.name}\n" for p in sorted(self.root.iterdir())
            if p.name != "SHA256SUMS"))

    def test_real_client_finds_unpublished_draft_via_release_collection(self):
        gh = publisher.GitHub(self.env["GH_REPO"])
        draft = {"id": 7, "tag_name": self.env["RELEASE_TAG"], "draft": True}
        with patch.object(gh, "api", return_value=None), patch.object(gh, "run", return_value=json.dumps([[], [draft]])) as run:
            self.assertEqual(gh.release(self.env["RELEASE_TAG"]), draft)
            self.assertIn("--paginate", run.call_args.args)

    def test_new_release_stays_draft_until_downloaded_hashes_pass(self):
        gh = FakeGitHub(self.root, self.env)
        url = publisher.publish(self.root, self.env, gh)
        operations = [call[1] for call in gh.calls]
        self.assertEqual(operations, ["create", "download", "edit", "download"])
        self.assertIn("--draft", gh.calls[0])
        self.assertIn("--latest=false", gh.calls[0])
        self.assertEqual(gh.calls[0][gh.calls[0].index("--target") + 1], self.env["PUBLISHER_COMMIT"])
        self.assertIn("--draft=false", gh.calls[2])
        self.assertFalse(gh.current["draft"])
        self.assertTrue(url.endswith(self.env["RELEASE_TAG"]))

    def test_complete_published_retry_downloads_and_verifies_without_writes(self):
        gh = FakeGitHub(self.root, self.env, existing=True)
        publisher.publish(self.root, self.env, gh)
        self.assertEqual([call[1] for call in gh.calls], ["download"])

    def test_complete_draft_retry_finishes_publication(self):
        gh = FakeGitHub(self.root, self.env, existing=True, draft=True)
        publisher.publish(self.root, self.env, gh)
        self.assertEqual([call[1] for call in gh.calls], ["download", "edit", "download"])

    def test_incomplete_existing_release_is_never_overwritten(self):
        gh = FakeGitHub(self.root, self.env, existing=True, draft=True)
        del gh.remote["lean-source.zip"]
        with self.assertRaisesRegex(publisher.PublicationError, "incomplete or different"):
            publisher.publish(self.root, self.env, gh)
        self.assertEqual(gh.calls, [])
        self.assertTrue(gh.current["draft"])

    def test_remote_corruption_blocks_new_draft_publication(self):
        gh = FakeGitHub(self.root, self.env)
        gh.remote["lean-source.zip"] = b"different proof"
        with self.assertRaisesRegex(publisher.PublicationError, "Local asset hash"):
            publisher.publish(self.root, self.env, gh)
        self.assertEqual([call[1] for call in gh.calls], ["create", "download"])
        self.assertTrue(gh.current["draft"])

    def test_existing_release_allows_different_fresh_verification_logs(self):
        gh = FakeGitHub(self.root, self.env, existing=True)
        report = json.loads((self.root / "verification.json").read_text())
        report["duration_seconds"] = 123.45
        self.write_json("verification.json", report)
        (self.root / "verification-logs.zip").write_bytes(b"fresh timing output")
        self.seal()
        publisher.publish(self.root, self.env, gh)
        self.assertEqual([call[1] for call in gh.calls], ["download"])

    def test_self_consistent_remote_with_different_stable_artifact_is_rejected(self):
        gh = FakeGitHub(self.root, self.env, existing=True)
        (self.root / "lean-source.zip").write_bytes(b"changed immutable source bundle")
        self.seal()
        with self.assertRaisesRegex(publisher.PublicationError, "Downloaded release hashes"):
            publisher.publish(self.root, self.env, gh)
        self.assertEqual([call[1] for call in gh.calls], ["download"])

    def test_retry_still_requires_matching_verification_headline(self):
        gh = FakeGitHub(self.root, self.env, existing=True)
        report = json.loads((self.root / "verification.json").read_text())
        report["headline_declaration"] = "CollatzWork.different"
        self.write_json("verification.json", report)
        self.seal()
        with self.assertRaisesRegex(publisher.PublicationError, "headline differs"):
            publisher.publish(self.root, self.env, gh)

    def test_wrong_remote_manifest_is_not_accepted(self):
        gh = FakeGitHub(self.root, self.env, existing=True)
        gh.remote["manifest.json"] = json.dumps({**self.manifest, "publisher_commit": "c" * 40}).encode()
        with self.assertRaisesRegex(publisher.PublicationError, "Manifest publisher_commit"):
            publisher.publish(self.root, self.env, gh)
        self.assertEqual([call[1] for call in gh.calls], ["download"])

    def test_wrong_tag_or_release_target_is_rejected_before_download(self):
        for wrong_tag in (True, False):
            with self.subTest(wrong_tag=wrong_tag):
                gh = FakeGitHub(self.root, self.env, existing=True)
                if wrong_tag:
                    gh.commit = "c" * 40
                else:
                    gh.current["target_commitish"] = "main"
                with self.assertRaises(publisher.PublicationError):
                    publisher.publish(self.root, self.env, gh)
                self.assertEqual(gh.calls, [])

    def test_local_tampering_is_rejected_before_any_network_write(self):
        gh = FakeGitHub(self.root, self.env)
        (self.root / "research-source.zip").write_text("tampered")
        with self.assertRaisesRegex(publisher.PublicationError, "Local asset hash"):
            publisher.publish(self.root, self.env, gh)
        self.assertEqual(gh.calls, [])

    def test_manifest_scope_and_job_identity_must_match(self):
        for key, wrong in (("publication_state", "unverified-preview"),
                           ("venue_submission_state", "submitted"),
                           ("publisher_commit", "c" * 40),
                           ("conjecture_status", "proved")):
            with self.subTest(key=key):
                original = self.manifest[key]
                self.manifest[key] = wrong
                self.seal()
                gh = FakeGitHub(self.root, self.env)
                with self.assertRaisesRegex(publisher.PublicationError, "Manifest"):
                    publisher.publish(self.root, self.env, gh)
                self.assertEqual(gh.calls, [])
                self.manifest[key] = original

    def test_checksum_index_must_include_manifest_and_every_asset(self):
        (self.root / "SHA256SUMS").write_text("")
        with self.assertRaisesRegex(publisher.PublicationError, "SHA256SUMS"):
            publisher.validate_package(self.root, self.env)

    def test_failed_verification_cannot_be_published_with_valid_checksums(self):
        self.write_json("verification.json", {"status": "failed", "source_commit": self.env["SOURCE_COMMIT"]})
        self.seal()
        with self.assertRaisesRegex(publisher.PublicationError, "exact-source verification"):
            publisher.validate_package(self.root, self.env)


if __name__ == "__main__":
    unittest.main()
