"""Ordinary and optimized CI replay of the guarded original-root checker."""
import json
from pathlib import Path
import subprocess
import sys
import unittest

ROOT = Path(__file__).resolve().parents[1]


class MultiExcursionBudgetTests(unittest.TestCase):
    def test_normal_and_optimized_outputs_match(self):
        results = []
        for flags in ([], ["-O"], ["-OO"]):
            with self.subTest(flags=flags):
                process = subprocess.run(
                    [sys.executable, "-B", *flags,
                     str(ROOT / "verification/multi_excursion_budget_check.py")],
                    cwd=ROOT, capture_output=True, text=True, timeout=45,
                )
                self.assertEqual(process.returncode, 0, process.stdout + process.stderr)
                result = json.loads(process.stdout)
                self.assertEqual(result["status"], "PASS")
                self.assertEqual(result["family_replays"], 396)
                self.assertEqual(result["parity_replays"], 1022)
                self.assertEqual(result["closed_form_checks"], 800)
                self.assertEqual(result["negative_controls"], 12)
                self.assertEqual(result["max_failed_returns"], 64)
                self.assertFalse(result["root_reset_control"]["original_root_descent"])
                results.append(result)
        self.assertEqual(results[0], results[1])
        self.assertEqual(results[0], results[2])
        frozen = json.loads((ROOT / "verification/multi_excursion_budget_2026-09-05.json").read_text())
        self.assertEqual(results[0], frozen)


if __name__ == "__main__":
    unittest.main()
