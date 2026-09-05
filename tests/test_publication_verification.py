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


if __name__ == "__main__":
    unittest.main()
