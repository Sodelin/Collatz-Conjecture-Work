#!/usr/bin/env python3
"""Exact replay of the canonical 2-local YAH edge-potential no-go.

This checks one finite cancellation certificate.  It is not a Collatz proof
and not a global SRS termination result.
"""

from collections import Counter
import re


CANONICAL = re.compile(r"^\^[ft012]*\$$")


def value(word: str) -> int:
    assert CANONICAL.fullmatch(word), word
    n = 1
    for symbol in word[1:-1]:
        if symbol == "f":
            n = 2 * n
        elif symbol == "t":
            n = 2 * n + 1
        else:
            n = 3 * n + int(symbol)
    return n


def shortcut_T(n: int) -> int:
    return n // 2 if n % 2 == 0 else (3 * n + 1) // 2


def signed_delta(lhs: str, rhs: str) -> Counter[tuple[str, str]]:
    result = Counter(zip(lhs, lhs[1:]))
    result.subtract(Counter(zip(rhs, rhs[1:])))
    return Counter({edge: coefficient for edge, coefficient in result.items()
                    if coefficient})


ROWS = [
    (1, "^2t$", "^22$", "t$->2$", True),
    (1, "^1f12$", "^10t2$", "f1->0t", False),
    (1, "^2f10$", "^20t0$", "f1->0t", False),
    (1, "^f22$", "^1f2$", "f2->1f", False),
    (1, "^1f22$", "^11f2$", "f2->1f", False),
    (1, "^1t02$", "^11t2$", "t0->1t", False),
    (1, "^2t02$", "^21t2$", "t0->1t", False),
    (1, "^2t11$", "^22f1$", "t1->2f", False),
    (2, "^0t22$", "^02t2$", "t2->2t", False),
    (1, "^1t2$", "^12t$", "t2->2t", False),
    (1, "^2t20$", "^22t0$", "t2->2t", False),
    (1, "^2t21$", "^22t1$", "t2->2t", False),
    (1, "^11$", "^ff1$", "^1->^ff", False),
]


def main() -> None:
    total: Counter[tuple[str, str]] = Counter()
    strict_lower_bound = 0

    for index, (mult, lhs, rhs, rule, strict) in enumerate(ROWS, 1):
        assert CANONICAL.fullmatch(lhs) and CANONICAL.fullmatch(rhs)
        old, new = rule.split("->")
        assert lhs.count(old) == 1, (index, lhs, rule)
        assert lhs.replace(old, new, 1) == rhs, (index, lhs, rhs, rule)

        if strict:
            assert rule == "t$->2$"
            assert value(rhs) == shortcut_T(value(lhs))
            strict_lower_bound += mult
        else:
            assert value(lhs) == value(rhs), (index, lhs, rhs)

        for edge, coefficient in signed_delta(lhs, rhs).items():
            total[edge] += mult * coefficient

    total = Counter({edge: coefficient for edge, coefficient in total.items()
                     if coefficient})
    assert strict_lower_bound == 1
    assert total == Counter({("f", "f"): -1}), total

    print("weighted strict lower bound =", strict_lower_bound)
    print("weighted edge-count cancellation =", dict(total))
    print("therefore -W_(f,f) >= 1, i.e. W_(f,f) <= -1")
    print("mu(^f^m$) is unbounded below")
    print("PASS")


if __name__ == "__main__":
    main()
