# Free mathematical tool setup

**Node ID:** `Collatz-Conjecture-Work:MATH-TOOLS`

**Node type:** `verification`

The Wolfram connector is optional. The project can use Python for exact integer
and rational arithmetic, SymPy for symbolic exploration, and the pinned Lean
release for formal checking. These tools require no Wolfram account or payment.

## Optional symbolic environment

From the repository root, with Python 3.12 and `uv` installed:

```bash
uv venv .venv-math --python 3.12
uv pip install --python .venv-math/bin/python -r requirements-math.txt
.venv-math/bin/python -B verification/math_tool_smoke.py
```

On Windows the environment interpreter is `.venv-math\Scripts\python.exe`.
An equivalent setup using the standard Python tools is:

```bash
python3 -m venv .venv-math
.venv-math/bin/python -m pip install -r requirements-math.txt
.venv-math/bin/python -B verification/math_tool_smoke.py
```

The dependencies are pinned in [requirements-math.txt](../requirements-math.txt).
The smoke check performs exact factorization, integration, and twenty symbolic
affine-word identities. Affine identities alone do not validate parity guards.
The promoted finite-palette checker needs only the Python standard library.

## Lean

Install Lean's version manager from the [official installation guide](https://lean-lang.org/install/),
then let the repository's [lean-toolchain](../lean-toolchain) select its release:

```bash
elan toolchain install leanprover/lean4:v4.33.1
lean --version
lake build
lake env lean lean/CollatzWork/Disproof/TwoPumpDependency.lean
```

No Mathlib download is required by this repository. Avoid replacing its pinned
release merely because another release is installed. CI downloads the pinned
release and validates the archive SHA-256 before building source.

## What was exercised in the 2026-09-05 exploration

An isolated Python 3.12.13 environment installed SymPy 1.14.0 and mpmath 1.3.0.
The exact symbolic smoke checks passed. A cached Lean 4.33.1 distribution was
reused read-only; both an independent theorem and a clean Lake project compiled.
The hosted execution environment needed a process-path compatibility wrapper
for the toolchain's own executable lookup. That environment-specific wrapper
is not required on ordinary installations and is not part of the mathematical
proof. CI replays the source using the unchanged release on Ubuntu.

Installation in one hosted workspace does not install software on the user's
phone or PC and is not a guarantee that another chat inherits its environment.
The committed dependency pins and commands provide the reproducible setup.

## Connections

- **Verified by:** [verification manifest](../verification/README.md).
- **Formalized by / pending:** [Lean scope and targets](../LEAN_TARGETS.md).
- **Depends on:** [verification policy](../lean/VERIFICATION_POLICY.md).
