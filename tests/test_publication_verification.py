"""Publication must fail closed when revision or mathematical audits disagree."""

import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest
from unittest.mock import patch

from publication import verify_source as verifier


class PublicationVerificationTests(unittest.TestCase):
    def test_missing_and_unexpected_axioms_are_rejected(self):
        for output in (
            "'CollatzWork.headline' depends on axioms: [propext, sorryAx]",
            "'CollatzWork.headline' depends on axioms: [CollatzWork.unprovedBridge]",
            "Build completed successfully.",
        ):
            with self.subTest(output=output):
                with self.assertRaises(verifier.VerificationError):
                    verifier.audit_axioms(output, {"CollatzWork.headline"})

    def test_multiline_and_axiom_free_lean_output(self):
        output = """'CollatzWork.headline' depends on axioms: [propext,
            Classical.choice, Quot.sound]
        'CollatzWork.other' does not depend on any axioms
        """
        report = verifier.audit_axioms(output, {"CollatzWork.headline", "CollatzWork.other"})
        self.assertEqual(report, [
            {"declaration": "CollatzWork.headline", "axioms": ["Classical.choice", "Quot.sound", "propext"]},
            {"declaration": "CollatzWork.other", "axioms": []},
        ])

    def test_verification_removes_inherited_optimization(self):
        with patch.dict(os.environ, {"PYTHONOPTIMIZE": "2", "PYTHONPATH": "/untrusted/path"}):
            env = verifier.verification_environment()
        self.assertNotIn("PYTHONOPTIMIZE", env)
        self.assertNotIn("PYTHONPATH", env)

    def test_metadata_cannot_inject_output_or_lean_commands(self):
        metadata = {"source_commit": "a" * 40, "repository": "Sodelin/Collatz-Conjecture-Work",
                    "headline_declaration": "CollatzWork.headline"}
        verifier.validate_metadata(metadata)
        for key, invalid in (
            ("source_commit", "main"),
            ("source_commit", "a" * 40 + "\nother=bad"),
            ("repository", "../outside"),
            ("headline_declaration", "CollatzWork.headline\naxiom fake : False"),
        ):
            with self.subTest(key=key, invalid=invalid):
                with self.assertRaises(verifier.VerificationError):
                    verifier.validate_metadata({**metadata, key: invalid})

    def test_wrong_checkout_writes_failed_report_without_running_lean(self):
        metadata = {"source_commit": "a" * 40, "repository": "Sodelin/Collatz-Conjecture-Work",
                    "headline_declaration": "CollatzWork.headline"}
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source, output = root / "source", root / "dist"
            source.mkdir()
            result = subprocess.CompletedProcess(["git"], 0, "b" * 40 + "\n")
            with patch.object(verifier.subprocess, "run", return_value=result) as run:
                report = verifier.verify(source, output, metadata)
            self.assertEqual(run.call_count, 1)
            self.assertEqual(report["status"], "failed")
            self.assertIn("Source commit mismatch", report["error"])
            self.assertEqual(json.loads((output / "verification.json").read_text()), report)
            self.assertTrue((output / report["commands"][0]["log"]).is_file())

    def test_nonzero_checker_and_incomplete_proof_cannot_pass(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            for code, text in ((1, "certificate failed"), (0, "warning: declaration uses 'sorry'")):
                with self.subTest(code=code, text=text):
                    report = {"commands": []}
                    result = subprocess.CompletedProcess(["lean"], code, text)
                    with patch.object(verifier.subprocess, "run", return_value=result):
                        with self.assertRaises(verifier.VerificationError):
                            verifier.run_command(root, root, report, "proof", ["lean", "proof.lean"])
                    self.assertEqual(report["commands"][0]["exit_code"], code)
                    self.assertEqual((root / report["commands"][0]["log"]).read_text(), text)

    def test_archived_program_is_compiled_and_audited_separately(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            source, output = root / "source", root / "output"
            archive = "research/archive-name/Proof.lean"
            original = "import Std\nnamespace Archive\ntheorem checked : True := True.intro\nend Archive\n"
            for name, text in (("lean/Fixture.lean", "import Std\n"),
                               (archive, original), ("lakefile.lean", "import Lake\n")):
                path = source / name
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text(text)
            report = {"commands": [], "axiom_audit": []}
            calls = []
            def command(_source, _output, _report, label, args):
                calls.append((label, args))
                if label.startswith("standalone-axioms-"):
                    return "'Archive.checked' does not depend on any axioms\n"
                if label == "declaration-axioms":
                    return "'Fixture.headline' depends on axioms: [propext]\n"
                return ""
            with patch.dict(verifier.STANDALONE_LEAN, {archive: ("Archive.checked",)}, clear=True), \
                    patch.object(verifier, "run_command", side_effect=command):
                verifier.verify_lean_sources(source, output, report,
                    [archive, "lakefile.lean", "lean/Fixture.lean"], "Fixture.headline")
            self.assertIn(["lake", "env", "lean", archive], [args for _, args in calls])
            self.assertIn(["lake", "build", "Fixture"], [args for _, args in calls])
            labels = [label for label, _ in calls]
            self.assertLess(labels.index("build-module-Fixture"), labels.index("declaration-axioms"))
            self.assertEqual((source / archive).read_text(), original)
            audit = output / report["standalone_lean"][0]["audit_program"]
            self.assertTrue(audit.read_text().startswith(original))
            self.assertIn("#print axioms Archive.checked", audit.read_text())
            main_audit = (output / "verification-logs/PublicationAxiomAudit.lean").read_text()
            self.assertIn("import Fixture", main_audit)
            self.assertNotIn("archive-name", main_audit)
            self.assertNotIn("import lakefile", main_audit)
            self.assertEqual(report["lean_config_files"], ["lakefile.lean"])
            self.assertEqual({row["declaration"] for row in report["axiom_audit"]},
                             {"Fixture.headline", "Archive.checked"})

    def test_archived_audit_cannot_omit_or_hide_axioms(self):
        archive = "research/archive-name/Proof.lean"
        for result in ("Build completed successfully.",
                       "'Archive.checked' depends on axioms: [sorryAx]",
                       "'Archive.checked' depends on axioms: [Archive.unproved]"):
            with self.subTest(result=result), tempfile.TemporaryDirectory() as directory:
                root = Path(directory)
                path = root / "source" / archive
                path.parent.mkdir(parents=True)
                path.write_text("import Std\n")
                with patch.dict(verifier.STANDALONE_LEAN, {archive: ("Archive.checked",)}, clear=True), \
                        patch.object(verifier, "run_command", return_value=result), \
                        self.assertRaises(verifier.VerificationError):
                    verifier.verify_lean_sources(root / "source", root / "output",
                        {"commands": []}, [archive], "Fixture.headline")

    def test_unknown_archived_lean_is_not_silently_skipped(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "unreviewed.lean").write_text("import Std\n")
            with self.assertRaisesRegex(verifier.VerificationError, "explicit standalone audit policy"):
                verifier.verify_lean_sources(root, root / "out", {"commands": []},
                    ["unreviewed.lean"], "Fixture.headline")

    def test_checker_failure_survives_inherited_optimization(self):
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            (root / "checker.py").write_text("assert False, 'deliberately invalid certificate'\n")
            report = {"commands": []}
            with patch.dict(os.environ, {"PYTHONOPTIMIZE": "2"}), \
                    self.assertRaises(verifier.VerificationError):
                verifier.run_checker(root, root, report, "checker.py", ("-B",))
            self.assertEqual(report["commands"][0]["exit_code"], 1)
            self.assertIn("AssertionError", (root / report["commands"][0]["log"]).read_text())
            with patch.object(verifier, "run_command") as run, \
                    self.assertRaisesRegex(verifier.VerificationError, "removable assertions"):
                verifier.run_checker(root, root, report, "checker.py", ("-O", "-B"))
            run.assert_not_called()


if __name__ == "__main__":
    unittest.main()
