"""Behavioral distinction between a verified archive and venue preparation."""
import copy
import json
from pathlib import Path
import tempfile
import unittest
from unittest.mock import patch

from publication import admissibility as policy
from publication import build as exporter

ROOT = Path(__file__).resolve().parents[1]


class AdmissibilityTests(unittest.TestCase):
    def setUp(self):
        self.metadata = exporter.read_json(ROOT / "publication/metadata.json")
        self.assessment = exporter.read_json(ROOT / "publication/admissibility.json")
        self.schema = exporter.read_json(ROOT / "publication/vibemathed-schema.json")

    def qualifying_fixture(self):
        """Fictional evidence exercises policy, never claims an actual discovery."""
        metadata = copy.deepcopy(self.metadata)
        metadata["vibemathed"].update(statement="Previously stated fixture problem: is B(n) at most n for all n >= 1?",
                                      resultNote="A proved improvement from B(n) <= 2n to B(n) <= 3n/2.")
        assessment = {
            "schema_version": 1, "venue": "vibemathed", "decision": "eligible",
            "source_commit": metadata["source_commit"],
            "scientific_sha256": policy.scientific_fingerprint(metadata),
            "assessed_by": "Test fixture only", "assessed_date": "2026-09-07",
            "target": {"origin": "previously-stated-question", "name": "Fixture bound problem",
                       "statement": metadata["vibemathed"]["statement"], "posed_by": "Fixture author",
                       "source": {"title": "Fixture question", "url": "https://example.org/question",
                                  "published_date": "2020-01-01", "locator": "Problem 2",
                                  "statement_excerpt": "Is B(n) <= n for all n >= 1?"}},
            "chronology": {"work_started_date": "2026-08-01", "work_start_evidence_url": "https://example.org/work-start"},
            "progress": {"relation": "measurable-progress", "prior_baseline": "B(n) <= 2n",
                         "proved_result": "B(n) <= 3n/2", "connection_argument": "For every n >= 1, 3n/2 < 2n, improving the upper bound toward n.",
                         "evidence_url": "https://example.org/proof"},
            "novelty": {"nearest_prior_result": "Fixture bound 2n", "added_contribution": "Fixture bound 3n/2",
                        "search_scope": "A bounded fixture review", "limitations": "No absolute priority certification",
                        "review_url": "https://example.org/prior-art"},
        }
        return metadata, assessment

    def test_real_candidate_is_schema_valid_but_blocked(self):
        draft, _ = exporter.make_draft(self.metadata, self.schema, "a" * 40, False)
        exporter.validate_draft(draft, self.schema)
        report = policy.evaluate(self.metadata, self.assessment)
        self.assertEqual(report["status"], "blocked")
        with self.assertRaisesRegex(ValueError, "Venue preparation blocked"):
            policy.require_eligible(report)

    def test_retitle_does_not_remove_recorded_exclusion(self):
        for key in ("name", "shortName"):
            metadata = copy.deepcopy(self.metadata)
            metadata["vibemathed"][key] = "A much stronger sounding title"
            self.assertEqual(policy.evaluate(metadata, self.assessment)["status"], "blocked")

    def test_source_and_scientific_changes_invalidate_assessment(self):
        for key in ("source_commit", "statement", "resultNote"):
            metadata, assessment = self.qualifying_fixture()
            if key == "source_commit":
                metadata[key] = "c" * 40
            else:
                metadata["vibemathed"][key] += " Changed mathematical scope."
            report = policy.evaluate(metadata, assessment)
            self.assertEqual(report["status"], "insufficient-evidence")
            self.assertEqual(report["reasons"][0]["code"], "stale-assessment")

    def test_missing_evidence_is_separate_from_known_exclusion(self):
        self.assertEqual(policy.evaluate(self.metadata, None)["status"], "insufficient-evidence")
        for field in ("target", "chronology", "progress", "novelty"):
            metadata, assessment = self.qualifying_fixture()
            del assessment[field]
            self.assertEqual(policy.evaluate(metadata, assessment)["status"], "insufficient-evidence")

    def test_target_direction_or_new_restriction_cannot_pass_by_changing_decision(self):
        for origin in ("research-direction-only", "self-chosen-restriction"):
            metadata, assessment = self.qualifying_fixture()
            assessment["target"]["origin"] = origin
            self.assertEqual(policy.evaluate(metadata, assessment)["status"], "blocked")

    def test_dated_prior_target_and_real_progress_fields_are_required(self):
        for field in ("published_date", "locator", "statement_excerpt", "url"):
            metadata, assessment = self.qualifying_fixture()
            del assessment["target"]["source"][field]
            self.assertEqual(policy.evaluate(metadata, assessment)["status"], "insufficient-evidence")
        metadata, assessment = self.qualifying_fixture()
        assessment["target"]["source"]["published_date"] = "2026-09-01"
        self.assertEqual(policy.evaluate(metadata, assessment)["status"], "blocked")
        assessment["target"]["source"]["published_date"] = "2026-08-01"
        self.assertEqual(policy.evaluate(metadata, assessment)["status"], "insufficient-evidence")

    def test_synthetic_proved_bound_improvement_is_eligible_without_priority_certificate(self):
        metadata, assessment = self.qualifying_fixture()
        report = policy.evaluate(metadata, assessment)
        self.assertEqual(report["status"], "eligible", report["reasons"])
        policy.require_eligible(report)
        # Eligibility is necessary; preparation still needs an explicit action.
        draft, _ = exporter.make_draft(metadata, self.schema, "a" * 40, False)
        disabled = exporter.importer(draft, "fixture", report)
        enabled = exporter.importer(draft, "fixture", report, True)
        self.assertNotIn("localStorage", disabled)
        self.assertIn("throw new Error", disabled)
        self.assertIn("localStorage.setItem", enabled)
        self.assertNotIn("fetch(", enabled)
        self.assertNotIn(".submit(", enabled)

    def test_verified_labels_cannot_change_admissibility(self):
        metadata = copy.deepcopy(self.metadata)
        metadata["vibemathed"]["verification"] = "lean-verified"
        self.assertEqual(policy.evaluate(metadata, self.assessment)["status"], "blocked")

    def preview(self, output, **kwargs):
        claims = exporter.read_json(ROOT / "publication/claims.json")
        files = {name: b"fixture source\n" for claim in claims for name in claim["source_paths"]}
        def git(_root, *args):
            return b"a" * 40 if args == ("rev-parse", "HEAD") else b""
        with patch.object(exporter, "snapshot", return_value=files), patch.object(exporter, "git", side_effect=git):
            return exporter.build(ROOT, output, ROOT / "publication/metadata.json", None, preview=True, **kwargs)

    def test_blocked_candidate_still_builds_archive_with_disabled_helper_and_report(self):
        with tempfile.TemporaryDirectory() as directory:
            output = Path(directory) / "archive"
            manifest = self.preview(output)
            self.assertEqual(manifest["venue_admissibility_state"], "blocked")
            self.assertEqual(manifest["venue_preparation_state"], "archive-only")
            self.assertIn("admissibility-report.json", manifest["artifacts"])
            self.assertIn("CITATION.md", manifest["artifacts"])
            self.assertNotIn("CITATION.cff", manifest["artifacts"])
            self.assertFalse((output / "CITATION.cff").exists())
            self.assertNotRegex((output / "citation.bib").read_text(), r"(?im)^\s*(author|editor)\s*=")
            self.assertTrue((output / "research-source.zip").is_file())
            self.assertIn("ARCHIVE ONLY", (output / "vibemathed-form.md").read_text())
            self.assertNotIn("localStorage", (output / "vibemathed-import.js").read_text())
            with self.assertRaisesRegex(ValueError, "Venue preparation blocked"):
                self.preview(Path(directory) / "prepare", prepare_venue=True)
            self.assertFalse((Path(directory) / "prepare/vibemathed-import.js").exists())

    def test_missing_assessment_does_not_block_archive_build(self):
        with tempfile.TemporaryDirectory() as directory:
            manifest = self.preview(Path(directory) / "archive", admissibility_path=Path(directory) / "absent.json")
            self.assertEqual(manifest["venue_admissibility_state"], "insufficient-evidence")
            self.assertEqual(manifest["venue_preparation_state"], "archive-only")

    def test_malformed_assessment_preserves_archive_and_disables_preparation(self):
        with tempfile.TemporaryDirectory() as directory:
            assessment = Path(directory) / "malformed.json"
            assessment.write_text("{broken json")
            manifest = self.preview(Path(directory) / "archive", admissibility_path=assessment)
            self.assertEqual(manifest["venue_admissibility_state"], "insufficient-evidence")
            self.assertEqual(manifest["venue_preparation_state"], "archive-only")


if __name__ == "__main__":
    unittest.main()
