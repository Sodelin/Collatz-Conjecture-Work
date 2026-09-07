# YAH restricted obstruction: report and certificate replay

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

Mathematical source: d45362b75a8b48c7067e6db864e948be713f32e9
Publication source: 026aa4ad4be6453a005ab950b160a9f2204c5271
Repository: https://github.com/Sodelin/Collatz-Conjecture-Work
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
