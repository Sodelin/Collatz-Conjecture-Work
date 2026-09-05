"""Failure-path coverage for publication integrity and venue constraints."""
import copy
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest
import zipfile

ROOT = Path(__file__).resolve().parents[1]
SPEC = importlib.util.spec_from_file_location("publication_build", ROOT / "publication/build.py")
EXPORT = importlib.util.module_from_spec(SPEC)
SPEC.loader.exec_module(EXPORT)


class PublicationExportTests(unittest.TestCase):
    def setUp(self):
        self.schema = EXPORT.read_json(ROOT / "publication/vibemathed-schema.json")
        self.metadata = EXPORT.read_json(ROOT / "publication/metadata.json")
        self.draft, _ = EXPORT.make_draft(self.metadata, self.schema, "a" * 40, False)

    def test_actual_draft_and_preview_obey_schema(self):
        EXPORT.validate_draft(self.draft, self.schema)
        draft, _ = EXPORT.make_draft(self.metadata, self.schema, "a" * 40, True)
        self.assertEqual(draft["verification"], "unreviewed")
        self.assertIn("UNVERIFIED", draft["verificationNote"])

    def test_scope_cannot_silently_be_promoted(self):
        for field, value in (("resolution", "resolved"), ("verification", "lean-verified")):
            draft = dict(self.draft, **{field: value})
            with self.assertRaises(ValueError):
                EXPORT.validate_draft(draft, self.schema)

    def test_form_length_and_duplicate_links_are_rejected(self):
        for draft in (dict(self.draft, shortName="x" * 61),
                      dict(self.draft, shortName="𝔽" * 61),
                      dict(self.draft, links=json.dumps([{"label": "Primary again", "url": self.draft["sourceUrl"] + "?tracking=yes", "kind": "other"}]))):
            with self.assertRaises(ValueError):
                EXPORT.validate_draft(draft, self.schema)

    def test_form_counts_normalized_codepoints_and_export_normalizes(self):
        for value in ("𝔽" * 60, "  " + "e\u0301" * 60 + "  "):
            EXPORT.validate_draft(dict(self.draft, shortName=value), self.schema)
        metadata = copy.deepcopy(self.metadata)
        metadata["vibemathed"]["shortName"] = "  " + "e\u0301" * 60 + "  "
        draft, _ = EXPORT.make_draft(metadata, self.schema, "a" * 40, False)
        self.assertEqual(draft["shortName"], "é" * 60)
        metadata["vibemathed"]["sourceUrl"] = "{source_url}/blob/{publisher_commit}/publication/template-fixture.md"
        draft, _ = EXPORT.make_draft(metadata, self.schema, "a" * 40, False)
        self.assertIn("/blob/" + "a" * 40 + "/", draft["sourceUrl"])

    def test_link_label_retains_upstream_utf16_limit(self):
        link = {"label": "𝔽" * 60, "url": "https://example.org/proof", "kind": "code"}
        EXPORT.validate_draft(dict(self.draft, links=json.dumps([link])), self.schema)
        for label in ("𝔽" * 61, "   "):
            with self.assertRaises(ValueError):
                EXPORT.validate_draft(dict(self.draft, links=json.dumps([{**link, "label": label}])), self.schema)

    def test_dates_numbers_and_missing_verification_evidence_fail(self):
        for field, value in (("solveDate", "0999"), ("solveDate", "3001"),
                             ("solveDate", "2026-00"), ("solveDate", "2026-13"),
                             ("solveDate", "2026-09-00"), ("solveDate", "2026-09-32"),
                             ("yearPosed", "999"), ("yearPosed", "3001"),
                             ("citations", "１２")):
            with self.subTest(field=field, value=value), self.assertRaises(ValueError):
                EXPORT.validate_draft(dict(self.draft, **{field: value}), self.schema)
        for date in ("2026", "2026-09", "2026-09-05", "2026-02-31"):
            # The observed upstream checks component ranges only.
            EXPORT.validate_draft(dict(self.draft, solveDate=date), self.schema)
        with self.assertRaises(ValueError):
            EXPORT.validate_draft(dict(self.draft, verification="lean-checked", verificationNote="", links="[]"), self.schema)

    def test_missing_and_unrecognized_fields_fail(self):
        for key in ("sourceUrl", "unrecognized"):
            draft = copy.deepcopy(self.draft)
            if key in draft:
                del draft[key]
            else:
                draft[key] = "unsupported"
            with self.assertRaises(ValueError):
                EXPORT.validate_draft(draft, self.schema)

    def test_zip_is_deterministic_and_rejects_traversal(self):
        with tempfile.TemporaryDirectory() as tmp:
            first, second = Path(tmp) / "a.zip", Path(tmp) / "b.zip"
            files = {"lean/A.lean": b"theorem example : True := True.intro\n", "README.md": b"scope\n"}
            EXPORT.zip_bytes(files, first)
            EXPORT.zip_bytes(dict(reversed(list(files.items()))), second)
            self.assertEqual(first.read_bytes(), second.read_bytes())
            with zipfile.ZipFile(first) as archive:
                self.assertEqual(set(archive.namelist()), set(files))
            with self.assertRaises(ValueError):
                EXPORT.zip_bytes({"../escape": b"x"}, second)

    def test_lean_bundle_retains_archived_programs_and_lake_config(self):
        files = {
            "lean/A.lean": b"theorem ok : True := True.intro\n",
            "lean/README.md": b"Library scope\n",
            "research/blind-2026-09-05/Descent.lean": b"import Std\n",
            "lakefile.lean": b"import Lake\n",
            "lakefile.toml": b'name = "fixture"\n',
            "lean-toolchain": b"leanprover/lean4:v4.33.1\n",
            "lake-manifest.json": b'{}\n',
            "README.md": b"General note\n",
        }
        bundle = EXPORT.lean_bundle_files(files)
        self.assertEqual(set(bundle), set(files) - {"README.md"})
        with tempfile.TemporaryDirectory() as directory:
            path = Path(directory) / "lean-source.zip"
            EXPORT.zip_bytes(bundle, path)
            with zipfile.ZipFile(path) as archive:
                for name, contents in bundle.items():
                    self.assertEqual(archive.read(name), contents)

    def test_source_must_match_commit_and_tracked_files(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            def git(*args):
                return subprocess.check_output(["git", "-C", tmp, *args], stderr=subprocess.DEVNULL).decode().strip()
            git("init")
            (root / "proof.lean").write_text("theorem ok : True := True.intro\n")
            git("add", ".")
            git("-c", "user.name=Test", "-c", "user.email=test@example.invalid", "commit", "-m", "fixture")
            sha = git("rev-parse", "HEAD")
            self.assertIn("proof.lean", EXPORT.snapshot(root, sha))
            with self.assertRaises(ValueError):
                EXPORT.snapshot(root, "0" * 40)
            (root / "proof.lean").write_text("axiom ok : False\n")
            with self.assertRaises(ValueError):
                EXPORT.snapshot(root, sha)

    def test_helper_stays_on_venue_origin_and_never_submits(self):
        code = EXPORT.importer(self.draft, self.schema["transport"]["draft_storage_key"])
        self.assertIn("location.origin !== 'https://vibemathed.com'", code)
        self.assertIn(":backup:", code)
        self.assertNotIn("fetch(", code)
        self.assertNotIn(".submit(", code)
        self.assertNotIn("document.cookie", code)

    def test_verification_archive_retains_exact_audit_program(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            log = "verification-logs/declaration-axioms.log"
            audit = "verification-logs/PublicationAxiomAudit.lean"
            (root / "verification-logs").mkdir()
            (root / log).write_text("axiom result\n")
            report = {"status": "passed", "commands": [{"log": log}]}
            with self.assertRaises(ValueError):
                EXPORT.verification_files(report, root)
            (root / audit).write_text("import CollatzWork\n#print axioms CollatzWork.headline\n")
            target = root / "verification-logs.zip"
            EXPORT.zip_bytes(EXPORT.verification_files(report, root), target)
            with zipfile.ZipFile(target) as archive:
                self.assertEqual(set(archive.namelist()), {log, audit})
                self.assertEqual(archive.read(audit), (root / audit).read_bytes())

    def test_standalone_audit_programs_are_required_evidence(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            main = "verification-logs/PublicationAxiomAudit.lean"
            standalone = "verification-logs/StandaloneDescentAxiomAudit.lean"
            (root / main).parent.mkdir()
            (root / main).write_text("import Fixture\n")
            report = {"status": "passed", "commands": [],
                      "audit_programs": [main, standalone]}
            with self.assertRaisesRegex(ValueError, "Verification evidence missing"):
                EXPORT.verification_files(report, root)
            (root / standalone).write_text("import Std\n#print axioms Nat.add_comm\n")
            self.assertEqual(set(EXPORT.verification_files(report, root)), {main, standalone})


if __name__ == "__main__":
    unittest.main()
