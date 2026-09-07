#!/usr/bin/env python3
"""Build a portable report and a minimal, byte-pinned certificate replay bundle.

Requires Python 3.10+ for replay, plus pandoc/XeLaTeX for PDF generation.
This script prepares local files only; it makes no remote submission.
"""
from __future__ import annotations

import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import zipfile

HERE = Path(__file__).resolve().parent
ROOT = HERE.parent.parent
SOURCE = "d45362b75a8b48c7067e6db864e948be713f32e9"
PUBLICATION = "026aa4ad4be6453a005ab950b160a9f2204c5271"
REPO = "https://github.com/Sodelin/Collatz-Conjecture-Work"
TITLE = "Exact certificates excluding scalar arctic-natural first steps for the mixed-base Collatz rewrite system"
REPLAY_FILES = [
    "verification/yah_two_state_scalar_arctic_full_no_start.py",
    "verification/yah_scalar_arctic_top/top_cert_common.py",
    "verification/yah_scalar_arctic_top/top_certificates.json",
    "verification/yah_scalar_arctic_top/verify_top_certificates.py",
]
COMMANDS = [
    ["python3", "-S", "-B", REPLAY_FILES[0]],
    ["python3", "-S", "-B", REPLAY_FILES[3]],
]


def sha(data: bytes) -> str:
    return hashlib.sha256(data).hexdigest()


def write(name: str, text: str) -> None:
    (HERE / name).write_text(text, encoding="utf-8")


def source_bytes(rev: str, path: str) -> bytes:
    return subprocess.check_output(["git", "show", f"{rev}:{path}"], cwd=ROOT)


def portable_link(match: re.Match[str]) -> str:
    label, target = match.group(1), match.group(2)
    if re.match(r"[a-z]+://|#", target):
        return match.group(0)
    logical = os.path.normpath("publication/" + target)
    revision = SOURCE if logical.startswith(("verification/", "proof-search/", "lean/")) else PUBLICATION
    return f"[{label}]({REPO}/blob/{revision}/{logical})"


def make_note() -> str:
    original = source_bytes(PUBLICATION, "publication/yah-obstruction.md").decode()
    historical_contact = re.search(r"^Maintainer: ([^.]+)\.", original, re.M).group(1)
    note = original.replace(
        "**A restricted proof-method result for community review. Collatz remains unresolved.**",
        "**Unreviewed research report and reproducibility artifact. Collatz remains unresolved.**",
    ).replace(
        f"Maintainer: {historical_contact}. Research and preparation were AI-assisted.",
        "Research and preparation were AI-assisted. No human mathematical authorship or editor role is claimed for this proposed deposit. Contribution metadata and platform eligibility remain under review.",
    )
    note = note.replace(
        "Our contribution is therefore a restricted first-step subcase of its broader research direction, not a resolution of that direction.",
        "The result is therefore a restricted first-step subcase of that broader research direction. It does not settle the general matrix-interpretation question and is not presented as the resolution of a previously stated named conjecture.",
    ).replace(
        "The precise subquestion is whether the specified unbounded scalar interpretation class can make any first rule-removal progress.",
        "The project-selected subquestion is whether the specified unbounded scalar interpretation class can make any first rule-removal progress.",
    )
    note = note.replace(
        "From the mathematical source checkout specified by the release manifest, with Python assertions enabled:",
        "From the extracted accompanying reproducibility ZIP, or from the pinned mathematical source checkout, with Python 3.10 or newer and assertions enabled:",
    )
    note = note.replace(
        "Write the internal slopes as `a,b,c,d,e`.",
        r"Write the internal slopes as $a=m_f$, $b=m_t$, $c=m_0$, $d=m_1$, and $e=m_2$.",
    )
    note = note.replace(
        "Release asset hashes and the pinned mathematical source are recorded in the generated manifest and `SHA256SUMS`. See [publication metadata](metadata.json) for the selected revision.",
        "The accompanying report package records the mathematical source revision, per-file byte hashes and checker commands in `manifest.json`, and results in `replay-results.json`; `SHA256SUMS` covers its delivered files. The focused ZIP contains only the four Python/checker-data files needed for these two replays, with a README, rights statement and manifest. The broader [publication metadata](metadata.json) records the earlier consolidated release.",
    )
    note = note.replace(
        "This is the narrowly selected candidate for one VibeMathed partial-result entry.",
        "This report archives a scoped proof-method obstruction with executable certificate data. The earlier catalog submission was declined because the exact restricted subquestion had not been stated before the project selected it; this report does not claim to cure that eligibility issue by changing its wording. Archival availability does not establish novelty, peer review, or a solution to the general YAH matrix-interpretation question.",
    )
    note = re.sub(r"\[([^\]\\]+)\]\(([^)]+)\)", portable_link, note)
    # Preserve the original display mathematics byte for byte. Render inline
    # mathematical notation as mathematics, not font-dependent Unicode code.
    replacements = {
        "`⊥ = -∞`": r"$\bot=-\infty$",
        "`a ≫ b`": r"$a\gg b$",
        "`a>b`": "$a>b$",
        "`T₂`": "$T_2$",
        "`Δᵢ`": r"$\Delta_i$",
        "`Δᵢ·m`": r"$\Delta_i\cdot m$",
        "`s₁…sₖ`": r"$s_1\cdots s_k$",
        "`0 ≥ b`": r"$0\ge b$",
        "`b>0`": "$b>0$",
        "`a=0`": "$a=0$",
        "`e=b`": "$e=b$",
        "`b=0`": "$b=0$",
        "`c=d`": "$c=d$",
        "`c=d=0`": "$c=d=0$",
    }
    for old, new in replacements.items():
        note = note.replace(old, new)
    # Preserve immutable source provenance without reproducing personal attribution.
    note = note.replace(
        f"{historical_contact} maintains the project; repository ownership is not asserted to establish sole mathematical authorship.",
        "Historical provenance is available through the immutable source-manuscript link. Personal attribution from that earlier record is not reproduced in this packet; no human mathematical author or editor role is assigned for this proposed deposit.",
    )
    note += f"\n## Appendix. Archival package provenance\n\nThis portable report preserves the mathematical claims of the [original manuscript]({REPO}/blob/{PUBLICATION}/publication/yah-obstruction.md). Changes concern venue framing, attribution disclosure, notation typesetting, reproduction instructions and immutable links. All display formulas are unchanged.\n\nMathematical source: `{SOURCE[:12]}` ([full revision]({REPO}/commit/{SOURCE})). Publication source: `{PUBLICATION[:12]}` ([full revision]({REPO}/commit/{PUBLICATION})). The four replay files are byte-identical at both revisions. The package is an unreviewed research report; it is not a claim of external mathematical acceptance. Contribution roles and platform eligibility remain unresolved; no remote submission is authorized by this packet itself.\n\nExisting rights are retained. The proposed deposit grants no new broad reuse license over pre-existing source material. Any applicable pre-existing permissions and third-party rights remain with their holders. No claim of copyright is made over material that is not copyrightable. See `RIGHTS.txt`.\n"
    assert re.findall(r"\$\$.*?\$\$", original, re.S) == re.findall(r"\$\$.*?\$\$", note, re.S)
    assert not re.search(r"\]\((?:\.\.?/|metadata\.json|announcement\.md)", note)
    assert not any(part.casefold() in note.casefold() for part in historical_contact.split())
    return note


def main() -> None:
    write("yah-research-note.md", make_note())
    rights = """Existing rights retained; public archival access

The project maintainer has authorized public archival access to this report
and the accompanying research artifacts. This notice does not grant a new
broad reuse license or relicense pre-existing source material.

Applicable pre-existing permissions, notices, and third-party rights remain
in effect and with their respective rights holders. No blanket open-source
license was identified at the pinned project revisions. Public availability
alone should not be read as permission to redistribute, modify, or reuse
copyrightable material beyond applicable existing permissions or law.

No claim of copyright is made over material that is not copyrightable,
including any material for which no copyright protection arises. This
notice does not restrict rights that already exist under applicable law.

No human mathematical authorship or editor role is claimed for the proposed
deposit. Creator/contributor metadata and platform eligibility remain under
review. AI assistance and limitations of historical attribution are
disclosed in the report. Referenced third-party papers and author code are
linked, not bundled as copies in the focused reproducibility archive.
"""
    write("RIGHTS.txt", rights)
    description = (
        "Unreviewed research report with exact, replayable certificates for a restricted proof-method obstruction in the mixed-base Collatz rewrite system of Yolcu, Aaronson and Heule. "
        "Under the stated coefficientwise dimension-one arctic-natural constraints, it excludes a first full rule-removal step and the two specified relative-top opportunities, including one fixed two-state labeling. "
        "The full scalar cancellation is elementary and uses established machinery; the combined top/labeled certificate package is offered as a reproducible research artifact. "
        "No exact prior match was located in a bounded search, which does not establish novelty or priority. "
        "The work does not settle Collatz or the general arbitrary-dimension YAH matrix-interpretation question, and the exact restricted question was selected within this project. "
        "Replay uses standard-library Python with assertions enabled: ten top cases, 491 Farkas lemmas and 426 RUP clauses. "
        "The complete interpretation-to-encoding bridge and full-plus-top theorem are not formalized in Lean; internal AI review is not independent expert endorsement. "
        "AI assisted argument development, certificate discovery, checker code, review and manuscript preparation; exact historical model versions and complete per-step attribution are unavailable. "
        "No human mathematical authorship or editor role is claimed for the proposed deposit. Creator/contributor metadata and platform eligibility remain unresolved."
    )
    metadata = {
        "schema_note": "Review history for an archival research packet; this is not an API request payload. HOLD: no truthful, policy-compliant Zenodo path has been established for the work as represented. Do not submit this incomplete metadata. No deposit has been created by this build script.",
        "resource_type": "Report",
        "title": TITLE,
        "publication_date": "2026-09-07",
        "version": "research-report-1",
        "creators": [],
        "attribution_status": "Unresolved: no human mathematical author/editor role has been established from the user's actual contribution. No human author/editor or organization author has been assigned.",
        "venue_status": "Zenodo submission held: no eligible path established for the AI-conducted work as represented. Existing GitHub research archive is the current delivery context, with transparent AI attribution and no acceptance claim.",
        "venue_policy": {"url": "https://support.zenodo.org/help/en-gb/13-policies/227-what-is-your-usage-policy-for-generative-ai-for-depositors", "finding": "The official policy requires genuine human-conducted research and does not allow AI systems as authors, creators or contributors. No human mathematical authorship or editing role has been established for this proposed deposit."},
        "description": description,
        "keywords": ["Collatz conjecture", "string rewriting", "termination", "arctic interpretations", "proof-method obstruction", "Farkas certificates", "reverse unit propagation", "reproducible research", "AI-assisted research"],
        "language": "eng",
        "access": "open",
        "rights": {"type": "custom", "title": "Existing rights retained; public archival access", "description": "Public archival access is authorized. No new broad reuse license is granted over pre-existing source material. Applicable existing permissions and third-party rights remain in effect. No claim of copyright is made where none exists."},
        "related_identifiers": [
            {"identifier": "10.1007/s10817-022-09658-8", "scheme": "doi", "relation": "References", "title": "Yolcu, Aaronson and Heule: An Automated Approach to the Collatz Conjecture"},
            {"identifier": "https://arxiv.org/abs/2105.14697v3", "scheme": "url", "relation": "References"},
            {"identifier": f"{REPO}/tree/{SOURCE}", "scheme": "url", "relation": "IsDerivedFrom", "title": "Pinned mathematical source"},
            {"identifier": f"{REPO}/blob/{PUBLICATION}/publication/yah-obstruction.md", "scheme": "url", "relation": "IsVersionOf", "title": "Source manuscript"},
            {"identifier": f"{REPO}/blob/{PUBLICATION}/research-review/consolidation-2026-09-05/YAH_NOVELTY.md", "scheme": "url", "relation": "IsSupplementedBy", "title": "Bounded prior-art audit"},
            {"identifier": f"{REPO}/blob/{PUBLICATION}/research-review/consolidation-2026-09-05/YAH_SEMANTICS.md", "scheme": "url", "relation": "IsSupplementedBy", "title": "Internal semantic audit"},
        ],
        "references": [
            "Yolcu, E., Aaronson, S., and Heule, M. J. H. (2023). An Automated Approach to the Collatz Conjecture. Journal of Automated Reasoning 67, article 15. https://doi.org/10.1007/s10817-022-09658-8",
            "Gebhardt and Waldmann (2009). Weighted Automata Define a Hierarchy of Terminating String Rewriting Systems. Acta Cybernetica 19(2), 295-312. https://cyber.bibl.u-szeged.hu/index.php/actcybern/article/view/3770/3754",
            "Koprowski and Waldmann (2009). Max/Plus Tree Automata for Termination of Term Rewriting. Acta Cybernetica 19(2), 357-392. https://cyber.bibl.u-szeged.hu/index.php/actcybern/article/view/3772/3756",
        ],
    }
    write("metadata.json", json.dumps(metadata, indent=2, ensure_ascii=False) + "\n")
    readme = f"""# YAH restricted obstruction: report and certificate replay

This package is an **unreviewed research report** and a focused reproducibility
artifact. It is not a solution of Collatz or the general YAH arbitrary-dimension
matrix-interpretation question. The exact restricted question was chosen in the
project. Novelty and priority are not independently established.

No human mathematical authorship or editor role is claimed for the proposed
deposit. AI assisted the mathematical work, code, review and preparation;
precise historical per-step model attribution is unavailable. Historical
maintainer attribution does not establish a proposed deposit creator role.

**Zenodo submission held:** no truthful, policy-compliant deposit path has been
established for this AI-conducted work as represented. The [official Zenodo
depositor AI policy](https://support.zenodo.org/help/en-gb/13-policies/227-what-is-your-usage-policy-for-generative-ai-for-depositors)
requires genuine human-conducted research and prohibits AI systems as authors,
creators or contributors. The proposed `metadata.json` intentionally has no
assigned creator. Do not submit it, invent an organization author, or assign
a human mathematical author/editor role merely to satisfy a form.

This is a generic archival research packet for the existing GitHub research
archive, with transparent AI attribution and no claim of external acceptance.
The directory name preserves preparation history; it does not imply Zenodo
eligibility, endorsement, submission or publication.

## Read the report

`yah-research-note.pdf` is the typeset report; `yah-research-note.md` is its
portable Markdown source with immutable links. `metadata.json` contains
reviewable archival field values, not an API payload or submission receipt.
`RIGHTS.txt` preserves existing rights without imposing a new broad license.

## Replay the certificates

Extract `yah-reproducibility.zip`, then work in its `yah-reproducibility` folder.
Use Python 3.10 or newer, with assertions enabled:

```bash
python3 -S -B verification/yah_two_state_scalar_arctic_full_no_start.py
python3 -S -B verification/yah_scalar_arctic_top/verify_top_certificates.py
```

Do not set `PYTHONOPTIMIZE` or use `-O`/`-OO`. No third-party Python package,
network connection, or discovery solver is needed. All three expected final
labels must say PASS:

```text
ORIGINAL_FULL_EXTENDED_SCALAR_ARCTIC_NO_START = PASS
FULL_EXTENDED_SCALAR_ARCTIC_NO_START = PASS
TOP_SCALAR_ARCTIC_NO_FIRST_STEP = PASS
```

The top replay reconstructs all ten target cases and checks 491 exact Farkas
lemmas, 426 reverse-unit-propagation clauses, and ten terminal contradictions.
The positive Farkas multiplier mass is 10,183. These checks support only the
report's stated interpretation class and target families. The complete theorem
and encoding bridge are not Lean-formalized in this claim.

## Contents and provenance

The replay archive has four mathematical-source files: the full checker, the
top checker, its common constraint module, and its JSON certificate payload.
It also contains this README, `RIGHTS.txt`, and `manifest.json` with per-file
hashes. No discovery-solver code or third-party paper is bundled.

The package includes `replay-results.json`, whose successful command results
were obtained from an extracted copy of the ZIP. `manifest.json` outside the
ZIP records file identities and the source revisions. `SHA256SUMS` covers all
delivered files except itself. Hashes establish byte identity, not theorem
soundness, novelty or independent review.

Mathematical source: {SOURCE}
Publication source: {PUBLICATION}
Repository: {REPO}
The four replay files are byte-identical at these two revisions.

## Rebuild the report package

In a checkout containing these source commits, run:

```bash
python3 publication/zenodo/build_packet.py
```

PDF generation requires Pandoc and XeLaTeX with Latin Modern Roman and DejaVu
Sans Mono fonts. Replay requires only Python. The generated PDF may have
different bytes when rendered with different TeX/font versions. The archive
uses fixed ZIP timestamps and source bytes for deterministic source packaging.
This script does not create, upload, publish or edit any remote record.
"""
    write("README.md", readme)
    files = {path: source_bytes(SOURCE, path) for path in REPLAY_FILES}
    for path, raw in files.items():
        assert raw == source_bytes(PUBLICATION, path), path
    manifest = {
        "schema_version": 1,
        "kind": "focused-research-report-reproducibility-package",
        "mathematical_source_commit": SOURCE,
        "publication_source_commit": PUBLICATION,
        "repository": REPO,
        "source_manuscript": "publication/yah-obstruction.md",
        "source_manuscript_sha256": sha(source_bytes(PUBLICATION, "publication/yah-obstruction.md")),
        "minimum_python": "3.10",
        "commands": COMMANDS,
        "expected_top_counts": {"cases": 10, "Farkas_lemmas": 491, "RUP_clauses": 426, "terminal_contradictions": 10, "positive_multiplier_mass": 10183},
        "files": [{"path": path, "size_bytes": len(raw), "sha256": sha(raw), "source_commit": SOURCE} for path, raw in files.items()],
        "claim_ceiling": "Exact certificate replay plus prose encoding soundness; unreviewed, not a complete Lean proof; no Collatz or general YAH resolution.",
    }
    write("manifest.json", json.dumps(manifest, indent=2) + "\n")
    files.update({"README.md": readme.encode(), "RIGHTS.txt": rights.encode(), "manifest.json": (HERE / "manifest.json").read_bytes()})
    with zipfile.ZipFile(HERE / "yah-reproducibility.zip", "w", compression=zipfile.ZIP_DEFLATED, compresslevel=9) as archive:
        for path, raw in sorted(files.items()):
            info = zipfile.ZipInfo("yah-reproducibility/" + path, date_time=(2026, 9, 7, 0, 0, 0))
            info.compress_type = zipfile.ZIP_DEFLATED
            info.external_attr = 0o100644 << 16
            archive.writestr(info, raw)
    with tempfile.TemporaryDirectory(prefix="yah-archive-replay-") as scratch:
        with zipfile.ZipFile(HERE / "yah-reproducibility.zip") as archive:
            archive.extractall(scratch)
        extracted = Path(scratch) / "yah-reproducibility"
        for file in manifest["files"]:
            assert sha((extracted / file["path"]).read_bytes()) == file["sha256"]
        results = []
        for command in COMMANDS:
            run = subprocess.run(command, cwd=extracted, capture_output=True, text=True, check=True)
            results.append({"command": command, "exit_code": run.returncode, "stdout": run.stdout, "stderr": run.stderr})
            print(run.stdout, end="")
        replay = {"replayed_from_extracted_zip": True, "archive_sha256": sha((HERE / "yah-reproducibility.zip").read_bytes()), "python_version": subprocess.check_output(["python3", "--version"], text=True).strip(), "results": results}
        write("replay-results.json", json.dumps(replay, indent=2) + "\n")
    with tempfile.TemporaryDirectory(prefix="yah-typeset-") as scratch:
        header = Path(scratch) / "header.tex"
        header.write_text(r"""\usepackage{microtype}
\usepackage{xurl}
\usepackage{fvextra}
\DefineVerbatimEnvironment{Highlighting}{Verbatim}{breaklines,commandchars=\\\{\},fontsize=\small}
\fvset{breaklines=true,breakanywhere=true,fontsize=\small}
\setlength{\emergencystretch}{3em}
\AtBeginDocument{\hypersetup{colorlinks=true,urlcolor=blue,linkcolor=blue}}
\let\oldtexttt\texttt
\renewcommand{\texttt}[1]{{\small\oldtexttt{#1}}}
""", encoding="utf-8")
        pdf_source = Path(scratch) / "report.md"
        pdf_text = (HERE / "yah-research-note.md").read_text().split("\n", 1)[1]
        pdf_text = re.sub(r"`([0-9a-f]{64})`", lambda m: r"\texttt{" + r"\allowbreak{}".join(m.group(1)[i:i+16] for i in range(0, 64, 16)) + "}", pdf_text)
        pdf_source.write_text(pdf_text, encoding="utf-8")
        command = ["pandoc", str(pdf_source), "--from=markdown", "--pdf-engine=xelatex", "--standalone", "--include-in-header=" + str(header), "-V", "geometry:margin=0.85in", "-V", "fontsize:11pt", "-V", "mainfont:Latin Modern Roman", "-V", "monofont:DejaVu Sans Mono", "-V", "linestretch:1.04", "-V", "pagestyle:plain", "-M", "title:" + TITLE, "-M", "date:7 September 2026", "-o", str(HERE / "yah-research-note.pdf")]
        run = subprocess.run(command, capture_output=True, text=True)
        print(run.stdout, end="")
        print(run.stderr, end="")
        run.check_returncode()
    checksum_files = sorted(p for p in HERE.iterdir() if p.is_file() and p.name != "SHA256SUMS")
    write("SHA256SUMS", "".join(f"{sha(path.read_bytes())}  {path.name}\n" for path in checksum_files))
    print("REPORT_PDF_SHA256 =", sha((HERE / "yah-research-note.pdf").read_bytes()))
    print("REPLAY_ARCHIVE_SHA256 =", sha((HERE / "yah-reproducibility.zip").read_bytes()))


if __name__ == "__main__":
    main()
