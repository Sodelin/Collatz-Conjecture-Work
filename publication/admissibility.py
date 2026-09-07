"""Local venue preparation policy, separate from syntax and archive verification.

This checks evidence records and their binding to a claim. It cannot establish
that the evidence is mathematically correct or promise a curator's acceptance.
No function in this module submits or publishes anything.
"""
from __future__ import annotations

from datetime import date
import hashlib
import json
import unicodedata
from urllib.parse import urlsplit

VENUE = "vibemathed"
STATES = {"eligible", "blocked", "insufficient-evidence"}


def scientific_fingerprint(metadata: dict) -> str:
    """Bind the question and actual result, excluding presentation-only titles."""
    fields = metadata.get("vibemathed", {})
    scientific = {key: unicodedata.normalize("NFC", str(fields.get(key, "")).strip())
                  for key in ("statement", "resultNote", "solveType", "resolution")}
    return hashlib.sha256(json.dumps(scientific, sort_keys=True, ensure_ascii=False,
                                     separators=(",", ":")).encode()).hexdigest()


def _text(value) -> bool:
    return isinstance(value, str) and bool(value.strip())


def _url(value) -> bool:
    if not _text(value):
        return False
    try:
        parsed = urlsplit(value)
        return parsed.scheme in {"http", "https"} and bool(parsed.hostname) and not parsed.username and not parsed.password
    except ValueError:
        return False


def evaluate(metadata: dict, assessment) -> dict:
    """Fail closed for missing/stale evidence; known exclusions stay distinct."""
    report = {"schema_version": 1, "venue": VENUE,
              "source_commit": metadata.get("source_commit"),
              "scientific_sha256": scientific_fingerprint(metadata),
              "status": "insufficient-evidence", "reasons": [],
              "assessment": assessment,
              "meaning": "Internal venue-fit assessment only; not mathematical verification, established priority, submission, or curator acceptance."}

    def reason(code, message):
        report["reasons"].append({"code": code, "message": message})

    if not isinstance(assessment, dict):
        reason("missing-assessment", "No documented assessment is available.")
        return report
    if (assessment.get("schema_version") != 1 or assessment.get("venue") != VENUE
            or assessment.get("decision") not in STATES):
        reason("invalid-assessment", "Unknown assessment version, venue, or disposition.")
        return report
    if (assessment.get("source_commit") != report["source_commit"]
            or assessment.get("scientific_sha256") != report["scientific_sha256"]):
        reason("stale-assessment", "Source or scientific statement changed; reassess this exact candidate.")
        return report
    if assessment["decision"] == "blocked":
        report["status"] = "blocked"
        reason("documented-exclusion", assessment.get("decision_reason") or "The candidate has a recorded venue-fit exclusion.")
        return report

    target = assessment.get("target")
    target = target if isinstance(target, dict) else {}
    if target.get("origin") in {"self-chosen-restriction", "research-direction-only"}:
        report["status"] = "blocked"
        reason("no-stated-target", "A self-chosen restriction or research direction alone does not establish a previously stated question.")
        return report
    if target.get("origin") != "previously-stated-question":
        reason("missing-target-provenance", "Identify a previously stated question, separately from the result proved here.")
    for field in ("name", "statement", "posed_by"):
        if not _text(target.get(field)):
            reason("missing-target-" + field, "Target evidence is missing: " + field + ".")
    source = target.get("source")
    source = source if isinstance(source, dict) else {}
    for field in ("title", "locator", "statement_excerpt"):
        if not _text(source.get(field)):
            reason("missing-source-" + field, "Primary-source evidence is missing: " + field + ".")
    if not _url(source.get("url")):
        reason("missing-source-url", "A public primary-source URL is required.")
    chronology = assessment.get("chronology")
    chronology = chronology if isinstance(chronology, dict) else {}
    if not _url(chronology.get("work_start_evidence_url")):
        reason("missing-work-chronology", "Link evidence of when this work began.")
    try:
        posed = date.fromisoformat(source.get("published_date", ""))
        started = date.fromisoformat(chronology.get("work_started_date", ""))
        if posed > started:
            report["status"] = "blocked"
            reason("target-postdates-work", "The supplied target date is later than the start of this work.")
        elif posed == started:
            reason("ambiguous-chronology", "Same-day dates do not establish that the question preceded the work.")
    except (ValueError, TypeError):
        reason("missing-dated-provenance", "Provide valid ISO dates for the question and the start of this work; do not invent precision.")
    progress = assessment.get("progress")
    progress = progress if isinstance(progress, dict) else {}
    if progress.get("relation") not in {"settles", "measurable-progress"}:
        reason("missing-progress-relation", "State how the result settles or measurably advances the prior question.")
    for field in ("prior_baseline", "proved_result", "connection_argument"):
        if not _text(progress.get(field)):
            reason("missing-progress-" + field, "Progress evidence is missing: " + field + ".")
    if not _url(progress.get("evidence_url")):
        reason("missing-progress-url", "Link the exact proof or argument establishing the stated progress.")
    novelty = assessment.get("novelty")
    novelty = novelty if isinstance(novelty, dict) else {}
    # Bounded evidence is acceptable; this is deliberately not a priority certificate.
    for field in ("nearest_prior_result", "added_contribution", "search_scope", "limitations"):
        if not _text(novelty.get(field)):
            reason("missing-novelty-" + field, "Claim-specific prior-art accounting is missing: " + field + ".")
    if not _url(novelty.get("review_url")):
        reason("missing-novelty-review", "Link the bounded prior-art review and attribution record.")
    if not _text(assessment.get("assessed_by")) or not _text(assessment.get("assessed_date")):
        reason("missing-assessment-attribution", "Record who made this internal assessment and when.")
    if assessment["decision"] != "eligible":
        reason("assessment-not-eligible", assessment.get("decision_reason") or "The recorded assessment does not recommend venue preparation.")
    if not report["reasons"]:
        report["status"] = "eligible"
    return report


def require_eligible(report: dict) -> None:
    if report.get("status") != "eligible":
        reasons = "; ".join(reason["message"] for reason in report.get("reasons", []))
        raise ValueError("Venue preparation blocked (" + report.get("status", "missing-assessment") + "): " + reasons)
