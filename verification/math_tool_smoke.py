"""Smoke-test the optional symbolic environment with exact computations."""

import sympy as sp


def check(condition: bool, message: str) -> None:
    if not condition:
        raise RuntimeError(message)


def main() -> None:
    x, m = sp.symbols("x m")
    check(sp.factor(x**4 - 1) == (x - 1) * (x + 1) * (x**2 + 1),
          "factorization failed")
    check(sp.integrate(x**2, (x, 0, 1)) == sp.Rational(1, 3),
          "exact integration failed")
    for k in range(1, 21):
        n = (2 ** (k + 2) * m - 5) / 3
        endpoint = (3 * n + 1) / 4
        for _ in range(k - 1):
            endpoint = (3 * endpoint + 1) / 2
        check(sp.expand(endpoint - (2 * 3 ** (k - 1) * m - 1)) == 0,
              f"affine word identity failed at k={k}")
    print(f"SymPy {sp.__version__}: factorization, exact integral, 20 affine identities PASS")
    print("Affine identities alone do not certify parity guards or Collatz termination.")


if __name__ == "__main__":
    main()
