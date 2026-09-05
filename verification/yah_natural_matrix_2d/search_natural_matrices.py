#!/usr/bin/env python3
"""Bounded, exact first-rule-removal search for the canonical YAH SRS.

Source: Yolcu--Aaronson--Heule, arXiv:2105.14697v3, pp.9,19,28--29.
This script is a search experiment, not a proof of Collatz or a general no-go.
No modular overflow is permitted in the SMT encoding: width is chosen from
an explicit upper bound for every entry of a composed word of length <= 3.
"""
import json
from pathlib import Path
import sys
import time

if not __debug__:
    raise RuntimeError("Run without -O: assertions are part of the candidate checker")

ROOT = Path(__file__).resolve().parent
sys.path.insert(0, str(ROOT / "deps"))
import z3

SYMBOLS = "ft012^$"
RULES = [
    ("D_f", "f$", "$"),
    ("D_t", "t$", "2$"),
    ("X_f0", "f0", "0f"),
    ("X_f1", "f1", "0t"),
    ("X_f2", "f2", "1f"),
    ("X_t0", "t0", "1t"),
    ("X_t1", "t1", "2f"),
    ("X_t2", "t2", "2t"),
    ("X_^0", "^0", "^t"),
    ("X_^1", "^1", "^ff"),
    ("X_^2", "^2", "^ft"),
]

# Primary-source positive control: Example 4.3, pp.28--29. All ten
# rules other than f1->0t are strictly oriented by this interpretation.
EXAMPLE_43 = {
    "f": ([[1, 1], [1, 0]], [0, 0]),
    "t": ([[1, 3], [3, 4]], [1, 1]),
    "^": ([[1, 5], [0, 0]], [0, 0]),
    "$": ([[1, 0], [1, 0]], [1, 1]),
    "0": ([[7, 2], [2, 5]], [2, 1]),
    "1": ([[2, 1], [1, 1]], [1, 0]),
    "2": ([[2, 2], [2, 4]], [0, 2]),
}


def exact_word(word, interpretation):
    """Independent integer checker: direct 3x3 homogeneous matrix products."""
    out = [[int(i == j) for j in range(3)] for i in range(3)]
    for symbol in word:
        a, b = interpretation[symbol]
        item = [a[0] + [b[0]], a[1] + [b[1]], [0, 0, 1]]
        out = [[sum(out[i][k] * item[k][j] for k in range(3))
                for j in range(3)] for i in range(3)]
    return out


def verify(interpretation, rules=RULES):
    for symbol in SYMBOLS:
        a, b = interpretation[symbol]
        assert all(isinstance(x, int) and x >= 0 for row in a for x in row)
        assert all(isinstance(x, int) and x >= 0 for x in b)
        assert a[0][0] >= 1
    records = []
    for name, lhs, rhs in rules:
        l, r = exact_word(lhs, interpretation), exact_word(rhs, interpretation)
        delta = [[l[i][j] - r[i][j] for j in range(3)] for i in range(2)]
        weak = all(x >= 0 for row in delta for x in row)
        records.append(dict(name=name, lhs=lhs, rhs=rhs, delta=delta,
                            weak=weak, strict=weak and delta[0][2] > 0))
    return records


def symbolic_word(word, interpretation, width):
    """Independent SMT builder: compose affine functions from right to left."""
    one, zero = z3.BitVecVal(1, width), z3.BitVecVal(0, width)
    matrix, vector = [[one, zero], [zero, one]], [zero, zero]
    for symbol in reversed(word):
        a, b = interpretation[symbol]
        matrix, vector = (
            [[sum(a[i][k] * matrix[k][j] for k in range(2))
              for j in range(2)] for i in range(2)],
            [sum(a[i][k] * vector[k] for k in range(2)) + b[i]
             for i in range(2)],
        )
    return matrix, vector


def build(bound, timeout_ms, fixed=None, omit=None, require_all_strict=False):
    assert all(len(side) <= 3 for _, lhs, rhs in RULES for side in (lhs, rhs))
    # At length 3 each matrix entry <=4B^3, each vector entry
    # <=4B^3+2B^2+B. Shorter-word intermediate sums are smaller.
    upper = 4 * bound**3 + 2 * bound**2 + bound
    width = max(2, upper.bit_length())
    input_width = max(1, bound.bit_length())
    solver = z3.SolverFor("QF_BV")
    solver.set(timeout=timeout_ms)
    raw, interpretation = {}, {}
    for symbol in SYMBOLS:
        values = [z3.BitVec(f"v_{ord(symbol)}_{i}", input_width) for i in range(6)]
        raw[symbol] = values
        solver.add(*[z3.ULE(x, bound) for x in values])
        solver.add(z3.UGE(values[0], 1))
        wide = [z3.ZeroExt(width - input_width, x) for x in values]
        interpretation[symbol] = ([wide[:2], wide[2:4]], wide[4:])
        if fixed is not None:
            a, b = fixed[symbol]
            solver.add(*[x == y for x, y in zip(values, a[0] + a[1] + b)])
    strict = []
    for name, lhs, rhs in RULES:
        if name == omit:
            continue
        la, lb = symbolic_word(lhs, interpretation, width)
        ra, rb = symbolic_word(rhs, interpretation, width)
        solver.add(*[z3.UGE(la[i][j], ra[i][j]) for i in range(2) for j in range(2)])
        solver.add(*[z3.UGE(lb[i], rb[i]) for i in range(2)])
        strict.append(z3.UGT(lb[0], rb[0]))
    solver.add(z3.And(strict) if require_all_strict else z3.Or(strict))
    return solver, raw, dict(bound=bound, width=width,
                             largest_composition_entry_bound=upper,
                             variables=42, rules=11 if omit is None else 10)


def main():
    positive = verify(EXAMPLE_43, [r for r in RULES if r[0] != "X_f1"])
    assert len(positive) == 10 and all(r["strict"] for r in positive)
    missing = verify(EXAMPLE_43, [r for r in RULES if r[0] == "X_f1"])[0]
    assert not missing["weak"]
    print("PASS exact primary-source Example 4.3: all ten rules strict; omitted rule fails", flush=True)
    # Validate the very same SMT composition against the published example.
    control, _, _ = build(8, 3000, fixed=EXAMPLE_43, omit="X_f1", require_all_strict=True)
    started = time.monotonic()
    result = control.check()
    control_time = time.monotonic() - started
    assert result == z3.sat, str(result)
    print("PASS SMT encoding positive control", flush=True)
    report = dict(source="https://arxiv.org/abs/2105.14697v3", z3=z3.get_version_string(),
                  positive_control=positive, missing_rule=missing,
                  positive_control_solver_seconds=control_time, searches=[])
    # Full high-coefficient attempt first; smaller bounds provide a decisive
    # restricted result if the ambitious full bound exhausts its time budget.
    remaining = 89.0 - control_time
    for bound, seconds in [(8, 60), (2, 20), (1, 8)]:
        timeout_ms = max(1, int(min(seconds, remaining) * 1000))
        solver, raw, metadata = build(bound, timeout_ms)
        (ROOT / f"full_bound_{bound}.smt2").write_text(solver.to_smt2())
        started = time.monotonic()
        outcome = solver.check()
        elapsed = time.monotonic() - started
        remaining -= elapsed
        metadata.update(outcome=str(outcome), solver_seconds=elapsed)
        if outcome == z3.unknown:
            metadata["reason_unknown"] = solver.reason_unknown()
        elif outcome == z3.sat:
            model = solver.model()
            candidate = {}
            for symbol, values in raw.items():
                v = [model.eval(x, model_completion=True).as_long() for x in values]
                candidate[symbol] = ([v[:2], v[2:4]], v[4:])
            checked = verify(candidate)
            assert all(r["weak"] for r in checked) and any(r["strict"] for r in checked)
            metadata.update(candidate=candidate, independent_check=checked)
        report["searches"].append(metadata)
        (ROOT / "result.json").write_text(json.dumps(report, indent=2))
        print(json.dumps(metadata), flush=True)
        if outcome != z3.unknown or remaining < 1:
            break
    report["solver_wall_seconds_total"] = control_time + sum(x["solver_seconds"] for x in report["searches"])
    (ROOT / "result.json").write_text(json.dumps(report, indent=2))
    print("No claim beyond the recorded finite template and outcomes.", flush=True)


if __name__ == "__main__":
    main()
