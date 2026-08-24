# Provenance and timestamp notes

## Public publication date

This GitHub repository is a **2026-08-23 public archival publication** of artifacts produced earlier in the research sequence. GitHub's commit history therefore proves public availability from the repository commit onward. It does **not** prove that the files were public on 2026-08-01.

## Earlier artifact metadata

The source artifacts themselves are dated 2026-08-01. The ChatGPT file-library records from which this repository was assembled also recorded earlier creation times. Selected packet-level records were:

| Artifact | Recorded creation time (UTC) |
|---|---:|
| `Collatz_Multi_Agent_Research_Bundle_2026-08-01.zip` | 2026-08-01 20:41:51 |
| `Collatz_Round2_Research_Bundle_2026-08-01.zip` | 2026-08-01 21:12:59 |
| `Collatz_Round3_FixedGap_and_RisingTail_Dossier_2026-08-01.pdf` | 2026-08-01 22:38:21.913667 |
| `Collatz_Round4B_Packet_2026-08-01.zip` | 2026-08-01 23:25:31.485105 |
| `Collatz_Round4A_Packet_2026-08-01.zip` | 2026-08-01 23:25:48.045753 |
| `Collatz_Round5A_Packet_2026-08-01.zip` | 2026-08-01 23:59:23.385291 |
| `Collatz_Round5B_Packet_2026-08-01.zip` | 2026-08-02 00:10:12.313767 |
| `Collatz_Round6A_Packet_2026-08-01.zip` | 2026-08-02 03:02:38.736493 |
| `Collatz_Round6B_Terminal_Packet_2026-08-01.zip` | 2026-08-02 03:22:27.584587 |

These are preserved as **platform metadata claims**, not represented as an independent cryptographic timestamp authority.

## What the old SHA-256 files establish

Several rounds already contained SHA-256 manifests before this repository was created. Those files are preserved unchanged under `checksums/original/`.

A hash can establish **identity/integrity**: if a current artifact has the same SHA-256 digest as an earlier recorded digest, the bytes match.

A hash by itself does **not** establish **when** the artifact existed. To prove an earlier date to an independent third party, the digest must itself have been anchored at that earlier time by a trusted external system.

## Retrospective evidence that may help

Potential evidence for the 2026-08-01/02 chronology includes:
- original ChatGPT conversation timestamps and conversation exports;
- ChatGPT Library creation metadata;
- cloud-drive version history, if copies were stored there at the time;
- email/message attachments sent at the time;
- backup-provider snapshots or filesystem history.

These can corroborate chronology, but they vary in evidentiary strength and are not equivalent to a contemporaneous cryptographic timestamp.

## Strong timestamping from this publication forward

From the first public GitHub commit onward, the repository history and its SHA-256 manifest provide a public, inspectable anchor for the exact bytes published here.

For stronger future archival practice, a release can also be deposited with a durable archival service/DOI or timestamped using a trusted timestamping system. Such a later timestamp should be described as the date of that archival action, never backdated.

## No backdating

The Git history in this repository should not be interpreted as claiming that GitHub hosted these files before 2026-08-23. Author dates can be edited in Git and therefore would not constitute trustworthy proof of earlier existence. This archive deliberately separates the earlier artifact metadata from the later public-publication timestamp.
