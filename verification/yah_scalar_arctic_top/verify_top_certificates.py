#!/usr/bin/env python3
"""Dependency-free exact replay of the ten scalar-arctic top certificates."""

from __future__ import annotations


if not __debug__:
    raise RuntimeError(
        "Verification requires assertions; rerun without -O, -OO, "
        "or PYTHONOPTIMIZE."
    )

import json
import time
from hashlib import sha256
from pathlib import Path

from top_cert_common import (
    TOP_CASES,
    build_case,
    farkas_valid,
    instance_fingerprint,
    learned_clause,
    rup_valid,
    verify_full_compatibility,
)


HERE = Path(__file__).resolve().parent
CERTIFICATE = HERE / "top_certificates.json"


def main() -> None:
    started = time.monotonic()
    raw = CERTIFICATE.read_bytes()
    data = json.loads(raw)
    assert data["format"] == "yah-top-scalar-arctic-farkas-v1"
    assert data["published_compatibility_commit"] == "f8558a566b682e8dbc4465206f9c26ac9b17760c"
    assert data["origin_state"] == "e7a72cdc1fc6d5c45144c8bbb5925f6906541673"

    # Semantic identity with the published full/extended theorem is checked
    # both by a canonical instance fingerprint and by replaying its 49-row
    # all-positive cancellation on this independent reconstruction.
    assert data["instance_fingerprint"] == instance_fingerprint()
    verify_full_compatibility()

    expected = {(family, target, original) for family, target, original in TOP_CASES}
    actual = {(item["family"], item["target"], item["original"]) for item in data["cases"]}
    assert actual == expected and len(data["cases"]) == 10

    total_lemmas = 0
    total_rup_clauses = 0
    total_weight = 0
    for item in data["cases"]:
        key = (item["family"], item["target"], item["original"])
        assert key in expected
        case = build_case(*key)
        assert item["variables"] == len(case.cnf.names) - 1
        assert item["base_clauses"] == len(case.cnf.clauses)
        assert item["arithmetic_atoms"] == len(case.inequalities)

        clauses = list(case.cnf.clauses)
        for lemma in item["lemmas"]:
            assert farkas_valid(case, lemma)
            clause = learned_clause(case, lemma)
            assert clause
            clauses.append(clause)
            total_weight += sum(weight for _index, weight in lemma["base"])
            total_weight += sum(weight for _index, weight in lemma["atoms"])
        for candidate in item["rup_clauses"]:
            candidate = tuple(candidate)
            assert rup_valid(clauses, candidate, len(case.cnf.names) - 1)
            clauses.append(candidate)
        assert rup_valid(clauses, (), len(case.cnf.names) - 1)
        total_lemmas += len(item["lemmas"])
        total_rup_clauses += len(item["rup_clauses"])
        print(
            f"CASE {item['family']} {item['target']}: PASS; "
            f"atoms={len(case.inequalities)} lemmas={len(item['lemmas'])}"
        )

    elapsed = time.monotonic() - started
    assert total_lemmas == 491
    assert total_rup_clauses == 426
    assert total_weight == 10183
    print("published full-system compatibility = PASS")
    print("instance fingerprint =", instance_fingerprint())
    print("certificate sha256 =", sha256(raw).hexdigest())
    print("cases = 10")
    print("Farkas lemmas =", total_lemmas)
    print("RUP clauses =", total_rup_clauses)
    print("total positive multiplier mass =", total_weight)
    print(f"checker elapsed seconds = {elapsed:.3f}")
    print("TOP_SCALAR_ARCTIC_NO_FIRST_STEP = PASS")


if __name__ == "__main__":
    main()
